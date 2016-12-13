From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 13 Dec 2016 15:46:05 +0800
Subject: [LTP] [PATCH v2 1/5] tst_test.h: move test result description
	to tst_res.h
In-Reply-To: <20161212142847.GD21828@rei.lan>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161212142847.GD21828@rei.lan>
Message-ID: <584FA73D.7060503@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/12/12 22:28, Cyril Hrubis wrote:
> Hi!
>> Move test result description to tst_res.h so that we
>> can use them independently for new ipc.
> Isn't definining TST_NO_DEFAULT_MAIN before you include tst_test.h
> enough? Is there any other problem?
>
Hi Cyril

Thanks for your review.
I don't know that  defining TST_NO_DEFAULT_MAIN can skip main function,
so I remove this patch.  I have rewritten other patches as your suggestions.

Thanks,
Xiao Yang


