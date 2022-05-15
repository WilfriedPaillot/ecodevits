# Erase the content of all tables, hence reseting the related "id" counters
DatabaseCleaner.clean_with(:truncation)

p ' ########################'
p '## Generation des users ##'
p ' ########################'

User.create!(
  email: "admin@yopmail.com", 
  password: 'admin@2022', 
  username: Faker::Internet.username(specifier: 3..15, separators: %w(_)), 
  role: 2
)
p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
p "Son adresse email est #{User.last.email}."
p "Son role est #{User.last.role}."
puts "\n"

10.times do |i|
  User.create!(
    email: "instructor#{i+1}@yopmail.com", 
    password: 'instructor@2022', 
    username: Faker::Internet.username(specifier: 3..15, separators: %w(_)),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    adress: Faker::Address.street_address,
    zipcode: rand(10000..95000),
    city: Faker::Address.city,
    specialities: [Faker::ProgrammingLanguage.name, Faker::ProgrammingLanguage.name],
    role: 1
  )
    p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
    p "Son adresse email est #{User.last.email}."
    p "Son role est #{User.last.role}."
    puts "\n"  
end

5.times do |i|
  User.create!(
    email: "student#{i+1}@yopmail.com", 
    password: "student#{i+1}@2022",
    username: Faker::Internet.username(specifier: 3..15, separators: %w(_)),
  )
  p "L'utilisateur #{User.last.username.capitalize} vient d'être généré."
  p "Son adresse email est #{User.last.email}."
  p "Son role est #{User.last.role}."
  puts "\n" 
end

p ' #############################'
p '## Generation des formations ##'
p ' #############################'
puts "\n"*2

instructors = User.where(role: 1).ids

Training.create!(
  title: "Formation de développeur web",
  description: "Cette formation vous permettra de développer votre compétences en développement web.",
  user_id: instructors.sample,
)
  Section.create!(
    title: "Introduction aux fondamentaux du Web",
    description: "Cette section vous permettra de développer votre compétences en HTML, CSS.",
    training_id: Training.last.id
  )
    Lesson.create!(
      title: "Le HTML pour de bonnes bases",
      content: "HyperText Markup Language (HTML) est le code utilisé pour structurer une page web et son contenu. Par exemple, le contenu de votre page pourra être structuré en un ensemble de paragraphes, une liste à puces ou avec des images et des tableaux de données. Comme le suggère le titre, cet article vous fournit les bases de compréhension du HTML et de ses fonctions.",
      url: 'https://www.youtube.com/watch?v=8FqZZrbnwkM',
      section_id: Section.last.id
    )
    Lesson.create!(
      title: "Le CSS, l'art de mettre en forme",
      content: "CSS est l'un des langages principaux du Web ouvert et a été standardisé par le W3C. Ce standard évolue sous forme de niveaux (levels), CSS1 est désormais considéré comme obsolète, CSS2.1 correspond à la recommandation et CSS3, qui est découpé en modules plus petits, est en voie de standardisation.",
      url: 'https://www.youtube.com/watch?v=qTN9bNaBCK8',
      section_id: Section.last.id
    )
  Section.create!(
      title: "Javascript",
      description: "Cette section vous permettra de développer votre compétences en Javascript.",
      training_id: Training.last.id
  )
    Lesson.create!(
        title: "Le Javascript en partant de ZERO 1/2",
        content: "Le Javascript est un langage de programmation informatique qui permet de créer des interfaces interactives. Il est utilisé pour créer des interfaces dynamiques et interactives. Il est utilisé pour créer des interfaces interactives et dynamiques. Il est utilisé pour créer des interfaces dynamiques et interactives.\n
        Nous verrons les fondamentaux du langage et concluerons par la réalisation d'un projet de calculatrice.",
        url: 'https://www.youtube.com/watch?v=9OJLxDxyNg4',
        section_id: Section.last.id
    )
    Lesson.create!(
        title: "Le Javascript en partant de ZERO 2/2",
        content: "Du DOM (Document Object Model), c'est l'interface de base entre le navigateur et le document. Il permet de manipuler le document, de créer des éléments, de les manipuler, de les manipuler, etc.\n
        Ce cours vous montrera comment manipuler le DOM pour dynamiser un site web et ce concluera par la création d'un petit projet de compteur de bulles",
        url: 'https://www.youtube.com/watch?v=6q-zt0aQ74U',
        section_id: Section.last.id
    )

