categories = [{title: "Food and Drink", clues:{
  'In 1919 Roy Allen created the A&W recipe for this drink': 'root beer',
  'Water buffalo milk (delicious on its own!) is used to make this cheese & Italy exports 40,000 tons a year of the stuff': 'mozzarella',
  'This fast food chain with more than 17,000 stores worldwide dropped its full name in 1991 & began using an abbreviation': 'KFC',
  'For purists, the blue agave from Jalisco state produces the best of this product': 'tequila',
  'This aromatic herb essential to Bearnaise sauce has a sweet flavor similar to licorice or anise': 'tarragon'}
},
{title: "3 Letter Words", clues:{
  'A solemn promise; you might take one "of silence" (but not now!)': 'vow',
  '237, when talking about 199 + 38': 'sum',
  "This British ending to the alphabet ain't dead, baby": 'zed',
  "A crustacean's eggs, as the coral of the lobster": 'roe',
  "It's the possessive form of thou": 'thy'}
},
{title: "Sports", clues:{
  'In this game, an entry sport to baseball, the batter hits the ball that rests atop a tube': 'T-ball',
  "Oops--in bowling, it's the one place you don't wanna throw your ball": 'the gutter',
  "It's the sport played professionally by Andre Agassi": 'tennis',
  "What the Europeans call association football, we call this": 'soccer',
  "In golf it's the proper word to yell when your ball is headed toward another player": "fore"}
},
{title: "Word Origins", clues:{
  "From the Latin for \"kidnapping\", it's stealing the ideas or writings of another & passing them off as your own": "plagiarism",
  "The name of this official Chinese language comes from the Sanskrit for \"counselor\"": "mandarin",
  "Before it had instrument readouts, it was a panel that kept mud from splashing into horse-drawn vehicles": "dashboard",
  "The name of this small magnifying glass used by jewellers is from a French term for a flawed gem": "loupe",
  "In mythology it's the shield of Zeus; it also means protection or sponsorship": "aegis"}
},
{title: "Common Bonds", clues:{
  "Loving, measuring, sippy": "cups",
  "Mount Suribachi volcano, the Gothic language, dodos": "extinct",
  "Cuckoo, grandfather, alarm": "clocks",
  "Disneyland rides, a football field, notebook paper": "lines",
  "Nautical, statute, Standish": "miles"}
},
{title: "Nature", clues:{
  "It's the weed seen here spreading more little ones": "dandelion",
  "From the Latin for \"gnawing\", it's the order of mammals that includes mice & hamsters": "rodent",
  "Most bats are this 9-letter adjective, so they don't mind if you call them at 2 in the morning": "nocturnal",
  "While not all grow so quickly, one of these giant, hollow, woody grasses grew 3 feet in 1 day": "bamboo",
  "In trees such as pines & firs, the seeds form in these": "cones",}
},
{title: "Brand Names", clues:{
  "This company offers crop insurance as well as it signature green & yellow tractors": "John Deere",
  "This candy brand invites you to \"Taste the rainbow\"": "Skittles",
  "For many years Nancy Green portrayed this fictional Southern pancake cook": "Aunt Jemima",
  "Treat your itchy eyes with this brand of antihistamine first marketed back in 1946": "Benadryl",
  "This cosmetics brand is named for T.L. Williams' sister": "Maybelline"}
},
{title: "5 Letter Words", clues:{
  "The name of this yellowish white color is from a word for \"elephant\"": "ivory",
  "Another word for poisonous, it can also describe a bad relationship": "toxic",
  "Honey is an animal product & can be excluded from a strict this type of diet": "vegan",
  "From Yiddish, it's a clumsy person": "klutz",
  "This synonym for \"kingdom\" comes from the Latin for \"regal\"": "realm"}
},
{title: "Number, Please", clues:{
  "In musical slang this number refers to a piano": "eighty-eight",
  "Number of permanent members of the U.N. security council": "five",
  "A superfecta at Saratoga involves correctly guessing this number of horses in order of finish": "four",
  "Number of hertz in a gigahertz": "billion",
  "Total cups in a gallon": "sixteen"}
},
{title:"Body Language", clues:{
  "To \"put my\" this \"down\" means I'm ending the discussion once & for all": "foot",
  "\"Having thin\" this means criticism bothers you": "skin",
  "\"Tongue in\" this": "cheek",
  "\"An army marches on its\" this": "stomach", 
  "Cowardly? You're \"lily-\" this": "livered"}
}]

categories.each do |category|
  new_category = Category.create(name: category[:title])
  count = 0
  category[:clues].each do |description, answer|
    count += 1
    question = new_category.questions.create(description: description, value: (200*count))
    question.create_answer(description: answer)
  end
end