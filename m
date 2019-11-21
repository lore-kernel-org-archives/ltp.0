From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 16:19:01 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <339862280.13302048.1574334489479.JavaMail.zimbra@redhat.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
 <1893160007.13287158.1574326875945.JavaMail.zimbra@redhat.com>
 <20191121103003.GC23702@dell5510>
 <339862280.13302048.1574334489479.JavaMail.zimbra@redhat.com>
Message-ID: <20191121151901.GA30697@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ----- Original Message -----
> > > > Also ,If we use uint64_t, they still failed on 2.6.32-754.el6.x86_64 with
> > > > undefined  . Or, we should use TST_ABI to define uint64_t them
> > Jan, are you aware of this problem?

> I'm not, it should be defined in stdint.h.

> # cat /etc/redhat-release 
> Red Hat Enterprise Linux Server release 6.10 (Santiago)

> # grep uint64_t -r /usr/include/ | grep stdint
> /usr/include/stdint.h:typedef unsigned long int	uint64_t;

> > Xu, I'm not sure if you're talking about uint64_t problematic in
> > <linux/types.h>
> > (as you mention kernel) or problem in glibc <sys/types.h> / <stdint.h> /
> > <inttypes.h>?
> > We have lots of code which is using some of these 3 libc headers, does it
> > fail
> > on 2.6.32?

> > Does anybody compile for 2.6.32?

> [CC Li]
> I think RH still does compile latest for regression tests. RHEL6 will be in
> sustaining for couple more years. 
Thanks for info. Sorry I forgot, we have CentOS 6.10 in travis, that should be
enough for testing build in old toolchain.
