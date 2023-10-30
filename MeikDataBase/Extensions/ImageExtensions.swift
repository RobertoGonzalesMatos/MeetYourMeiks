
import SwiftUI

extension Image {
    init(stringURL: String) {
        let name = String(stringURL.split(separator: ".")[0])
        let ext = String(stringURL.split(separator: ".")[1])
        var uiImage = UIImage()
        
        do {
            if let filePath = Bundle.main.url(forResource: name, withExtension: ext) {
                let imageData = try Data(contentsOf: filePath)
                uiImage = UIImage(data: imageData)!
            } else {
            }
        } catch let error {
            print("[System] Error while bring local image: \(error)")
            self.init(systemName: "xmark")
        }
        self.init(uiImage: uiImage)
    }
}
enum concentrations: String, CaseIterable{
    case Default = "--"
    case AfricanaStudies = "Africana Studies"
    case AmericanStudies = "American Studies"
    case Anthropology = "Anthropology"
    case AppliedMath = "Applied Mathematics"
    case AppliedMathematicsBiology = "Applied Mathematics-Biology"
    case AppliedMathematicsComputerScience = "Applied Mathematics-Computer Science"
    case AppliedMathematicsEconomics = "Applied Mathematics-Economics"
    case Archaeology = "Archaeology and the Ancient World"
    case Architecture = "Architecture"
    case Astronomy = "Astronomy"
    case BDS = "Behavioral Decision Sciences"
    case Biochemistry = "Biochemistry & Molecular Biology"
    case Biology = "Biology"
    case Biomed = "Biomedical Engineering"
    case Biophysics = "Biophysics"
    case BEO = "Business, Entrepreneurship and Organizations"
    case ChemicalPhysics = "Chemical Physics"
    case Chemistry = "Chemistry"
    case Classics = "Classics"
    case Neuroscience = "Cognitive Neuroscience"
    case CognitiveScience = "Cognitive Science"
    case ComparativeLiterature = "Comparative Literature"
    case ComputationalBiology = "Computational Biology"
    case ComputerScience = "Computer Science"
    case ComputerScienceEconomics = "Computer Science-Economics"
    case ContemplativeStudies = "Contemplative Studies"
    case CriticalNativeAmericanandIndigenousStudies = "Critical Native American and Indigenous Studies"
    case DesignEngineering = "Design Engineering"
    case DevelopmentStudies = "Development Studies"
    case EarlyModernWorld = "Early Modern World"
    case EastAsianStudies = "East Asian Studies"
    case Economics = "Economics"
    case EducationStudies = "Education Studies"
    case Engineering = "Engineering"
    case EngineeringandPhysic = "Engineering and Physics"
    case English = "English"
    case EnvironmentalStudies = "Environmental Studies"
    case EthnicStudies = "Ethnic Studies"
    case French = "French and Francophone Studies"
    case GenderSexuality = "Gender and Sexuality Studies"
    case Geology = "Geological Sciences"
    case GeoBio = "Geology-Biology"
    case GeoChem = "Geology-Chemistry"
    case GeoPhy = "Geology-Physics/Mathematics"
    case German = "German Studies"
    case Health = "Health & Human Biology"
    case HispanicLit = "Hispanic Literatures and Cultures"
    case History = "History"
    case HistroyArt = "History of Art and Architecture"
    case IC = "Independent Concentration"
    case IAPA = "International and Public Affairs"
    case InterRel = "International Relations"
    case Italian = "Italian Studies"
    case Judaic = "Judaic Studies"
    case LATAMStudies = "Latin American and Caribbean Studies"
    case Linguist = "Linguistics"
    case LitArts = "Literary Arts"
    case Math = "Mathematics"
    case MathCS = "Mathematics-Computer Science"
    case MathECON = "Mathematics-Economics"
    case Medieval = "Medieval Cultures"
    case MiddleEast = "Middle East Studies"
    case MCM = "Modern Culture and Media"
    case Music = "Music"
    case Neuro = "Neuroscience"
    case Philo = "Philosophy"
    case Physics = "Physics"
    case PhysicsAndPhilo = "Physics and Philosophy"
    case PoliSci = "Political Science"
    case Portuguese = "Portuguese and Brazilian Studies"
    case Psyc = "Psychology"
    case PublicHealth = "Public Health"
    case PublicPolicy = "Public Policy"
    case Relogious = "Religious Studies"
    case SciTechSco = "Science, Technology, and Society"
    case Slav = "Slavic Studies"
    case Research = "Social Analysis and Research"
    case Soc = "Sociology"
    case SouthAsian = "South Asian Studies"
    case Stats = "Statistics"
    case TAPS = "Theatre Arts and Performance Studies"
    case Urban = "Urban Studies"
    case VISA = "Visual Art"
}
