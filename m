From: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Date: Wed,  2 Nov 2016 12:57:03 +0100
Subject: [LTP] [PATCH 2/3] socketcall: TCONF instead of TFAIL when user is
	not root
In-Reply-To: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <1478087824-31577-3-git-send-email-dejan.jovicevic@rt-rk.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sockatcall01 uses certain protocols that require super user
privileges.

Signed-off-by: Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
---
 testcases/kernel/syscalls/socketcall/socketcall01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/socketcall/socketcall01.c b/testcases/kernel/syscalls/socketcall/socketcall01.c
index d439729..b576bd8 100644
--- a/testcases/kernel/syscalls/socketcall/socketcall01.c
+++ b/testcases/kernel/syscalls/socketcall/socketcall01.c
@@ -142,6 +142,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test. */
 void setup(void)
 {
+	tst_require_root();
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-- 
1.9.1

