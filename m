From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 14:06:29 +0200
Subject: [LTP] [PATCH 2/4] syscalls/modify_ldt: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <YJPNgGwlZBLMaJOd@yuki>
References: <20210429125255.31510-1-zhaogongyi@huawei.com>
 <YJPImeHT9rVsVtON@pevik> <YJPNgGwlZBLMaJOd@yuki>
Message-ID: <YJPbxQikXPap5DHW@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > FYI: since merging this patch (f5e8e6b11) test fails on this. Is it expected?
> > I haven't looked closer whether it's a test bug or real issue.

> What is the test failure output? The only part that was change that

$ ./modify_ldt02
modify_ldt02    1  TPASS  :  value read as expected
modify_ldt02    0  TINFO  :  received signal: 11
modify_ldt02    2  TFAIL  :  modify_ldt02.c:136: Did not generate SEGV

(I wrote my report below affected line)

11 is SIGSEGV, thus there must be a bug in a test, which probably has been there
before (test just didn't check). It's strange that WTERMSIG(status) returns 0
instead of 11.

> could introduce difference in the output is as far as I can tell this:

>                 /*
>                  * Create a new LDT segment.
>                  */
>                 if (create_segment(seg, sizeof(seg)) == -1) {
> -                       tst_brkm(TINFO, cleanup, "Creation of segment failed");
> +                       tst_brkm(TBROK, cleanup, "Creation of segment failed");
>                 }


> Which would mean that the test was broken before the change but just
> haven't produced any errors.
Yes.

Old results:
modify_ldt02    0  TINFO  :  Enter block 1
modify_ldt02    0  TINFO  :  block 1 PASSED
modify_ldt02    0  TINFO  :  Exit block 1
modify_ldt02    0  TINFO  :  Enter block 2
modify_ldt02    0  TINFO  :  received signal: 11
modify_ldt02    0  TINFO  :  block 2 PASSED

NOTE: no PASS/FAIL.

Kind regards,
Petr
