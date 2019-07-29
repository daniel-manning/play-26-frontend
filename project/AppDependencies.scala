import sbt._

object AppDependencies {
  import play.core.PlayVersion

  val compile = Seq(
    play.sbt.PlayImport.ws,
    "uk.gov.hmrc" %% "simple-reactivemongo" % "7.12.0-play-26",
    "uk.gov.hmrc" %% "govuk-template" % "5.29.0-play-26",
    "uk.gov.hmrc" %% "play-health" % "3.12.0-play-26",
    "uk.gov.hmrc" %% "play-ui" % "7.32.0-play-26",
    "uk.gov.hmrc" %% "http-caching-client" % "7.1.0",
    "uk.gov.hmrc" %% "play-conditional-form-mapping" % "0.2.0",
    "uk.gov.hmrc" %% "bootstrap-play-26" % "0.36.0",
    //"uk.gov.hmrc" %% "play-language" % "3.4.0",
    "uk.gov.hmrc" %% "play-whitelist-filter" % "2.0.0",
    "uk.gov.hmrc" %% "csp-client" % "3.6.0-play-26-SNAPSHOT"
  )

  val test = Seq(
    "uk.gov.hmrc" %% "hmrctest" % "3.3.0",
    "org.scalatest" %% "scalatest" % "3.0.5",
    "org.scalatestplus.play" %% "scalatestplus-play" % "3.1.2",
    "org.pegdown" % "pegdown" % "1.6.0",
    "org.jsoup" % "jsoup" % "1.10.3",
    "com.typesafe.play" %% "play-test" % PlayVersion.current,
    "org.mockito" % "mockito-all" % "1.10.19",
    "org.scalacheck" %% "scalacheck" % "1.14.0"
  ).map(_ % Test)

  def apply() = compile ++ test
}
