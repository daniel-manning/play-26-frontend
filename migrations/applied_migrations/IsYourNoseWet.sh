#!/bin/bash

echo "Applying migration IsYourNoseWet"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /isYourNoseWet                        controllers.IsYourNoseWetController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /isYourNoseWet                        controllers.IsYourNoseWetController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeIsYourNoseWet                  controllers.IsYourNoseWetController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeIsYourNoseWet                  controllers.IsYourNoseWetController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "isYourNoseWet.title = isYourNoseWet" >> ../conf/messages.en
echo "isYourNoseWet.heading = isYourNoseWet" >> ../conf/messages.en
echo "isYourNoseWet.checkYourAnswersLabel = isYourNoseWet" >> ../conf/messages.en
echo "isYourNoseWet.error.required = Select yes if isYourNoseWet" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsYourNoseWetUserAnswersEntry: Arbitrary[(IsYourNoseWetPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[IsYourNoseWetPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryIsYourNoseWetPage: Arbitrary[IsYourNoseWetPage.type] =";\
    print "    Arbitrary(IsYourNoseWetPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to CacheMapGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(IsYourNoseWetPage.type, JsValue)] ::";\
    next }1' ../test/generators/CacheMapGenerator.scala > tmp && mv tmp ../test/generators/CacheMapGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def isYourNoseWet: Option[AnswerRow] = userAnswers.get(IsYourNoseWetPage) map {";\
     print "    x => AnswerRow(\"isYourNoseWet.checkYourAnswersLabel\", if(x) \"site.yes\" else \"site.no\", true, routes.IsYourNoseWetController.onPageLoad(CheckMode).url)"; print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration IsYourNoseWet completed"
