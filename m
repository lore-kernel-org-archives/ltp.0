From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 22 Jun 2021 13:14:40 +0200
Subject: [LTP] [PATCH 2/2] syscalls/msgstress04: fix fork failure on small
 memory systems
In-Reply-To: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
References: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210622111440.74722-2-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running syscalls/msgstress04 on a system with less than ~4 GB of RAM fails:

    Fork failure in the first child of child group 4396
    Fork failure in the second child of child group 4413
    msgstress04    1  TFAIL  :  msgstress04.c:222: Child exit status = 1

The reason is cgroups pid limit set by systemd user.slice.  The limit is
set for login session, also for root user.  For example on 2 GB RAM
machine it is set as:
    /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

Read the maximum number of pids and adjust the test limit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index f1c124990cb1..37561b18c651 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -387,7 +387,7 @@ static void term(int sig LTP_ATTRIBUTE_UNUSED)
 
 void setup(void)
 {
-	int nr_msgqs, free_pids;
+	int nr_msgqs, free_pids, max_session_pids;
 
 	tst_tmpdir();
 	/* You will want to enable some signal handling so you can capture
@@ -423,6 +423,13 @@ void setup(void)
 	 * For each child we fork up to 2*maxnkids grandchildren. */
 	maxnprocs = (free_pids / 2) / (1 + 2 * maxnkids);
 
+	max_session_pids = get_pids_limit();
+	if ((max_session_pids > 0) && (max_session_pids < free_pids)) {
+		/* Clamp number of processes to session limit with some buffer for OS */
+		max_session_pids = (max_session_pids > 500 ? max_session_pids - 500 : 0);
+		maxnprocs = (max_session_pids / 2) / (1 + 2 * maxnkids);
+	}
+
 	if (!maxnprocs)
 		tst_brkm(TBROK, cleanup, "Not enough free pids");
 
-- 
2.27.0

