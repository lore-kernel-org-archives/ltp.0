From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Feb 2021 15:35:46 +0100
Subject: [LTP] [PATCH 4/5] API: Add tst_clone
In-Reply-To: <877dne65s5.fsf@suse.de>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
 <20210211110317.31942-5-rpalethorpe@suse.com>
 <YCUoWPHssRVkQ+vf@yuki.lan> <877dne65s5.fsf@suse.de>
Message-ID: <YCVAwoQDKJWMi6hX@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	int flags;
> >> +	pid_t pid = -1;
> >> +
> >> +	tst_flush();
> >> +
> >> +	errno = ENOSYS;
> >> +	if (__NR_clone3 != __LTP__NR_INVALID_SYSCALL)
> >> +		pid = syscall(__NR_clone3, &args, sizeof(args));
> >> +
> >> +	if (pid == -1 && errno != ENOSYS)
> >> +		return -1;
> >
> > As far as I can tell when kernel is too old we would get EINVAL because
> > the syscall number is not allocated. ENOSYS happens mostly when syscall
> > number is allocated and kernel does not implement the functionality,
> > e.g. it's disabled in .config.
> >
> > I wonder if it's even menaningful to handle ENOSYS here, I doubt that
> > clone3() can be disabled, or do I miss something?
> 
> AFAICT it should return ENOSYS if the syscall number is greater than the
> current maximum. This is certainly true for riscv and also apears to be
> true for arm64 and x86. It is also written in a kernel book I have from
> 2010 :-p

Sounds sane, so we get EINVAL if the syscall number is out of the
syscall table. So I guess that we have to handle both.

-- 
Cyril Hrubis
chrubis@suse.cz
