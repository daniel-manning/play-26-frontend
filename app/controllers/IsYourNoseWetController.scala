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

package controllers

import javax.inject.Inject
import play.api.data.Form
import play.api.i18n.{I18nSupport, MessagesApi}
import uk.gov.hmrc.play.bootstrap.controller.FrontendController
import connectors.DataCacheConnector
import controllers.actions._
import config.FrontendAppConfig
import forms.IsYourNoseWetFormProvider
import models.{Mode, UserAnswers}
import pages.IsYourNoseWetPage
import navigation.Navigator
import uk.gov.hmrc.http.cache.client.CacheMap
import views.html.isYourNoseWet

import scala.concurrent.Future

class IsYourNoseWetController @Inject()(appConfig: FrontendAppConfig,
                                         override val messagesApi: MessagesApi,
                                         dataCacheConnector: DataCacheConnector,
                                         navigator: Navigator,
                                         identify: IdentifierAction,
                                         getData: DataRetrievalAction,
                                         requireData: DataRequiredAction,
                                         formProvider: IsYourNoseWetFormProvider
                                         ) extends FrontendController with I18nSupport {

  val form: Form[Boolean] = formProvider()

  def onPageLoad(mode: Mode) = (identify) {
    implicit request =>

      val preparedForm = form

      Ok(isYourNoseWet(appConfig, preparedForm, mode))
  }

  def onSubmit(mode: Mode) = (identify andThen getData).async {
    implicit request =>

      form.bindFromRequest().fold(
        (formWithErrors: Form[_]) =>
          Future.successful(BadRequest(isYourNoseWet(appConfig, formWithErrors, mode))),
        (value) => {
          val updatedAnswers = request.userAnswers.getOrElse(new UserAnswers(new CacheMap("", Map()))).set(IsYourNoseWetPage, value)

          dataCacheConnector.save(updatedAnswers.cacheMap).map(
            _ =>
              Redirect(navigator.nextPage(IsYourNoseWetPage, mode)(updatedAnswers))
          )
        }
      )
  }
}
