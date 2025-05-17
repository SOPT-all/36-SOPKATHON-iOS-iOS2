//
//  FilterButton.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/18/25.
//

import UIKit

class FilterButton: UIButton {
    
    // MARK: - Properties
    
    private let cornerRadius: CGFloat = 14
    
    private let defaultBackgroundColor: UIColor = .grayScale200
    private let selectedBackgroundColor: UIColor = .brand1
    
    private let selectedTitleColor: UIColor = .grayScale000
    private let defaultTitleColor: UIColor = .grayScale600
    
    override var isSelected: Bool {
        didSet {
            updateButton()
        }
    }
    
    // MARK: - Initializer
    
    init(_ type: FilterType, isSelected: Bool = false) {
        super.init(frame: .zero)
        
        self.isSelected = isSelected
        setButton(type, isSelected: isSelected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterButton {
    
    func setButton(_ type: FilterType, isSelected: Bool) {
        setTitle(type.title, for: .normal)
        setTitleColor(isSelected ? selectedTitleColor : defaultTitleColor, for: .normal)
        titleLabel?.attributedText = .pretendard(.title_m_14, text: type.title)
        setCornerRadius(cornerRadius)
    }
    
    func updateButton() {
        backgroundColor = isSelected ? selectedBackgroundColor : defaultBackgroundColor
        setTitleColor(isSelected ? selectedTitleColor : defaultTitleColor, for: .normal)
    }
    
    enum FilterType {
        case all // 전체
        case accessories // 악세서리
        case life // 생활용품
        case goods // 문구잡화
        
        var title: String {
            switch self {
            case .all:
                return "전체"
            case .accessories:
                return "악세서리"
            case .life:
                return "생활용품"
            case .goods:
                return "문구잡화"
            }
        }
    }
}
