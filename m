Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7A1C46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 21:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39EA23D050C
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 22:19:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C573C062A
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:19:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B934631D63
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:19:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 026ED21F6A;
 Tue,  2 Jan 2024 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704230359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1cJLpo3ZTynRfFBkTqjNuqsoROaPsumL1pQBCAesE=;
 b=CAgBPqj0xU0ODrenek4yc3PVZMD/6So1loBkrPxDXLnXMvg/4v12HTn5rIh8J8mz2uV3hc
 9Z5Vu3qA1kFSQ0olp/+Bgl5BeXgQGJEnkEn3haLTzTJAexscb1gQEANwXPMphMhZoAz+6N
 IiO93dD2Rk6Q3hP6xOquG/hSEiPTdew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704230359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1cJLpo3ZTynRfFBkTqjNuqsoROaPsumL1pQBCAesE=;
 b=bqfmLd/AjstJ1X8MCM6OyyvlFQezu3Cb59+FoPjHRaimXce5Zv3m42BLQWAO+4SPxdxjz0
 M8+ybXq4L2d98rDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704230359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1cJLpo3ZTynRfFBkTqjNuqsoROaPsumL1pQBCAesE=;
 b=CAgBPqj0xU0ODrenek4yc3PVZMD/6So1loBkrPxDXLnXMvg/4v12HTn5rIh8J8mz2uV3hc
 9Z5Vu3qA1kFSQ0olp/+Bgl5BeXgQGJEnkEn3haLTzTJAexscb1gQEANwXPMphMhZoAz+6N
 IiO93dD2Rk6Q3hP6xOquG/hSEiPTdew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704230359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fA1cJLpo3ZTynRfFBkTqjNuqsoROaPsumL1pQBCAesE=;
 b=bqfmLd/AjstJ1X8MCM6OyyvlFQezu3Cb59+FoPjHRaimXce5Zv3m42BLQWAO+4SPxdxjz0
 M8+ybXq4L2d98rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A948A1340C;
 Tue,  2 Jan 2024 21:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xqg5J9Z9lGWkRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Jan 2024 21:19:18 +0000
Date: Tue, 2 Jan 2024 22:19:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240102211917.GA983826@pevik>
References: <20231219123709.339435-1-pvorel@suse.cz>
 <69ae372c-c089-4201-957f-2e07b592afcc@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69ae372c-c089-4201-957f-2e07b592afcc@suse.cz>
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] net: tst_netload_compare(): Ignore
 performance failures
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,

> On 19. 12. 23 13:37, Petr Vorel wrote:
> > Performance failures in tests which use tst_netload_compare() (tests in
> > runtest/net.features) can hide a real error (e.g. test fails due missing
> > required kernel module). Best solution would be to have feature tests
> > (likely written in C API) and performance tests (the current ones).

> > But until it happens, just disable performance failure by default,
> > print TINFO message instead unless TST_NET_FEATURES_TEST_PERFORMANCE=1
> > environment variable is set.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   testcases/lib/tst_net.sh    | 12 +++++++++---
> >   testcases/lib/tst_test.sh   |  5 +++--
> >   testcases/network/README.md |  4 ++++
> >   3 files changed, 16 insertions(+), 5 deletions(-)

> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > index e47ee9676..46d49c266 100644
> > --- a/testcases/lib/tst_net.sh
> > +++ b/testcases/lib/tst_net.sh
> > @@ -869,16 +869,22 @@ tst_netload_compare()
> >   	local new_time=$2
> >   	local threshold_low=$3
> >   	local threshold_hi=$4
> > +	local ttype='TFAIL'
> > +	local msg res
> >   	if [ -z "$base_time" -o -z "$new_time" -o -z "$threshold_low" ]; then
> >   		tst_brk_ TBROK "tst_netload_compare: invalid argument(s)"
> >   	fi
> > -	local res=$(((base_time - new_time) * 100 / base_time))
> > -	local msg="performance result is ${res}%"
> > +	res=$(((base_time - new_time) * 100 / base_time))
> > +	msg="performance result is ${res}%"
> >   	if [ "$res" -lt "$threshold_low" ]; then
> > -		tst_res_ TFAIL "$msg < threshold ${threshold_low}%"
> > +		if [ -z "$TST_NET_FEATURES_TEST_PERFORMANCE" ]; then
> > +			ttype='TINFO';
> > +			tst_res_ TINFO "WARNING: slow performance is not treated as error, change it with TST_NET_FEATURES_TEST_PERFORMANCE=1"

> This TINFO message should probably be moved to tst_net_setup(). Otherwise
> some tests will print it multiple times.

I wanted to print it only when relevant. When added to tst_net_setup() it will
print also for tests which does not use tst_netload_compare(), which is IMHO
worth than printing multiple times the info. I could avoid it with guarding
with a variable (e.g. _tst_net_test_performance_warn_printed, ugly solution but
solves the problem). WDYT?

> I'd also slightly prefer to keep the default as is and use a variable to
> disable perf checks instead.

That's obviously more friendly as it's backward compatible, so I'm ok to send v2
which implements that. The reason why I dared to change the default is that I
haven't seen any report on these tests thus I suspect not many people (if any
outside SUSE) use them. I also wonted to promote them as working tests to the
testing community, but I would recommend to use them only with disabled checks.

Kind regards,
Petr

> > +		fi
> > +		tst_res_ $ttype "$msg < threshold ${threshold_low}%"
> >   		return
> >   	fi
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index 5f178a1be..06ee6005a 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -1,6 +1,6 @@
> >   #!/bin/sh
> >   # SPDX-License-Identifier: GPL-2.0-or-later
> > -# Copyright (c) Linux Test Project, 2014-2022
> > +# Copyright (c) Linux Test Project, 2014-2023
> >   # Author: Cyril Hrubis <chrubis@suse.cz>

> >   # LTP test library for shell.
> > @@ -681,7 +681,8 @@ tst_run()
> >   			NEEDS_KCONFIGS|NEEDS_KCONFIGS_IFS);;
> >   			IPV6|IPV6_FLAG|IPVER|TEST_DATA|TEST_DATA_IFS);;
> >   			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
> > -			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
> > +			NETLOAD_CLN_NUMBER|NET_DATAROOT|NET_FEATURES_TEST_PERFORMANCE);;
> > +			NET_MAX_PKT|NET_RHOST_RUN_DEBUG);;
> >   			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
> >   			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
> >   			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
> > diff --git a/testcases/network/README.md b/testcases/network/README.md
> > index a0a1d3d95..0547c3f9f 100644
> > --- a/testcases/network/README.md
> > +++ b/testcases/network/README.md
> > @@ -84,6 +84,10 @@ Where
> >   Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
> >   Network stress parameters are documented in `testcases/network/stress/README`.
> > +Tests which use `tst_netload_compare()` test just basic functionality,
> > +performance failure is just printed with 'TINFO'. To enable also performance
> > +testing, set `TST_NET_FEATURES_TEST_PERFORMANCE=1` environment variable.
> > +
> >   ## Debugging
> >   Both single and two host configurations support debugging via
> >   `TST_NET_RHOST_RUN_DEBUG=1` environment variable.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
