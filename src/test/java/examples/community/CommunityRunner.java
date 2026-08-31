package examples.community;

import com.intuit.karate.junit5.Karate;

class CommunityRunner {
    
    @Karate.Test
    Karate testEmployees() {
        return Karate.run("community").relativeTo(getClass());
    }    

}
