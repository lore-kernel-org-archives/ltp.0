From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Nov 2017 16:33:38 +0100
Subject: [LTP] [PATCH v2 08/13] sigwaitinfo01: catch SEGV and report
 success for bad_address2 testcase
In-Reply-To: <87fu8x1ajt.fsf@e105922-lin.cambridge.arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-9-punit.agrawal@arm.com>
 <20171129102959.GA18489@rei>
 <87fu8x1ajt.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20171129153338.GA18696@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Why don't we just check for WIFSIGNALED() and WTERMSIG() instead?
> >
> > We do not have to install any handler that way...
> 
> I think that is what I tried initially but for the tst_sig() call in
> setup() that installs a default handler and catches the SIGSEGV.

Then just do signal(SIGSEGV, SIGDFL) in the child just before do do the
test. Also it does not make sense to use FORK_OR_VFORK() there because
the thest will not work on uClinux anyway, just use plain old fork()
instead.

> >
> >> +	else
> >> +		tst_resm(TFAIL, "Unrecognised child exit code");
> >>  }
> >>  
> >>  void test_bad_address3(swi_func sigwaitinfo, int signo)
> >> -- 
> >> 2.14.2
> >> 

-- 
Cyril Hrubis
chrubis@suse.cz
