From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 11 Jan 2017 13:42:29 +0100
Subject: [LTP] [PATCH 1/1] travis: initial configuration
Message-ID: <20170111124229.18935-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

Configuration: build with gcc only, install, email to mailing list in
case of error or change (previously broken build was just fixed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000..16c0cd477
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,9 @@
+sudo: required
+
+language: c
+
+notifications:
+    email:
+        - ltp@lists.linux.it
+
+script: make autotools && ./configure --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
-- 
2.11.0

