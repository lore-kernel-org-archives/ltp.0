From: zhaogongyi <zhaogongyi@huawei.com>
Date: Tue, 30 Mar 2021 13:17:33 +0000
Subject: [LTP] [PATCH] syscalls/chdir01: Add umask before mkdir
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E8F1@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Umask is always 022 in many system env. In this testcase, if umask is not 022, for example, umask is 0077, test would fail because the file mode is affected by umask.

Thanks!

Best Regards,
Gongyi

> 
> > When uid is nobody, umask is not 022, the test process might
> Not sure if I understand "When uid is nobody, umask is not 022", umask
> setup depends usually on the system. I wonder which system has different
> setup for nobody.
> 
> BTW later was posted another solution, see my comments there.
> 
> Kind regards,
> Petr
> 
> [2]
> https://patchwork.ozlabs.org/project/ltp/patch/20210322091512.103266
> -1-xieziyao@huawei.com/
> 
> > has not permmission to access the file which created by SAFE_MKDIR
> > with mode 0755.
