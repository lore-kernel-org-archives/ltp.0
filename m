From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Jan 2016 10:53:43 +0800
Subject: [LTP] [PATCH] pwritev/pwritev02.c: add new testcase
In-Reply-To: <20160126163823.GB21691@rei.lan>
References: <1451384431-29742-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1451384431-29742-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160126163823.GB21691@rei.lan>
Message-ID: <56A83137.1070209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

? 2016/01/27 0:38, Cyril Hrubis ??:
> Hi!
> Both pushed, thanks.
>
> BTW: both preadv() and pwritev() can also fail with errors specified for
>       read() and write(), so we should, get EBADFD if fd is invalid or not
>       open for reading/writing for read/write, etc.
Thanks for your suggestion. I will send patches to test other errors.


