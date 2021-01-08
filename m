From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 8 Jan 2021 09:23:39 +0800
Subject: [LTP] Holidays and LTP release
In-Reply-To: <X/b1tUeAVrTpVQBJ@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <X/b1tUeAVrTpVQBJ@yuki.lan>
Message-ID: <5FF7B41B.6020803@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
> Hi!
> Is there anything that should be considered for the release?
We can apply patch[1] disables the test(ioctl_loop05) on overlay so that 
it's fixed for next release.

Also, please see patch[2] for cpu_inherit fix.

[1]https://patchwork.ozlabs.org/project/ltp/patch/20201215155650.6496-1-radoslav.kolev@suse.com/
[2]https://patchwork.ozlabs.org/project/ltp/patch/1606701966-1596-1-git-send-email-xuyang2018.jy@cn.fujitsu.com/

Best Regards
Yang Xu
>
> If not I would like to freeze the git at the end of the week and start
> the pre-relase testing on Monday next week.
>



