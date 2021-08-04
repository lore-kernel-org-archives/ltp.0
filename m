From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Aug 2021 16:39:26 +0200
Subject: [LTP] [PATCH v3] shmget02: check if CONFIG_HUGETLBFS enabled in
 kernel
In-Reply-To: <20210804093918.1087-1-bogdan.lezhepekov@suse.com>
References: <20210804093918.1087-1-bogdan.lezhepekov@suse.com>
Message-ID: <YQqmnkRd/AWgQthp@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

The inline variable definition is valid on in C99 and we still have to
support old distributions that compile LTP with GNU89 which does not
allow it. I've also changed the type to unsigned in order to avoid a
warning.

Full diff:

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 7856c2b8e..effd33799 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -110,10 +110,11 @@ static void setup(void)
 	pw = SAFE_GETPWNAM("nobody");
 
 	if (!hugetlbfs_supported()) {
+		unsigned int i;
 
 		tst_res(TINFO, "SHM_HUGETLB not supported by kernel");
 
-		for (int i = 0; i < ARRAY_SIZE(tcases); i++) {
+		for (i = 0; i < ARRAY_SIZE(tcases); i++) {
 			if (tcases[i].flags & SHM_HUGETLB)
 				tcases[i].exp_err = EINVAL;
 		}

-- 
Cyril Hrubis
chrubis@suse.cz
