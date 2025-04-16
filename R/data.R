#' College basketball Season Statistics data
#'
#' A combination of the kaggle college basketball dataset and CBBData with
#'    information from 2013 to 2024 college basketball
#'
#' @format ## 'DATASET'
#' A data frame with 4238 rows and 84 columns:
#' \describe{
#'    \item{team} {Team name}
#'    \item{year} {Year the statistics were recorded}
#'    \item{min} {Total minutes played by the team in the season or per game}
#'    \item{pos} {Estimated number of possessions per game or per season}
#'    \item{fgm} {Number of field goals made}
#'    \item{fga} {Number of field goals attempted}
#'    \item{fg_pct} {Field goal percentage (FGM divided by FGA)}
#'    \item{tpm} {Three-point field goals made}
#'    \item{tpa} {Three-point field goals attempted}
#'    \item{tp_pct} {Three-point shooting percentage (TPM divided by TPA)}
#'    \item{ftm} {Free throws made}
#'    \item{fta} {Free throws attempted}
#'    \item{oreb} {Offensive rebounds}
#'    \item{dreb} {Defensive rebounds}
#'    \item{reb} {Total rebounds (OREB + DREB)}
#'    \item{ast} {Assists}
#'    \item{stl} {Steals}
#'    \item{blk} {Blocks}
#'    \item{to} {Turnovers}
#'    \item{pf} {Personal fouls}
#'    \item{pts} {Total number of points scored}
#'    \item{opp_fgm} {Opponent's field goals made}
#'    \item{opp_fga} {Opponent's field goals attempted}
#'    \item{opp_fg_pct} {Opponent's field goal percentage}
#'    \item{opp_tpm} {Opponent's three-point field goals made}
#'    \item{opp_tpa} {Opponent's three-point field goals attempted}
#'    \item{opp_tp_pct} {Opponent's three-point percentage}
#'    \item{opp_ftm} {Opponent's free throws made}
#'    \item{opp_fta} {Opponent's free throws attempted}
#'    \item{opp_ft_pct} {Opponent's free throw percentage}
#'    \item{opp_oreb} {Opponent's offensive rebounds}
#'    \item{opp_dreb} {Opponent's defensive rebounds}
#'    \item{opp_reb} {Opponent's total rebounds}
#'    \item{opp_ast} {Opponent's assists}
#'    \item{opp_stl} {Opponent's steals}
#'    \item{opp_blk} {Opponent's blocks}
#'    \item{opp_to} {Opponent's turnovers}
#'    \item{opp_pf} {Opponent's personal fouls}
#'    \item{opp_pts} {Total points scored by the opponent}
#'    \item{pts_scored} {Team's total points scored over the season}
#'    \item{pts_allowed} {Total points allowed over the season}
#'    \item{adj_o.x} {Adjusted offensive efficiency (points per 100 possessions, accounting for strength of schedule)}
#'    \item{adj_d.x} {Adjusted defensive efficiency (points allowed per 100 possessions, adjusted for opponent strength)}
#'    \item{off_ppp} {Offensive points per possession}
#'    \item{off_efg} {Offensive effective field goal percentage (accounts for the extra value of 3-point shots)}
#'    \item{off_to} {Offensive turnover rate (turnovers per possession)}
#'    \item{off_or} {Offensive rebound rate (OREB divided by total available offensive rebounds)}
#'    \item{off_ftr} {Offensive free throw rate (FTA divided by FGA)}
#'    \item{def_ppp} {Defensive points allowed per possession}
#'    \item{def_efg.x} {Opponent's effective field goal percentage}
#'    \item{def_to} {Defensive turnover rate}
#'    \item{def_or} {Opponent's offensive rebound rate}
#'    \item{def_ftr.x} {Opponent's free throw rate}
#'    \item{game_score} {A metric summarizing team performance for a single game}
#'    \item{tempo} {Average number of possessions per 40 minutes}
#'    \item{games.x} {Number of games played}
#'    \item{games.y} {Number of games played}
#'    \item{wins} {Total wins for the season}
#'    \item{losses} {Total losses for the season}
#'    \item{adj_t} {Adjusted tempo (possessions per game adjusted for opponents)}
#'    \item{adj_o.y} {Alternative source for adjusted offensive efficiency}
#'    \item{adj_d.y} {Alternative source for adjusted defensive efficiency}
#'    \item{barthag} {Power ranking metric estimating team strength and win probability against average opponent}
#'    \item{efg} {Team's effective field goal percentage}
#'    \item{def_efg.y} {Opponent's effective field goal percentage}
#'    \item{ftr} {Team's free throw rate}
#'    \item{def_ftr.y} {Opponent's free throw rate}
#'    \item{oreb_rate} {Offensive rebounding percentage}
#'    \item{dreb_rate} {Defensive rebounding percentage}
#'    \item{tov_rate} {Turnover rate per offensive possession}
#'    \item{def_tov_rate} {Opponent turnover rate (forced turnovers per possession)}
#'    \item{two_pt_pct} {Team's 2-point field goal percentage}
#'    \item{three_pt_pct} {Team's 3-point field goal percentage}
#'    \item{ft_pct.y} {Free throw percentage}
#'    \item{def_two_pt_pct} {Opponent's 2-point field goal percentage}
#'    \item{def_three_pt_pct} {Opponent's 3-point field goal percentage}
#'    \item{three_fg_rate} {Proportion of field goal attempts that are three-pointers}
#'    \item{def_three_fg_rate} {Proportion of opponent field goal attempts that are threes}
#'    \item{assist_rate} {Percentage of made field goals that were assisted}
#'    \item{def_assist_rate} {Percentage of opponent's made field goals that were assisted}
#'    \item{wab} {Wins Above Bubble — how many more wins a team has compared to a typical bubble team}
#'    \item{CONF} {The conference the team plays in (e.g., ACC, Big Ten)}
#'    \item{POSTSEASON} {How far the team advanced in the postseason}
#'    \item{SEED} {NCAA tournament seed assigned to the team}
#' }
#'
#' @Manual{,title = {cbbdata: API for College Basketball Data},
#' author = {Andrew Weatherman},
#' year = {2024},
#' note = {R package version 0.3.0.9000},
#' url = {https://cbbdata.aweatherman.com/},
#' }
#'
#' @source "https://www.kaggle.com/datasets/andrewsundberg/college-basketball-dataset?select=cbb.csv"
#'
#' "DATASET"
#'
#'
#'
