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

package views

import play.api.data.Form
import controllers.routes
import forms.WhatNoiseDoYouMakeFormProvider
import models.{NormalMode, WhatNoiseDoYouMake}
import views.behaviours.QuestionViewBehaviours
import views.html.whatNoiseDoYouMake

class WhatNoiseDoYouMakeViewSpec extends QuestionViewBehaviours[WhatNoiseDoYouMake] {

  val messageKeyPrefix = "whatNoiseDoYouMake"

  override val form = new WhatNoiseDoYouMakeFormProvider()()

  def createView = () => whatNoiseDoYouMake(frontendAppConfig, form, NormalMode)(fakeRequest, messages)

  def createViewUsingForm = (form: Form[_]) => whatNoiseDoYouMake(frontendAppConfig, form, NormalMode)(fakeRequest, messages)


  "WhatNoiseDoYouMake view" must {

    behave like normalPage(createView, messageKeyPrefix)

    behave like pageWithBackLink(createView)

    behave like pageWithTextFields(
      createViewUsingForm,
      messageKeyPrefix,
      routes.WhatNoiseDoYouMakeController.onSubmit(NormalMode).url,
      "field1", "field2"
    )
  }
}
