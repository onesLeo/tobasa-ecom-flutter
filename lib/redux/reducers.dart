import 'package:flutter_app/models/UserEcom.dart';
import 'package:flutter_app/models/app_state.dart';
import 'package:flutter_app/models/produk.dart';
import 'package:flutter_app/redux/actions.dart';
import 'package:flutter_app/users/user.dart';

AppState appReducer(AppState state, dynamic action){
  return AppState(
    user: userReducer(state.user, action),
    produk: produkReducer(state.produk, action),
    keranjangBelanja: keranjangBelanjaReducer(state.keranjangBelanja, action),
    userInformation: userInformationReducer(state.userInformation, action)
  );
}

User userReducer(User user, dynamic action){
  if(action is GetUserAction){
    return action.user;
  }else if(action is LogOutUserAction){
    return action.user;
  }
  return user;
}

UserEcom userInformationReducer(UserEcom userInformation, dynamic action){
  if(action is GetUserInformation){
    return action.userInformation;
  }

  return userInformation;
}


List<Produk> produkReducer(List<Produk> produkList, dynamic action){
  if(action is GetProdukAction){
    return action.produk;
  }
  return produkList;
}

List<Produk> keranjangBelanjaReducer(List<Produk> produkList, dynamic action){
  if(action is GetKeranjangBelanjaAction){
    return action.keranjangBelanja;
  }else
  if(action is KeranjangBelanjaAction){
    return action.keranjangBelanja;
  }
  return produkList;
}