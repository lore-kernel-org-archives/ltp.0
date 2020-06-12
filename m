From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jun 2020 16:30:04 +0200
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open*.c: Drop .min_kver flag
In-Reply-To: <20200505033507.oerhoby6aif3leea@vireshk-i7>
References: <20200430085742.1663-1-yangx.jy@cn.fujitsu.com>
 <20200430085742.1663-2-yangx.jy@cn.fujitsu.com>
 <20200504051107.edvfiqloegt3ak5o@vireshk-i7>
 <b74eac89-11fc-9a7c-c337-ffe6f19ec7b8@163.com>
 <20200505033507.oerhoby6aif3leea@vireshk-i7>
Message-ID: <20200612143004.GB2310@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > First, I want to explain my check point:
> > 
> > Passing invalid argument can check the support of pidfd_open(2) by ENOSYS
> > errno and we don't need to close the pidfd.
> > 
> > Second, I don't like the implementation of fsopen_supported_by_kernel() and
> > give some suggestions:
> > 
> > a) syscall()/tst_syscall() is enough to check the support of pidfd_open(2)
> > and 'tst_kvercmp(5, 2, 0)) < 0' will skip the check

Hmm, man pidf_open says that it's implemented starting 5.3 or do I miss
something?

> > ??? if a kernel on distribution is newer than v5.2 but drop the support of
> > pidfd_open(2) on purpose.
> 
> I don't think kernel can drop support of syscalls just like that, we
> can't break user space. And if that is done, we need to fix userspace
> again separately for that.

For most cases we cannot, there are a few that are guarded by CONFIG_
macros though e.g. SysV IPC.

> We came to the implementation of fsopen_supported_by_kernel() after a
> lot of reviews and decided on that and so I asked you for the sake of
> keeping similar code throughout LTP (of course there will be old
> usages which are different) to have a similar implementation.
> 
> Anyway, I will leave it to Cyril to decide on that :)

Agree here, doing the check only if kernel version is not sufficient
seems to be the most reasoanble strategy here.

-- 
Cyril Hrubis
chrubis@suse.cz
