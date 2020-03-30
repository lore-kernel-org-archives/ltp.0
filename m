From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 10:45:16 +0800
Subject: [LTP] [PATCH v2] security/dirtyc0w: Get and set umask in setup
Message-ID: <1585536316-23604-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v2:
Clear current umask by umask(0) in setup()

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

