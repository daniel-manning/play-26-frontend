/*
 * Copyright 2018 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package utils

import controllers.routes
import models.{CheckMode, UserAnswers}
import pages._
import viewmodels.{AnswerRow, RepeaterAnswerRow, RepeaterAnswerSection}

class CheckYourAnswersHelper(userAnswers: UserAnswers) {

  def whatNoiseDoYouMake: Option[AnswerRow] = userAnswers.get(WhatNoiseDoYouMakePage) map {
    x => AnswerRow("whatNoiseDoYouMake.checkYourAnswersLabel", s"${x.field1} ${x.field2}", false, routes.WhatNoiseDoYouMakeController.onPageLoad(CheckMode).url)
  }

  def isYourNoseWet: Option[AnswerRow] = userAnswers.get(IsYourNoseWetPage) map {
    x => AnswerRow("isYourNoseWet.checkYourAnswersLabel", if(x) "site.yes" else "site.no", true, routes.IsYourNoseWetController.onPageLoad(CheckMode).url)
  }

  def areYouALabrador: Option[AnswerRow] = userAnswers.get(AreYouALabradorPage) map {
    x => AnswerRow("areYouALabrador.checkYourAnswersLabel", if(x) "site.yes" else "site.no", true, routes.AreYouALabradorController.onPageLoad(CheckMode).url)
  }
}
