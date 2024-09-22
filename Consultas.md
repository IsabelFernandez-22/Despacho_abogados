# Proyecto de Base de Datos para el Bufete de Abogados FERTAR

Se ha contratado al equipo para desarrollar una base de datos que apoye la gestión del sistema del bufete de abogados FERTAR. El bufete necesita llevar un control integral de sus operaciones, incluyendo la gestión de las siguientes entidades:

- **Cliente**: Un cliente tiene un nombre, dirección, números de teléfono de contacto, apellido, sexo y ciudad.
- **Contacto de Emergencia**: Cada contacto de emergencia tiene un nombre, relación con el cliente, dirección, número de teléfono y correo electrónico. Se registran para poder contactar rápidamente en caso de necesidad.
- **Abogado**: Un abogado tiene un nombre, apellido, sexo, dirección, número de teléfono y correo electrónico. Se registran sus áreas de especialización, como derecho penal, civil, administrativo, etc.
- **Caso**: Un caso incluye un nombre, descripción, fecha de inicio y estado actual. Está asociado a uno o muchos abogados responsables y a uno o más clientes. Los casos también están vinculados a facturas y se registran detalles como el tipo de derecho involucrado.
- **Actividad**: Una actividad está relacionada con las tareas y gestiones diarias del bufete. Incluye información sobre el tipo de actividad, fecha y hora, y el abogado o cliente involucrado.
- **Cita**: Una cita incluye la fecha, hora, lugar, y una lista de participantes, que incluye tanto a abogados como a clientes. También puede incluir una breve descripción del propósito de la cita.
- **Servicio**: Un servicio prestado por el bufete incluye un nombre, descripción del servicio, si será del tipo penal, civil, familiar o laboral, entre otros, y precio asociado.
- **Tipo de Servicio**: Un tipo de servicio lleva el nombre del tipo de servicio que ofrece algún área de derecho penal (Asesoramiento en Procedimientos Prejudiciales, defensa penal, etc.).
- **Factura**: Cada factura incluye la fecha de emisión, el cliente asociado y el monto total. Las facturas están asociadas tanto con clientes como con pagos y reflejan los servicios prestados.
- **Pago**: Los pagos incluyen la fecha, el monto pagado y el método de pago utilizado. Se asocian con las facturas correspondientes y con los servicios prestados.
- **Testigo**: Un testigo incluye el nombre, relación con el caso, fecha del testimonio y un resumen del mismo. Los testimonios se asocian con el expediente correspondiente del caso.
- **Evidencia**: La evidencia incluye una descripción, tipo, fecha de recolección y cualquier detalle relevante sobre el material probatorio.
- **Juzgado**: Cada juzgado tiene un nombre, dirección y tipo de casos que maneja. Se registra para asociar los casos con la audiencia correspondiente.
- **Demandado**: Un demandado tiene un nombre, dirección y otros datos de contacto, representante legal, y el tipo de demanda (contra demanda, demanda, querella, etc.), entre otros.
- **Representante Legal**: Cada demandado cuenta con un representante legal a la hora de llegar a un acuerdo entre ambas partes. Es necesario el nombre, DNI y teléfono.
- **Audiencia**: Una audiencia incluye la fecha, hora, lugar y el tipo de audiencia. Está asociada con un caso específico y un juzgado donde se realiza. También puede incluir una lista de participantes, como abogados y clientes.
