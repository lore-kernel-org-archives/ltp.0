From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 May 2021 16:16:08 +0200
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <CAEemH2dxhzBk+fbR8YnxAKqQSYhsb=HW2B2rov18yOjk9a+5Uw@mail.gmail.com>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2dxhzBk+fbR8YnxAKqQSYhsb=HW2B2rov18yOjk9a+5Uw@mail.gmail.com>
Message-ID: <YK0GqLg9AUrOxPdx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > stx_attributes_mask shows what's supported in stx_attributes.
> > Set supp_{append,compr,immutable,nodump} attributes only on filesystems
> > which actually support it.
> >
> > Also merge duplicate code.
> >
> > ---------------
> > v2->v3:
> > 1.add kernel version check for stx_attributes_mask
> > 2. use test_flag(int) instead of test_flagged and test_unflagged
> > ---------------
> >
> > Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Reviewed-by: Li Wang <liwang@redhat.com>
> 
> This patch makes sense to me, I'm not sure if any blocker issue for
> holding the apply process. If _no_ I would help to merge it:).

See:

https://github.com/linux-test-project/ltp/issues/557

Basically this change hides a kernel bug. I've proposed to create a
separate test for kernel that makes sure that all flags that are
supposed to be enabled are enabled for new enough kernels, then we can
apply this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
