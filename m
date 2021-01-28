From: Zhu Feiyu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 28 Jan 2021 17:52:04 +0800
Subject: [LTP] [PATCH 5/5] syscalls/ipc: semctl07: Convert to new API
 and cleanup
In-Reply-To: <YBFboS09Wgc9F7TF@yuki.lan>
References: <1609918063-15810-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1609918063-15810-5-git-send-email-zhufy.jy@cn.fujitsu.com>
 <YBFboS09Wgc9F7TF@yuki.lan>
Message-ID: <60128944.7080501@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

>
> This part is broken. We do issue the TPASS here even if one of the above
> statement issued TFAIL.
>
> So we either change the code to produce TPASS/TFAIL pair on each check
> e.g.
>
> 	if (status != arg.val) {
> 		tst_res(TFAIL, "semctl(GETVAL) returned %d expected %d",
> 		        arg.val, status);
> 	} else {
> 		tst_res(TPASS, "semctl(GETVAL) returned %d", arg.val);
> 	}
>
> Or we have to maintain flag that is set to non-zero on any failure and
> then we can, at the end of the test do:
>
> 	if (!flag)
> 		tst_res(TPASS, "everything is fine");
>

Thanks for your review, I have sent v2.

Best Regards
Feiyu Zhu


