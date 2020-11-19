From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Nov 2020 16:41:32 +0100
Subject: [LTP] [PATCH 1/1] net/traceroute01: Check also -T flag
In-Reply-To: <20201119152300.05ef03b0@kmaincent-XPS-13-7390>
References: <20201112173609.4123-1-petr.vorel@suse.com>
 <20201119152300.05ef03b0@kmaincent-XPS-13-7390>
Message-ID: <20201119154132.GA16438@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

> Hello Petr,

> Just find out you didn't merge your patch which makes the code cleaner. :)
Waiting for Alexey's review.
Also hesitate about tracepath6 symlink to traceroute being always installed
on all distros (hopefully yes).

Kind regards,
Petr

> Regards,


> On Thu, 12 Nov 2020 18:36:09 +0100
> Petr Vorel <petr.vorel@suse.com> wrote:

> > From: Petr Vorel <pvorel@suse.cz>

> > and move checks to run_trace()

> > There are 3 traceroute versions:

> > * Dmitry Butskoy (http://traceroute.sourceforge.net/)
> > * busybox
> > * iputils (only tracepath6; deprecated, but still used (e.g. OpenWrt Project)

> > -I is supported by Dmitry Butskoy's and busybox implementation
> > -T is supported only by Dmitry Butskoy's implementation

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Alexey, Kory,

> > follow up to Kory's fix (there are some problems with suse.cz
> > mailserver, thus I haven't reply about pushing your patch).

> > Kind regards,
> > Petr

> >  testcases/network/traceroute/traceroute01.sh | 30 +++++++++++---------
> >  1 file changed, 17 insertions(+), 13 deletions(-)

> > diff --git a/testcases/network/traceroute/traceroute01.sh
> > b/testcases/network/traceroute/traceroute01.sh index 38f4d3b85..90030af39
> > 100755 --- a/testcases/network/traceroute/traceroute01.sh
> > +++ b/testcases/network/traceroute/traceroute01.sh
> > @@ -13,9 +13,12 @@ TST_NEEDS_TMPDIR=1

> >  setup()
> >  {
> > -	tst_res TINFO "traceroute version:"
> > -	tst_res TINFO $(traceroute --version 2>&1)
> > -	[ "$TST_IPV6" ] && tst_res TINFO "NOTE: tracepath6 from iputils is
> > not supported" +
> > +	TRACEROUTE=traceroute${TST_IPV6}
> > +	tst_require_cmds $TRACEROUTE
> > +
> > +	tst_res TINFO "$TRACEROUTE version:"
> > +	tst_res TINFO $($TRACEROUTE --version 2>&1)
> >  }

> >  run_trace()
> > @@ -24,18 +27,23 @@ run_trace()
> >  	local ip=$(tst_ipaddr rhost)
> >  	local pattern="^[ ]+1[ ]+$ip([ ]+[0-9]+[.][0-9]+ ms){3}"

> > +	if $TRACEROUTE $opts 2>&1 | grep -q "invalid option"; then
> > +		tst_res TCONF "$opts flag not supported"
> > +		return
> > +	fi
> > +
> >  	# According to man pages, default sizes:
> >  	local bytes=60
> >  	[ "$TST_IPV6" ] && bytes=80

> > -	EXPECT_PASS traceroute $ip $bytes -n -m 2 $opts \>out.log 2>&1
> > +	EXPECT_PASS $TRACEROUTE $ip $bytes -n -m 2 $opts \>out.log 2>&1

> >  	grep -q "$bytes byte" out.log
> >  	if [ $? -ne 0 ]; then
> >  		cat out.log
> >  		tst_res TFAIL "'$bytes byte' not found"
> >  	else
> > -		tst_res TPASS "traceroute use $bytes bytes"
> > +		tst_res TPASS "$TRACEROUTE use $bytes bytes"
> >  	fi

> >  	tail -1 out.log | grep -qE "$pattern"
> > @@ -43,24 +51,20 @@ run_trace()
> >  		cat out.log
> >  		tst_res TFAIL "pattern '$pattern' not found in log"
> >  	else
> > -		tst_res TPASS "traceroute test completed with 1 hop"
> > +		tst_res TPASS "$TRACEROUTE test completed with 1 hop"
> >  	fi
> >  }

> >  test1()
> >  {
> > -	tst_res TINFO "run traceroute with ICMP ECHO"
> > +	tst_res TINFO "run $TRACEROUTE with ICMP ECHO"
> >  	run_trace -I
> >  }

> >  test2()
> >  {
> > -	tst_res TINFO "run traceroute with TCP SYN"
> > -	if traceroute -T 2>&1 | grep -q "invalid option"; then
> > -		tst_res TCONF "-T flag (TCP SYN) not supported"
> > -	else
> > -		run_trace -T
> > -	fi
> > +	tst_res TINFO "run $TRACEROUTE with TCP SYN"
> > +	run_trace -T
> >  }

> >  tst_run
