From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Oct 2019 09:27:36 -0400 (EDT)
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <20191018132300.GA27956@dell5510>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
 <20191018132300.GA27956@dell5510>
Message-ID: <2145309610.6976144.1571405256594.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > Test sporadically fails with:
> >   lsmod01 1 TFAIL: lsmod output different from /proc/modules.
> >   36c36
> >   < loop 42057 2
> >   ---
> >   > loop 42057 1
> 
> > commands runtest file runs mkswap01 before this test. That test is
> > using loop device, and udev is presumably still holding a reference
> > by the time lsmod01 test starts.
> 
> > Repeat the test couple times to avoid racing with rest of the system.
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> ...
> > +++ b/testcases/commands/lsmod/lsmod01.sh
> > @@ -10,31 +10,41 @@ TST_NEEDS_TMPDIR=1
> >  TST_NEEDS_CMDS="lsmod"
> >  . tst_test.sh
> 
> > -lsmod_test()
> > +lsmod_matches_proc_modules()
> >  {
> >  	lsmod_output=$(lsmod | awk '!/Module/{print $1, $2, $3}' | sort)
> >  	if [ -z "$lsmod_output" ]; then
> > -		tst_res TFAIL "Failed to parse the output from lsmod"
> > -		return
> > +		tst_brk TBROK "Failed to parse the output from lsmod"
> >  	fi
> 
> > -	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
> > +	modules_output=$(awk '{print $1, $2, $3} 1' /proc/modules | sort)
> This is a regression. Please keep the old version (without 1).

My bad, I left it in by accident after testing.

> 
> 
> -	modules_output=$(awk '{print $1, $2, $3} 1' /proc/modules | sort)
> +	modules_output=$(awk '{print $1, $2, $3}' /proc/modules | sort)
> 
> >  	if [ -z "$modules_output" ]; then
> > -		tst_res TFAIL "Failed to parse /proc/modules"
> > -		return
> > +		tst_brk TBROK "Failed to parse /proc/modules"
> >  	fi
> 
> >  	if [ "$lsmod_output" != "$modules_output" ]; then
> > -		tst_res TFAIL "lsmod output different from /proc/modules."
> > +		tst_res TINFO "lsmod output different from /proc/modules."
> nit: please remove dots at the end of messages, when you're touching that
> file.

will do

> 
> The rest looks good to me.
> 
> Kind regards,
> Petr
> 
