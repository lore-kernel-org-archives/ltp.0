Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48270E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 12:10:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728413C03F6
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 13:10:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36A4A3C02C4
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 13:10:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 715E722E82C
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 13:10:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97ABB21161;
 Fri,  3 Jan 2025 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735906202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aqEXm37PKWIwLAxtXrc7Y0+/EBgEQw+TOgmgOnFHME=;
 b=OSl6dbTf3f0ydMuFR8sgFAT8Kq19H2yl1TFZp7l+j/ltV/it9Z4cyF3uCUn5fq5Ulm1c36
 JIS5JWJDG9Kaho8WlkyQB2ws4Rc0HZSVAQemWXKfDNQoZS0aGpk75jFLtwfSDAtUWZGq20
 GVBz9CIyZPghXBkIR89TeMAU7cLl5rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735906202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aqEXm37PKWIwLAxtXrc7Y0+/EBgEQw+TOgmgOnFHME=;
 b=ybzq3VlYPFNPuVCZj9hA/d47fVlQwsfuvs0sBRE0nbMKYsEsoarQ5Mlk7AlnZbDHzhv3Yu
 S9VuTOMaZ/7AqTDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735906202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aqEXm37PKWIwLAxtXrc7Y0+/EBgEQw+TOgmgOnFHME=;
 b=OSl6dbTf3f0ydMuFR8sgFAT8Kq19H2yl1TFZp7l+j/ltV/it9Z4cyF3uCUn5fq5Ulm1c36
 JIS5JWJDG9Kaho8WlkyQB2ws4Rc0HZSVAQemWXKfDNQoZS0aGpk75jFLtwfSDAtUWZGq20
 GVBz9CIyZPghXBkIR89TeMAU7cLl5rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735906202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aqEXm37PKWIwLAxtXrc7Y0+/EBgEQw+TOgmgOnFHME=;
 b=ybzq3VlYPFNPuVCZj9hA/d47fVlQwsfuvs0sBRE0nbMKYsEsoarQ5Mlk7AlnZbDHzhv3Yu
 S9VuTOMaZ/7AqTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62649134E4;
 Fri,  3 Jan 2025 12:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JiGJFZrTd2d8OAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 12:10:02 +0000
Date: Fri, 3 Jan 2025 13:09:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250103120952.GB211314@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
 <20241231100057.GB36475@pevik>
 <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> On Tue, 2024-12-31 at 11:00 +0100, Petr Vorel wrote:
> > > Hi Petr,

> > > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > > [snip]

> > > > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > > @@ -1,7 +1,7 @@
> > > > =A0#!/bin/sh
> > > > =A0# SPDX-License-Identifier: GPL-2.0-or-later
> > > > =A0# Copyright (c) 2009 IBM Corporation
> > > > -# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
> > > > +# Copyright (c) 2018-2024 Petr Vorel <pvorel@suse.cz>
> > > > =A0# Author: Mimi Zohar <zohar@linux.ibm.com>

> > > > =A0TST_TESTFUNC=3D"test"
> > > > @@ -72,14 +72,20 @@ require_policy_readable()
> > > > =A0	fi
> > > > =A0}

> > > > -require_policy_writable()
> > > > +check_policy_writable()
> > > > =A0{
> > > > -	local err=3D"IMA policy already loaded and kernel not configured =
to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
> > > > -
> > > > -	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> > > > -	# CONFIG_IMA_READ_POLICY
> > > > +	[ -f $IMA_POLICY ] || return 1
> > > > +	# workaround for kernels < v4.18 without fix
> > > > +	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
> > > > =A0	echo "" 2> log > $IMA_POLICY
> > > > -	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> > > > +	grep -q "Device or resource busy" log && return 1
> > > > +	return 0
> > > > +}
> > > > +
> > > > +require_policy_writable()
> > > > +{
> > > > +	check_policy_writable || tst_brk TCONF \
> > > > +		"IMA policy already loaded and kernel not configured to enable m=
ultiple writes to it (need CONFIG_IMA_WRITE_POLICY=3Dy)"
> > > > =A0}

