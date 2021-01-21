From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 11:59:59 +0100
Subject: [LTP] [PATCH 1/1] travis: Test NUMA also on Fedora/CentOS
Message-ID: <20210121105959.1002-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

tested (affected distros only)
https://travis-ci.org/github/pevik/ltp/builds/755505691

Kind regards,
Petr

 travis/fedora.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/travis/fedora.sh b/travis/fedora.sh
index 665915a47..ef2d32f47 100755
--- a/travis/fedora.sh
+++ b/travis/fedora.sh
@@ -13,6 +13,7 @@ $yum \
 	gcc \
 	git \
 	findutils \
+	numactl-devel \
 	libtirpc \
 	libtirpc-devel \
 	perl-JSON \
-- 
2.30.0

