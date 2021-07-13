From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jul 2021 16:15:20 +0200
Subject: [LTP] [PATCH v4 4/7] lib: Add script for running tests
In-Reply-To: <YO2gUL2/s29SGdNo@pevik>
References: <20210713101338.6985-1-pvorel@suse.cz>
 <20210713101338.6985-5-pvorel@suse.cz> <YO2T4J14roLUT32t@yuki>
 <YO2gUL2/s29SGdNo@pevik>
Message-ID: <YO2f+P8Z9l6SISDG@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks! It looks like it helped (but few jobs haven't finished yet).
> https://github.com/pevik/ltp/actions/runs/1026771350
> Will you merge this fix yourself please?

It was obvious bug in the code, so I pushed it with yours Reported-by and
Tested-by.

> > Not sure what we can do here, I guess that timings would be hard to fix
> > on VMs that run the tests.
> 
> If I remember correctly Richie suggested that FAIL is also OK. He said only
> TBROK and TCONF is a problem. I'd prefer to fuzzy sync tests which always pass,
> but after this effort I can work on API tests metadata, which would allow also
> this.

Another possibility would be relaxing the timings on VMs. I guess that
we could change the treshold for reaching the criticall section to 10 on
VMs.

> > > +# custom version
> > > +tst_res()
> > > +{
> > > +	if [ $# -eq 0 ]; then
> > > +		echo >&2
> > > +		return
> > > +	fi
> > > +
> > > +	local res="$1"
> > > +	shift
> > > +
> > > +	tst_color_enabled
> > > +	local color=$?
> > > +
> > > +	printf "runtest " >&2
> > > +	tst_print_colored $res "$res: " >&2
> > > +	echo "$@" >&2
> > > +
> > > +}
> > > +
> > > +# custom version
> > > +tst_brk()
> > > +{
> > > +	local res="$1"
> > > +	shift
> > > +
> > > +	tst_flag2mask "$res"
> > > +	local mask=$?
> > > +
> > > +	tst_res
> > > +	tst_res $res $@
> > > +
> > > +	exit $mask
> > > +}
> 
> > I'm not sure that we should call these function tst_res and tst_brk it
> > only confuses everything since these are different from the ones in the
> > test library.
> OK, I'll rename it (runtest_res() and runtest_brk()).
> 
> > > +run_tests()
> > > +{
> > > +	local target="$1"
> > > +	local i ret tconf tpass vars
> > > +
> > > +	eval vars="\$LTP_${target}_API_TESTS"
> > > +
> > > +	tst_res TINFO "=== Run $target tests ==="
> > > +
> > > +	for i in $vars; do
> > > +		tst_res TINFO "* $i"
> > > +		./$i
> > > +		ret=$?
> > > +
> > > +		case $ret in
> > > +			0) tpass="$tpass $i";;
> > > +			1) tst_brk TFAIL "$i failed with TFAIL";;
> > > +			2) tst_brk TFAIL "$i failed with TBROK";;
> > > +			4) tst_brk TFAIL "$i failed with TWARN";;
> > > +			32) tconf="$tconf $i";;
> > > +			127) tst_brk TBROK "Error: file not found (wrong PATH? out-of-tree build without -b?), exit code: $ret";;
> > > +			*) tst_brk TBROK "Error: unknown failure, exit code: $ret";;
> 
> > Why do we exit on failure here?
> 
> > We should just increase the fail counters and go ahead with next test.
> 
> I quit here because you know how hard is to find error in very long log
> file. Also why to waste developer time when some test failed? Similar approach
> make has. But sure, I can continue here and print summary at the end.

As long as we run it on CI we really should run all tests.

-- 
Cyril Hrubis
chrubis@suse.cz
