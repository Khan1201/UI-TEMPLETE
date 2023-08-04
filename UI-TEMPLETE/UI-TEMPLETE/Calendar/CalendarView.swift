import SwiftUI
import SwiftUIPager

struct CalendarView: View {
  @State var offset: CGSize = CGSize()
  @StateObject var viewModel: CalendarVM = CalendarVM()
  
  @State private var page: Page = .withIndex(0)
  @State private var size: CGSize = CGSize()
    
  var body: some View {
    
    VStack(alignment: .leading, spacing: 0) {
      Pager(page: page, data: viewModel.pageData, id: \.self) { _ in
        VStack {
          headerView
          calendarGridView
        }
        .getSize(size: $size)
      }
      .onPageWillTransition { result in
        switch result {
        case .success(let res):
          viewModel.pageDragGesture(
            currentIndex: res.currentPage,
            nextIndex: res.nextPage
          )
        case .failure:
          ()
        }
      }
      .background {
        Color.red.opacity(0.5)
      }
      .frame(maxWidth: .infinity, maxHeight: size.height)
    }
    .task {
      page = .withIndex(viewModel.dateForMonthToInt - 1)
    }
  }
  
  // MARK: - 헤더 뷰
  private var headerView: some View {
    VStack {
      Text(viewModel.dateForMonth.toStringByFormat("M월"))
        .font(.title)
        .padding(.bottom)
      
      HStack {
        ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
          Text(symbol)
            .frame(maxWidth: .infinity)
        }
      }
      .padding(.bottom, 5)
    }
  }
  
  // MARK: - 날짜 그리드 뷰
  private var calendarGridView: some View {
    let maxDays: Int = viewModel.maxDays
    let firstWeekday: Int = viewModel.firstWeekday
    let monthToInt: Int = viewModel.dateForMonthToInt
    
    return VStack {
      LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
        ForEach(0 ..< maxDays + firstWeekday, id: \.self) { index in
          
          if index < firstWeekday {
            RoundedRectangle(cornerRadius: 5)
              .foregroundColor(Color.clear)
            
          } else {
            let day = index - firstWeekday + 1
            
            CellView(
              day: day,
              month: monthToInt,
              selectedDayAndMonth: viewModel.selectedDayAndMonth
            )
              .onTapGesture {
                viewModel.dayOnTapGesture(day: day, month: monthToInt)
              }
          }
        }
      }
    }
  }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
  let day: Int
  let month: Int
  let selectedDayAndMonth: (Int, Int)
    
  var body: some View {
    
    let isFocused: Bool = day == selectedDayAndMonth.0 && month == selectedDayAndMonth.1
    
    VStack {
      RoundedRectangle(cornerRadius: 5)
        .opacity(0)
        .overlay(Text(String(day)))
        .foregroundColor(.blue)
      
      if isFocused {
        Text("Current")
          .font(.caption)
          .foregroundColor(.red)
      }
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
