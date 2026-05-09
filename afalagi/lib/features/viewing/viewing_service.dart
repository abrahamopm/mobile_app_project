import 'package:afalagi/features/viewing/models/viewing_model.dart';

class ViewingService {
  static final List<Viewing> _viewings = [
    Viewing(
      id: '1',
      propertyId: 'p1',
      clientId: 'c1',
      propertyTitle: 'Bole High-Rise Penthouse',
      clientName: 'Almaz Abraham',
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&q=80&w=2071',
      date: 'Oct 24, 2023 - 10:30 AM',
      status: 'Recent',
      price: '18.9M',
    ),
    Viewing(
      id: '2',
      propertyId: 'p2',
      clientId: 'c2',
      propertyTitle: 'CMC Estate Villa 42',
      clientName: 'Dawit Getachew',
      imageUrl: 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?auto=format&fit=crop&q=80&w=2070',
      date: 'OCT 22',
      status: 'Completed',
      price: '12.5M',
    ),
    Viewing(
      id: '3',
      propertyId: 'p3',
      clientId: 'c3',
      propertyTitle: 'Old Airport Apartment',
      clientName: 'Sara Tekle',
      imageUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?auto=format&fit=crop&q=80&w=2070',
      date: 'OCT 18',
      status: 'Second Viewing',
      price: '8.2M',
    ),
    Viewing(
      id: '4',
      propertyId: 'p4',
      clientId: 'c4',
      propertyTitle: 'Kazanchis Office Space',
      clientName: 'Tewodros Kassahun',
      imageUrl: 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&q=80&w=2070',
      date: 'OCT 12',
      status: 'Cancelled',
      price: '15k',
    ),
  ];

  static List<Viewing> getViewings() {
    return _viewings;
  }

  static void addViewing(Viewing viewing) {
    _viewings.insert(0, viewing);
  }

  static void updateViewing(Viewing updatedViewing) {
    final index = _viewings.indexWhere((v) => v.id == updatedViewing.id);
    if (index != -1) {
      _viewings[index] = updatedViewing;
    }
  }

  static void deleteViewing(String id) {
    _viewings.removeWhere((v) => v.id == id);
  }
}
