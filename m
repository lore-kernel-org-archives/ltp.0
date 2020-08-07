From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Aug 2020 16:30:27 +0200
Subject: [LTP] [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
In-Reply-To: <20200807141524.GA3247@dell5510>
References: <20200807112929.8984-1-pvorel@suse.cz>
 <20200807141524.GA3247@dell5510>
Message-ID: <20200807143027.GB3247@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> ...
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > @@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
> >  # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
> >  test1()
> >  {
> > -	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
> > +	local keyrings keycheck_lines keycheck_line templates
> > +	local policy="func=KEY_CHECK"
> > +	local test_file="file.txt"

> >  	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"

> > -	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
> > +	require_ima_policy_content $policy
> > +	keycheck_lines=$(check_ima_policy_content $policy "")
> >  	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
> While working on this patchset, I wonder, why we don't check for
> 'func=KEY_CHECK.*keyrings' in single grep call instead of grepping it twice.
> IMHO single grep call is enough. Or am I missing something?
OK, the order can be different as (according to doc [1] as Mimi remarked in some
older mail) only action is fixed on first place, order of conditions isn't
defined. Thus this would make it:
grep -E '^measure.*(func=KEY_CHECK.*keyrings|keyrings.*func=KEY_CHECK)'

But both tests have the requirement in common only 'func=KEY_CHECK', thus I'll
do some preparations for next test.

(+ we didn't require measure, thus dont_measure could fit into previous check as
well).

Kind regards,
Petr

[1] https://www.kernel.org/doc/Documentation/ABI/testing/ima_policy

