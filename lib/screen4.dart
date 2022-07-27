import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectemos/screen5.dart';
import 'package:conectemos/session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String nombreJugador = '';

List<String> preguntas = [
  '¿Con quién de los presentes te sentirías más seguro(a) ante una situación límite?',
  '¿Qué te emociona?',
  'Me gustan las personas… (completa la oración)',
  '¿Qué te gusta hacer cuando estás solo(a)?',
  '¿Cómo sería tu día ideal mañana?',
  'Entre un mundo basado en la naturaleza, alejado de la tecnología, y uno totalmente futurista, ¿dónde vivirías?',
  '¿Qué es lo más complejo que te ha tocado vivir? ',
  '¿Qué te desmotiva?',
  '¿Qué visión tienes de la muerte?',
  '¿Cómo es la relación con tu madre?',
  '¿Cómo es la relación con tu padre?',
  '¿Cómo es tu familia?',
  '¿Qué te cuesta manejar? ¿Qué te permitirías hacer si eso no existiera en tu vida?',
  '¿Qué te molesta?',
  '¿Hay algún sueño que te haya marcado?',
  '¿Qué es lo que más te agrada y lo que menos te agrada del ser humano?',
  '¿A qué le dedicas mucho tiempo?',
  '¿Qué es lo más extraño que te ha pasado?',
  'Entre la seguridad y la inseguridad, ¿para dónde se inclinaría tu balanza personal? ',
  '¿Cómo sería tu pareja ideal?',
  '¿Cómo sientes que te ve la gente?',
  '¿Qué es lo que menos muestras de ti?',
  'El mejor regalo.',
  '¿Qué harías con 10 millones?',
  '¿Qué es lo más lindo que han hecho por ti?',
  '¿Qué es lo más lindo que has hecho por alguien?',
  '¿Qué te agrada de cada uno de los presentes?',
  '¿Hay alguien con quien tengas temas pendientes?',
  'Algo que aún no vives y te encantaría vivir.',
  'Ingredientes para una buena relación.',
  'Una buena adicción.',
  '¿Cuál es el mejor momento del día a día?',
  '¿Quién es la persona que más amas?',
  '¿Por qué te pedirías perdón?',
  '¿Por qué te darías las gracias?',
  '¿Cómo es la relación con tu mejor amigo(a)?',
  '¿Cómo es la relación con tus vecinos?',
  '¿Qué te hace sentir orgullo?',
  '¿Cómo describirías este momento en 3 conceptos?',
  '¿Cuál es tu itinerario en un día normal?',
  'Cuando piensas en tu infancia, ¿cuál es tu primera emoción o recuerdo?',
  '¿Qué tipo de pareja eres o te gustaría ser?',
  '¿Qué es lo que más te agrada de ti?',
  'Cuando miras al pasado, ¿qué te da nostalgia?',
  'Cuando piensas en el futuro, ¿cómo lo visualizas?',
  '¿Cómo es tu mundo social?',
  '¿Cuál es tu mejor recuerdo de adolescencia?',
  'Si tu yo del futuro viniera a darte un consejo, ¿qué crees que te diría?',
  '¿Hay algo que te haya cambiado la vida?',
  'El peor error.',
  'La peor mentira.',
  'La historia del mejor beso.',
  '¿Qué no comerías nunca?',
  '¿Qué es lo que más te gusta hacer?',
  'En un concepto, ¿qué proyecta c/u de los presentes? ',
  '¿Cómo te relacionas con la naturaleza?',
  '¿Quién es o ha sido tu mayor espejo?',
  '¿Cómo describirías tu vida hoy en 3 conceptos?',
  'Si pudieras revivir un momento, ¿cuál sería?',
  'Lo que más te ha marcado.',
  '¿Te consideras más racional o emocional? ¿Por qué?',
  'Te conceden un poder especial para toda la vida, ¿cuál escogerías?',
  'Tu alma en un concepto.',
  '¿Cuál de tus sentidos tienes más desarrollado? ¿Por qué?',
  '¿Sueles evadir o enfrentar?',
  '¿Cómo se llamaría la película de tu vida?',
  '¿Cómo es tu relación con el sexo opuesto?',
  '¿Cuál crees que es la primera impresión que sueles causar?',
  '¿Qué es lo más valiente que has hecho?',
  '¿Qué te inspira?',
  'Si pudieras eliminar algo de este mundo, ¿qué sería?',
  '¿Qué te gustaría que se visibilizara más?',
  '¿Cómo sería tu cita ideal?',
  '¿Cómo sería tu trabajo ideal?',
  'Se te concede la respuesta a la pregunta que desees, ¿qué preguntarías?',
  '¿Cómo era la relación de tus padres cuando naciste?',
  '¿Cuál es la relación más importante en tu vida hoy?',
  '¿Cómo fue tu vida escolar infantil?',
  '¿Cómo sueles ser a la hora de tomar decisiones?',
  'Tu mayor convicción.',
  'Te dan la posibilidad de ver que hubiese sucedido si tomabas otra decisión en tu pasado, ¿a qué episodio irías?',
  '¿Qué te hace sentir libre?',
  '¿Qué te gustaría estar viviendo en 10 años más?',
  '¿Qué significa para ti la fidelidad?',
  'Vienen los ovnis y te ofrecen ir con ellos, ¿qué harías?',
  '¿Cómo vives tu lado ying (femenino) y tu lado yang (masculino)?',
  'Entre tierra, agua, fuego y aire, ¿cuál es la combinación que más te representa? ',
  'Tres cosas que sería imposible que hicieras.',
  '¿Qué película o libro recomendarías?',
  '¿Qué te gustaría saber de tu padre o de tu madre?',
  '¿Qué te asombra?',
  'Un momento que te cambió la vida.',
  '¿Cuál es la conexión humana más intensa que has tenido?',
  '¿Qué te gustaría recordar?',
  'Lo más impactante que te ha tocado ver o vivir.',
  '¿Con quién de los presentes crees podrías tener las conversaciones más profundas?',
  '¿Quién de los presentes crees que es más celoso(a)?',
  '¿Quién de los presentes crees que tiene más claro lo que quiere?',
  '¿Quién de los presentes crees que tiene más historias para contar?',
  '¿Cómo sueles reaccionar ante una situación de peligro?',
  'Te puedes comprar lo que desees, ¿qué es lo primero que viene a tu mente?',
  '¿Cuál ha sido tu mayor cambio?',
  'Tienes una cita importante, ¿qué cocinarías?',
  'Casi nadie sabe que soy… (completa la oración)',
  'Un momento donde sentiste mucho miedo.',
  '¿Te consideras una persona romántica?',
  'Cuando piensas en un momento feliz, ¿qué se te viene a la mente?',
  '¿Cuál sería un panorama entretenido para ti?',
  'Lo más doloroso es… (completa la oración)',
  'Un acontecimiento familiar importante.',
  '¿Has hecho o te han hecho bullying?',
  'Tus mejores vacaciones.',
  'Un paisaje perfecto.',
  '¿En qué sueles gastar más tu dinero?',
  '¿Qué estilo de música te gusta y cuál no?',
  'Tu mejor compra.',
  '¿Adoptarías?',
  'Tu mejor amigo(a) tiene problemas de fertilidad y te pide si puedes donarle óvulos o espermios según sea el caso, ¿lo harías?',
  '¿Cuál crees es el mejor invento que ha creado el hombre?',
  '¿Qué extrañas?',
  'Me desagrada… (completa la oración)',
  '¿Cuál es tu lado “B”?',
  'Un aroma y un sabor especial',
  'Mejor panorama de fin de semana.',
  'Antojo más recurrente.',
  'Tu personalidad en tres conceptos.',
  'Me hace falta... (completa la oración)',
  '¿Te consideras una persona de pensamiento abierto?',
  '¿Qué tan flexible te consideras?',
  '¿Maestro, aprendiz u observador? ¿Por qué?',
  '¿Hay algo que no hayas superado?',
  '¿Has vivido o conoces alguna historia paranormal?',
  '¿Cuál sería un buen panorama romántico?',
  'Me encanta… (completa la oración)',
  'Me alegra el día… (completa la oración)',
  'Guardas en una capsula del tiempo un mensaje para las próximas generaciones, ¿qué les dirías?',
  'Si vieras la película de tu vida hasta el día de hoy, ¿con qué sensación crees que te quedarías?',
  '¿A dónde irías si tuvieras acceso a una máquina del tiempo?',
  'Nunca he sido… (completa la oración)',
  '¿Qué te cuesta aceptar?',
  'Me parece muy difícil de entender… (completa la oración)',
  'Hubo un momento en mi vida que… (completa la oración)',
  '¿Qué importancia tiene para ti la música?',
  'Hay caos en el mundo y debes hacer una huerta, pero sólo puedes elegir 5 semillas, ¿cuáles escoges?',
  'Siempre me he sentido… (completa la oración)',
  '¿Qué prefieres, mar, río, lago o cascada?',
  'Si sólo pudieras comer 3 menús durante un año, ¿cuáles serían?',
  'La peor experiencia.',
  '¿Cómo es la casa de tus sueños?',
  '¿Qué ves cuando te miras?',
  'El mejor aprendizaje.',
  '¿Quién te ha enseñado mucho? ¿Por qué?',
  '¿Qué no volverías a repetir?',
  'Estarás lejos de la civilización por años y te dan a elegir 7 alimentos ilimitados, ¿cuáles eliges?',
  'No podría vivir sin… (completa la oración)',
  '¿Cuál es el clima que más disfrutas?',
  'En un mundo utópico, inventa las 3 principales leyes.',
  'Si pudieras tener la habilidad de un animal, ¿cuál elegirías?',
  'Tienes la opción de volverte inmortal, ¿aceptas?',
  'Si pudieras escoger un aspecto de tu próxima vida, ¿cuál sería?',
  'Ingredientes para una vida feliz.',
  '¿Qué terapias has experimentado, o te gustaría experimentar?',
  '¿Has tenido o te gustaría tener un sueño lúcido?',
  'Un lugar que sea significativo para ti.',
  '¿De qué dudas?',
  'Si fueras invisible por unas horas, ¿a dónde irías?',
  '¿Qué no te has atrevido a hacer?',
  '¿Cuál es tu visión del ser humano?',
  '¿Qué caracteriza a tu familia?',
  'La persona con la que más compartes, ¿cómo es?',
  'La amistad ha sido en mi vida… (completa la oración)',
  '¿Cuál es el mejor cumpleaños que recuerdas?',
  '¿Qué contenidos son los que más consumes?',
  'Un aspecto de ti que te gustaría que tuviera tu pareja.',
  'Tu mayor acierto.',
  'Algo que sea simbólico para ti.',
  'Tu mayor maestro(a).',
  '¿Qué sueles hacer cuando tienes tiempo?',
  '¿Cómo definirías tu vida en 3 conceptos?',
  '¿Qué es lo más romántico que has vivido?',
  'El mayor susto que has pasado.',
  '¿Cómo es el lugar donde pasas la mayor parte del tiempo?',
  'La relación más conflictiva de tu vida.',
  '¿A quién de los presentes te gustaría conocer más?',
  '¿A quién de los presentes te hubiese gustado conocer antes?',
  '¿Quién de los presentes te intriga más?',
  '3 temas que te interesen mucho.',
  '¿Crees en los milagros? ¿Has vivido alguno?',
  '¿Cómo le describirías la tierra a un ser de otro planeta?',
  '¿Cuál es el lugar de tu ciudad que más te gusta?',
  'Te ofrecen ir a un universo paralelo donde estaría tu alma gemela, pero no hay retorno, ¿irías?',
  'Un hecho importante que marcó tu vida.',
  'Escoge a alguien de los presentes e imagínalo en una vida pasada, ¿qué se te viene a la mente?',
  '5 cosas que debería tener tu paraíso perfecto',
  '¿Qué agradeces?',
  'Si pudieras construir algo con sólo pensarlo, ¿qué construirías?',
  '¿Cuál sientes que es tu talento?',
  'Algo físico o psicológico que te guste de alguno de los presentes.',
  '¿Qué sacarías de tu vida?',
  'A la hora de viajar, ¿cuáles son tus 3 objetos indispensables?',
  '¿Qué regalo te gustaría dar o recibir?',
  'La mejor herencia es… (completa la oración)',
  '¿Qué has aprendido este último año?',
  'Algo que te agrade del género femenino y masculino.',
  '¿Qué mensaje le darías al sexo opuesto?',
  'Tu mayor logro.',
  '¿Cuál sentido es tu favorito?',
  '¿Qué aspecto de tu vida cambiarías y cuál no?',
  '¿Qué te cuesta tolerar?',
  '¿Qué es lo que más aprecias?',
  '¿Quién es la persona que más ha influido en tu vida?',
  '¿Dónde te gustaría vivir?',
  '¿Qué harías si ganaras un premio millonario?',
  '¿Cómo describirías tu mente?',
  '¿Qué es lo que más te identifica?',
  '¿Te consideras una persona relajada o estresada?',
  'La pérdida más importante.',
  '¿Qué don te gustaría tener?',
  'Un hábito que te gustaría sumar o restar.',
  'Un recuerdo alegre de tu infancia o adolescencia.',
  'Tu mayor tesoro.',
  '¿Qué no cambiarías de tu cotidiano?',
  'Tu mejor descubrimiento.',
  '¿Con qué elemento asocias a cada uno de los presentes? (agua, aire, tierra, fuego)',
  '¿Quién de los presentes crees que es más versátil?',
  '¿Respetas el mundo LGBT?',
  '¿Quién de los presentes crees que es más intenso?',
  '¿Quién de los presentes crees que es más honesto?',
  '¿Quién de los presentes crees que se parece más a ti?',
  '¿Cómo te imaginas el mundo en 50 años más?',
  '¿Qué tan importante es el conocimiento en tu vida?',
  '¿Qué es lo más importante que has aprendido?',
  '¿Qué criticas?',
  '¿Has sentido atracción por alguien de tu mismo sexo?',
  '¿Qué le preguntarías a un vidente?',
  '¿Qué le preguntarías a un sabio?',
  'El desafío más grande.',
  '¿Qué no has vivido y te gustaría vivir?',
  '¿Qué es lo que menos te importa?',
  'Una anécdota graciosa.',
  '¿Te consideras una persona fiel?',
  '¿Te consideras una persona cariñosa?',
  'El mejor recuerdo con amigos o en familia.',
  '¿Qué es lo más característico de tu padre y/o de tu madre?',
  '¿Estás más del lado del control o del descontrol?',
  '¿Qué no cambiarías de ti?',
  '¿Cambiarías algo de tu familia?',
  'Algo con lo que sueñas.',
  '¿Quién de los presentes crees que te daría el mejor consejo?',
  '¿Sueles concretar o postergar?',
  '¿Qué no te comprarías jamás?',
  '¿Qué piensas de la reencarnación?',
  '¿Qué te descontrola?',
  '¿Qué te da seguridad?',
  'Recuerdo de alguna aventura.',
  'La decisión más importante.',
  '¿Pides ayuda cuando lo necesitas?',
  'Te contactan para que seas parte de un reality, ¿participarías?',
  'Es el fin del mundo y te seleccionan para poblar un nuevo planeta, sólo puedes llevar a una persona, ¿irías?',
  '¿Expresas tus emociones con facilidad?',
  '¿Qué te cuesta entender?',
  '¿Has sentido una conexión de otras vidas?',
  '¿A qué no te acostumbras?',
  '¿Cuál es el mundo que te gustaría dejarle a tus hijos?',
  '¿Te amas?',
  'Un genio mágico te concede 3 deseos, ¿qué pedirías?',
  '¿Te consideras una persona espiritualmente despierta o dormida?',
  'Si uno de tus padres te confiesa que su origen es extraterrestre, ¿cuál sería tu reacción?',
  'Se abre un portal a otro mundo frente a ti, y una multitud te invita a que lo cruces, ¿lo harías?',
  '¿Cuál es tu visión de los extraterrestres?',
  'Te despiertas en otro cuerpo y otro espacio, ¿qué harías?',
  '¿Qué es intocable para ti?',
  '¿Qué es lo más importante que has vivido en este último tiempo?',
  '¿Qué es lo más mágico que has vivido?',
  '¿Con qué tipo de personas te gustaría rodearte?',
  '¿Qué alimenta tu corazón?',
  '¿Qué alimenta tu mente?',
  '¿Qué aspecto de tu personalidad es el que más ha cambiado?',
  '¿Sueles confiar o te cuesta?',
  '¿Qué evitas?',
  'Algo que consideres arte.',
  '¿Te sientes una persona empoderada?',
  '¿Qué te asusta?',
  '¿Te gusta lo que estás viviendo?',
  'El objeto más significativo de tu hogar.',
  '¿Cómo imaginas el después de la muerte?',
  '¿Cuál sientes que es tu misión en esta vida?',
  'El mejor desayuno y almuerzo.',
  '¿Qué no te gusta ver?',
  '¿Qué te causa tristeza?',
  'Si nada te diera miedo, ¿qué te atreverías a hacer?',
  '¿Qué te gustaría que se hiciera realidad?',
  'Me considero una persona… (completa la oración)',
  'Tu mayor locura.',
  'Suelo ser… (completa la oración)',
  '¿Es fácil o difícil conquistarte?',
  '¿Qué te conquista?',
  'La mejor noticia que te han dado.',
  '¿Hay algo de tu realidad que te gustaría modificar?',
  '¿La aventura es parte de tu vida?',
  '¿Pasas más tiempo contigo o con otros?',
  '¿Disfrutas la soledad?',
  '¿Cómo es tu yo adolescente?',
  '¿Qué te ha hecho crecer?',
  'Si tu cuerpo te quisiera decir algo, ¿qué sería?',
  '¿Cómo alimentas tu alma?',
  'Una habilidad o don que admires',
  '¿Cómo te gustaría contribuir al mundo?',
  'Ves a un hombre golpeando a una mujer, ¿cuál sería tu actitud?',
  '¿Cómo es tu conexión con los animales?',
  'La mejor experiencia.',
  'Algo que te parezca perfecto.',
  '¿Qué valoras?',
  '¿Qué traerías de tu pasado al hoy?',
  '¿Qué te gustaría atraer?',
  'Una creencia que eliminarías.',
  'Algo que llame mucho tu atención.',
  'Hacia dónde se inclina tu balanza, ¿dar o recibir?',
  'Cuando piensas en tus ancestros, ¿qué es lo primero que viene a tu mente?',
  '¿Cómo sería tu hogar perfecto?',
  '¿Cómo es tu niño interior?',
  '¿Sueles tomar la iniciativa o dejarte llevar?',
  '¿Qué es lo que más disfrutas?',
  '¿Qué te da paz o te hace sentir bien?',
  'El vínculo más especial de tu vida.',
  '¿Qué debes soltar?',
  'Lo más peligroso que has vivido.',
  '¿Qué no harías como padre o madre?',
  '¿Cómo ves las nuevas generaciones?',
  '¿Te gustan los cambios o te resistes?',
  '¿Qué tanto te conoce la gente que te rodea?',
  '¿Sueles vivir más en el presente, pasado o futuro?',
  'El desafío del ser humano es… (completar la oración)',
  '¿Quién es la mejor persona que conoces?',
  '¿Te gusta lo que estás viviendo?',
  'Imagina que atraviesas un portal dimensional, ¿qué es lo primero que viene a tu mente? ',
  '¿Quién de los presentes crees que goza más la vida?',
  '¿Quién de los presentes crees que se siente más realizado?',
  '¿Quién de los presentes crees que es más magnético?',
  '¿Quién de los presentes te parece más alegre?',
  '¿De quién te gustaría recibir un abrazo?',
  '¿Tienes alguna conversación pendiente?',
  '¿Quién o qué alegra tu vida?',
  'Un libro o una película significativa para ti.',
  'La mejor historia de amor que conoces o has vivido.',
  '¿Con qué resuenas?',
  'Un momento inolvidable.',
  'Un deseo para la humanidad.',
  '¿Cuándo sientes que aprovechas el tiempo?',
  'Alguna historia importante en tu familia o árbol genealógico.',
  '¿Qué clausurarías?',
  '¿Qué te gustaría que fuera diferente en tu vida?',
  'Cuando algo te molesta, ¿qué sueles hacer?',
  '¿Cuál sería tu trabajo ideal?',
  'Anécdota memorable.',
  'Lo que más te ha gustado aprender en la vida.',
  '¿Hay algo de lo que te arrepientas?',
  '¿En qué confías y en qué desconfías?',
  '¿Qué crees que podrían pensar los extraterrestres de nosotros?',
  '¿Te hubiese gustado nacer sabiendo de tu vida anterior?',
  '¿Qué marca un antes y un después en tu vida?',
  'Si viajarás al pasado, ¿qué consejo le darías a tu yo de la infancia?',
  'Si recibieras una visita de tu yo del futuro, ¿qué le preguntarías?',
  '¿Qué crees que no se debería hacer en la primera cita?',
  'Cuando miras al pasado, ¿qué ves?',
  '¿Qué destruye al hombre?',
  '¿Qué consejo le darías al mundo?',
  '¿Cómo sería un buen amor?',
  '¿Cómo eras de niño(a)?',
  '¿Cómo fue tu infancia?',
  '¿Qué hay de tu padre y de tu madre en ti?',
  '¿Qué de ti es lo que menos le muestras al mundo?',
  'Si viajaras al pasado y pudieras darte un consejo, ¿cuál sería? ',
  '¿Cuál es tu mayor miedo?',
  '¿Cuál es tu mayor sueño?',
  '¿En qué no crees?',
  '¿Qué elemento sientes más débil en ti? (tierra, agua, fuego, aire)',
  '¿Qué animal te causa curiosidad? ¿Hay alguno que rechaces?',
  '¿Qué animal no te gustaría ser?',
  '¿Qué es lo mejor de la vida?',
  '¿Por qué ser o no madre o padre?',
  '¿Cuál ha sido la mayor lección que te ha dado la vida?',
  '¿Te consideras una persona libre?',
  '¿Con qué tipo de personas te sientes más a gusto?',
  '¿Qué necesitas dejar de repetir?',
  '¿Qué tan cerca estás de tus sueños?',
  '¿Cuál es la escena que más se repite en tu cotidiano?',
  '¿Qué se te hace fácil de realizar?',
  '¿Qué no te gusta realizar?',
  'Un deseo cumplido.',
  'Un deseo aún no cumplido.',
  '¿Qué eleva tu vibración?',
  '¿Qué te hace falta?',
  '¿Qué necesitas soltar?',
  '¿Por dónde divaga tu mente la mayor parte del tiempo?',
  '¿Qué te gustaría que todo el mundo entendiera?',
  '¿Cómo quieres vivir esta vida? ¿Lo estás haciendo?',
  '¿Cómo te gustaría que te recordaran?',
  '¿Cuál ha sido tu batalla más grande?',
  '¿En cuál etapa de tu vida te has sentido más feliz?',
  '¿Qué es para ti la energía?',
  '¿Hay algo que necesites perdonar?',
  '¿Qué te provocan las distintas estaciones del año?',
  '¿Qué te incomoda?',
  '¿Qué te motiva? ¿Qué te mueve?',
  '¿Qué te sensibiliza?',
  '¿Cómo es tu forma de amar?',
  '¿Qué te duele?',
  '¿Qué lugar ocupa la imaginación o la creatividad en tu vida?',
  '¿En qué estación del año está tu corazón ahora?',
  '¿Qué te emociona?',
  '¿Qué instrumento musical te gustaría saber tocar?',
  '¿Cómo fue la historia de tu primer amor?',
  '¿Qué es lo que más disfrutas hacer cuando estás solo(a)?',
  'Si mañana fuera tu último día, ¿qué harías?',
  '¿Cómo es tu energía?',
  'Una experiencia difícil que desees compartir.',
  '¿Qué te mata las pasiones?',
  '¿Qué te enamora?',
  '¿Qué te enfada?',
  'Un sueño que no olvides.',
  '¿Hay algún factor común entre las parejas que has tenido o las personas que te rodean?',
  '¿Qué te causa inseguridad?',
  '¿Qué sentido crees que tiene la experiencia humana?',
  '¿De dónde crees que venimos? ¿Qué teoría es la que más te resuena?',
  '¿Qué etapa de tu vida es la más emocionante?',
  'Tienes la misión de crear un nuevo programa de tv, ¿de qué se trataría?',
  '¿De qué no sueles hablar? ',
  '¿Cuál ha sido el mejor regalo que has recibido? ',
  '¿Cómo sería tu muerte ideal?',
  '¿Quién de los presentes crees que era más terrible en su infancia?',
  '¿Quién de los presentes crees que es más generoso?',
  '¿Quién de los presentes crees que dejaría todo por amor?',
  '¿Quién de los presentes crees que es menos influenciable?',
  '¿Quién de los presentes crees que es más inocente?',
  '¿Cómo describirías tu adolescencia?',
  '¿Qué te gustaría aprender?',
  '¿Quién es la persona que más te conoce?',
  'Alguien que ya no esté en tu vida y que te gustaría poder ver.',
  '¿Qué te estresa?',
  '¿Qué te falta vivir?',
  '¿Que tienes pendiente?',
  '¿Qué te hace feliz?',
  '¿Que sientes que fuiste o viviste en otra vida?',
  'Tu mejor viaje.',
  '¿Tienes hermanos? ¿Cómo es la relación?  Si no tienes, ¿cómo ha sido no tenerlos?',
  '¿Qué es lo más extremo que has realizado?',
  '¿Cómo te relacionas con el control?',
  '¿Cuál es el lugar donde te sientes más cómodo(a)? ',
  '¿Cómo es o fue la relación con tus abuelos?',
  '¿Qué es lo que más valoras de tu vida hoy?',
  '¿Qué aspecto de tu personalidad te gustaría que heredará tu hijo?',
  '¿Cuál es el juguete de tu infancia que más recuerdas?',
  '¿Qué es lo que más te gusta del sexo opuesto?',
  '¿Qué es lo que más te gusta de tu genero? ',
  '¿En qué crees que serías bueno(a)?',
  '¿Qué caracteriza a tus amigos?',
  '¿Cuál es tu mayor dolor?',
  'La mejor aventura.',
  'Un momento adrenalínico.',
  'Una película que te haya marcado. ',
  'No puedo resistirme a… (completar la oración)',
  '¿Qué le agradeces a tus padres o a la vida?',
  'Tu placer culpable.',
  '¿Qué es lo que más disfrutas comer?',
  '¿Cómo te consideras como amigo?',
  'La conexión más mística que has tenido con alguien.',
  'Un hito importante en tu vida.',
  '¿Cuál es el aprendizaje más grande que te ha dado tu pareja, ex pareja o alguien de tu familia?',
  '¿Cuándo eras niño, que querías ser de grande?',
  '¿Para qué no estás preparado?',
  '¿Cuál sería el viaje de tus sueños?',
  '¿Cuál ha sido el lugar más lindo que has conocido?',
  'Lo que más te agrada de ti.',
  'Un momento lindo que hayas vivido.',
  '¿Qué es imprescindible para ti?',
  '¿Cuál es la hora del día que más disfrutas?',
  '¿Qué tipo de cine es el que más te gusta?',
  '¿Cuál es el primer recuerdo que se te viene a la mente de tu niñez?',
  '¿Quiénes son las 3 mujeres más importantes en tu vida?',
  '¿De qué te apasiona conversar?',
  '¿Qué te intriga?',
  '¿Qué es lo más loco que has hecho?',
  'Algo que consideres una verdad.',
  '¿De qué escapas?',
  '¿Cómo te identificas con tu signo?',
  '¿Cómo es o era la relación de tus padres?',
  '¿Que necesitas hoy?',
  'Cuando necesitas un consejo, ¿a quién recurres?',
  'Algo que nunca más harías.',
  'Una persona coquetea exageradamente con tu pareja, ¿cuál es tu reacción?',
  '¿Qué es fundamental incentivar?',
  '¿Qué es lo más valioso que tienes o has perdido?',
  '¿Cuál sientes o crees que es la misión del ser humano?',
  '¿Qué te gustaría entender?',
  '¿Qué te inspira? ',
  '¿Qué te apasiona?',
  '¿Qué te hubiese gustado hacer que probablemente ya no harás?',
  'Si la vida fuese un juego, ¿qué tipo de personaje te gustaría ser?',
  '¿A qué te gustaría dedicarle más tiempo?',
  'Si pudieras ir a otro tiempo, ¿irías al pasado o al futuro?',
  '¿Qué le regalarías a cada uno de los presentes?',
  'Imagina que despiertas y estás en un cuerpo del sexo opuesto por un día, ¿qué harías?',
  'Si pudieras ser un animal por un día, ¿qué animal te gustaría ser?',
  'Imagina tu familia ficticia con cada uno de los presentes, ¿qué rol le darías a cada uno?',
  'Si pudieras elegir tu próxima vida, ¿cómo te gustaría que fuese?',
  'Si pudieras crear una ley, ¿cuál sería?',
  'Si lo tuyo fuese escribir, ¿sobre qué trataría tu libro?',
  'Te regalan un viaje para dar la vuelta al mundo y puedes invitar a una persona, ¿quién sería?',
  'Actor, actriz o personaje famoso que te guste mucho.',
  '¿Quién de los presentes crees que es más emocional?',
  '¿Quién de los presentes crees que es más aventurero(a)?',
  '¿Quién de los presentes crees que maneja mejor el estrés?',
  '¿Quién de los presentes crees que está más empoderado(a)?',
  '¿Quién de los presentes crees que sería mejor compañero de viaje?',
  '¿Quién de los presentes te parece más enigmático?',
  '¿Por qué vale la pena luchar y por qué no?',
  '¿Qué te enoja?',
  '¿Cómo te relacionas con los límites?',
  '¿Qué desconoces y te gustaría conocer?',
  '¿Sientes que te sabes defender?',
  '¿Qué sientes que espera tu familia de ti?',
  'Si el mundo fuera dirigido sólo por mujeres, ¿cómo te lo imaginas?',
  '¿Cuál es la emoción más recurrente en tu vida? ',
  '¿Se te ha prohibido algo en la vida?',
  '¿Qué sientes que viniste a sanar en esta vida?',
  '¿Cómo te relacionas con la culpa?',
  '¿Quién es tu cable a tierra?',
  '¿Qué te frustra?',
  '¿Qué mensaje le darías a alguien que se siente solo?',
  '¿Qué regalo te darías?',
  '¿Cuáles son tus momentos de mayor felicidad?',
  '¿Qué haces por ti?',
  '¿Te consideras independiente?',
  '¿Qué rechazas?',
  'Si piensas en tus ancestros, ¿cuál es la primera emoción que te viene?',
  'Es violento... (completa la oración)',
  '¿Qué deseas?',
  '¿Cómo es tu mundo exterior?',
  '¿Cómo es tu mundo interior?',
  '¿Te consideras una persona paciente?',
  '¿Cómo te relacionas con la energía del dinero?',
  '¿Quién es la persona más diferente que has conocido? ',
  'El peor invento del hombre',
  'Te ofrecen una vida llena de abundancia a cambio de perder todo lo que tienes actualmente, incluyendo personas, ¿aceptas?',
  'En tu próxima vida, ¿qué sexo te gustaría tener?',
  '¿Qué necesita el mundo para poder evolucionar?',
  '¿Qué ha sido lo más injusto que te ha tocado vivir?',
  '¿Qué no te puede faltar nunca?',
  '¿Qué te sorprende?',
  '¿Qué ha significado para ti la pandemia?',
  '¿Qué eliminarías?',
  'Un recuerdo memorable.',
  'Me gustaría que las personas fueran conscientes de… (completa la oración)',
  '¿Qué mensaje le darías a las mujeres del mundo?',
];

