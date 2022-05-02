//
//  ColorPickerViewController.swift
//  MySchedule
//
//  Created by Igor on 26.04.2022.
//

import UIKit

enum ColorPickerColors: CaseIterable {
    case gray, red, green, blue, pink, orange, purple, indigo, yellow, teal

    var rawValue: UIColor {
        switch self {
        case .gray:
            return .systemGray
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        case .blue:
            return .systemBlue
        case .pink:
            return .systemPink
        case .orange:
            return .systemOrange
        case .purple:
            return .systemPurple
        case .indigo:
            return .systemIndigo
        case .yellow:
            return .systemYellow
        case .teal:
            return .systemTeal
        }
    }
}

protocol ColorPickerDelegate {
    func colorPickerDidColorSelected(selectedColor: UIColor)
}

class ColorPickerViewController: UIViewController {
    var delegate: ColorPickerDelegate!
    private var colorCollectionView: UICollectionView!
    
    private let cellID = "cellForColor"
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewDidLayoutSubviews() {
        colorCollectionView.frame = view.frame
        let itemsInRows: CGFloat = 5
        
        let itemSize = (colorCollectionView.frame.width - 20) / itemsInRows
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
    }
    
    private func setupScreen() {
        colorCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        colorCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)

        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        
        view.addSubview(colorCollectionView)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ColorPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ColorPickerColors.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        let color = ColorPickerColors.allCases[indexPath.item].rawValue
        
        cell.backgroundColor = color
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = ColorPickerColors.allCases[indexPath.item].rawValue
        delegate.colorPickerDidColorSelected(selectedColor: color)
        dismiss(animated: true)
    }
}
