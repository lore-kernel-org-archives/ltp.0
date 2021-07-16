From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Fri, 16 Jul 2021 08:26:45 +0000
Subject: [LTP] [PATCH] syscalls/ioctl_ns05,6: Fix buffer overflow
In-Reply-To: <a0c00c11-1d50-2eed-131f-cc74798ebf03@linux.ibm.com>
References: <1626313169-30611-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <a0c00c11-1d50-2eed-131f-cc74798ebf03@linux.ibm.com>
Message-ID: <60F142DA.4060308@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi  Marius

cc ltp list
> Hi Yang,
>
> Thanks for your patch! I had missed your email before submitting my PR.
It doesn't matter.
>
> What do you think about also turning the sprintf() into snprintf()?
I have no objection for using snprintf.
Also, ltp usually accepts patch from mailing list instead of pull request.

ps: cc ltp guys, so other maintainers will know I have no objection for 
your patch.

Best  Regards
Yang Xu
>
> Regards,
> Marius
