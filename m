From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 12:13:25 +0100
Subject: [LTP] [PATCH] lib/tst_device.c: Add exception handling of
 function tst_find_free_loopdev
In-Reply-To: <20210310081048.27993-1-zhaogongyi@huawei.com>
References: <20210310081048.27993-1-zhaogongyi@huawei.com>
Message-ID: <YEip1Ru2m6wH8tIo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

> Because of race condition or abnormal env, set_dev_path may be
> return 1. And when set_dev_path return 1 in tst_find_free_loopdev,
You mean return 0, right?

> we should return Immediately.

Not really sure about this patch, mainly question for others.
Could you please more describe your problem?

Kind regards,
Petr
