import ApplicationController from './application_controller';

export default class extends ApplicationController {
  static targets = ['aside', 'overlay'];

  connect() {
    if (this.pageIsTurboPreview) {
      this.closeSidebar();
    }
  }

  openSidebar() {
    this.asideTarget.classList.add('sidebar--active');
    this.overlayTarget.classList.remove('hidden');
  }

  closeSidebar() {
    this.asideTarget.classList.remove('sidebar--active');
    this.overlayTarget.classList.add('hidden');
  }
}
