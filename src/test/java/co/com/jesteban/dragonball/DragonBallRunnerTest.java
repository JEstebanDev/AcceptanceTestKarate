package co.com.jesteban.dragonball;


import com.intuit.karate.junit5.Karate;

public class DragonBallRunnerTest {
    @Karate.Test
    Karate testAll() {
        // Puedes apuntar a todas las características en un paquete:
        // return Karate.run("classpath:co/com/jesteban/dragon-ball/features").relativeTo(getClass());
        // Puedes apuntar a una característica específica:
        return Karate.run("classpath:co/com/jesteban/dragon-ball/features/characters.feature").relativeTo(getClass());
        // O por etiquetas:
        // return Karate.run("classpath:co/com/jesteban/dragon-ball/features").tags("@smoke").relativeTo(getClass());
    }
}
