import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['toast'];

  connect() {
    if (this.pageIsTurboPreview) {
      return this.element.remove();
    }

    this.toastTarget.classList.add('toast--animate-in');

    setTimeout(() => {
      this.hide();
    }, 5000);
  }

  hide() {
    this.toastTarget.classList.replace(
      'toast--animate-in',
      'toast--animate-out'
    );
  }
}
