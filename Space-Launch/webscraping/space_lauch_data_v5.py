"""
App Name : Web scraping
Author : Aruna Das
Project : Space Launch
Date : 07-02-2023
"""

from bs4 import BeautifulSoup
import requests
import csv
from dataclasses import dataclass



@dataclass
class SpaceLaunch():
    Launch_status : str
    Title : str
    Info : str
    Country : str
    Prog_name : str
    Launch_datetime : str
    Launcher_name : str
    Status : str
    Price : str 
    Liftoff_Thrust : str
    Payload_to_LEO : str
    Payload_to_GTO : str
    Stages : str 
    Strap_ons : str
    Rocket_Height : str 
    Fairing_Diameter : str
    Fairing_Height : str
    Description : str

def web_extract(url):
    html_text = requests.get(url).text
    soup = BeautifulSoup(html_text,'lxml' )
    return soup

def csv_file_handling(file_name, mode,data):
    csv_file = open(file_name,mode)
    csv_writer = csv.writer(csv_file)
    csv_writer.writerow(data)
    csv_file.close()

def extract_launch_grid(soup,filename): 
    # launch_grid contains all the grids from the site
    
   
   for launch_grid in soup.find_all('div',class_='mdl-cell mdl-cell--6-col'):
       
    launch_data = {}
        # add title to the data row
    launch_data['Title'] = (launch_grid.find('h5',class_='header-style').text.replace(' ','').strip())

        # info --> rocket launcher | space program name , add info to data row
    launch_data['Info'] = (launch_grid.find('div',class_='mdl-card__supporting-text').text.replace('\n','').strip().split(','))
    launch_data['Country'] = launch_data['Info'][-1]

    try:
            # extracting space program launch details link from button on grid
            launch_detail_link = launch_grid.find('button',class_='mdc-button')['onclick'].split('=')[1].replace('\'','').strip()

            # create soup with your detail url link
            detail_soup = web_extract(f'<url>{launch_detail_link}')

            proj_details = detail_soup.find('section',class_='card section--center white mdl-grid mdl-grid--no-spacing mdl-shadow--6dp')
            try:
                launch_data['Launch_status'] = proj_details.find('h6',class_='rcorners status').span.text
            except:
                launch_data['Launch_status'] = 'NA'

            #add program launch time to the launch data
            if proj_details.find(string='Launch Time').find_next().name == 'br':
                 for v in proj_details.find(string='Launch Time').next_elements:
                      if v.name == 'span':
                        launch_data['Launch_datetime'] = v.text
                        break
                      else:
                        ldt = v.text.replace('\n','').strip()
                        if ldt != '':
                            launch_data['Launch_datetime'] = ldt
                            break          
            
            try:
                 #add program name to the launch data
                 launch_data['Prog_name'] = proj_details.h4.text
                 # get the description of the program
                 launch_data['Description'] = (detail_soup.find('section', class_='section--center card white mdl-grid mdl-grid--no-spacing mdl-shadow--6dp').div.p.text)
            except:
                 launch_data['Prog_name'] = 'NA'
                 launch_data['Description'] = 'NA'
         
          # extract all the items from program card
            launch_details = []
           
            for items in  detail_soup.find_all('div', class_='mdl-cell mdl-cell--6-col-desktop mdl-cell--12-col-tablet'):
                launch_details.append(items.text)

            launch_data['Launcher_name'] = launch_details[0]

            # elements of k:v from launch details
            launch_details = launch_details[1:]

                # declare a dictionary to hold all launch details
            launch_details_data = {}
                # data cleaning and parsing columns from launch details
            for s in launch_details:
                    k, v  =  s.split(':')
                    launch_details_data[k.replace(' ','_')] = v.replace(' million','').replace(' kN','').replace(' kg','').replace(' m','').strip()
                #print(launch_details_data)

    except Exception as e:
            launch_details = []
            print(e)

    

    launch_details_dict = vars(SpaceLaunch(
                            Launch_status=launch_data.get('Launch_status' , 'NA'),
                            Title=launch_data.get('Title', 'NA'),
                            Info=launch_data.get('Info', 'NA'),
                            Country=launch_data.get('Country', 'NA'),
                            Prog_name=launch_data.get('Prog_name', 'NA'),
                            Launch_datetime=launch_data.get('Launch_datetime', 'NA'),
                            Launcher_name=launch_data.get('Launcher_name', 'NA'),
                            Status=launch_details_data.get('Status','NA'),
                            Price=launch_details_data.get('Price','0'),
                            Liftoff_Thrust=launch_details_data.get('Liftoff_Thrust','NA'),
                            Payload_to_LEO=launch_details_data.get('Payload_to_LEO','NA'),
                            Payload_to_GTO=launch_details_data.get('Payload_to_GTO','NA'),
                            Stages=launch_details_data.get('Stages','NA'),
                            Strap_ons=launch_details_data.get('Strap-ons','NA'),
                            Rocket_Height=launch_details_data.get('Rocket_Height','NA'),
                            Fairing_Diameter=launch_details_data.get('Fairing_Diameter','NA'),
                            Fairing_Height=launch_details_data.get('Fairing_Height','NA'),
                            Description=launch_data.get('Description', 'NA')
                            ))

    #print(launch_details_dict)
     
    csv_file_handling(filename,'a',list(launch_details_dict.values()))
    

if __name__=='__main__':
    # Define columns you want to extract
    column = ['Launch_status','Title', 'Info','Country','Prog_name', 'Launch_datetime','Launcher_name',
         'Status','Price(million)','Liftoff_Thrust(kN)','Payload_to_LEO(kg)','Payload_to_GTO(kg)',
         'Stages','Strap-ons','Rocket_Height(m)','Fairing_Diameter(m)','Fairing_Height(m)','Description']
    
    var = 'past'
    if var == 'past':
        filename = f'space_launch_data_{var}.csv'
        url = f'<url>'
    else:
        filename = 'space_launch_data.csv'
        url = f'<url>'    

    
    csv_file_handling(filename,'w',column) 
    
    for i in range(1, 2):
        
        print(f"extracting from url {url}{i} --- Begins")   
        # create soup with your url link
        soup = web_extract(f'{url}{i}')

        extract_launch_grid(soup, filename)
        
        print("extracting from url --- completed") 
    
    