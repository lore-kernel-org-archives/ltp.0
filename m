From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 11 Jan 2017 13:59:37 +0100
Subject: [LTP] [PATCH v2 1/1] travis: initial configuration
Message-ID: <20170111125937.19842-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Configuration: build with gcc only, install.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Actually I decided to use default mail notification settings (mail sent to
author and committer if they have push or admin permissions, see
https://docs.travis-ci.com/user/notifications#Default-notification-settings).

The reason is that otherwise we'd get email notifications to mailing list also
for forks (see https://github.com/travis-ci/travis-ci/issues/329
https://github.com/travis-ci/travis-ci/issues/1094).
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000..60d4aa3d6
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,8 @@
+sudo: required
+
+language: c
+
+notifications:
+    - email: true
+
+script: make autotools && ./configure --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
-- 
2.11.0