List<dynamic> jugadores;
List<dynamic> colores;
String pregunta = '';
String responde = '';
String nombreJugadorTurno = '';
String colorTurno = '';
List<String> mano;

String imagenBarraJugador = 'assets/barra_nombre.png';

List<Image> circulos = [];

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() {
    return _Screen4State();
  }
}

class _Screen4State extends State<Screen4> {
  /*
  List<Image> circulos = [
    Image.asset(
      'assets/jugador_amarillo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_azul.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_calipso.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_naranjo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_negro.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_pistacho.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_rojo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_rosado.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_verde_musgo.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_verde.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_violeta.png',
      width: 70,
    ),
    Image.asset(
      'assets/jugador_morado.png',
      width: 70,
    )
  ];*/

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      FirebaseFirestore.instance
          .collection('partidas')
          .doc(Session.codigoPartida)
          .snapshots()
          .listen((doc) {
        jugadores = doc.get('jugadores');
        colores = doc.get('colores');
        int turno = doc.get('turno');

        responde = doc.get('responde');
        print('Screen4 - responde: ' + responde);
        pregunta = doc.get('pregunta');
        print('Screen4 - pregunta: ' + pregunta);

        nombreJugador = Session.nombreJugador;
        nombreJugadorTurno = jugadores[turno];
        colorTurno = colores[turno];

        if (nombreJugador == pregunta) {
          iguales = true;
        } else {
          iguales = false;
        }
        print('Screen4 - iguales: ' + iguales.toString());

        textoPregunta = doc.get('textoPregunta');

        if (textoPregunta.isNotEmpty) {
          Navigator.pushReplacementNamed(context, '/screen5');
        } else {
          print('Screen4 - textoPregunta no está definido aún');
        }

        circulos = List<Image>.generate(
            colores.length,
            (index) => Image.asset('assets/jugador_' + colores[index] + '.png',
                width: 70));

        switch (colorTurno) {
          case 'amarillo':
            circulos[turno] = Image.asset(
              'assets/jugador_amarillo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_amarillo.png';
            break;
          case 'azul':
            circulos[turno] = Image.asset(
              'assets/jugador_azul_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_azul.png';

            break;
          case 'calipso':
            circulos[turno] = Image.asset(
              'assets/jugador_calipso_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_calipso.png';

            break;
          case 'naranjo':
            circulos[turno] = Image.asset(
              'assets/jugador_naranjo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_naranjo.png';

            break;
          case 'negro':
            circulos[turno] = Image.asset(
              'assets/jugador_negro_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_negro.png';

            break;
          case 'pistacho':
            circulos[turno] = Image.asset(
              'assets/jugador_pistacho_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_pistacho.png';

            break;
          case 'rojo':
            circulos[turno] = Image.asset(
              'assets/jugador_rojo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rojo.png';

            break;
          case 'rosado':
            circulos[turno] = Image.asset(
              'assets/jugador_rosado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_rosado.png';

            break;
          case 'verde_musgo':
            circulos[turno] = Image.asset(
              'assets/jugador_verde_musgo_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde_musgo.png';

            break;
          case 'verde':
            circulos[turno] = Image.asset(
              'assets/jugador_verde_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_verde.png';

            break;
          case 'violeta':
            circulos[10] = Image.asset(
              'assets/jugador_violeta_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_violeta.png';

            break;
          case 'morado':
            circulos[turno] = Image.asset(
              'assets/jugador_morado_con_circulo.png',
              width: 70,
            );

            imagenBarraJugador = 'assets/barra_jugador_morado.png';

            break;
        }
        setState(() {}); // NO SE SI VA DENTRO DEL {} anterior o no
      });
    });

    // El siguiente código realiza lo que sería el proceso de sacar cartas del mazo a la mano
    int carta1 = Session.carta1;
    int carta2 = Session.carta2;
    int carta3 = Session.carta3;

    List<int> cartas = [];

    print("Cartas: $carta1 $carta2 $carta3");

    if (carta1 == null) {
      int randomInt;
      do {
        randomInt = Random().nextInt(preguntas.length);
      } while (cartas.contains(randomInt));
      carta1 = randomInt;
      print("carta1 $carta1");
      Session.carta1 = carta1;
    }

    cartas.add(carta1);

    if (carta2 == null) {
      int randomInt;
      do {
        randomInt = Random().nextInt(preguntas.length);
      } while (cartas.contains(randomInt));
      carta2 = randomInt;
      print("carta2 $carta2");
      Session.carta2 = carta2;
    }

    cartas.add(carta2);

    if (carta3 == null) {
      int randomInt;
      do {
        randomInt = Random().nextInt(preguntas.length);
      } while (cartas.contains(randomInt));
      carta3 = randomInt;
      print("carta3 $carta3");
      Session.carta3 = carta3;
    }

    cartas.add(carta3);

    mano = [preguntas[carta1], preguntas[carta2], preguntas[carta3]];

    print("cartas: $cartas");
    print("mano: $mano");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Screen4 - $nombreJugador')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              //Colors.blue,
              //Colors.red,
              Color(0xFF00003C),
              Color(0xFF091855),
              Color(0xFF1D5E7F),
              Color(0xFF635783),
              Color(0xFFB2656C),
              Color(0xFFFDD793),
            ],
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('Responde: ' + responde),
            Column(
              children: [
                (responde == 'TODOS')
                    ? Text(
                        'RESPONDEN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      )
                    : Text(
                        'RESPONDE',
                        style: TextStyle(
                            fontFamily: 'GillSans',
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 21),
                      ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  (responde == 'TODOS')
                      ? Image.asset(
                          'assets/barra_con_color_todos_responden.png',
                          width: 200,
                        )
                      : (responde == nombreJugadorTurno)
                          ? Image.asset(
                              imagenBarraJugador,
                              width: 200,
                            )
                          : Image.asset(
                              'assets/barra_nombre.png',
                              width: 200,
                            ),
                  Text(
                    responde,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ]),
              ],
            ),
            CircleList(
              origin: Offset(0, 0),
              innerRadius: 100,
              outerRadius: 180,
              rotateMode: RotateMode.stopRotate,
              children: circulos,
              centerWidget: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  (responde == 'TODOS')
                      ? Image.asset(
                          'assets/disco_central_para_todos.png',
                          width: 200,
                        )
                      : Image.asset(
                          'assets/disco_central_para_uno.png',
                          width: 200,
                        ),
                ],
              ),
            ),
            //Text('Pregunta: ' + pregunta),
            Column(
              children: [
                Text(
                  'PREGUNTA',
                  style: TextStyle(
                      fontFamily: "GillSans",
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 21),
                ),
                Stack(alignment: Alignment.center, children: <Widget>[
                  (pregunta == nombreJugadorTurno)
                      ? Image.asset(
                          imagenBarraJugador,
                          width: 200,
                        )
                      : Image.asset(
                          'assets/barra_nombre.png',
                          width: 200,
                        ),
                  Text(
                    pregunta,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: iguales
                      ? Image.asset('assets/icono_tus_cartas.png')
                      : Image.asset('assets/icono_tus_cartas_opaco.png'),
                  iconSize: 70,
                  onPressed: iguales
                      ? () {
                          _showMessageDialog(context, 'Elige la pregunta');
                        }
                      : null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 200.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mano.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(mano[index]),
            onTap: () {
              Navigator.pop(context); // quita el alertdialog antes de pasar a
              //la siguiente ventana

              if (index == 0) {
                Session.carta1 = null;
                print("carta1 removed");
              } else if (index == 1) {
                Session.carta2 = null;
                print("carta2 removed");
              } else if (index == 2) {
                Session.carta3 = null;
                print("carta3 removed");
              }

              FirebaseFirestore.instance
                  .collection('partidas')
                  .doc(Session.codigoPartida)
                  .update({'textoPregunta': mano[index]});
            },
          );
        },
      ),
    );
  }


  Widget eligePreguntaReemplazarContainer(String pregunta) {
    return Container(
      height: 200.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mano.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(mano[index]),
            onTap: () {
              Navigator.pop(context); // quita el alertdialog antes de pasar a
              //la siguiente ventana

              if (index == 0) {
                Session.carta1 = null;
                print("carta1 removed");
              } else if (index == 1) {
                Session.carta2 = null;
                print("carta2 removed");
              } else if (index == 2) {
                Session.carta3 = null;
                print("carta3 removed");
              }

              FirebaseFirestore.instance
                  .collection('partidas')
                  .doc(Session.codigoPartida)
                  .update({'textoPregunta': pregunta});

              FirebaseFirestore.instance.collection('reemplazar_pregunta').add({
                'pregunta': pregunta,
              });
            },
          );
        },
      ),
    );
  }

  _showMessageDialog(BuildContext context, String titulo) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: setupAlertDialoadContainer(),
          actions: [
            FlatButton(
              child: Text("Reemplazar pregunta por una propia"),
              onPressed: () {
                Navigator.pop(context);
                _showTextoPreguntaReemplazarDialog(
                    context, "Ingresa tu propia pregunta");
              },
            ),
          ],
        ),
      );

  _showTextoPreguntaReemplazarDialog(BuildContext context, String titulo) {
    String pregunta = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: TextField(
          onChanged: (value) {
            pregunta = value;
          },
          //controller: _textFieldController,
          //decoration: InputDecoration(hintText: "Text Field in Dialog"),
        ),
        actions: [
          FlatButton(
            child: Text("Reemplazar"),
            onPressed: () {
              Navigator.pop(context);

              _showEligePreguntaReemplazarDialog(
                  context, "Elige la pregunta que quieres reemplazar", pregunta);

            },
          ),
        ],
      ),
    );
  }

  _showEligePreguntaReemplazarDialog(BuildContext context, String titulo, String pregunta) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(titulo),
          content: eligePreguntaReemplazarContainer(pregunta),
        ),
      );
}
