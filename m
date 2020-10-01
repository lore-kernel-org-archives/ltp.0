From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Oct 2020 09:26:37 +0200
Subject: [LTP] [PATCH v4 4/4] ima_tpm.sh: Fix calculating PCR aggregate
In-Reply-To: <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
References: <20200930160214.29358-1-pvorel@suse.cz>
 <20200930160214.29358-5-pvorel@suse.cz>
 <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
Message-ID: <20201001072637.GA32109@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> <snip>

> > +get_pcr10_aggregate()
> > +{
> > +	local params pcr
> > +	local msg="$ERRMSG_EVMCTL"
> > +	local res=TCONF
> > +
> > +	if [ -z "$MISSING_EVMCTL" ]; then
> > +		params="--ignore-violations"  <=== 

> Violations should cause the measurement list verification to fail.
I didn't get this one. the idea is: TCONF for old evmctl version (failure can be
caused by old version, but TFAIL for new version).

> > +		msg=
> > +		res=TFAIL
> > +	elif check_ima_policy_cmdline "tcb"; then
> > +		tst_res TCONF "using builtin IMA TCB policy $ERRMSG_EVMCTL"
> > +		return
> > +	fi
> > +
> > +	evmctl -v ima_measurement $params $BINARY_MEASUREMENTS > hash.txt 2>&1
> > +	if [ $? -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> > +		tst_res TFAIL "evmctl failed $ERRMSG_EVMCTL"
> > +		tst_res TINFO "hash file:"
> > +		cat hash.txt >&2
> > +		return
> > +	fi
> > +
> > +	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \

> The IMA measurement list may contain records for other PCR 10.  The
> output may contain other PCRs.  Using "PCRAgg.*10:" is safer.  
> Probably need to use "grep -m 1 -E" as well.
+1 good point.

Kind regards,
Petr
