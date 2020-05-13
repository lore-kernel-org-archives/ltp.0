From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 12:30:32 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <5EBBCA12.5020901@cn.fujitsu.com>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <5EBB5B3D.4020302@cn.fujitsu.com> <20200513092028.GA4598@dell5510>
 <5EBBCA12.5020901@cn.fujitsu.com>
Message-ID: <20200513103032.GA18763@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> Thanks a lot for your quick reply.
Thanks for a patience (we're not working just on LTP unfortunately).

> Resetting errno may not necessary because errno will be set again when
> fd == -1.
Agree, I'm just careful, thus asking :).

> > > 2) tst_syscall() is enough to check the support of pidfd_open() and I
> > >     don't want to define check function as fsopen_supported_by_kernel()
> > >     does.
> > >     Do you think so?

> > > BTW:
> > > I don't like the implementation of fsopen_supported_by_kernel():
> > > a) syscall()/tst_syscall() is enough to check the support of
> > > pidfd_open(2) and 'tst_kvercmp(5, 2, 0))<  0' will skip the check if
> > +1 for tst_syscall()

> > > a kernel on distribution is newer than v5.2 but drop the support of
> > > pidfd_open(2) on purpose.
> > "drop support of pidfd_open(2) on purpose": would anybody has a reason to do
> > that?

> As my pervious mail said, It is just a possible situation? for example:
> Upstream kernel introduces btrfs filesystem long long ago but the
> kernel of RHEL8 drops btrfs filesystem because of some reasons.
I guess filesystem changes are the most frequent. But as I said, I wouldn't mind 
this implementation:
void fsopen_supported_by_kernel(void)
{
	TEST(tst_syscall(__NR_fsopen, NULL, 0));
	if (TST_RET != -1)
		SAFE_CLOSE(TST_RET);
}

> It is just a reason used to explain why I want to drop the kernel version
> check.

...

> > How about to call the function pidfd_open_supported_by_kernel()?

> OK

> > Than you can remove the comment (which BTW should use C style /* */).

> OK

> > And IMHO you don't have to assign pidfd to -1.

> In pidfd_open_supported_by_kernel(), do you want to drop 'pidfd = -1'
> directly or drop 'pidfd = -1' by using TEST()?
I meant (as it's always assigned by the call, it's just a nit.):
-int pidfd = -1;
+int pidfd;

Kind regards,
Petr
