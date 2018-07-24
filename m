From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jul 2018 14:57:08 +0200
Subject: [LTP] [PATCH v2 1/1] tst_test.sh: Add test cmd helper
	tst_test_cmds()
In-Reply-To: <20180724093537.GA19255@rei>
References: <20180423091706.24154-1-pvorel@suse.cz>
 <20180724093537.GA19255@rei>
Message-ID: <20180724125708.GA5894@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > + tst_cmd_available()

> > tst_test_cmds() is meant to be a check just for a particular test.
> > Works like tst_check_cmds(), but instead of tst_brk() calls tst_res().

> Hmm looking at this after a while I would expect the tst_test_cmds() to
> exit the test while tst_check_cmds() to return a value, the question is
> if this is worth of the work of renaming the current uses...
Indeed, names would be better to be reversed. It's up to you.
If you want, I'll first rename tst_check_cmds() to tst_test_cmds()
and then add this new one as tst_check_cmds().

> > tst_cmd_available() helper can handle cases when command shell builtin
> > is not available (e.g. Busybox).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > if you don't like using which or testing with 127 exit code in
> > tst_cmd_available() (or if you don't like tst_cmd_available()), I
> > can remove it.

> This looks fine to me.
Thx!

> >  Locating kernel modules
> >  +++++++++++++++++++++++

> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
...
> >  tst_check_cmds()
> >  {
> >  	local cmd
> >  	for cmd in $*; do

> 	BTW you can just write 'for cmd; do' here since the default
> 	array to loop over are the parameters passed to a function.
Thanks, I'll simplify it. This POSIX shell feature was hidden to me.

...
> > +tst_test_cmds()
> > +{
> > +	local cmd
> > +	for cmd in $*; do
> > +		if ! tst_cmd_available $cmd; then
> > +			tst_res TCONF "'$cmd' not found"
> > +			return 1
> >  		fi
> >  	done

> Can we add explicit return 0 here?
Sure.

> Other than that it's fine.


Kind regards,
Petr
