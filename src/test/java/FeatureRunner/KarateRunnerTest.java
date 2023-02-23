package FeatureRunner;

import static org.junit.Assert.*;

import java.io.File;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class KarateRunnerTest {

	@BeforeClass
	public static void beforeClass() {	
		System.setProperty("karate.env", "qa");
	}
	@Test
	public void testParallel() {
		Results results = Runner.path("src/test/java/resources)
				 .outputCucumberJson(true)
				.parallel(1);
		String OutputPath = results.getReportDir();
		File f = new File(OutputPath);
		if (f.exists() && f.isDirectory())
			generateReport(OutputPath);
		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}

	 public static void generateReport(String karateOutputPath) {        
	        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
	        final List<String> jsonPaths = new ArrayList(jsonFiles.size());
	        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
	        Configuration config = new Configuration(new File("target"), "demo");
	        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
	        reportBuilder.generateReports();        
	    }

}
