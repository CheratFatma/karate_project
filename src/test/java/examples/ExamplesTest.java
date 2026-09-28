package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import io.qameta.allure.karate.AllureKarate;


class ExamplesTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:examples")
                //.outputCucumberJson(true)
                .hook(new AllureKarate())
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
