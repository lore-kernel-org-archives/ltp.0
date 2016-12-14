From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 14 Dec 2016 17:42:23 +0800
Subject: [LTP] [PATCH v3 1/4] syscalls/ipc: add newipc library for new
 API
In-Reply-To: <20161214091908.GB16198@rei.lan>
References: <20161212142847.GD21828@rei.lan>
 <1481614745-27778-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20161213135233.GB750@rei.lan> <20161214082315.GA16198@rei.lan>
 <20161214091908.GB16198@rei.lan>
Message-ID: <585113FF.9070601@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril
on 2016/12/14 17:19, Cyril Hrubis wrote:
> Hi!
>> So the correct way how to fix this issue is to add the libnewipc to the
>> FILTER_OUT_DIRS and create Makefile2.inc similar to Makefile.inc. I will
>> change the first patch to do exactly that and push the patchset.
> And I've pushed the patches, thanks.
>
> I've added Makefile2.inc and also added clean target to the top level
> Makefile so that the libnewipc is cleaned up on make clean.
>
> And also merged the three msgget patches into one, since once the
> Makefile.inc is changed for Makefile2.inc in the Makefile the rest of
> the msgget testcases fails to build, which breaks bisecting. Ideally
> each commit should leave the tree in a state that at least compiles
> cleanly...
>
Thanks for your explanation and fix, so i got it. :-)

Best Regards,
Xiao Yang



