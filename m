From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 02:32:38 +0000
Subject: [LTP] [PATCH v2] tst_res: Replace tst_res with tst_brk for
 shell testcases
Message-ID: <bc169b9bef2249deba32f5683b9fbc3b@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your review!

I have split the patch into two sparate commits, and Cc Alexey Kodanev.

Please see:
https://patchwork.ozlabs.org/project/ltp/patch/20210429022839.24503-1-zhaogongyi@huawei.com/
https://patchwork.ozlabs.org/project/ltp/patch/20210429020922.24085-1-zhaogongyi@huawei.com/


Best Regards,
Gongyi

> 
> Hi,
> 
> > We need replace tst_res with tst_brk to terminate the test immediately
> > since there is no sence to go on.
> 
> > For those:
> > 	testcases/commands/lsmod/lsmod01.sh
> >         testcases/network/virt/sit01.sh
> Good catch. I'd split it into separate commits.
> For testcases/network please Cc also Alexey Kodanev.
> 
> Kind regards,
> Petr
