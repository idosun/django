# Must have `sentry-cli` installed globally
# Following variable must be passed in
#  SENTRY_AUTH_TOKEN=<your_auth_token>

SENTRY_ORG=testorg-az
SENTRY_PROJECT=sentry-django-rest-demo
VERSION=`sentry-cli releases propose-version`
REPO=sentry-demos/django

deploy: create_release associate_commits run_django

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --commit "$(REPO)@$(VERSION)"

run_django:
	python manage.py runserver --insecure