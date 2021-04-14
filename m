From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Apr 2021 17:47:24 +0800
Subject: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos
In-Reply-To: <1e332d4428ea42aeb59e1173b654ce30@huawei.com>
References: <1617765607-78263-1-git-send-email-wangxin410@huawei.com>
 <CAEemH2ctSMR5OF=0TQX1eNmTE7PcdEdMbjoYXc3RxiBsyfzcuw@mail.gmail.com>
 <91a235700b494bdf9a9a7dd1901aa947@huawei.com>
 <CAEemH2dU2r8gFS5r3os7UwXFUEmmPqR9CnAizXbP_FHP+Evd+A@mail.gmail.com>
 <1e332d4428ea42aeb59e1173b654ce30@huawei.com>
Message-ID: <CAEemH2ePd0td_fiK9MF66Mu9_XOzi7pa2pZLQj2t1qGwu0LxcQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xin,

I'm sorry I don't know how did you do make a new patch, I still can NOT
merge it to my local branch.

Btw, the one(about cpuset) I also solved the conflict by manual and
then applied, I guess you proably need to check your git, or did you
really make a patch via `git format-patch`?

After checking with scripts/checkpatch.pl, it repor errors like:

$ ./scripts/checkpatch.pl
~/v2-openposix-conformance-interfaces-Correct-typos.patch
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars
per line)
#73:
Types in the name of the temporary files: For example, in aio_cancel/8-1.c
file,

ERROR: patch seems to be corrupt (line wrapped?)
#109: FILE:
testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c:55:
index 5b980be..e1ae59e 100644

total: 1 errors, 1 warnings, 113 lines checked


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210414/c32b1759/attachment.htm>
