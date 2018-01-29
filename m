From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jan 2018 12:23:45 +0100
Subject: [LTP] [COMMITTED 1/1] travis: install packages also on cross and 32
	bit
Message-ID: <20180129112345.19886-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

unless the build is not meant to be build only with minimal dependencies.

This is a test for fix 50819a347 ("numa: Fix numa v2 detection for cross compilation")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 7b8fb504d..d89c4353b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -94,7 +94,7 @@ before_install:
     # installing / removing dependencies
     - if [ "$INSTALL_PACKAGES" = "" ]; then
           sudo apt remove $(cat .travis.packages_native | grep -v -e 'libc6' -e 'libc6-dev' -e 'linux-libc-dev' -e 'libacl1')
-      ; elif [ "$INSTALL_PACKAGES" != "cross" ]; then
+      ; else
           sudo apt install -qq $(cat .travis.packages_native)
       ; fi
 
-- 
2.16.0

