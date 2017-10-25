From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 10:40:18 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/madvise09: Fix TCONF propagation,
 remove .min_kver
In-Reply-To: <181956053.27405654.1507300284234.JavaMail.zimbra@redhat.com>
References: <20171006103839.24544-1-chrubis@suse.cz>
 <181956053.27405654.1507300284234.JavaMail.zimbra@redhat.com>
Message-ID: <20171025084018.GC4244@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This patch fixes TCONF propagation from the child to parent, the parent
> > have to handle the TCONF exit value.
> > 
> > And it also removes the .min_kver in order to enable the test on
> > distribution kernels that backported the MADV_FREE. Older kernels are
> > handled by the runtime EINVAL detection or will TCONF at the check for
> > memory cgroup support, so there is no real need to keep the .min_kver in
> > the source code.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Looks good to me:
> 
> # ./madvise09
> tst_test.c:937: INFO: Timeout per run is 0h 05m 00s
> madvise09.c:186: CONF: MADV_FREE is not supported: EINVAL
> madvise09.c:310: CONF: MADV_FREE is not supported

I've rebased the patch (since it had collision with the strstatus
patchset) and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
