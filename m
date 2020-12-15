From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Dec 2020 11:01:54 +0100
Subject: [LTP] Travis fix
In-Reply-To: <X9iGKllfr8qYi/yX@pevik>
References: <X9iGKllfr8qYi/yX@pevik>
Message-ID: <X9iJkj3ZDWj2NaWi@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi,

> you may noticed that our Travis CI testing currently fails on Ubuntu eoan.

> This is because Travis has outdated docker image, which still expect
> eoan-security being on ttp://security.ubuntu.com/ubuntu.

> I'm testing other releases, groovy should be probably best option (LTS => used
> by many people and has security repository so we don't have to bother fixing apt
> repository).
OK, 20.04 LTS focal in Travis is still fails on debconf issue [3]
("debconf: unable to initialize frontend: Dialog") which expect user input.
20.10 groovy is not LTS, but it looks stable. Let's move to it (we'll need to
switch to something else in 7 months, or we can move to another distro).

Kind regards,
Petr

[3] https://travis-ci.org/github/pevik/ltp/jobs/749784860
[4] https://travis-ci.org/github/pevik/ltp/jobs/749784861

> I suppose I fix it during today.

> Travis got pretty slow last few weeks. Maybe it's related to the move from
> travis-ci.org to travis-ci.com. Maybe we should think about other CI if problem
> persists for months. It looks like GitHub Actions supports docker [1].
> Also Gitlab pipelines support it [2], but moving from GitHub would affect more
> things than just CI.

> Kind regards,
> Petr

> [1] https://docs.github.com/en/free-pro-team@latest/actions/creating-actions/creating-a-docker-container-action
> [2] https://docs.gitlab.com/ee/ci/docker/using_docker_images.html
