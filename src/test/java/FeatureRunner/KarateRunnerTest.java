package FeatureRunner;

import java.io.File;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;

import com.intuit.karate.cucumber.CucumberRunner;
import com.intuit.karate.cucumber.KarateStats;

import cucumber.api.CucumberOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

//tags = "@Mobile-user-exists",
//to run single or multi tags use above
@CucumberOptions(features = { "classpath:resources/" })
public class KarateRunnerTest {

	@BeforeClass
	public static void beforeClass() {
		System.setProperty("karate.env", "qa");
	}

	@Test
	public void testParallel() {
		String OutputPath = "target/surefire-reports";
		KarateStats stats = CucumberRunner.parallel(getClass(), 10, OutputPath);
		generateTestReport(OutputPath);
	}

	private static void generateTestReport(String OutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(OutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList(jsonFiles.size());
		for (File file : jsonFiles) {
			jsonPaths.add(file.getAbsolutePath());
		}
		File file = new File("Execution report");
		file.mkdirs();
		Configuration config = new Configuration(file, "API Execution Report");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();

	}

}
