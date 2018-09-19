package org.pzy.tmall.util;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.exception.InvalidConfigurationException;
import org.mybatis.generator.exception.XMLParserException;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MyMyBatisGenerator {

    public static void main(String[] args) throws ParseException, IOException, XMLParserException,
            InvalidConfigurationException, SQLException, InterruptedException {
        String today = "2018-9-14";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(today);
        Date now = new Date();

        if (now.getTime() > date.getTime() + 1000 * 60 * 60 * 24){
            System.err.println("********Cannot Execute********");
            System.err.println("This problem is destructive, which can only operate once");
            return;
        }
        List<String> warnings = new ArrayList<>();
        boolean overwrite = true;
        InputStream is = MyMyBatisGenerator.class.getClassLoader().getResource("generatorConfig.xml").openStream();
        ConfigurationParser configurationParser = new ConfigurationParser(warnings);
        Configuration configuration = configurationParser.parseConfiguration(is);
        is.close();
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(configuration, callback, warnings);
        myBatisGenerator.generate(null);

        System.out.println("Successfully generate the data, which could override the existing file");
    }
}
