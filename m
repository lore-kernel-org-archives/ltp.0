From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Apr 2021 21:24:28 +0200
Subject: [LTP] [PATCH v2] tst_res: Replace tst_res with tst_brk for
 shell testcases
In-Reply-To: <20210413113549.3604-1-zhaogongyi@huawei.com>
References: <20210413113549.3604-1-zhaogongyi@huawei.com>
Message-ID: <YIm2bO3wkGf5jYD1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> We need replace tst_res with tst_brk to terminate the test immediately since
> there is no sence to go on.

> For those:
> 	testcases/commands/lsmod/lsmod01.sh
>         testcases/network/virt/sit01.sh
Good catch. I'd split it into separate commits.
For testcases/network please Cc also Alexey Kodanev.

Kind regards,
Petr
