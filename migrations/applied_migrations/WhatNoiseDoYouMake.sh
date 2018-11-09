#!/bin/bash

echo "Applying migration WhatNoiseDoYouMake"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatNoiseDoYouMake                        controllers.WhatNoiseDoYouMakeController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatNoiseDoYouMake                        controllers.WhatNoiseDoYouMakeController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatNoiseDoYouMake                  controllers.WhatNoiseDoYouMakeController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatNoiseDoYouMake                  controllers.WhatNoiseDoYouMakeController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatNoiseDoYouMake.title = whatNoiseDoYouMake" >> ../conf/messages.en
echo "whatNoiseDoYouMake.heading = whatNoiseDoYouMake" >> ../conf/messages.en
echo "whatNoiseDoYouMake.field1 = Field 1" >> ../conf/messages.en
echo "whatNoiseDoYouMake.field2 = Field 2" >> ../conf/messages.en
echo "whatNoiseDoYouMake.checkYourAnswersLabel = whatNoiseDoYouMake" >> ../conf/messages.en
echo "whatNoiseDoYouMake.error.field1.required = Enter field1" >> ../conf/messages.en
echo "whatNoiseDoYouMake.error.field2.required = Enter field2" >> ../conf/messages.en
echo "whatNoiseDoYouMake.error.field1.length = field1 must be 10 characters or less" >> ../conf/messages.en
echo "whatNoiseDoYouMake.error.field2.length = field2 must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatNoiseDoYouMakeUserAnswersEntry: Arbitrary[(WhatNoiseDoYouMakePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatNoiseDoYouMakePage.type]";\
    print "        value <- arbitrary[WhatNoiseDoYouMake].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatNoiseDoYouMakePage: Arbitrary[WhatNoiseDoYouMakePage.type] =";\
    print "    Arbitrary(WhatNoiseDoYouMakePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatNoiseDoYouMake: Arbitrary[WhatNoiseDoYouMake] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        field1 <- arbitrary[String]";\
    print "        field2 <- arbitrary[String]";\
    print "      } yield WhatNoiseDoYouMake(field1, field2)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to CacheMapGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatNoiseDoYouMakePage.type, JsValue)] ::";\
    next }1' ../test/generators/CacheMapGenerator.scala > tmp && mv tmp ../test/generators/CacheMapGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def whatNoiseDoYouMake: Option[AnswerRow] = userAnswers.get(WhatNoiseDoYouMakePage) map {";\
     print "    x => AnswerRow(\"whatNoiseDoYouMake.checkYourAnswersLabel\", s\"${x.field1} ${x.field2}\", false, routes.WhatNoiseDoYouMakeController.onPageLoad(CheckMode).url)";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatNoiseDoYouMake completed"