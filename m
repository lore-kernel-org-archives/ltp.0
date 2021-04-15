From: wangxin (CQ) <wangxin410@huawei.com>
Date: Thu, 15 Apr 2021 02:11:22 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBvcGVucG9zaXgvY29uZm9ybWFu?=
 =?utf-8?q?ce/interfaces=3A_Correct_typos?=
In-Reply-To: <CAEemH2ePd0td_fiK9MF66Mu9_XOzi7pa2pZLQj2t1qGwu0LxcQ@mail.gmail.com>
References: <1617765607-78263-1-git-send-email-wangxin410@huawei.com>
 <CAEemH2ctSMR5OF=0TQX1eNmTE7PcdEdMbjoYXc3RxiBsyfzcuw@mail.gmail.com>
 <91a235700b494bdf9a9a7dd1901aa947@huawei.com>
 <CAEemH2dU2r8gFS5r3os7UwXFUEmmPqR9CnAizXbP_FHP+Evd+A@mail.gmail.com>
 <1e332d4428ea42aeb59e1173b654ce30@huawei.com>
 <CAEemH2ePd0td_fiK9MF66Mu9_XOzi7pa2pZLQj2t1qGwu0LxcQ@mail.gmail.com>
Message-ID: <41393f626c104a208ebe81b439c3b2f5@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi  Wang,

I'm sorry. When I submitted the patch yesterday, I put a low-level error.
I don't think it will happen again.
Thank you for pointing out my mistake.
Thank you again. Best wishes for you.

--
Regards,
Wang Xin

???: Li Wang [mailto:liwang@redhat.com]
????: 2021?4?14? 17:47
???: wangxin (CQ) <wangxin410@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos

Hi Xin,

I'm sorry I don't know how did you do make a new patch, I still can NOT
merge it to my local branch.

Btw, the one(about cpuset) I also solved the conflict by manual and
then applied, I guess you proably need to check your git, or did you
really make a patch via `git format-patch`?

After checking with scripts/checkpatch.pl<http://checkpatch.pl>, it repor errors like:

$ ./scripts/checkpatch.pl<http://checkpatch.pl> ~/v2-openposix-conformance-interfaces-Correct-typos.patch
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#73:
Types in the name of the temporary files: For example, in aio_cancel/8-1.c file,

ERROR: patch seems to be corrupt (line wrapped?)
#109: FILE: testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c:55:
index 5b980be..e1ae59e 100644

total: 1 errors, 1 warnings, 113 lines checked


--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210415/8ed1bcf8/attachment-0001.htm>
