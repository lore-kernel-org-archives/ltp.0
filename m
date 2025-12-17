Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76208D65C49
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 14:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140653D03DF
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 15:25:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 908613C0322
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 15:25:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CECC1400176
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 15:25:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 851005BCFC;
 Wed, 17 Dec 2025 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765981518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
 b=YMKOziYOnTWIW32dZvfPZkGhH/88J2lpr/gkhk+O9IXnSgmxrZNiqTZiXgsfbVKhT5MJMd
 CVmn0EByQD70O+svlljK1QZFzD6gpSFONQXCMDRtBrUxWSV5VNuRaPlsWBFkCGkK3BRfW1
 koOTpXoh89RCgR6Fp+apqhrm+EqYoz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765981518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
 b=YUuHmz/j6dumd8ZQ+rpZwI/P97NzTDwvwnKJulxeZEHlQD/2MIcU64mcyLXqA5KfDirBkx
 PYpH/46ueqhIc9BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m1eXf7EM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Lq5mpX/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765981517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
 b=m1eXf7EMxkkWZcRjrgfqNTFJWZxMUYkxMf7ijHATU3dgSbSEEr+9FEhy/YuHi3zwQRqLHT
 6zy73vKZMuR0VUH9m9CMQh9FYjo0c0+4lDZpCSqs834TKoxywdKLlgEE+V4aCrqbUBU1rz
 algxBXrbZt6ZCGIoC1/05JiLWQZukf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765981517;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGc4zvn4VyyoN2L6CuBnyqtYJ4UNfZuIMN98KMw17z8=;
 b=Lq5mpX/Tq8/y/2nw2qa6R6MA3SCg8H/12ieLfJBGIipvfCGH7ort23dUY4NPL0vB3paUBB
 7pllTECevuVn+ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D4C3EA63;
 Wed, 17 Dec 2025 14:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cYGiDk29QmnPCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 14:25:17 +0000
Date: Wed, 17 Dec 2025 15:25:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20251217142515.GA66146@pevik>
References: <20251211111046.87297-1-pvorel@suse.cz>
 <c5450636264354dbf4d5e52d2441904d665e96ee.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5450636264354dbf4d5e52d2441904d665e96ee.camel@linux.ibm.com>
X-Rspamd-Queue-Id: 851005BCFC
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_violations.sh: Another fix of condition
 evaluation
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

> On Thu, 2025-12-11 at 12:10 +0100, Petr Vorel wrote:
> > c0c35509f9 was not enough to fix evaluation against empty
> > $expected_violations:

> > ima_violations 1 TINFO: verify open writers violation
> > /opt/ltp/testcases/bin/ima_violations.sh: line 96: [: 0: unary operator expected

> > Therefore split checks into two if.

> > Also improvements (readability)
> > * shorten line length with saving subtraction into variable
> > * evaluate empty variable with ${:-}

> > Fixes: 726ed71905 ("ima_violations.sh: Update validate() to support multiple violations")
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, Martin, Petr.  LGTM

Thanks! FYI merged with simpler code suggested by Andrea.

> > ---
> > NOTE: this was found on old SLES 4.4 based kernel which does not log
> > validations. But missing validations might be just a Secure Boot related
> > setup problem:

> > $ mokutil --sb-state
> > Secure Boot: EFI variables not supported on SUT

> > Events are logged when Secure Boot is off:
> > $ mokutil --sb-state
> > SecureBoot disabled

> > Or maybe violations worked differently on the old kernel (I remember
> > only 6.15 change).

> Violations only occur when there are policy rules containing "func=FILE_CHECK"
> defined.  The secure boot mode should only affects the arch specific policies,
> which do not include "func=FILE_CHECK" rules.  There is a slight difference
> between the builtin the original "ima_tcb" and newer "ima_policy=tcb" policies,
> which might affect violations.

Thanks for the hints! I'll have to dig more into tthe problem to see what is
wrong.

Anyway at least for example policy I see the differences between the old [1] and
new [2]:

-measure func=FILE_CHECK mask=MAY_READ uid=0
+measure func=FILE_CHECK mask=^MAY_READ euid=0
+measure func=FILE_CHECK mask=^MAY_READ uid=0    # root opened r/o, r/w

I guess I'll just add for older kernels this example policy:
measure func=FILE_CHECK mask=MAY_READ uid=0

Kind regards,
Petr

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-policy-tcb
[2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
