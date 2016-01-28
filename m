From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 28 Jan 2016 15:28:48 +0300
Subject: [LTP] [PATCH v2 2/6] include/lapi/fcntl.h: add O_TMPFILE definition
In-Reply-To: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1453984132-6240-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1453984132-6240-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/lapi/fcntl.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index d0bb713..1ea3fb4 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -23,6 +23,10 @@
 # define O_CLOEXEC 02000000
 #endif
 
+#ifndef O_TMPFILE
+# define O_TMPFILE (020000000 | O_DIRECTORY)
+#endif
+
 #ifndef F_DUPFD_CLOEXEC
 # define F_DUPFD_CLOEXEC 1030
 #endif
-- 
1.7.1