> > > > =A0check_ima_policy_content()
> > > > @@ -158,6 +164,34 @@ print_ima_config()
> > > > =A0	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
> > > > =A0}

> > > > +load_ima_policy()
> > > > +{
> > > > +	local policy=3D"$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> > > > +
> > > > +	if [ "$LTP_IMA_LOAD_POLICY" !=3D 1 -a "$policy" -a -f "$policy" ]=
; then
> > > > +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=3D1 to load policy =
for this test"
> > > > +		return
> > > > +	fi
> > > > +
> > > > +	if [ -z "$policy" -o ! -f "$policy" ]; then
> > > > +		tst_res TINFO "no policy for this test"
> > > > +		LTP_IMA_LOAD_POLICY=3D
> > > > +		return
> > > > +	fi
> > > > +
> > > > +	tst_res TINFO "trying to load '$policy' policy:"
> > > > +	cat $policy
> > > > +	if ! check_policy_writable; then
> > > > +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not=
 configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=
=3Dy), reboot required"
> > > > +		LTP_IMA_LOAD_POLICY=3D
> > > > +		return
> > > > +	fi
> > > > +
> > > > +	cat "$policy" 2> log > $IMA_POLICY
> > > > +	if grep -q "Device or resource busy" log; then
> > > > +		tst_brk TBROK "Loading policy failed"
> > > > +	fi

> > > To write to the IMA securityfs policy file, check_policy_writable() u=
sed "echo",
> > > while here it's using "cat".  "cat" fails when signed policies are re=
quired.
> > > Perhaps add something like:
> > > +
> > > +       if grep -q "write error: Permission denied" log; then
> > > +               tst_brk TBROK "Loading unsigned policy failed"
> > > +       fi

> > +1, I'll add this extra check to v3.

> > I suppose echo "" > /sys/kernel/security/ima/policy does not need this =
check.

> The original method for loading an IMA policy was by cat'ing the policy r=
ules. =

> Commit 7429b092811f ("ima: load policy using path") introduced the abilit=
y of
> verifying the integrity of the policy itself.

> echo <policy filepath>  > /sys/kernel/security/ima/policy

Thanks, I completely missed this already quite old method (v4.6).

I guess I could use

cat < /dev/null > /sys/kernel/security/ima/policy

instead of echo "" > /sys/kernel/security/ima/policy

Then "write error: Permission denied" check would not be needed, right?

> > Do I understand correctly you talk about policy containing func=3DPOLIC=
Y_CHECK [1]?

> Yes.  On a secure boot enabled system, the architecture specific policy m=
ight
> require the IMA policy itself to be signed.

> Snippet from ima_fs.c:

> #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
> IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
>         "appraise func=3DPOLICY_CHECK appraise_type=3Dimasig",
> #endif

+1

> > Maybe there could be a test based on example [2].

> > echo /home/user/tmpfile > /sys/kernel/security/ima/policy
> > cp tmpfile /sys/kernel/security/ima/policy
> > cat tmpfile > /sys/kernel/security/ima/policy

> All of the above will load a policy, assuming the policy itself doesn't n=
eed to
> be signed.  Only "echo /home/user/tmpfile > /sys/kernel/security/ima/poli=
cy" can
> load a signed policy.

> Loading a CA key (mokutil), signing (evmctl)[1] and loading (keyctl) an I=
MA
> policy is probably beyond LTP.  The purpose of this test would be to dete=
ct
> whether policies need to be signed.

> Going forward what's probably needed is a new package containing a set of=
 pre-
> defined sample custom policies, which are signed by the distro.

> [1] Directions for signing and loading a custom policy,
> https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#sign-and-inst=
all-a-custom-policy

Hopefully I find time to do some experiments with it soon.

Kind regards,
Petr

> Thanks,

> Mimi


> > Kind regards,
> > Petr

> > [1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-po=
licy-check
> > [2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-cu=
stom-policy

> > > > +}

> > > Mimi




-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
