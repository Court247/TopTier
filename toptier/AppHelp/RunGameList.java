import java.io.*;
import java.util.*;

//Class that holds the main method
public class RunGameList {

    private ArrayList<GameInfo> gameInfoList = new ArrayList<GameInfo>();
    private String[] title;


    public RunGameList() {}

    public ArrayList<GameInfo> getGameInfoList() {
        return gameInfoList;
    }

    public void setGameInfoList(ArrayList<GameInfo> gameInfoList) {
        this.gameInfoList = gameInfoList;
    }
    
    public String[] getTitle() {
        return title;
    }

    public void setTitle(String[] title) {
        this.title = title;
    }

    public boolean findCharacter(String name){
        boolean found = false;
        for(int i = 0; i < gameInfoList.size(); i++){
            if (getGameInfoList().get(i).getName() == name){
                found = true;
                return found;
            }
        }
        return found;
    }

    public void readGameInfo(String chooseGame) throws IOException{
        
        String[] gameInfo;
        File fileGame = new File(chooseGame + ".csv");
        boolean nF = fileGame.createNewFile(); //create few file

        Scanner info = new Scanner(fileGame);
        
        if(!(nF) && info.hasNextLine()){

            String line = info.nextLine();
            String[] titleLine = line.split(",");
            setTitle(titleLine);


            while(info.hasNextLine()){ 

                line = info.nextLine();
                System.out.println(line);
                gameInfo = line.split(",");
                GameInfo g = new GameInfo(gameInfo);
                g.setTitle(getTitle());

                getGameInfoList().add(g);

            }

        }
        else{ 

            String[] header = {"Name", "Role", "Affinity", "Grade", "Rating", "Faction"};
            setTitle(header);
            try{
                FileWriter fw =new FileWriter(chooseGame + ".csv");
    
                for(String head : header){
                    fw.write(head + ",");
                }
                fw.write("\n");
                fw.close();
            }catch(IOException e){
                e.printStackTrace();
            }

        }
        info.close();
    }
    public static void main(String[] args) throws IOException {

        RunGameList run = new RunGameList();
        Scanner game = new Scanner(System.in);
        System.out.println("************************************************************************************");
        System.out.println("Input Game Name: ");
        System.out.println("Input 'Exit' to quit");
        String gameName =  game.nextLine();

        if("Exit".equalsIgnoreCase(gameName)){
            return;
        }
        run.readGameInfo(gameName);

        GameInfoSystem runGame = new GameInfoSystem(run.getGameInfoList());
        runGame.setTitle(run.getTitle());

        runGame.mainMenu(gameName);
    }




}
