From: Punit Agrawal <punit.agrawal@arm.com>
Date: Thu, 26 Oct 2017 15:14:38 +0100
Subject: [LTP] [PATCH 09/18] kill05: fix race on getpwnam
In-Reply-To: <20171026141447.26749-1-punit.agrawal@arm.com>
References: <20171026141447.26749-1-punit.agrawal@arm.com>
Message-ID: <20171026141447.26749-10-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

Two threads doing getpwnam to a static struct in the library, sometimes
end up using the same UID. Fix this.

Reported-by: Tony Thompson <anthony.thompson@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/kill/kill05.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index ccef5afd6..2ae046130 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -174,15 +174,16 @@ void do_master_child(char **av)
 		do_child();
 #endif
 	}
+
+	/* wait until child sets its euid (and has finished with the static getpwnam result struct) */
+	wait_for_flag(1);
+
 	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
 	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
 		perror("seteuid failed");
 		exit(1);
 	}
 
-	/* wait until child sets its euid */
-	wait_for_flag(1);
-
 	TEST(kill(pid1, TEST_SIG));
 
 	/* signal the child that we're done */
-- 
2.14.2

