Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MTw9d-00028p-N4
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 11:08:05 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTw9Z-00041Q-Ln
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 11:08:05 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
In-Reply-To: <200907222028.55612.vapier@gentoo.org>
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
	<1248297619.3714.10.camel@dyn9002018117.watson.ibm.com>
	<200907222028.55612.vapier@gentoo.org>
Date: Thu, 23 Jul 2009 07:07:54 -0400
Message-Id: <1248347274.3884.13.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp: IMA cross platform fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list <ltp-list@lists.sf.net>, Shaz <shazalive@gmail.com>, waqar afridi <afridi.waqar@gmail.com>

On Wed, 2009-07-22 at 20:28 -0400, Mike Frysinger wrote: 
> On Wednesday 22 July 2009 17:20:19 Mimi Zohar wrote:
> > testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> >
> > -		if [ "${line:0:1}" != "#" ] ; then
> > +		firstch=`expr substr "${line}" 1 1`
> > +		if [ "${firstch}" != "#" ] ; then
> 
> the `expr` util, while pretty flexible, tends to not get used.  so it'll 
> probably be easier for people to grok:
> 	if [ "${line#\#}" = "${line}" ] ; then

Other than the comparison needing to be '!=', this works. Thanks!

> > -	RC=$((`expr $RC1 + $RC2`))
> > -	if [ $RC -eq 1 ]; then
> > +	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then
> 
> i dont see what was wrong with the original here, but if you really want to 
> rewrite this, then just change the one line to:
> 	RC=$((RC1 + RC2))

The test opens the policy file and attempts to open it again, while it
is still open.  The test now explicitly checks the return code from both
opens.  The return code from both opens shouldn't be 0.

> > testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> >
> > +	zero="0000000000000000000000000000000000000000"
> >
> > +	ima_aggr=`expr substr "${line}" 49 40`
> >
> > -		[ "${line:49:40}" -eq 0 ] || RC=$?
> > +		[ "${ima_aggr}" = "${zero}" ] || RC=$?
> 
> these changes arent exactly equivalent.  if the subst of line only returned 
> say 5 zeros, then your check wouldnt work.  do you even need this ?  simply 
> changing the line to ima_aggr via substr looks good enough to me.  this should 
> work fine in POSIX shells:
> 	[ "00000" -eq 0 ]

Although the statements aren't equivalent, the current check is more
correct.  If the TPM is not enabled, the first entry
in /sys/kernel/security/ascii_runtime, the boot aggregate, will be a
string of zeroes.

> > testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> >
> > +			tst_res TINFO $LTPTMP/imalog.$$\
> > +			 "$TCID: (message ratelimiting?)"
> 
> this shows up a few times in the patch ... if you're going to line wrap 
> things, there needs to be a space before the continuation marker for style.
> -mike

Ok.

Thanks!

Mimi


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
