From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 14 Jan 2018 17:12:56 +0200
Subject: [LTP] [PATCH 1/3] inotify: fix -Wsign-compare compile warnings
In-Reply-To: <1515942778-12633-1-git-send-email-amir73il@gmail.com>
References: <1515942778-12633-1-git-send-email-amir73il@gmail.com>
Message-ID: <1515942778-12633-2-git-send-email-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify01.c | 2 +-
 testcases/kernel/syscalls/inotify/inotify03.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 8a471ae..5ea9271 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -63,7 +63,7 @@ static char buf[BUF_SIZE];
 static int fd, fd_notify;
 static int wd, reap_wd;
 
-static int event_set[EVENT_MAX];
+static unsigned int event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 065890a..8460376 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -66,7 +66,7 @@ static char fname[BUF_SIZE];
 static int fd, fd_notify;
 static int wd;
 
-static int event_set[EVENT_MAX];
+static unsigned int event_set[EVENT_MAX];
 
 static char event_buf[EVENT_BUF_LEN];
 
-- 
2.7.4

