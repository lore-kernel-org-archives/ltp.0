From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 15:54:15 +0200
Subject: [LTP] [PATCH] [v2,
 1/6] syscalls/sysfs: Convert sysfs01 to the new API
In-Reply-To: <69afbc39-4c9d-dbab-beb2-4ff43d733818@uniontech.com>
References: <20210806062456.11678-1-sujiaxun@uniontech.com>
 <YRJM9PffB27VBngU@yuki>
 <69afbc39-4c9d-dbab-beb2-4ff43d733818@uniontech.com>
Message-ID: <YRKFBxpUwJExuMzi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I checked with "checkpatch.pl -f" and there were no errors or warnings. 
> I use "git am" to apply the patch normally without any warning. How did 
> you check that there are spaces.

Have you used recent enough version?

Latest kernel git:

$ ~/linux/scripts/checkpatch.pl -f sysfs01.c

ERROR: code indent should use tabs where possible
#20: FILE: sysfs01.c:20:
+        /* option 1, buf holds fs name */$

ERROR: code indent should use tabs where possible
#21: FILE: sysfs01.c:21:
+        TST_EXP_POSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),$

WARNING: please, no spaces at the start of a line
#21: FILE: sysfs01.c:21:
+        TST_EXP_POSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),$

ERROR: code indent should use tabs where possible
#22: FILE: sysfs01.c:22:
+                        "sysfs(1,'proc')");$

WARNING: please, no spaces at the start of a line
#22: FILE: sysfs01.c:22:

...


$ cd ~/linux/; git describe

v5.14-rc5-2-g9a73fa375d58

-- 
Cyril Hrubis
chrubis@suse.cz
