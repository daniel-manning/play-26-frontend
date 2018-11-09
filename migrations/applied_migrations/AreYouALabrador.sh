#!/bin/bash

echo "Applying migration AreYouALabrador"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /areYouALabrador                        controllers.AreYouALabradorController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /areYouALabrador                        controllers.AreYouALabradorController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeAreYouALabrador                  controllers.AreYouALabradorController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeAreYouALabrador                  controllers.AreYouALabradorController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "areYouALabrador.title = areYouALabrador" >> ../conf/messages.en
echo "areYouALabrador.heading = areYouALabrador" >> ../conf/messages.en
echo "areYouALabrador.checkYourAnswersLabel = areYouALabrador" >> ../conf/messages.en
echo "areYouALabrador.error.required = Select yes if areYouALabrador" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryAreYouALabradorUserAnswersEntry: Arbitrary[(AreYouALabradorPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[AreYouALabradorPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryAreYouALabradorPage: Arbitrary[AreYouALabradorPage.type] =";\
    print "    Arbitrary(AreYouALabradorPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to CacheMapGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(AreYouALabradorPage.type, JsValue)] ::";\
    next }1' ../test/generators/CacheMapGenerator.scala > tmp && mv tmp ../test/generators/CacheMapGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class/ {\
     print;\
     print "";\
     print "  def areYouALabrador: Option[AnswerRow] = userAnswers.get(AreYouALabradorPage) map {";\
     print "    x => AnswerRow(\"areYouALabrador.checkYourAnswersLabel\", if(x) \"site.yes\" else \"site.no\", true, routes.AreYouALabradorController.onPageLoad(CheckMode).url)"; print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration AreYouALabrador completed"
