package model;

import java.util.List;

public class Scan {

    private String target;
    private int breaches;
    private int risk;
    private List<String> breachDetails;

  
    private String scanType;    
    private String targetType;   
    private String scanTime;     

    
    public Scan() {}

    
    public Scan(String target, int breaches, int risk, List<String> breachDetails,
                String scanType, String targetType, String scanTime) {

        this.target = target;
        this.breaches = breaches;
        this.risk = risk;
        this.breachDetails = breachDetails;
        this.scanType = scanType;
        this.targetType = targetType;
        this.scanTime = scanTime;
    }

   
    public Scan(String target, int breaches, int risk, List<String> breachDetails) {
        this.target = target;
        this.breaches = breaches;
        this.risk = risk;
        this.breachDetails = breachDetails;
    }

    /* GETTERS */
    public String getTarget() { return target; }
    public int getBreaches() { return breaches; }
    public int getRisk() { return risk; }
    public List<String> getBreachDetails() { return breachDetails; }
    public String getScanType() { return scanType; }
    public String getTargetType() { return targetType; }
    public String getScanTime() { return scanTime; }

    /* SETTERS */
    public void setTarget(String target) { this.target = target; }
    public void setBreaches(int breaches) { this.breaches = breaches; }
    public void setRisk(int risk) { this.risk = risk; }
    public void setBreachDetails(List<String> breachDetails) { this.breachDetails = breachDetails; }
    public void setScanType(String scanType) { this.scanType = scanType; }
    public void setTargetType(String targetType) { this.targetType = targetType; }
    public void setScanTime(String scanTime) { this.scanTime = scanTime; }
}
