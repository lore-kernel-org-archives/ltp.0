From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 06:45:07 +0100
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <d1d72a63-fd3b-e670-4559-c0216176546c@cn.fujitsu.com>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
 <d1d72a63-fd3b-e670-4559-c0216176546c@cn.fujitsu.com>
Message-ID: <20191121054507.GB59487@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not really needed?
> > __u64 can be uint64_t etc (as it's also visible in struct dqblk in <sys/quota.h>
> > in various libc headers).
> > We used this approach for /usr/include/linux/bpf.h and for fanotify fixes for
> > musl (testcases/kernel/syscalls/fanotify/fanotify.h).

> > So unless you're against this approach here I'll change it before merge
> > (and add this info to next version of library API writing guidelines patch
> > https://patchwork.ozlabs.org/patch/1166786/).

> I have no objection about using uint64_t becuase Q_GETNEXTQUOTA man-pages also uses it.
> I used  struct if_nextdqblk as same as <linux/quota.h> defined. But I don't know why we can't use
> <linux/type.h> in lapi/quotactl.h and I also use it in lapi/seccomp.h. IMHO, they affected nothing.
> Or, they have some redefined errors or not having this headers files in special linux distribution.

Based on Jan's comment [1], maybe he meant it specifically for __kernel_fsid_t in
fanotify.h, not as a general approach. __kernel_fsid_t is more complicated than
uint64_t. That's why I'm asking whether there is a general approach we want to
take.

> > > +	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
> > > +		test_id, (void *) &res_ndq));
> > > +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> > Does EINVAL really mans not supported? Shouldn't be just for ENOSYS.

> EINVAL can mean non-supported? by using correct argument.

> look do_quotactl function in fs/quota/quota.c.

> static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
> ?????????????????????? void __user *addr, const struct path *path)
> {

> ??? switch (cmd) {
> ??????? case Q_QUOTAON:
> ??????????????? return quota_quotaon(sb, type, id, path);
> ??????? case Q_QUOTAOFF:
> ??????????????? return quota_quotaoff(sb, type);
> ??????? case Q_GETFMT:
> ??????????????? return quota_getfmt(sb, type, addr);
> ??????? case Q_GETINFO:
> ??? ??? ......

> ??? ???? default:
> ??????????????? return -EINVAL;
> ??????? }
> }

> So if it doesn't have Q_GETNEXTQUOTA cmd, it should report EINVAL(we use correct argument and correct environment, so there is no failure).
OK, you're right, thanks for info :).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1178182/#2281586
