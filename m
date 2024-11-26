Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F12D66B81
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 22:09:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC0573DB3D3
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 23:09:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4F3F3C724A
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 23:09:34 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4C181020041
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 23:09:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D924021177;
 Tue, 26 Nov 2024 22:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732658972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
 b=hLucftdKUqntAognT/Bi04UpUgtStsETay5H1fvWPHsTfOZy0CldxAa9bfhbc9fXBwtq/+
 mexKaZ/g+6vUn+zMRS2VYOYkR7wD9LP77Viq08sqzIDNwvHo5nDDCsMSSdGBrrPlId2TGm
 2Ywh4RooSu7hK0r0hVe1+e9UMjwc4RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732658972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
 b=yuAIGwqrK4OWkml7+6VeHKiFMukBADzUFhIbhtVwFiIXpB6++SOvt8l73H2a9rmxnDaUyi
 c3fvGjYOt4vV64BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PY8oOG4A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RoVvTDjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732658971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
 b=PY8oOG4A8C9kRHtD35hXHBqLWMOUOAg6K/vtTyLFKQ+D6RXNUErreSaaGi6+TN31ltxWMu
 Js8dwUCFErPKSp7iGveXyvAz6sEKprzlcxA14NGBi685kF/1mH89ayFV75aJoXYl/R8X/k
 SgxO6/q6I6eb8zZQfJqnr4Lbp0aFyJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732658971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KAzBwRGjyKLrksc4WYZCtyJ/3pO1xnkb+oPnqaMM88o=;
 b=RoVvTDjm8icfuXH33/VMFSmbFnv5WOZFqsd2bntKx7u078BDRC7MiUjfnX7IGNIvwxkJJL
 ufAzbiE0Bso6HBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC2BB13890;
 Tue, 26 Nov 2024 22:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nh5gLBtHRmfIBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 Nov 2024 22:09:31 +0000
Date: Tue, 26 Nov 2024 23:09:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20241126220930.GA135981@pevik>
References: <20241126173830.98960-1-pvorel@suse.cz>
 <20241126173830.98960-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241126173830.98960-3-pvorel@suse.cz>
X-Rspamd-Queue-Id: D924021177
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] ima_setup.sh: Allow to load predefined policy
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, all,

...
> +load_ima_policy()
> +{
> +	local policy="$(ls $TST_DATAROOT/*.policy 2>/dev/null)"
> +
> +	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$policy" -a -f "$policy" ]; then
> +		tst_res TINFO "NOTE: set LTP_IMA_LOAD_POLICY=1 to load policy for this test"
> +		return
> +	fi
> +
> +	if [ -z "$policy" -o ! -f "$policy" ]; then
> +		tst_res TINFO "no policy for this test"
FYI here needs to be a flag to not warn in the cleanup about needed reboot.

> +		return
> +	fi
> +
> +	tst_res TINFO "trying to load '$policy' policy:"
> +	cat $policy
> +	if ! check_policy_writable; then
> +		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
> +		return
> +	fi
> +
> +	cat "$policy" 2> log > $IMA_POLICY
> +	if grep -q "Device or resource busy" log; then
> +		tst_brk TBROK "Loading policy failed"
Also here.

diff, which should solve it.

Kind regards,
Petr

+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -175,6 +175,7 @@ load_ima_policy()
 
 	if [ -z "$policy" -o ! -f "$policy" ]; then
 		tst_res TINFO "no policy for this test"
+		LTP_IMA_LOAD_POLICY=
 		return
 	fi
 
@@ -182,6 +183,7 @@ load_ima_policy()
 	cat $policy
 	if ! check_policy_writable; then
 		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required"
+		LTP_IMA_LOAD_POLICY=
 		return
 	fi
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
