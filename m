From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 06:10:22 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510> <20191120151610.GB28197@dell5510>
 <efb495a4-1071-68fd-d5a2-7597646228e1@cn.fujitsu.com>
Message-ID: <20191121051022.GA59487@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > + general question: do we want always test against kernel headers or libc
> > headers? Libc is often outdated, so mostly it'd be our fallback to be tested.
> > Ideally both kernel and libc header should be tested, but that's not easily
> > achievable.

> IMHO, We often test libc and it usually includes kernel headers ie.
> <sys/quota.h> <sys/prctl.h>. I perfet to check one except that glibc and
> kernel they have themselves implementation . If the struct or variable is
> not defined, we can define it in ltp lapi headers. Then we can avoid build
> error and increase coverage(because kernel may implement it).

Yep. I'm ok with using libc headers (increased coverage), but we need good
checks anyway for other libc (at least for musl; bionic also like glibc uses
internally kernel headers, uclibc-ng usually embeds kernel header parts and
strives to be glibc compatible anyway).

Kind regards,
Petr
