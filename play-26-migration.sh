#!/bin/bash

#update plugins
sed -i 's/"sbt-plugin".*/"sbt-plugin" % "2.6.20")/' ./project/plugins.sbt
sed -i 's/"sbt-sassify".*/"sbt-sassify" % "1.4.12")/' ./project/plugins.sbt
sed -i 's/"sbt-uglify".*/"sbt-uglify" % "2.0.0")/' ./project/plugins.sbt

#directly remove logback
sed -i '/"uk.gov.hmrc" %% "logback-json-logger" % "3.1.0",/d' ./project/AppDependencies.scala

#update versions for play26
sed -i 's/govuk-template.*/govuk-template" % "5.25.0-play-26",/' ./project/AppDependencies.scala
sed -i 's/play-health.*/play-health" % "3.7.0-play-26",/' ./project/AppDependencies.scala
sed -i 's/play-ui.*/play-ui" % "7.25.0-play-26",/' ./project/AppDependencies.scala

#change the uglify key
sed -i 's/UglifyKeys.compressOptions/uglifyCompressOptions/' ./build.sbt


