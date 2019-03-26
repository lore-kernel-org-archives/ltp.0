From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Mar 2019 13:52:02 +0100
Subject: [LTP] [PATCH 1/2] travis: Fix testing on debian oldstable
Message-ID: <20190326125203.21104-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which failed due missing oldstable-updates repository

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

probably nobody cares much about travis, but sending anyway.

There is still one build failure on opensuse/tumbleweed,
should be fixed soon by openSUSE project.

Kind regards,
Petr
---
 travis/debian.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/travis/debian.sh b/travis/debian.sh
index 3918a915f..56c8a08be 100755
--- a/travis/debian.sh
+++ b/travis/debian.sh
@@ -1,7 +1,11 @@
 #!/bin/sh
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
 set -e
 
+# workaround for missing oldstable-updates repository
+# W: Failed to fetch http://deb.debian.org/debian/dists/oldstable-updates/main/binary-amd64/Packages
+grep -v oldstable-updates /etc/apt/sources.list > /tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list
+
 apt update
 
 apt install -y --no-install-recommends \
-- 
2.21.0

