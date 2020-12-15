From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Dec 2020 10:47:22 +0100
Subject: [LTP] Travis fix
Message-ID: <X9iGKllfr8qYi/yX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

you may noticed that our Travis CI testing currently fails on Ubuntu eoan.

This is because Travis has outdated docker image, which still expect
eoan-security being on ttp://security.ubuntu.com/ubuntu.

I'm testing other releases, groovy should be probably best option (LTS => used
by many people and has security repository so we don't have to bother fixing apt
repository).

I suppose I fix it during today.

Travis got pretty slow last few weeks. Maybe it's related to the move from
travis-ci.org to travis-ci.com. Maybe we should think about other CI if problem
persists for months. It looks like GitHub Actions supports docker [1].
Also Gitlab pipelines support it [2], but moving from GitHub would affect more
things than just CI.

Kind regards,
Petr

[1] https://docs.github.com/en/free-pro-team@latest/actions/creating-actions/creating-a-docker-container-action
[2] https://docs.gitlab.com/ee/ci/docker/using_docker_images.html
