@echo off
@echo This cmd file creates a Data API Builder configuration based on the chosen database objects.
@echo To run the cmd, create an .env file with the following contents:
@echo dab-connection-string=your connection string
@echo ** Make sure to exclude the .env file from source control **
@echo **
dotnet tool install -g Microsoft.DataApiBuilder
dab init -c dab-config.json --database-type mssql --connection-string "@env('dab-connection-string')" --host-mode Development
@echo Adding tables
dab add "Carrito" --source "[dbo].[Carrito]" --fields.include "id_carrito,id_usuario,id_producto,cantidad,fecha_agregado" --permissions "anonymous:*" 
dab add "Categoria" --source "[dbo].[Categorias]" --fields.include "id_categoria,nombre,descripcion" --permissions "anonymous:*" 
dab add "DetallesPedido" --source "[dbo].[Detalles_Pedido]" --fields.include "id_detalle,id_pedido,id_producto,cantidad,precio_unitario,subtotal" --permissions "anonymous:*" 
dab add "HistorialCompra" --source "[dbo].[Historial_Compras]" --fields.include "id_historial,id_usuario,id_pedido,fecha_compra" --permissions "anonymous:*" 
dab add "Pedido" --source "[dbo].[Pedidos]" --fields.include "id_pedido,id_usuario,fecha_pedido,estado,total,metodo_pago" --permissions "anonymous:*" 
dab add "Producto" --source "[dbo].[Productos]" --fields.include "id_producto,nombre,descripcion,precio,stock,imagen_url,id_categoria" --permissions "anonymous:*" 
dab add "Usuario" --source "[dbo].[Usuarios]" --fields.include "id_usuario,nombre,correo,contrase?a,direccion,telefono,rol,imagen_url,fecha_registro" --permissions "anonymous:*" 
@echo Adding views and tables without primary key
@echo Adding relationships
dab update Carrito --relationship Producto --target.entity Producto --cardinality one
dab update Producto --relationship Carrito --target.entity Carrito --cardinality many
dab update Carrito --relationship Usuario --target.entity Usuario --cardinality one
dab update Usuario --relationship Carrito --target.entity Carrito --cardinality many
dab update DetallesPedido --relationship Pedido --target.entity Pedido --cardinality one
dab update Pedido --relationship DetallesPedido --target.entity DetallesPedido --cardinality many
dab update DetallesPedido --relationship Producto --target.entity Producto --cardinality one
dab update Producto --relationship DetallesPedido --target.entity DetallesPedido --cardinality many
dab update HistorialCompra --relationship Pedido --target.entity Pedido --cardinality one
dab update Pedido --relationship HistorialCompra --target.entity HistorialCompra --cardinality many
dab update HistorialCompra --relationship Usuario --target.entity Usuario --cardinality one
dab update Usuario --relationship HistorialCompra --target.entity HistorialCompra --cardinality many
dab update Pedido --relationship Usuario --target.entity Usuario --cardinality one
dab update Usuario --relationship Pedido --target.entity Pedido --cardinality many
dab update Producto --relationship Categoria --target.entity Categoria --cardinality one
dab update Categoria --relationship Producto --target.entity Producto --cardinality many
@echo Adding stored procedures
@echo **
@echo ** run 'dab validate' to validate your configuration **
@echo ** run 'dab start' to start the development API host **
