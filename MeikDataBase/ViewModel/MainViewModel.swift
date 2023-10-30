/**
 A view model class for managing the user's authentication status and related data in the MeikDataBase app.

 The `MainViewModel` class provides properties and methods to check the user's authentication status and retrieve user-related information.

 - Author: Roberto Gonzales
 - Date: 8/28/23
 */
import Foundation
import FirebaseAuth
/**
 Initializes the `MainViewModel` and sets up an authentication state change listener.

 The listener observes changes in the user's authentication state and updates the `currentUserId` property accordingly.

 */
class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var email: String = ""
    private var handler : AuthStateDidChangeListenerHandle?
    
    init(){
        self.handler = Auth.auth().addStateDidChangeListener {
            [weak self] _,user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    /**
     Checks if a user is signed in.

     - Returns: `true` if a user is signed in; otherwise, `false`.
     */
    public var isSignedIn: Bool {
        if Auth.auth().currentUser != nil {
                if String(Auth.auth().currentUser?.email ?? "") == "test@gmail.com" {
                    return false
                }else {
                    return true}
        }
        return false
    }
    /**
     Checks if a guest user is signed in.

     - Returns: `true` if a guest user is signed in; otherwise, `false`.
     */
    public var guestSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    /**
     Checks if the current user is a Meik user based on their email address.

     - Returns: `true` if the current user's email is in the list of Meik users; otherwise, `false`.
     */
    public var isAMeik: Bool {
        return "testbrown@brown.edu aaron_seto@brown.edu aarya_jaipuria@brown.edu adam_gendreau@brown.edu addison_marin@brown.edu adelaide_poulson@brown.edu aditya_singh1@brown.edu adrian_lin@brown.edu aidan_berman@brown.edu aijah_garcia@brown.edu akshay_malhotra@brown.edu alan_mach@brown.edu albert_cho@brown.edu alberto_lopez@brown.edu aleah_davidsen@brown.edu alec_lacerte@brown.edu alex_rodriguez@brown.edu alexandra_lehman@brown.edu alexandra_mork@brown.edu alexandra_vitkin@brown.edu alexandria_martinez@brown.edu alice_min@brown.edu alix_hamon@brown.edu allison_hsieh@brown.edu amber_wang@brown.edu amelia_zug@brown.edu aminata_barrow@brown.edu amiya_mandapati@brown.edu amy_zhao@brown.edu ananya_mukerji@brown.edu ananya_narayanan@brown.edu andrew_s_li@brown.edu angela_wei1@brown.edu angelina_cho@brown.edu angelina_rios-galindo@brown.edu anisa_sondhi@brown.edu anita_zahiri@brown.edu anjali_srinivasan@brown.edu anna_brodsky@brown.edu anna_galer@brown.edu anna_lapre@brown.edu anthony_kharrat@brown.edu anusha_gupta@brown.edu arenal_haut@brown.edu ariana_cleveland@brown.edu arianna_baffa@brown.edu arushi_parekh@brown.edu aryan_joshi@brown.edu aryan_singh@brown.edu audrey_wijono@brown.edu autumn_wong@brown.edu ava_bradley@brown.edu ava_pellagrini@brown.edu avani_ghosh@brown.edu axel_martinez@brown.edu bella_pitman@brown.edu benicio_beatty@brown.edu benjamin_bradley@brown.edu benjamin_ringel@brown.edu bisheshank_c_aryal@brown.edu brandon_wu1@brown.edu brian_ji@brown.edu brian_t_nguyen@brown.edu brianna_nee@brown.edu brianna_pham@brown.edu brynn_goggins@brown.edu calvin_kirk@brown.edu camila_murillo@brown.edu camilla_regalia@brown.edu carlson_ogata@brown.edu catherine_jia@brown.edu catherine_manning@brown.edu catherine_morrissette@brown.edu chandler_stevenson@brown.edu chloe_chow@brown.edu chloe_nevas@brown.edu chloe_zhao@brown.edu christine_wu@brown.edu christopher_nguyen@brown.edu christopher_sanchez_jr@brown.edu claire_y_zhang@brown.edu clara_tandar@brown.edu cole_dorsey@brown.edu da-young_kim@brown.edu dahlia_levine@brown.edu daido_ouattara@brown.edu dana_magana_miralles@brown.edu danae_lopez@brown.edu daniel_newgarden@brown.edu daniel_omondi@brown.edu daniel_w_xu@brown.edu david_s_han@brown.edu dimitra_sofianou@brown.edu dixi_han@brown.edu edward_wibowo@brown.edu eileen_wu@brown.edu eliana_alweis@brown.edu elisa_kim1@brown.edu elise_togneri@brown.edu elizabeth_doss@brown.edu elizabeth_duchan@brown.edu elizabeth_morvatz@brown.edu emily_hamp@brown.edu emily_lin1@brown.edu emily_mayo@brown.edu emily_olson@brown.edu emily_perelman@brown.edu emily_wagg@brown.edu emma_donnelly@brown.edu emma_pearlman@brown.edu erica_brown3@brown.edu ethan_mcdowell@brown.edu evan_ren@brown.edu faith_s_kim@brown.edu faith_shim@brown.edu fanny-marie_vavrovsky@brown.edu farah_yahaya@brown.edu finnegan_keller@brown.edu francesca_fraim@brown.edu gaayatri_godbole@brown.edu gabriel_herrera@brown.edu gabriel_traietti@brown.edu gannon_lemaster@brown.edu garrett_johnson@brown.edu giang_thai@brown.edu giselle_goldfischer@brown.edu grace_posorske@brown.edu gustin_lafave@brown.edu hailey_tomashek@brown.edu hamid_torabzadeh@brown.edu hamsa_shanmugam@brown.edu hannah_menghis@brown.edu hannah_stoch@brown.edu hannah_zupancic@brown.edu harrison_sprofera@brown.edu hassan_alemara@brown.edu helena_soares_barros@brown.edu helene_comer@brown.edu hpone_thit_htoo@brown.edu ilana_greenstein@brown.edu iman_khanbhai@brown.edu indigo_mudbhary@brown.edu iris_yang@brown.edu isabella_collins1@brown.edu isabella_fish@brown.edu ivy_lin1@brown.edu jaclyn_cohen@brown.edu jacob_e_goldberg@brown.edu jacob_ravich@brown.edu jaeyeon_park@brown.edu james_reinke@brown.edu jane_trainor@brown.edu jane_zhou@brown.edu janelle_li@brown.edu jay_chi@brown.edu jeffrey_tao@brown.edu jelynn_ellianna_tatad@brown.edu jennifer_tran1@brown.edu jenny_hu@brown.edu jesse_hogan@brown.edu jessica_tuchin@brown.edu jesus_gonzalez@brown.edu jezlyn_abramowski@brown.edu jia_ning_karis_ma@brown.edu jiaxuan_peng@brown.edu joanne_lee1@brown.edu jocelyn_yang@brown.edu joel_gonzalez@brown.edu joel_manasseh@brown.edu johannes_elias@brown.edu john_bellaire@brown.edu john_hardart@brown.edu john_soscia@brown.edu jonathan_palfy@brown.edu jonathan_zhang1@brown.edu jordan_roller@brown.edu joseph_saperstein@brown.edu josephine_alston@brown.edu josephine_diaz@brown.edu joshua_jaramillo_lopez@brown.edu josue_navarro@brown.edu julia_clark@brown.edu julia_patterson@brown.edu julia_rodriguez@brown.edu julia_terra-salomao@brown.edu julianna_chang@brown.edu julie_hajducky@brown.edu junbeom_kwon@brown.edu justin_lee4@brown.edu justin_v_lee@brown.edu kailani_fletcher@brown.edu kaitlyn_chan@brown.edu kaitlyn_williams@brown.edu karina_ortiz1@brown.edu kate_kuli@brown.edu katharine_orchard@brown.edu katherine_mao@brown.edu kathleen_min@brown.edu kayla_mukai@brown.edu keelin_gaughan@brown.edu keidy_palma_ramirez@brown.edu kelly_mukai@brown.edu kimberly_munoz@brown.edu kimberly_valencia-solorzano@brown.edu kiran_rodrigues@brown.edu kofi_young@brown.edu kyoungmin_lee@brown.edu laura_chen@brown.edu lauren_castleman@brown.edu lauren_chiu@brown.edu lauren_meraz@brown.edu leah_derenge@brown.edu leeah_chang@brown.edu lella_wirth@brown.edu lena_noya@brown.edu leo_corzo-clark@brown.edu lia_ortner@brown.edu liliana_cunha@brown.edu lilly_nguyen@brown.edu lily_chahine@brown.edu lisa_duan@brown.edu lita_crichton@brown.edu logan_rulloda@brown.edu logan_torres@brown.edu logan_wojcik@brown.edu louisa_cavicchi@brown.edu lucy_lebowitz@brown.edu lucy_negatu@brown.edu lucy_nguyen@brown.edu luis_gomez@brown.edu luka_willett@brown.edu luxi_yu@brown.edu maddock_thomas@brown.edu madeline_goldsmith@brown.edu mahlon_page@brown.edu makenzie_komack@brown.edu mar_falcon@brown.edu marcos_montoya_andrade@brown.edu margherita_rampichini@brown.edu marina_demas@brown.edu marissa_scott@brown.edu marissa_shaffer@brown.edu matteo_papadopoulos@brown.edu matthew_t_liu@brown.edu maya_julian-kwong@brown.edu meehir_dixit@brown.edu megan_ball@brown.edu megan_savage@brown.edu meitsz_lau@brown.edu mena_kassa@brown.edu mia_busuladzic-begic@brown.edu mia_kantorovich@brown.edu michael_h_sun@brown.edu michael_ochoa@brown.edu mikhaila_doyle@brown.edu molly_woodfin@brown.edu moon_hee_kim@brown.edu morgan_glazier@brown.edu naile_ozpolat@brown.edu naomi_kissel@brown.edu naomi_umlauf@brown.edu natalia_begara_criado@brown.edu natalie_villacres@brown.edu nate_nigrin@brown.edu natsuka_hayashida@brown.edu nayani_modugula@brown.edu nhu_tran@brown.edu nishant_jayachandran@brown.edu nishitha_chaayanath@brown.edu noah_silverman@brown.edu oliver_corbett@brown.edu olivia_l_williamson@brown.edu olivia_massey@brown.edu olivia_nash1@brown.edu olivia_schmidt@brown.edu pascale_carvalho@brown.edu perseverance_unger@brown.edu peter_haynes@brown.edu praewprach_lerthirunvibul@brown.edu pran_teelucksingh@brown.edu pranav_mahableshwarkar@brown.edu qiao_ying_chen@brown.edu rachel_chae@brown.edu rafael_davis@brown.edu raima_islam@brown.edu rebecca_whang@brown.edu renee_choi@brown.edu rhea_rasquinha@brown.edu riley_stevenson@brown.edu rohan_meier@brown.edu rohan_zamvar@brown.edu ryan_peng@brown.edu saehee_jin@brown.edu saipravallika_chamarthi@brown.edu saira_moazzam@brown.edu samantha_bernstein@brown.edu samantha_chon@brown.edu samantha_rosario@brown.edu samuel_ferraro@brown.edu samuel_latzman@brown.edu samuel_lederman@brown.edu san_kwon@brown.edu sarah_frank4@brown.edu sarah_roberts2@brown.edu sarosh_nadeem@brown.edu sarvesh_rajkumar@brown.edu sashank_varanasi@brown.edu satvik_narang@brown.edu selamawit_asfaw@brown.edu selena_sheth@brown.edu selena_williams@brown.edu seth_peiris@brown.edu shadi_soufan@brown.edu shannon_feerick-hillenbrand@brown.edu shayla_hillis@brown.edu shokria_sakhi@brown.edu sidharth_udata@brown.edu sierra_bornheim@brown.edu siqi_wang4@brown.edu sofyan_squali-houssaini@brown.edu sonal_sharma@brown.edu sophia_lim@brown.edu sophia_thomas@brown.edu stella_tsogtjargal@brown.edu stephanie_therese_fajardo@brown.edu stephen_mccully@brown.edu sydney_butler@brown.edu sydney_nutakor@brown.edu sydney_roberts@brown.edu taimi_xu@brown.edu tanvi_palsamudram@brown.edu tara_hislip@brown.edu tasiemobi_anozie@brown.edu tej_tummala@brown.edu tenzin_diki@brown.edu thomas_gotsch@brown.edu thomas_madrid@brown.edu tina_li@brown.edu tuyetanh_le@brown.edu tyshon_hattori-lindsey@brown.edu vansh_patel@brown.edu varisa_tantivess@brown.edu venkatsai_bellala@brown.edu veronica_godina@brown.edu vicki_pu@brown.edu victoria_chamberlain@brown.edu viktor_bardi@brown.edu vivek_rajani@brown.edu wesley_peng@brown.edu william_boyce@brown.edu william_forys@brown.edu william_french@brown.edu william_kemball-cook@brown.edu william_lake@brown.edu william_lin1@brown.edu william_loughridge@brown.edu william_malloy@brown.edu william_salerno@brown.edu wilson_roe@brown.edu wilson_vo@brown.edu yameng_zhang@brown.edu yejin_song@brown.edu yeonwoo_jeong@brown.edu yitian_xu@brown.edu yuliya_velhan@brown.edu yunan_he@brown.edu yuze_zhu@brown.edu zachary_boston@brown.edu zachary_l_brown@brown.edu zahra_naqvi@brown.edu zain_peerbhoy@brown.edu zeyuan_gao@brown.edu zoe_cruz@brown.edu zoe_kass@brown.edu zoe_siegel@brown.edu zoey_grant@brown.edu olivia_hanley@brown.edu jae-hyun_m_lee@brown.edu nikitha_bhimireddy@brown.edu eloise_knight@brown.edu".contains(Auth.auth().currentUser?.email ?? "not A Meik")
    }
    
    public var isAMeikLeader: Bool {
        return "roberto_gonzales_matos@brown.edu sydney_stovall@brown.edu roberto_gonzales_matos@brown.edu adam_meller@brown.edu alaina_cherry@brown.edu aliza_kopans@brown.edu avery_liu@brown.edu cecile_schreidah@brown.edu david_felipe@brown.edu  jacquelyn_benjes@brown.edu klara_davidson-schmich@brown.edu marcelo_rodriguez_parra@brown.edu melia_lee@brown.edu patrick_rourke@brown.edu samantha_buyungo@brown.edu samantha_chambers@brown.edu".contains(Auth.auth().currentUser?.email ?? "not A Meik")
    }
}
