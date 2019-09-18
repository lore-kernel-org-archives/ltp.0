From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Sep 2019 11:21:11 +0800
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20190917165520.GA30320@x230>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
 <CAEemH2f4oeSvN-p7xSzjo2ZFvndxjX2sQ+M9f6fYV_bN2ewn=A@mail.gmail.com>
 <20190917165520.GA30320@x230>
Message-ID: <CAEemH2cHYS6jd4DCzJsy-vKLqShcFO6fU_-Rk=zxu=yD=7YLVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Here as well, why we need to distinguish the float and int, is the float
> > expression does not work for integer?
> Because it brings awk dependency on whole library, which I'm not sure if we
> want (awk is a must on linux distros, it's in busybox; it's missing on
> android
> toolsbox, but android project concentrates on syscalls, probably nobody
> uses
> shell tests on android). Also I'm not sure about containers, JeOS etc. (it
> sometimes miss a basic dependency).
> If awk dependency is ok, it'd simplify test a bit.


But it doesn't solve the dependency issue because, if the awk is missing,
it will still tst_brk on float $LTP_TIMEOUT_MUL at:
    tst_test_cmds awk
and never goes to the integer expression branch.

So, maybe that could be as a reason to disable float support for
$LTP_TIMEOUT_MUL?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190918/e393bc74/attachment.htm>
