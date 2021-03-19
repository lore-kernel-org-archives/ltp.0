From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 12:22:44 +0100
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY
 not defined
In-Reply-To: <78ca788f-f24e-61f5-b0c6-a0742b6af176@suse.cz>
References: <20210318162409.9871-1-mdoucha@suse.cz> <YFOcOJP4innlbIk4@pevik>
 <78ca788f-f24e-61f5-b0c6-a0742b6af176@suse.cz>
Message-ID: <YFSJhNjl17uZUtPt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> >> +#if !HAVE_DECL_SEM_STAT_ANY
> > nit: I'd prefer
> > #ifndef HAVE_DECL_SEM_STAT_ANY

> That will not work. AC_CHECK_DECLS() will always define
> HAVE_DECL_SEM_STAT_ANY, either with the value of 0 (macro not defined)
> or 1 (defined).
Correct, I'm sorry, thanks for catching my error.

> >> +	if (tst_variant == 1)
> >> +		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
> >> +#endif
> > Although I understand why you want to quit only tests with root
> > (only these fail), it's a bit confusing to test with user nobody
> > and then quit the same testing with root.

> tst_variant has nothing to do with UID.
> tst_variant == 0 => run the test using tst_syscall(__NR_semctl)
> tst_variant == 1 => run the test again using libc semctl()
Again, correct, sorry for wrong report.

> But if you want to make the test output a little more clear, I could
> move the test_info() call at the end of setup() a few lines up before
> the new #if.
+1

Kind regards,
Petr
