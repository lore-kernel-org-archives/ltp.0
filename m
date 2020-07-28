From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2020 11:16:40 +0200
Subject: [LTP] [PATCH 3/9] syscalls/ipc: shmctl04: Rewrite from scratch.
In-Reply-To: <20200717163453.9587-4-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-4-chrubis@suse.cz>
Message-ID: <20200728091640.GA24592@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See libs/libltpipc/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> +	TEST(shmctl(TST_RET, SHM_STAT_ANY, &ds));
Several old distros fail [1] as they miss SHM_STAT_ANY in <bits/shm.h> (added to
glibc in 2.28, to kernel in 4.17).
Of course, it's just enough to add the definition to include/tst_safe_sysv_ipc.h
(or some LAPI file).

Kind regards,
Petr

[1] https://travis-ci.org/github/pevik/ltp/builds/712476731

diff --git include/tst_safe_sysv_ipc.h include/tst_safe_sysv_ipc.h
index 3e0e50e8d..dea85f97c 100644
--- include/tst_safe_sysv_ipc.h
+++ include/tst_safe_sysv_ipc.h
@@ -10,6 +10,10 @@
 #include <sys/msg.h>
 #include <sys/shm.h>
 
+#ifndef SHM_STAT_ANY
+# define SHM_STAT_ANY	15
+#endif
+
 int safe_msgget(const char *file, const int lineno, key_t key, int msgflg);
 #define SAFE_MSGGET(key, msgflg) \
 	safe_msgget(__FILE__, __LINE__, (key), (msgflg))
