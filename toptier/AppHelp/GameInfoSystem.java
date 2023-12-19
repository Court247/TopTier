import java.io.*;
import java.util.*;

public class GameInfoSystem extends GameInfo {

    public GameInfoSystem(ArrayList<GameInfo> gameInfoList) {
        setGameInfoList(gameInfoList);
    }

    public void mainMenu(String gameName){
        Scanner game = new Scanner(System.in);

        int ans = -1;
        
        while(ans != 6){

            System.out.println("************************************************************************************");
            System.out.println("\t1. Look at list. ");
            System.out.println("\t2. Look for character. ");
            System.out.println("\t3. Add to list.");
            System.out.println("\t4. Remove from List.");
            System.out.println("\t5. Change value.");
            System.out.println("\t6. Exit.");
            System.out.println("************************************************************************************");

            ans = game.nextInt();

            if(ans == 1){

                printList(getGameInfoList());

            }else if (ans == 2){ 

                System.out.println("Number of letters");
                int ans2 = game.nextInt();

                findCharacter(ans2);

            }else if ( ans == 3){ 

                System.out.println("Name: ");
                System.out.println("How many letters?");
                int ans2 = game.nextInt();

                addCharacter(ans2);

            }else if(ans == 4){

                System.out.println("Name: ");
                System.out.println("How many letters?");
                int ans2 = game.nextInt();

                removeFromList(ans2);

            }else if(ans ==5){

                System.out.println("Number of letters");
                int ans2 = game.nextInt();

                changeValue(ans2);

            }else{

                updateList(gameName);

                break;

            }


        }
    }
    public void printList(ArrayList<GameInfo> gameInfoList){ 

        for(int i = 0; i < gameInfoList.size(); i++){

            if(getGameInfoList().get(i).getGrade() == -1){ 

                if(getGameInfoList().get(i).getFaction().equals("null")){

                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + gameInfoList.get(i).getName());
                    System.out.println("Character Role: " + gameInfoList.get(i).getRole());
                    System.out.println("Character Affinity: " + gameInfoList.get(i).getAffinity());
                    System.out.println("Character Rating: " + gameInfoList.get(i).getRating());
                }else{
                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + gameInfoList.get(i).getName());
                    System.out.println("Character Role: " + gameInfoList.get(i).getRole());
                    System.out.println("Character Affinity: " + gameInfoList.get(i).getAffinity());
                    System.out.println("Character Rating: " + gameInfoList.get(i).getRating());
                    System.out.println("Character Faction: " + gameInfoList.get(i).getFaction());

                }
                
            }else{

                if(getGameInfoList().get(i).getFaction().equals("null")){
                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + gameInfoList.get(i).getName());
                    System.out.println("Character Role: " + gameInfoList.get(i).getRole());
                    System.out.println("Character Affinity: " + gameInfoList.get(i).getAffinity());
                    System.out.println("Character Grade: " + gameInfoList.get(i).getGrade());
                }else{

                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + gameInfoList.get(i).getName());
                    System.out.println("Character Role: " + gameInfoList.get(i).getRole());
                    System.out.println("Character Affinity: " + gameInfoList.get(i).getAffinity());
                    System.out.println("Character Grade: " + gameInfoList.get(i).getGrade());
                    System.out.println("Character Faction: " + gameInfoList.get(i).getFaction());
                }
            }
      

        }
    }

    public void add(GameInfo character) {

        getGameInfoList().add(character);

    }

    public void addToList(String name, String role, String affinity, Double grade, String rating, String faction){

        GameInfo g = new GameInfo();
        g.setName(name);
        g.setRole(role);
        g.setAffinity(affinity);
        g.setGrade(grade);
        g.setRating(rating);
        g.setFaction(faction);
        getGameInfoList().add(g);

    }

    public void removeFromList(int num) {

        String[] names = new String[num];
        Scanner game = new Scanner(System.in);
        String name = "";

        for(int i = 0; i < names.length;i++){
            System.out.println("Enter name[" + i + "]");
            names[i] = game.next();
        }

        if(names.length == 1){ 
            name = names[0];

        }else if (names.length == 2){ 
            name = names[0] + " " + names[1];
        }else if ( names. length == 3){ 
            name = names[0] + " " + names[1] + " " + names[2];
        }
        int i = findCharacters(name);
        getGameInfoList().remove(i);

    }

    public boolean findCharacter(String name) {

        boolean found = false;

        for(int i = 0; i < getGameInfoList().size(); i++){

            if (getGameInfoList().get(i).getName().equals(name)){

                GameInfo character = getGameInfoList().get(i);
                found = true;
                int j = findCharacters(name);
                printCharacter(found, character, j);
                return found;
            }
        }

        return found;

    }

    public boolean findCharacter(int num){

        String[] names = new String[num];
        boolean found = false;
        String name = "";
        Scanner game = new Scanner(System.in);

        for(int i = 0; i < names.length;i++){
            System.out.println("Enter name[" + i + "]");
            names[i] = game.next();
        }

        if(names.length == 1){ 
            name = names[0];
        }else if (names.length == 2){ 
            name = names[0] + " " + names[1];
        }else if ( names. length == 3){ 
            name = names[0] + " " + names[1] + " " + names[2];
        }

        for(int i = 0; i < getGameInfoList().size(); i++){

            if (getGameInfoList().get(i).getName().equals(name)){

                GameInfo character = getGameInfoList().get(i);
                found = true;
                int j = findCharacters(name);
                printCharacter(found, character, j);
                return found;
            }
        }

        return found;

    }
   
    public int findCharacters(String name){

        for(int i =0; i < getGameInfoList().size(); i++){

            if (getGameInfoList().get(i).getName().equals(name)){

                GameInfo character = getGameInfoList().get(i);
                return i;
            }
        }
        return -1;

    }

    public GameInfo printCharacter(boolean found, GameInfo character, int i){

        GameInfo searchChar = null;

        if(found){

            searchChar = character;
            if (getGameInfoList().get(i).getGrade() == -1){

                if(getGameInfoList().get(i).getFaction().equals("null")){
                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + searchChar.getName());
                    System.out.println("Character Role: " + searchChar.getRole());
                    System.out.println("Character Affinity: " + searchChar.getAffinity());
                    System.out.println("Character Grade: " + searchChar.getRating());
        
                    return searchChar;
                }else{
                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + searchChar.getName());
                    System.out.println("Character Role: " + searchChar.getRole());
                    System.out.println("Character Affinity: " + searchChar.getAffinity());
                    System.out.println("Character Grade: " + searchChar.getRating());
                    System.out.println("Character Faction: " + searchChar.getFaction());
        
                    return searchChar;

                }

            }else{

                if(getGameInfoList().get(i).getFaction().equals("null")){

                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + searchChar.getName());
                    System.out.println("Character Role: " + searchChar.getRole());
                    System.out.println("Character Affinity: " + searchChar.getAffinity());
                    System.out.println("Character Grade: " + searchChar.getGrade());
    
                    return searchChar;
                }else{
                    System.out.println("************************************************************************************");
                    System.out.println("Character Name: " + searchChar.getName());
                    System.out.println("Character Role: " + searchChar.getRole());
                    System.out.println("Character Affinity: " + searchChar.getAffinity());
                    System.out.println("Character Grade: " + searchChar.getGrade());
                    System.out.println("Character Faction: " + searchChar.getFaction());
    
                    return searchChar;
                }

            }

        }

        return searchChar;

    }

    public void updateList(String chooseGame){
        ArrayList<String[]> gameInfoList2 = new ArrayList<String[]>();
        gameInfoList2.add(getTitle());

        for (int i = 0; i < getGameInfoList().size(); i++){

            GameInfo currentCharacter = getGameInfoList().get(i);

            String[] currCharacter = {currentCharacter.getName(), currentCharacter.getRole(), currentCharacter.getAffinity(), String.valueOf(currentCharacter.getGrade()), currentCharacter.getRating(), currentCharacter.getFaction()};
            gameInfoList2.add(currCharacter);
        }
        try{
            FileWriter fw =new FileWriter(chooseGame + ".csv");

            for(String[] characterInfo : gameInfoList2){
                System.out.println(Arrays.toString(characterInfo));
                for(String info : characterInfo){
                    fw.write(info + ",");
                }
                fw.write("\n");
            }
            fw.close();
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    public void addCharacter(int num){ 

        String name = "";
        String role = "";
        String affinity = "";
        Double grade = 0.0;
        String rating = "";
        String faction = "";
        Scanner game = new Scanner(System.in);

        String[] names = new String[num];

        for(int i = 0; i < names.length;i++){
            System.out.println("Enter name");
            names[i] = game.next();
        }

        if(names.length == 1){ 
            name = names[0];
            if(findCharacter(name)){
                System.out.println("No Duplicates");
                return;
            }
        }else if (names.length == 2){ 
            name = names[0] + " " + names[1];
            if(findCharacter(name)){
                System.out.println("No Duplicates");
                return;
            }
        }else if ( names. length == 3){ 
            name = names[0] + " " + names[1] + " " + names[2];
            if(findCharacter(name)){
                System.out.println("No Duplicates");
                return;
            }
        }

    
        System.out.println("Role: ");
        System.out.println("How many letters: ");
        int r = game.nextInt();

        String[] roles = new String[r];

        for(int i = 0; i < roles.length;i++){
            System.out.println("Enter role");
            roles[i] = game.next();
        }

        if(roles.length == 0){
            role = null;
        }
        else if(roles.length == 1){
            role = roles[0];

        }else if (factionNames.length == 2){ 
            role = roles[0] + " " + roles[1];
        }

        System.out.println("Affinity: ");
        affinity = game.next();

        System.out.println("Grade: ");
        grade = game.nextDouble();

        System.out.println("Rating: ");
        rating = game.next();

        System.out.println("Faction: ");
        System.out.println("How many letters: ");
        int ans = game.nextInt();

        String[] factionNames = new String[ans];

        for(int i = 0; i < factionNames.length;i++){
            System.out.println("Enter faction name. ");
            factionNames[i] = game.next();
        }

        if(factionNames.length == 0){
            faction = null;
        }
        else if(factionNames.length == 1){
            faction = factionNames[0];

        }else if (factionNames.length == 2){ 
            faction = factionNames[0] + " " + factionNames[1];
        }

        addToList(name, role, affinity, grade, rating, faction);

    }

    public void changeValue(int num){ 

        String[] names = new String[num];
        String name = "";
        Scanner game = new Scanner(System.in);

        for(int i = 0; i < names.length;i++){
            System.out.println("Enter name[" + i + "]");
            names[i] = game.next();
        }

        if(names.length == 1){ 
            name = names[0];

        }else if (names.length == 2){ 
            name = names[0] + " " + names[1];
        }else if ( names. length == 3){ 
            name = names[0] + " " + names[1] + " " + names[2];
        }

        int found = findCharacters(name);

        System.out.println("************************************************************************************");
        System.out.println("Which value would you like to change?");
        System.out.println("\t1.Name.");
        System.out.println("\t2.Role.");
        System.out.println("\t3.Affinity.");
        System.out.println("\t4.Grade.");
        System.out.println("\t5.Rating.");
        System.out.println("\t6.Faction");
        System.out.println("************************************************************************************");

        int ans4 = game.nextInt();
        String changeChar;

        if(ans4 == 1){
            System.out.println("Input new Name.");
            System.out.println("How many letters to change?");
            int ans5 = game.nextInt();

            String[] naming = new String[ans5];

            for(int i = 0; i < naming.length;i++){
                System.out.println("Enter name[" + i + "]");
                naming[i] = game.next();
            }

            if(naming.length == 1){

                changeChar = names[0];
                getGameInfoList().get(found).setName(changeChar);
    
            }else if (names.length == 2){

                changeChar = names[0] + " " + names[1];
                getGameInfoList().get(found).setName(changeChar);

            }else if ( names. length == 3){

                changeChar = names[0] + " " + names[1] + " " + names[2];
                getGameInfoList().get(found).setName(changeChar);

            }
        }else if (ans4 == 2){
            System.out.println("Input new Role.");
            changeChar = game.next();
            getGameInfoList().get(found).setRole(changeChar);
        }else if(ans4 == 3){ 
            System.out.println("Input new Affinity.");
            changeChar = game.next();
            getGameInfoList().get(found).setAffinity(changeChar);
        }else if(ans4 == 4){
            System.out.println("Input new Grade.");
            changeChar = game.next();
            getGameInfoList().get(found).setGrade(Double.valueOf(changeChar));
        }else if(ans4 ==5){
            System.out.println("Input new Rating.");
            changeChar = game.next();
            getGameInfoList().get(found).setRating(changeChar);
        }else if( ans4 == 6){

            System.out.println("Input new Faction.");
            System.out.println("How many letters: ");
            int ans = game.nextInt();

            String[] factionNames = new String[ans];

            for(int i = 0; i < factionNames.length;i++){
                System.out.println("Enter name[" + i + "]");
                factionNames[i] = game.next();
            }
            
            if(factionNames.length == 1){
                changeChar = factionNames[0];
                getGameInfoList().get(found).setFaction(changeChar);

            }else if (factionNames.length == 2){ 
                changeChar = factionNames[0] + " " + factionNames[1];
                getGameInfoList().get(found).setFaction(changeChar);
            }else{
                System.out.println("Invalid");
            }
        }else{
            System.out.println("Invalid");
        }

    }
}
