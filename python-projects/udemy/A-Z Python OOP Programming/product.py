
class Product:
    def __init__(self, product_name: str, brand_name: str, model_name: str, price: int) -> None:
        self.product_name = product_name
        self.brand_name = brand_name
        self.model_name = model_name
        self.price = price
        self.product_name_with_model = f"{product_name} - {model_name}"

    def discount(self, discountValue):
        discountAmount = (self.price/100)*discountValue
        final_price = self.price - discountAmount
        return int(final_price)

laptop = Product("laptop", "lenovo", "y350p", 1500)
print(laptop.discount(10))
mobile_phone = Product("galaxy", "samsung", "s20", 800)

print(mobile_phone.product_name_with_model)