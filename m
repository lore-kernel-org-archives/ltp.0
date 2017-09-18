From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 19:23:14 +0800
Subject: [LTP] [PATCH] syscalls/clone09.c: skip this test if net ns is
 not supported
In-Reply-To: <20170720121717.GG32092@rei>
References: <1500542704-4889-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170720121717.GG32092@rei>
Message-ID: <59BFACA2.5070907@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2017/07/20 20:17, Cyril Hrubis wrote:
> Hi!
>> If net namespace is supported and disable, clone(CLONE_NEWNET) fails
>> and sets errno to EINVAL as expected.  However, If net namespace is
>> not supported(e.g. RHEL5.11GA), clone(CLONE_NEWNET) succeeds abnormally.
> This sounds like a kernel bug. The usuall course of action for unknown
> flag is to return EINVAL.
>
Hi Cyril,

Usually, a syscall flags should always include a check of the following form
in its implementation:
-------------------------------------------------
	if (flags&   ~(FL_XXX | FL_YYY))
		return -EINVAL;
-------------------------------------------------

This check could verify unknown flags, but clone(2) does not have the check and
just returns 0, this issue has been around for several years, and it is hardly
to be fixed since doing so would break existing applications.

Please see the following URL for detailed information:
https://lwn.net/Articles/588444/

So I feel this issue should not be counted as a kernel bug which leads to some
bad consequences, this kind of ancient syscalls were simply not designed well.

It is hard to make out whether CLONE_NEWNET is supported or not by returned value
and errno, so i think we should skip this case when a kernel does not support
CLONE_NEWNET.

Thanks,
Xiao Yang.



