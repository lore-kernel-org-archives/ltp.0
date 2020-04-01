From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Apr 2020 14:01:40 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <fd62323e-3d29-884d-1a0c-bf1adc3e28c2@suse.cz>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
 <20200401095822.GB23773@yuki.lan>
 <aa695e74-2aed-2b9e-c0c0-7626dfc0a7e1@suse.cz>
 <20200401105055.GC23773@yuki.lan>
 <fd62323e-3d29-884d-1a0c-bf1adc3e28c2@suse.cz>
Message-ID: <20200401120140.GD23773@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>> The problem here is that gcc10 forbids variables in headers, moving it
> >>> anywhere int the header wouldn't help.
> >>
> >> I don't think GCC cares about where exactly the variable came from. It's
> >> only refusing to link multiple definitions of the same symbol. So if we
> >> move the TCID definition into the TST_NO_DEFAULT_MAIN guard block, GCC
> >> linker should stop complaining because the symbol name will become unique.
> > 
> > See:
> > 
> > https://gcc.gnu.org/gcc-10/porting_to.html
> > 
> 
> This patch fixes the "multiple definition of `TCID'" error. But never
> mind because we'll get the "undefined reference to `TCID'" error instead
> from about 50 programs files that use the new library but define their
> own main().
> 
> Reminder that "multiple definition of `TCID'" is a linker error. If
> defining variables in .h files were really forbidden, it'd be a
> preprocessor error instead.

Well variables in headers are not exactly forbidden by -fno-common but
they are not resolved as a single global variable by the linker anymore,
which was the default before gcc10. So effectivelly this disallows
having variables in headers if the header is included from more than one
compilation unit becuase you end up with a linker error.

The end result is overall the same, no more variables in headers in any
non-trivial codebase.

-- 
Cyril Hrubis
chrubis@suse.cz
