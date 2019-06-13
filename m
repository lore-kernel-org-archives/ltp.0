From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Jun 2019 18:10:43 +0200
Subject: [LTP] [PATCH v3 3/4] ima/ima_measurements.sh: Require builtin
 IMA tcb policy
In-Reply-To: <1560352011.4578.43.camel@linux.ibm.com>
References: <20190611193021.17651-1-pvorel@suse.cz>
 <20190611193021.17651-4-pvorel@suse.cz>
 <1560352011.4578.43.camel@linux.ibm.com>
Message-ID: <20190613161042.GA24675@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

thanks a lot for your review.

> On Tue, 2019-06-11 at 21:30 +0200, Petr Vorel wrote:
> > Although custom policy which contains tcb can be loaded via dracut,

> ^which may contain the equivalent measurement tcb rules
I'm going to address this in v4.

> > systemd or later manually from user space, detecting it would require
> > IMA_READ_POLICY=y. In order to simplify the check and avoid false
> > positives lets ignore this option and require builtin IMA tcb policy.

> This test is for adding new measurements to the measurement list.
Sure. So what should I change in commit message?


> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  .../kernel/security/integrity/ima/tests/ima_measurements.sh    | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > index 328affc43..a3aa24d8a 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > @@ -57,7 +57,8 @@ setup()
> >  	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
> >  		"Cannot find digest index (template: '$template')"

> > -	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
> > +	grep -q -e ima_policy=[a-z_]*tcb -e ima_tcb -e ima_appraise_tcb /proc/cmdline || \
> > +		tst_brk TCONF "IMA measurement tests require builtin IMA tcb policy (ima_policy=tcb or ima_policy=appraise_tcb kernel parameter)"
> >  }


> "appraise_tcb" doesn't provide the necessary measurement rules.
> "ima_policy=" isn't order specific.  The check would be for "|tcb", "|
> tcb", "tcb|", "tcb |", or just "=tcb".  The deprecated "ima_tcb"
> option is fine too.
Going to change in v4.

> Mimi

Kind regards,
Petr

