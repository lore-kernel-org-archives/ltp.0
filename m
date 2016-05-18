From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 18 May 2016 08:51:26 +0800
Subject: [LTP] [PATCH 2/2] syscalls/fanotify*: Cleanup && fix compiler
 warnings
In-Reply-To: <20160517121121.GB12051@rei.lan>
References: <1463037494-7284-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1463037494-7284-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160517121121.GB12051@rei.lan>
Message-ID: <573BBC8E.4090400@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi!
>>   testcases/kernel/syscalls/fanotify/fanotify.h   | 57 -------------------------
> Looking at the code indeed the testcases have
>
> #if defined(HAVE_SYS_FANOTIFY_H)
>
> #endif
>
> Around the whole test code so the wrappers are not used at all.
>
> But you should really describe exactly that in the commit description so
> that it's clear why this header could be removed.
>
> We may also try to remove the #ifdefs from the testcases so they are
> compiled even on glibc 2.12 and older (which is not that old). I guess
> is that these testcases will compile fine, but we would have to add
> configure check for linux/fanotify.h which would have to be included
> before the fanotify wrappers to get the FAN_* constants defined. And
> also create fallback definitions or skip the test compilation if both
> sys/fanotify.h and linux/fanotify.h was misssing.
>
Hi Cyril
thanks for your response, so i will rewrite this patch.


