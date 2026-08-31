package examples.employees;

import com.intuit.karate.junit5.Karate;

class EmployeesRunner {
    
    @Karate.Test
    Karate testEmployees() {
        return Karate.run("employees").relativeTo(getClass());
    }    

}
