object prueba {}

class ObjetoMagico{
    var poderBase
    var poderMax

    method agregarPoder(mago){}
}

class Varitas inherits ObjetoMagico{
    override method agregarPoder(mago){
        if(mago.nombre().mod(2) ==0){
        poderMax = poderBase * 1.5
        }
        
    }
}

class TunicasComunes inherits ObjetoMagico{
    
    override method agregarPoder(mago){
        poderMax = mago.resistenciaMagica() * 2
    }
    
}
class TunicasEpicas inherits ObjetoMagico{
   
   override method agregarPoder(mago){
        if(mago.resistenciaMagica()>10){
            poderMax = mago.resistenciaMagica() * 2
        }
    }
}

class Amuletos inherits ObjetoMagico{
    override method agregarPoder(mago){
        poderMax = 200
    }
}

class Ojotas inherits ObjetoMagico{
    override method agregarPoder(mago){
        poderMax = mago.nombre().forEach({letra => letra.char()}).sum(10) 
    }
    
}


class Magos{
    var nombre
    var poderInnato
    var resistenciaMagica
    var energiaMagica

    method agregarPoder(){}
    method poderTotal(){
        poderInnato + self.poderObjetos()
    }
    method poderObjetos(objetoMagico){
        objetoMagico.poderMax()
    }

    method desafiarAOtroMago(mago, otroMago){
        if(mago.ganaBatalla(mago, otroMago)){
            energiaMagica += otroMago.energiaMagica()
        }
    }
    method ganaBatalla(mago, otroMago){  
        mago == self     
    }
    
}

class MagoAprendiz inherits Magos{
   override method ganaBatalla(mago, otroMago){
    if(!resistenciaMagica > otroMago.poderTotal()){
        energiaMagica = energiaMagica/2
    }
   }
}

class MagoVeterano inherits Magos{
    override method ganaBatalla(mago, otroMago){
        if(!resistenciaMagica > (otroMago.poderTotal()*1.5)){
            energiaMagica = (energiaMagica - energiaMagica/4)
        }
    }
}
class MagoInmortal inherits Magos{}


//Punto B
class Gremio{
    method initialize(){ 
    self.validarLista()
    }
    
    const miembros = new List()
    
    method validarLista(){
        if(miembros.size() < 2){
            self.error("El gremio no puede tener menos de 2 miembros")
        }
    }
    
    var reservaDeEnergia
    var resistenciaMagica
    var energiaMagica

    method poderTotal(){
        miembros.forEach({mago => mago.poderTotal()}).sum()
    }
    method reservaDeEnergia(){
        miembros.forEach({mago => mago.energiaMagica()}).sum()
    }
    method desafiarAOtroGremio(gremio, otroGremio){
        if(gremio.ganaBatallaentreGremios(gremio, otroGremio)){

        }
    }
    
    method desafiarAOtroMago(gremio,otroMago){
        if(gremio.ganaBatallaAMago(gremio, otroMago)){
            gremio.lider().reservaDeEnergia() + otroMago.energiaMagica()
        }
    }
    method ganaBatallaAMago(gremio, otroMago){
        if(!gremio.resistenciaMagica() > otroMago.poderTotal()){
            self.error("El gremio no le pudo ganar al mago")
        }
    }

    method ganaBatallaEntreGremios(gremio, otroGremio){
       if( gremio.poderTotal() > (otroGremio.resistenciaMagica() + otroGremio.lider().resistenciaMagica())){
              gremio.lider().reservaDeEnergia() += otroGremio.sumaReservaEnergia()
              //otroGremio.forEach({mago => mago.energiaMagica()}).sum()      
       }else{
        self.error("El gremio no le pudo ganar al gremio Enemigo")
       }
       
    } 
    method sumaReservaEnergia(){
         miembros.forEach({mago => mago.energiaMagica()}).sum()
    }

    
    method lider(){
        miembros.forEach({mago => mago.poderTotal()}).max()
    }
}

object mago1 inherits Magos(nombre= "Mago 1", poderInnato= 10, resistenciaMagica= 10, energiaMagica= 100) {}
object mago2 inherits Magos(nombre= "Mago 2", poderInnato= 20, resistenciaMagica= 20, energiaMagica= 200) {}

object mago3 inherits Magos(nombre= "Mago 3", poderInnato= 30, resistenciaMagica= 30, energiaMagica= 300) {}
object mago4 inherits Magos(nombre= "Mago 4", poderInnato= 40, resistenciaMagica= 40, energiaMagica= 400) {}
object mago5 inherits Magos(nombre= "Mago 5", poderInnato= 50, resistenciaMagica= 50, energiaMagica= 500) {}

const gremio1 = new Gremio( miembros= [magoAprendiz, magoAprendiz2], reservaDeEnergia = 200, resistenciaMagica= 30, energiaMagica= 300)
const gremio2 = new Gremio( miembros= [magoVeterano], reservaDeEnergia = 400, resistenciaMagica= 40, energiaMagica= 400)
const gremio3 = new Gremio( miembros= [magoInmortal, magoVeterano], reservaDeEnergia = 600, resistenciaMagica= 50, energiaMagica= 500)

object magoAprendiz inherits MagoAprendiz(nombre= "Mago Aprendiz", poderInnato= 10, resistenciaMagica= 10, energiaMagica= 100) {}
object magoVeterano inherits MagoVeterano(nombre= "Mago Veterano", poderInnato= 20, resistenciaMagica= 20, energiaMagica= 200) {}
object magoInmortal inherits MagoInmortal(nombre= "Mago Inmortal", poderInnato= 30, resistenciaMagica= 30, energiaMagica= 300) {}
object magoAprendiz2 inherits MagoAprendiz(nombre= "Mago Aprendiz 2", poderInnato= 40, resistenciaMagica= 40, energiaMagica= 400) {}
object magoVeterano2 inherits MagoVeterano(nombre= "Mago Veterano 2", poderInnato= 50, resistenciaMagica= 50, energiaMagica= 500) {}