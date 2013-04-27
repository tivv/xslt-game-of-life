package game;

import junit.framework.Assert;
import org.apache.commons.io.IOUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Arrays;
import java.util.List;

/**
 * @author Vitalii Tymchyshyn
 */
@RunWith(Parameterized.class)
public class XSLTTest {
    @Parameterized.Parameters
    public static List<Object[]> getParams() {
        return Arrays.asList(new Object[][] {
                {"test1.xml"},
                {"test2.xml"},
                {"testRetain.xml"},
                {"testRotate.xml"},

        });
    }

    private String fileName;

    public XSLTTest(String fileName) {
        this.fileName = fileName;
    }

    @Test
    public void testTransform() throws TransformerException, IOException {
        TransformerFactory factory = TransformerFactory.newInstance();
               Source xslt = new StreamSource(XSLTTest.class.getResourceAsStream("/game.xsl"));
               Transformer transformer = factory.newTransformer(xslt);
        Source text = new StreamSource(XSLTTest.class.getResourceAsStream("/in/" + fileName));
        StringWriter result = new StringWriter();
        transformer.transform(text, new StreamResult(result));
        String expectedResult = IOUtils.toString(XSLTTest.class.getResourceAsStream("/expected/" + fileName));
        Assert.assertEquals(expectedResult, result.toString());
    }
}
