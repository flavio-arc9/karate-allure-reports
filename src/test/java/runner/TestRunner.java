package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import io.qameta.allure.karate.AllureKarate;

public class TestRunner {

    @Test
    public void Runner() {
        Runner.path("classpath:resources/features")
                .hook(new AllureKarate())
                .outputCucumberJson(true)
                .outputJunitXml(true)
                .relativeTo(getClass())
                .parallel(1);

    }
}
