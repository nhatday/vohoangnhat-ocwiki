package oop.util;

import java.io.IOException;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.AnnotationIntrospector;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.type.TypeReference;
import org.codehaus.jackson.xc.JaxbAnnotationIntrospector;

public final class JsonUtils {

	private JsonUtils() {
	}
	
	private static ObjectMapper mapper;
	
	static {
		mapper = new ObjectMapper();
		mapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS, false);
		AnnotationIntrospector introspector = new JaxbAnnotationIntrospector();
		// make deserializer use JAXB annotations (only)
	    mapper.getDeserializationConfig().setAnnotationIntrospector(introspector);
	    // make serializer use JAXB annotations (only)
	    mapper.getSerializationConfig().setAnnotationIntrospector(introspector);
	}

	public static String toJson(Object obj) throws Exception {
		return mapper.writeValueAsString(obj);
	}
	
	public static <T> T fromJson(String json, TypeReference<T> type)
			throws JsonParseException, JsonMappingException, IOException {
		return mapper.readValue(json, type);
	}
	
}
