Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1856BC5DF70
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 08:20:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2621A3CC86F
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 10:20:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDE6B3C00C7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:20:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04D626009E8
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:20:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 22ED73E49;
 Tue, 18 Aug 2026 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787041233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=surFAzr89Y+LzeubsSHsj+Qcu5OZ0r9bn+81ylsIXq4=;
 b=Hi26ebYvsV/l2RIg3eEmQd/5Joz2kbuazN2drN+XHoAIyH0QxitxbLkld1WVfgj+8br544
 NvwaHWipR9cx2UnSONQeQ3452LwYqTWbr4H6mU3Y9sfwGwLNGd00m2HKy1f/L6b6qW+DcZ
 A5gR0Wr5wOagzbYiA/sQVqU1ZAiiNw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787041233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=surFAzr89Y+LzeubsSHsj+Qcu5OZ0r9bn+81ylsIXq4=;
 b=FK6pW4MC4Cvx+JwmNAqf+gTU66lUAGKBWcBuV6NhD5X+WWsqnQ9dB6pb0nDgQdcrbWo8AR
 dcAT5ybIe2ORKDCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787041229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=surFAzr89Y+LzeubsSHsj+Qcu5OZ0r9bn+81ylsIXq4=;
 b=NTSACBvyY6YmUXkihPg/Kx4u3l15egeEL6/lOjQoNXgAXKQOQfSzj5ulYpP4igrZhXRsn0
 gafXhgZ9ckkFUsrwROQjqFtd05EBDCLN3gTiqkdvKmBdjuwRXW2E9lcOMDDez2STMPp0Qn
 Kf5351LB029JJw1oEsbukouiPgqmJsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787041229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=surFAzr89Y+LzeubsSHsj+Qcu5OZ0r9bn+81ylsIXq4=;
 b=LEHg0kqbXVAkzqZlhWbHaNkY1qpg2k2m2I4iHoJ4nj5MNhidqhOskKRz7/gOdcM+hpKtkl
 sDCIDNW6PQ54TeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F12C822BA;
 Tue, 18 Aug 2026 08:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r6ALOcwVhGrcDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Aug 2026 08:20:28 +0000
Date: Tue, 18 Aug 2026 10:20:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20260818082023.GA2038472@pevik>
References: <20260814135704.1247403-1-zohar@linux.ibm.com>
 <20260817105556.GA1951950@pevik>
 <2fb152d374a14a0e30b20de73d74a90b195e0793.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2fb152d374a14a0e30b20de73d74a90b195e0793.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_test.sh:url,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_tpm.sh: update test2 to detect integrity
 violations
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Hi Petr,

> On Mon, 2026-08-17 at 12:55 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > > <securityfs>/integrity/ima/violations reflects the number of
> > > integrity violations.  Include the "--ignore-violations" option,
> > > if there are any violations, on the initial IMA measurement list
> > > verification.

> > Thanks for your patch!

> > LGTM and it should be fixed. But there are some potential problems
> > (see bellow).

> And here I thought this was a simple performance improvement to execute evmctl
> with/without the --ignore-violations option once.

FYI back then I did not worry that much about performance (i.e. running evmctl
once or twice does not matter to me), I wanted to keep test coverage on vast
majority of distro versions (old and new). Maybe it's not that important.

> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  .../security/integrity/ima/tests/ima_tpm.sh   | 20 ++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > index 5d34d8679..acd8b6d30 100755
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > > @@ -142,6 +142,8 @@ read_pcr_tpm2()
> > >  get_pcr10_aggregate()
> > >  {
> > >  	local cmd="evmctl -vv ima_measurement $BINARY_MEASUREMENTS"
> > > +	local violations="$IMA_DIR/violations"
> > > +	local num_violations=0
> > >  	local msg="$ERRMSG_EVMCTL"
> > >  	local res=TCONF
> > >  	local pcr ret
> > > @@ -151,16 +153,20 @@ get_pcr10_aggregate()
> > >  		res=TFAIL
> > >  	fi

> > > -	$cmd > hash.txt 2>&1
> > > -	ret=$?
> > > -	if [ $ret -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> > > -		tst_res TFAIL "evmctl failed, trying with --ignore-violations"
> > You removed TFAIL (potential problem, see later).

> > > +	if [ ! -f "$violations" ]; then
> > > +		tst_res TINFO "missing $violations"
> > > +	else
> > > +		num_violations=$(cat "$violations")
> > > +	fi
> > > +
> > > +	if [ "$num_violations" -eq 0 ]; then
> > > +		$cmd > hash.txt 2>&1
> > > +		ret=$?
> > > +	else
> > > +		tst_res TINFO "ignoring $num_violations violations"
> > >  		cmd="$cmd --ignore-violations"
> > >  		$cmd > hash.txt 2>&1
> > >  		ret=$?
> > > -	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
> > > -		tst_res TFAIL "evmctl failed $msg"
> > And here again removed TFAIL (see later).

> > The main problem is that you removed the code when evmctl is not installed.

> If I'm understanding the code correctly, the original code executed evmctl
> whether it existed or not.  Let's fix that first.  My question is whether the
IMHO no.

> test should fail or be skipped?

The original intention in 7fd7c9febd [1] was to run without --ignore-violations
on any evmctl and if test fails (recorded always as TFAIL) and evmctl is new
enough rerun it with --ignore-violations.  (Simply not run for the second time
and just fail on missing evmctl or evmctl being too old to support
--ignore-violations.) Quoting the kernel commit for the reason:

	For old kernels which use SHA1/MD5, any evmctl version is required (evmctl
	ima_measurement was introduced in very old v0.7), but:
	* newer sysctl path /sys/class/tpm/tpm0/device/pcrs requires evmctl 1.1
	* using ima_policy=tcb requires 1.3.1 due --ignore-violations

	For evmctl >= 1.3.1 on failure we try to retest with --ignore-violations.

Is it a wrong approach? Looking on your patch it probably is wrong approach
(not taking /sys/kernel/security/ima/violations into account).

Also, as $MISSING_EVMCTL is taking into account in the results, it should be
safe.

[1] https://github.com/linux-test-project/ltp/commit/7fd7c9febdd7ed48ae3563923074bcabdfec3923

> > Therefore trying to rerun evmctl on failure on older release (e.g. 1.3) it will
> > fail due option have different name or not exist at all in evmctl < 1.2).
> > -a "$MISSING_EVMCTL" = 1 check had meaning "don't rerun with --ignore-violations
> > on old evmctl which does not have the option.

And $MISSING_EVMCTL is a bit misleading name, because 1 means either "evmctl not
installed at all" or "installed old evmctl version" (MISSING_SUITABLE_EVMCTL or
something would be more obvious).

> Thank you for the explanation.

+1, thank you too for your explanation.

> Before appending the "--ignore-violations" we should make sure it is supported.
Yes. And I hoped that code in the setup() resulting in $MISSING_EVMCTL did it
correctly.

> I guess for backwards compatibility we still want to verify the measurement
> list, knowing it will fail.

Yes.

> Hopefully with these two changes this patch will work properly.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
(plan to merge tomorrow, in case there is any feedback)

BTW when run on new system (recent Tumbleweed) without evmctl the second TCONF
message is misleading a bit but let's ignore it:

ima_tpm 1 TINFO: TPM hardware support not enabled in kernel or no TPM chip found, testing TPM-bypass
ima_tpm 1 TCONF: 'evmctl' not found
ima_tpm 1 TCONF: algorithm not sha1 (sha256) => install evmctl >= 1.3.1

And other issue is that parsing kernel config in setup() should be replaced with
API function tst_check_kconfigs (less error-prone, it can ballback to
/proc/config.gz, etc). That's my TODO.

Kind regards,
Petr

> Mimi


> > FYI the code is a bit complicated, because here on TPM2 we require evmctl 1.3.1
> > to have --ignore-violations (renamed from --validate), which was released in
> > 2020 - too new for old enterprise distros to ignore; also TPM1 we require only
> > 1.1 from 2018, probably still too new. Once SLE12-SP3 EOL (in 1 year we may just
> > expect 1.3.1 to simplify).

> > > -		return
> > >  	fi

> > >  	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $msg"
> > Back to removed TFAIL. While this is OK as TWARN (some problem, but not related
> > to testing) we might end up to TBROK "Test didn't report any results" error in
> > tst_test.sh which quits test with TBROK "Test didn't report any results" if
> > there is no TPASS/TFAIL/TCONF message.

> > _tst_resstr()
> > {
> > 	echo "$TST_PASS$TST_FAIL$TST_CONF"
> > }

> > _tst_rescmp()
> > {
> > 	local res=$(_tst_resstr)

> > 	if [ "$1" = "$res" ]; then
> > 		tst_brk TBROK "Test didn't report any results"
> > 	fi
> > }

> > And this happen later in test2():
> > 	get_pcr10_aggregate > tmp.txt
> > 	pcr_aggregate="$(cat tmp.txt)"
> > 	if [ -z "$pcr_aggregate" ]; then
> > 		return
> > 	fi

> > Other option would be to print TFAIL message in test2():

> > 	get_pcr10_aggregate > tmp.txt
> > 	pcr_aggregate="$(cat tmp.txt)"
> > 	if [ -z "$pcr_aggregate" ]; then
> > 		tst_res TBROK "failed to get aggregate PCR-10"
> > 		return
> > 	fi

> > Lol, I'm disappointed how complicated and error prone I wrote back then.
> > Part of the problem is that quit with tst_brk does not work, when code which
> > does it is run in a subshell (via $(...) or `...) ), which quits subshell but
> > not the parent shell.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
