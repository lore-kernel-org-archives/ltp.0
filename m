Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D92EE77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 10:01:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0E6C3E9F1C
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:01:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76AA63DCCDF
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:01:08 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49F5C1034053
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:01:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE0411F37C;
 Tue, 31 Dec 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A359513A30;
 Tue, 31 Dec 2024 10:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MClyJuLAc2dzEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 31 Dec 2024 10:01:06 +0000
Date: Tue, 31 Dec 2024 11:00:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20241231100057.GB36475@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: CE0411F37C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] ima_setup.sh: Allow to load predefined
 policy
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

> Hi Petr,

> On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> [snip]

> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -1,7 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >  # Copyright (c) 2009 IBM Corporation
> > -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> > +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
> >  # Author: Mimi Zohar <zohar@linux.ibm.com>

> >  TST_TESTFUNC="test"
> > @@ -72,14 +72,20 @@ require_policy_readable()
> >  	fi
> >  }

> > -require_policy_writable()
> > +check_policy_writable()
> >  {
> > -	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> > -
> > -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> > -	# CONFIG_IMA_READ_POLICY
> > +	[ -f $IMA_POLICY ] || return 1
> > +	# workaround for kernels < v4.18 without fix
> > +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> >  	echo "" 2> log > $IMA_POLICY
> > -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> > +	grep -q "Device or resource busy" log && return 1
> > +	return 0
> > +}
> > +
> > +require_policy_writable()
> > +{
> > +	check_policy_writable || tst_brk TCONF \
> > +		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> >  }

> >  check_ima_policy_content()
> > @@ -158,6 +164,34 @@ print_ima_config()
> >  	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> >  }

> > +load_ima_policy()
> > +{
> > +	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> > +
> > +	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
> > +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
> > +		return
> > +	fi
> > +
> > +	if [ -z "$policy" -o ! -f "$policy" ]; then
> > +		tst_res TINFO "no policy for this test"
> > +		LTP_IMA_LOAD_POLICY=
> > +		return
> > +	fi
> > +
> > +	tst_res TINFO "trying to load '$policy' policy:"
> > +	cat $policy
> > +	if ! check_policy_writable; then
> > +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
> > +		LTP_IMA_LOAD_POLICY=
> > +		return
> > +	fi
> > +
> > +	cat "$policy" 2> log > $IMA_POLICY
> > +	if grep -q "Device or resource busy" log; then
> > +		tst_brk TBROK "Loading policy failed"
> > +	fi

> To write to the IMA securityfs policy file, check_policy_writable() used "echo",
> while here it's using "cat".  "cat" fails when signed policies are required.
> Perhaps add something like:
> +
> +       if grep -q "write error: Permission denied" log; then
> +               tst_brk TBROK "Loading unsigned policy failed"
> +       fi

+1, I'll add this extra check to v3.

I suppose echo "" > /sys/kernel/security/ima/policy does not need this check.

Do I understand correctly you talk about policy containing func=POLICY_CHECK [1]?
Maybe there could be a test based on example [2].

echo /home/user/tmpfile > /sys/kernel/security/ima/policy
cp tmpfile /sys/kernel/security/ima/policy
cat tmpfile > /sys/kernel/security/ima/policy

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-policy-check
[2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-custom-policy

> > +}

> Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
