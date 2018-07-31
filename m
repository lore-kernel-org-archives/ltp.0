From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Jul 2018 14:43:32 +0200
Subject: [LTP] [PATCH] syscalls/execveat01: new test to verify execveat
 unlinked fd
In-Reply-To: <CALLuPvrDgQX8XB-oVL_gm58cwRSinVNXTk5PzyUxcG8fG+Wcmw@mail.gmail.com>
References: <1532678306.28611.1.camel@mtkswgap22> <20180727094703.GB914@rei>
 <CALLuPvrDgQX8XB-oVL_gm58cwRSinVNXTk5PzyUxcG8fG+Wcmw@mail.gmail.com>
Message-ID: <20180731124331.GB32738@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I removed "if (status == 0) tst_res(TPASS, ..." from execveat01.c and
> add "tst_res(TPASS, ..." in execveat_child.c, but I got a no reported
> result error:
> 
> execveat_child.c:44: PASS: execveat_child run as expected
> tst_test.c:869: BROK: Test haven't reported results!
> 
> It seems child's test result doesn't propagated to parent.
> Do I use wrong API in child or miss something in parent?

You are right, this is supposed to work but nobody checked that and
while the IPC is mapped the results pointer is not initialized in the
test library.

It should work with following patch:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 008bcefe0..bb3908d6c 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -152,6 +152,7 @@ void tst_reinit(void)
        fd = SAFE_OPEN(path, O_RDWR);
 
        ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+       results = ptr;
        tst_futexes = (char*)ptr + sizeof(struct results);
        tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);

-- 
Cyril Hrubis
chrubis@suse.cz
