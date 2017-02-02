From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Feb 2017 16:43:15 +0100
Subject: [LTP] [PATCH 1/1] travis: stop github forks spamming mailing list
Message-ID: <20170202154315.29693-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by crypting our mailing list email with:
travis encrypt -r linux-test-project/ltp "ltp@lists.linux.it"

Thanks to Peter Maydell for pointing this out.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 86b96d630..d937f9dcf 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -70,6 +70,6 @@ matrix:
 
 notifications:
     email:
-        - ltp@lists.linux.it
+        secure: "b/xcA/K5OyQvPPnd0PRahTH5LJu8lgz8goGHvhXpHo+ZPsPgTDXNFo5cX9fSOkMuFKeoW8iGl0wOgK2+ptc8mbYDw277K4RFIHRHeV/KIoE1EzjQnEFiL8J0oHCAvDj12o0AXeriTyY9gICXKbR31Br6Zh5eKViDJe2OAGeHeDU="
 
 script: make autotools && ./configure --prefix $HOME/ltp --with-open-posix-testsuite --with-realtime-testsuite && make -j$(getconf _NPROCESSORS_ONLN) && make -j$(getconf _NPROCESSORS_ONLN) install
-- 
2.11.0

