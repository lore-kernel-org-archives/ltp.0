From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 15:27:47 +0800
Subject: [LTP] [PATCH v3 1/3] security/dirtyc0w: Fix bug caused by default
 umask
In-Reply-To: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
Message-ID: <1585553269-119544-2-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v3:
The case is only successful when system default umask is 0022.
When default umask is 0077 or other values, should clear current umask by umask(0) in setup().

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/kernel/security/dirtyc0w/dirtyc0w.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index a0a81b6..6455f9c 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -45,6 +45,8 @@ static void setup(void)
 {
 	struct passwd *pw;

+	umask(0);
+
 	pw = SAFE_GETPWNAM("nobody");

 	nobody_uid = pw->pw_uid;
--
2.6.2

