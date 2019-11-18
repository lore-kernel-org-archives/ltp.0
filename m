From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Nov 2019 09:21:42 +0800
Subject: [LTP] [PATCH v5 2/2] syscalls/prctl09: New timer sample test
 for PR_SET_TIMERSLACK
In-Reply-To: <20191115163517.GB25964@rei.lan>
References: <20191107130543.GD22352@rei.lan>
 <1573214419-15435-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1573214419-15435-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191115163517.GB25964@rei.lan>
Message-ID: <60d360f6-fa33-0e80-8349-26f49a7fd34e@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/16 0:35, Cyril Hrubis wrote:

> Hi!
>> It also moves test setup function before timer setup function,
>> so we can get this set value.
> Can we please change the library code in a separate patch with
> appropripate description of the change?

Of course. I will put the library code change in a separate patch.

>
> Otherwise it looks good.
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191118/1549998d/attachment.htm>
