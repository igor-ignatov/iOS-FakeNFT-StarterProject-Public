import UIKit

final class CollectionViewController: UIViewController {
    
    private let coverImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TestCoverFull")
        
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        image.heightAnchor.constraint(equalToConstant: 310).isActive = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Test title"
        label.textColor = .Themed.black
        label.font = .Bold.size22
        
        return label
    }()
    
    private let authorButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setTitle("Test author", for: .normal)
        button.setTitleColor(.Universal.blue, for: .normal)
        button.titleLabel?.font = .Regular.size15
        
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Test description of NFT collection"
        label.textColor = .Themed.black
        label.font = .Regular.size13
        label.numberOfLines = 0
        
        return label
    }()
    
    private let nftCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collection.register(NFTCollectionViewCell.self)
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    private let scrollView = UIScrollView()
    private let widthParameters = CollectionWidthParameters(cellsNumber: 3, leftInset: 16, rightInset: 16, interCellSpacing: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nftCollection.dataSource = self
        nftCollection.delegate = self
        
        setupNavigationBar()
        makeViewLayout()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        var insets = view.safeAreaInsets
        insets.top = 0 // ignore only top safe area inset
        scrollView.contentInset = insets
    }
    
    private func setupNavigationBar() {
        guard let bar = navigationController?.navigationBar else {
            return
        }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        bar.standardAppearance = appearance
        bar.topItem?.backBarButtonItem = UIBarButtonItem()
        bar.tintColor = .Themed.black
    }
    
    private func makeViewLayout() {
        view.backgroundColor = .Themed.white
        
        let mainStack = makeMainStack()
        scrollView.contentInsetAdjustmentBehavior = .never // ignore safe area insets on all edges
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        view.layoutIfNeeded()
        let contentHeight = nftCollection.collectionViewLayout.collectionViewContentSize.height
        nftCollection.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }
    
    private func makeMainStack() -> UIStackView {
        let mainStack = UIStackView()
        let authorStack = makeAuthorStack()
        
        mainStack.axis = .vertical
        mainStack.alignment = .center
        
        mainStack.addArrangedSubview(coverImage)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(authorStack)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(nftCollection)
        
        mainStack.setCustomSpacing(16, after: coverImage)
        mainStack.setCustomSpacing(8, after: titleLabel)
        
        NSLayoutConstraint.activate([
            coverImage.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -16),
            
            authorStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            authorStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -16),
            
            nftCollection.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            nftCollection.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
        ])
        return mainStack
    }
    
    private func makeAuthorStack() -> UIStackView {
        let label = UILabel()
        label.text = NSLocalizedString("", value: "Автор коллекции:", comment: "")
        label.textColor = .Themed.black
        label.font = .Regular.size13
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(authorButton)
        stack.addArrangedSubview(UIView())
        
        return stack
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NFTCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        
        cell.configure(
            image: UIImage(named: "TestImageNFT"),
            rating: indexPath.item % 5 + 1,
            name: "Test \(indexPath.item)",
            price: indexPath.item,
            isInCart: indexPath.item % 2 == 0,
            isFavorite: indexPath.item % 2 == 0
        )
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - widthParameters.widthInsets
        let cellWidth =  availableWidth / CGFloat(widthParameters.cellsNumber)
        return CGSize(width: cellWidth, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: widthParameters.leftInset, bottom: 20, right: widthParameters.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