p '*' * 20
p "La formation #{Training.last.title.upcase} a été créée"
p '*' * 20

Training.create!(
  title: "Formation Ruby on Rails",
  description: "Cette formation vous permettra de développer votre compétences dans le développement web avec Ruby on Rails.",
  user_id: instructors.sample,
)
  Section.create!(
    title: "Introduction",
    description: "Cette section vous permettra d'aborder le framework Ruby on Rails.",
    training_id: Training.last.id
  )
    Lesson.create!(
      title: "Introduction à Ruby on Rails 1/2",
      content: "Rails is a web application development framework written in the Ruby programming language. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started. It allows you to write less code while accomplishing more than many other languages and frameworks. Experienced Rails developers also report that it makes web application development more fun.
      Rails is opinionated software. It makes the assumption that there is a \"best\" way to do things, and it's designed to encourage that way - and in some cases to discourage alternatives. If you learn \"The Rails Way\" you'll probably discover a tremendous increase in productivity. If you persist in bringing old habits from other languages to your Rails development, and trying to use patterns you learned elsewhere, you may have a less happy experience.
      The Rails philosophy includes two major guiding principles:\n
      Don't Repeat Yourself: DRY is a principle of software development which states that \"Every piece of knowledge must have a single, unambiguous, authoritative representation within a system\". By not writing the same information over and over again, our code is more maintainable, more extensible, and less buggy.
      Convention Over Configuration: Rails has opinions about the best way to do many things in a web application, and defaults to this set of conventions, rather than require that you specify minutiae through endless configuration files.",
      url: 'https://www.youtube.com/watch?v=zppMfm4fuxM',
      section_id: Section.last.id
    )
    Lesson.create!(
      title: "Introduction à Ruby on Rails 2/2",
      content: "En résumé : le fichier routes.rb est ni plus ni moins que le routeur de ton application Rails. Comme on te l'avait expliqué lors de la présentation du modèle MVC, le routeur va dire : \"telle requête HTTP (une requête est définie par un verbe GET/POST/PUT/etc. et une URL) doit renvoyer l'utilisateur vers telle méthode Ruby de tel controller\". \n
      Ces méthodes Ruby, au sein du controller, feront ensuite leur travail d'interroger (ou non) des models pour finalement construire une view qu'on affichera à l'utilisateur.\n
      Je te remets le schéma d'une app en MVC pour que tu resitues bien tout ça !",
      url: 'https://www.youtube.com/watch?v=sAi1r8tzzS4',
      section_id: Section.last.id
    )
    Lesson.create!(
      title: "Rails basics",
      content: "Sans surprise, la doc a encore prévu le coup, avec une belle ressource sur les routes. Demain nous verrons en détails l'utilisation de la commande resources dans les routes, mais tu peux y jeter un œil héhé.
      Après, j'imagine que tu dois te dire que ton cerveau va exploser, que tu es loin d'être autonome : si je te demandais de refaire toutes les routes d'un gros site comme The Hacking Project, tu ferais un joli \"lol nope\". \n
      C'est normal, il te manque une info importante que l'on verra demain : quelles sont les bonnes pratiques pour faire des routes propres \"The Rails Way™ \". \n
      Patience, on va y venir.",
      url: 'https://www.youtube.com/watch?v=sAi1r8tzzS4',
      section_id: Section.last.id
    )
    Lesson.create!(
      title: "Rails first app",
      content: "Quand on fait du développement, nous recherchons en priorité :\n
      la lisibilité de notre code\n
      un rangement qui optimise la lisibilité et l'édition dans le futur\n
      Quand notre code est en production, nous recherchons en priorité :\n
      la rapidité d’exécution\n
      l’optimisation en vitesse\n
      Forcément, ces deux objectifs sont différents et difficilement compatibles : dur d’avoir du code qui s’exécute rapidement si ce dernier est bien rangé dans 40 dossiers et 50 fichiers. 
      C’est pour cela que les langages de programmation web ont pour la majorité une solution de gestion de CSS, JS et images. Rails a l’Asset Pipeline, une solution efficace qui a fait ses preuves depuis quelques années et qui a inspiré d’autres outils de gestion d’assets par la suite.",
      url: 'https://www.youtube.com/watch?v=fP64Wvz13AM',
      section_id: Section.last.id
    )

    p '*' * 20
    p "La formation #{Training.last.title.upcase} a été créée"
    p '*' * 20


    Training.create!(
      title: "Accessibilité et SEO",
      description: "Cette formation vous permettra de développer votre compétences en SEO et Accessibilité.",
      user_id: instructors.sample,
    )
      Section.create!(
        title: "Accessibilité",
        description: "Cette section vous permettra d'aborder les notions d'accessibilité appliquée au numérique.",
        training_id: Training.last.id
      )    
        Lesson.create!(
          title: "L’accessibilité numérique à toutes les étapes d’un projet",
          content: "Vous avez besoin de mieux comprendre l’accessibilité numérique et/ou de savoir comment la prendre en compte à votre niveau  ? Nous sommes très fiers de vous annoncer la création de notre nouvelle formation en ligne «  L’accessibilité numérique à toutes les étapes d’un projet  ».\n
          Pour l’occasion, nous vous partageons ici la vidéo d’introduction à l’accessibilité numérique du premier module. N’hésitez pas à la relayer/partager pour sensibiliser autour de vous.",
          url: 'https://www.youtube.com/watch?v=e9dgLfpcE9M',
          section_id: Section.last.id
        )
        Lesson.create!(
          title: "Les bases de l'accessibilité",
          content: "Lorsqu’un site ou un outil web est bien conçu et bien codé, les personnes handicapées peuvent l’utiliser. Cependant, beaucoup de sites et d’outils développés actuellement contiennent des problèmes d’accessibilité, ce qui les rend dificiles ou impossibles à utiliser par certaines personnes.\n
          Rendre le web accessible est un avantage pour les internautes, les entreprises et la société. Les standards du web internationaux définissent ce qui est nécessaire pour l’accessibilité.",
          url: 'https://www.youtube.com/watch?v=z68N3VrA9h4',
          section_id: Section.last.id
        )
      Section.create!(
        title: "Accessibilité orientée SEO",
        description: "Cette section vous permettra d'aborder les notions d'accessibilité au service du SEO.",
        training_id: Training.last.id
      )    
        Lesson.create!(
          title: "Importance de l'accessibilité au service du SEO",
          content: "Un site web accessible est un site dont le contenu est accessible à tous: valides, seniors et personnes en situation de handicap. \n
          Déficience auditive, visuelle, troubles cognitifs ou mobilité, autant de handicaps qui touchent aujourd’hui près de 18% de la population qui, sans prise en compte spécifique se voient privés d’un accès optimal au web.
          Un site accessible se devra donc d’être:\n
          perceptible : accentuer une différentiation des éléments entre eux (textes/images/boutons) et fournir une alternative textuelle aux images ;\n
          utilisable : le contenu doit être accessible tant grâce à une souris ou assimilé (trackpad par exemple) mais également grâce au clavier via une navigation par tabulation ;\n
          compréhensible : les textes doivent être lisibles en permanence ;\n
          robuste : le contenu doit être accessible quel que soit le support sur lequel il est consulté.",
          url: 'https://www.youtube.com/watch?v=vvLoYCq9uPw',
          section_id: Section.last.id
        )
      
        p '*' * 20
        p "La formation #{Training.last.title.upcase} a été créée"
        p '*' * 20