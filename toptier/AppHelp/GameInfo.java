import java.util.*;

public class GameInfo {

    private String name;
    private String role;
    private String affinity;
    private Double grade;
    private String rating;
    private String faction;
    private String[] title;
    private ArrayList<GameInfo> gameInfoList = new ArrayList<GameInfo>();

    public GameInfo(){}

    public GameInfo(String[] gameInfo){

        setName(gameInfo[0]);
        setRole(gameInfo[1]);
        setAffinity(gameInfo[2]);
        setGrade(Double.parseDouble(gameInfo[3]));
        setRating(gameInfo[4]);
        setFaction(gameInfo[5]);

    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getAffinity() {
        return affinity;
    }
    public void setAffinity(String affinity) {
        this.affinity = affinity;
    }
    public Double getGrade() {
        return grade;
    }
    public void setGrade(Double grade) {
        this.grade = grade;
    }

    public String[] getTitle() {
        return title;
    }

    public void setTitle(String[] title) {
        this.title = title;
    }

    public ArrayList<GameInfo> getGameInfoList() {
        return gameInfoList;
    }

    public void setGameInfoList(ArrayList<GameInfo> gameInfoList) {
        this.gameInfoList = gameInfoList;
    }

    public String getRating() {
        return rating;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getFaction() {
        return faction;
    }

    public void setFaction(String faction) {
        this.faction = faction;
    }

    



}
