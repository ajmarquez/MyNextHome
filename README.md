# MyNextHome

##Architecture
I decided to go for an MVVMC approach, while MVC or MVP could have been easier for the size of the project, the first allows for a more flexible expansion of the project if needed. The binding was done via Combine. 

The use of Storyboard coould have make the project on an easier implementation, but, in case of scaling the Storyboards are very problematic when working several developers under Version Control System. Many merge conflics appear and many hours can be spend on that. That's why the decision of running programmatically was chosen. 

##Dashboard (RealStateListViewController)
The strategy for the dashboard was to propagate the model via Combine. Use a coordinator to acces to each one of the Viewcontroller. By starting with the idea of a non-persistent dashboard, later in the project I realised that maybe integrating CoreData would allow for an easier integration and reutilization of components. 

The idea was to make it scalable, so if it's decided to expand the list to more that 10 elements it could be possible. Also attaching a SearchBar could use the same combine architecture. 

##Favorite List
The data was stored in CoreData, being one of the best options for storing several models locally. A Viewmodel controls the reloading of data and the methods for deleting and adding new items. 

##Networking
Several layer with the purpose of enforcing type safety to avoid errors and being able to scale if more Endpoints are necesarry. 

##Constants
On the Utils folder the contans were arrange in other being able to quickly change variables all view corner, margins, colors and images. 

## Images
Originally images have the following URL:
`https://uat.homegate.ch/www/ftp/x311x/images/0018227.jpg`

But the domain can't be found unless we erase the `uat`, and then the image can be collected via:
 `https://homegate.ch/www/ftp/x311x/images/0018227.jpg`
 
 ## Extra
 I wanted to make the design a little bit nice, even that it's not part of the evaluation. You can also choose dark or light view. 
 
 
 
 ----
 ## Limitations & bugs
 
 - The proper control of the status of the Favorite icon on the RealStateListViewcontroller needs some work. The re-use of the cell creates some problems on that particular view.
 - Testing (I know), this is the main lack I would say. But with time constrains I prioritized functinability.
 - Error handling, there a lack of proper error handling. The idea was to build a series on enums of Localized error to propers handle them. It's still a to do. 
 
 ## Improvements
 - I still have a lot to learn with Combine, so I think I could make better a better and more efficient use of it on the future. 
 - Reutilization of components: By using two main models `RealState` and `FavoritedItem`(CoreData) the management of the models was a bit complicated. Maybe making the NSManagedObject conform with Codable could have been a good idea. An unified model would have helped a lot for reutilization and testing. 
 - An idea was to make the contact person and telephone visible on the watchlist, so the user could directly contact the property instead of needing of another click. 
 - A detail view also could also been added. But was a low priority as was not contemplated on the tasks. 
 
 
