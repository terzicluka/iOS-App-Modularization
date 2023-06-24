import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: TableDataSourceDelegate {

    var items: Binder<[TableCellItem]?> {
        return Binder(self.base) { dataSourceDelegate, items in
            dataSourceDelegate.items = items
        }
    }

    var sections: Binder<[TableSectionItem]?> {
        return Binder(self.base) { dataSourceDelegate, sections in
            dataSourceDelegate.sections = sections
        }
    }
}
