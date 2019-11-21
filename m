From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 11:30:03 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <1893160007.13287158.1574326875945.JavaMail.zimbra@redhat.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
 <1893160007.13287158.1574326875945.JavaMail.zimbra@redhat.com>
Message-ID: <20191121103003.GC23702@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan, Li,

> ----- Original Message -----
> > @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not
> > really needed?

> Yes, we generally try to avoid including kernel headers. Our style-guide says
> "Don't use +linux/+ headers if at all possible". uapi on older distros
> was more prone to cause LTP build errors.
Thank you for pointing out docs, I completely forgot on this page.
BTW it needs some update (examples use old API, linux_syscall_numbers.h).
Also not sure if everything else still applies (4. Call APIs that don't require
freeing up resources on failure first, 2. Sort headers).

> > Also ,If we use uint64_t, they still failed on 2.6.32-754.el6.x86_64 with undefined  . Or, we should use TST_ABI to define uint64_t them
Jan, are you aware of this problem?
Xu, I'm not sure if you're talking about uint64_t problematic in <linux/types.h>
(as you mention kernel) or problem in glibc <sys/types.h> / <stdint.h> / <inttypes.h>?
We have lots of code which is using some of these 3 libc headers, does it fail
on 2.6.32?

Does anybody compile for 2.6.32?
I know we want to keep support for 2.6.x (we had some discussion in the past).
Than it'd be good to have travis build for kernel 2.6.x.

Back to patchset. I suggest to merge it as it is and I'll prepare patches, which
use <sys/types.h> in our tests.

Kind regards,
Petr
