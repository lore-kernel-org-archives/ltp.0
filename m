From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 Nov 2019 18:31:09 +0800
Subject: [LTP] [PATCH v4] syscalls/prctl02: add more error tests
In-Reply-To: <20191112101512.GB9373@rei.lan>
References: <20191108142434.GA5913@rei>
 <1573462752-6679-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191111163144.GB16894@rei.lan>
 <43e4f419-0100-dc52-7159-2355e9de1639@cn.fujitsu.com>
 <5DCA5206.3040508@cn.fujitsu.com>
 <ac6040e3-d561-cd53-e538-e3e6c8953ecc@cn.fujitsu.com>
 <20191112101512.GB9373@rei.lan>
Message-ID: <a41ad6e5-3ee0-e87a-3a2c-5ccd2fa0c396@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/12 18:15, Cyril Hrubis wrote:

> Hi!
>>> 1) Can undefined error be triggered on old kernel if you use ifdef?  It seems unnecessary for ifdef method to include lapi header.
>> Yes. It can be triggered and it should use #if HAVE_DECL_PR_GET_SPECULATION_CTRL instead of #ifdef.
>> Yes. And we should add more check( such as PR_SET_SECCOMP undefined 2.6.18-398.el5) in m4/ltp-prctl.m4 so that we cannot include lapi header.
>>
>>> 2) Undfined option in glibc doesn't mean that kernel doesn't support it as well.
>> options definitions is in linux/prctl.h. For most distributions, I think if it is in supported in kernel-header, it should also been
>> supported on kernel.
> That is usually the case, but there are cons that I explained in the
> previous email.

OK.

>
>>>> IMO, we only test options that kernel supports.
>>>> If we test an unsupported option, our case reports EINVAL that will give user a false impression(kernel
>>>> supports it, but argument or environment is bad). I think we should check they whether supported before run
>>>> (ifdef is a way).
>>>>
>>>> ps: If we test EPERM error(cap is not in PI or PP) of PR_CAP_AMBIENT on old kernel,  they will report EINVAL.
>>>> So, I think ifdef is needed.
>>> Why don't we check if the specified option is supported by calling it
>>> with correct args?(i.e. don't mix unsupported option up with wrong args).
>>>
>> It sounds reasonable.  I will try it in verify_prctl function if you and cyril have strong opposition to #if.
> Okay, that will work. Calling it with correct parameters in test setup
> is 100% correct way how to find out if kernel implements the
> functionality.

OK. I will use correct parameters to check whether kernel implements the functionality in setup.
Thanks for your patiently explation.

ps: I will make v5 patch tomorrow.

>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191112/c64c5257/attachment.htm>
