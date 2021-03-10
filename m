From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 15:03:12 +0100
Subject: [LTP] [PATCH] lib/tst_device.c: Add exception handling of
 function tst_find_free_loopdev
In-Reply-To: <CAEemH2dpSfc=fgRG1zwbBm1aLgRkbX8qECH7VPz+avBVLjmnDg@mail.gmail.com>
References: <20210310081048.27993-1-zhaogongyi@huawei.com>
 <CAEemH2dpSfc=fgRG1zwbBm1aLgRkbX8qECH7VPz+avBVLjmnDg@mail.gmail.com>
Message-ID: <YEjRoDbqeBapqSXQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Because of race condition or abnormal env, set_dev_path may be
> > return 1. And when set_dev_path return 1 in tst_find_free_loopdev,
> > we should return Immediately.


> If there exists a race condition, I firstly think of the TST_RETRY_FUNC
> macro
> to try more times for the set_dev_path. That might help to get the function
> success
> in the follow-up tries.

+1

Kind regards,
Petr
