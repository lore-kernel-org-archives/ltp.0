From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 14:20:48 +0200
Subject: [LTP] [PATCH 4/4] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200724103454.ttaqxq3hzmth7gpr@vireshk-mac-ubuntu>
References: <e51142a397858a2fe6a040563d3c0795a7d0bb05.1595511710.git.viresh.kumar@linaro.org>
 <a83166af3a2b432bb11a0876e18e15705479f32d.1595511710.git.viresh.kumar@linaro.org>
 <20200724055826.GE32086@dell5510>
 <20200724103454.ttaqxq3hzmth7gpr@vireshk-mac-ubuntu>
Message-ID: <20200724122048.GF9768@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > sigwait.c: In function ???test_masked_matching???:
> > sigwait.c:157:42: warning: passing argument 3 to restrict-qualified parameter aliases with argument 2 [-Wrestrict]
> >   157 |  TEST(sigprocmask(SIG_SETMASK, &oldmask, &oldmask));
> >       |                                ~~~~~~~~  ^~~~~~~~
> > ../../include/tst_test.h:266:13: note: in definition of macro ???TEST???
> >   266 |   TST_RET = SCALL; \
>  
> > IMHO we shouldn't use oldmask for src and dest.
> 
> And I am not really sure what the error says and why it is there.

I guess that new enough glibc has restrict keyword used on the
sigprocmask() pointer parameters, which basically means that compiler
can assume that for the lifetime of the pointer a piece of memory can be
accessed only via that pointer or pointers directly derived from it.

And passing the same pointer twice obviously violates that promise,
hence the warning.

-- 
Cyril Hrubis
chrubis@suse.cz
