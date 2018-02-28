From: xie hui <xieh.jy@cn.fujitsu.com>
Date: Wed, 28 Feb 2018 15:44:35 +0800
Subject: [LTP] [PATCH] runtest/controllers:Distinguish duplicate name of
	pids_7_100
Message-ID: <1519803875-2130-1-git-send-email-xieh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: xie hui <xieh.jy@cn.fujitsu.com>
---
 runtest/controllers | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/controllers b/runtest/controllers
index 3e5df8d..e3d0243 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -383,8 +383,8 @@ pids_6_100 pids.sh 6 100 0
 pids_7_10 pids.sh 7 10 5
 pids_7_50 pids.sh 7 50 10
 pids_7_100 pids.sh 7 100 10
-pids_7_100 pids.sh 7 500 50
-pids_7_100 pids.sh 7 1000 100
+pids_7_500 pids.sh 7 500 50
+pids_7_1000 pids.sh 7 1000 100
 pids_8_2 pids.sh 8 2 0
 pids_8_10 pids.sh 8 10 0
 pids_8_50 pids.sh 8 50 0
-- 
1.8.3.1



