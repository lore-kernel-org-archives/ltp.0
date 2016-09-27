From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Sep 2016 13:06:43 +0300
Subject: [LTP] [PATCH 3/3] network/netsress: increase internal message
	buffer size to 2^16 - 1
In-Reply-To: <1474970803-24241-1-git-send-email-alexey.kodanev@oracle.com>
References: <1474970803-24241-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1474970803-24241-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allow to pass larger buffer to sendto()/recvfrom(). netstress's
protocol already supports setting such size as it has 16 bit field
for message size parameter.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/netstress/netstress.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 4d7ffcc..26fd217 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -36,7 +36,7 @@
 
 char *TCID = "netstress";
 
-static const int max_msg_len = 1500;
+static const int max_msg_len = (1 << 16) - 1;
 
 /* TCP server requiers */
 #ifndef TCP_FASTOPEN
-- 
1.7.1

