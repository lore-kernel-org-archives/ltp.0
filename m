From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Feb 2019 13:16:11 +0100
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
Message-ID: <20190215121611.GA14270@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 1) Compilation failed on older kernel(e.g. v2.6.32) because of the
> > undefined syncfs().
> > According to manpage, syncfs() was first appeared in Linux 2.6.39 and
> > library
> > support was added to glibc in version 2.14. Perhaps, we need to check if
> > syncfs()
> > is defined.
> >
> 
> Would configuring .min_kver suffice to avoid this compilation issue?

Not at all, min_kver is runtime check, which could solve the latter
problem.

For this you can either:

* Add a configure check for syscfs()

* Add a fallback syscall definition to header include/lapi/

Fallback definition is preferable solution since with that the test will
still work on old userspace with new kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
