Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8449C282D3
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D9023CA000
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 13:58:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A9B3C9D55
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:57:53 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E212C219646
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 13:57:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 127F921190;
 Tue,  4 Mar 2025 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
 b=tAVuru5krXb+Xk2l10WLjHGMJKouBox6M4ZM9tIXRNc34yry28/Y5bGeYOn5fRMTl6KGZQ
 ci3vJV01UY90jd8DR94JNEqnu1bs8IMLRJWMfiFxYqxVMQP4XZJINnvaXhJ6Z4moVOW9Wg
 HdWq9xqCiurA9nTB3brJqDYGYwPKLFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
 b=bPWNnAOIV44TBVxZSAPcVOu8Zq9+qH+oABRpbq/NwUH6yALxoetGPDLYl3rRKe9kq4rDpM
 fc58oKH02QmhyVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741093071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
 b=tAVuru5krXb+Xk2l10WLjHGMJKouBox6M4ZM9tIXRNc34yry28/Y5bGeYOn5fRMTl6KGZQ
 ci3vJV01UY90jd8DR94JNEqnu1bs8IMLRJWMfiFxYqxVMQP4XZJINnvaXhJ6Z4moVOW9Wg
 HdWq9xqCiurA9nTB3brJqDYGYwPKLFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741093071;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87zAOwEdaCcmKqN1c4wbkJqYWFYitpjRDie2jchQ710=;
 b=bPWNnAOIV44TBVxZSAPcVOu8Zq9+qH+oABRpbq/NwUH6yALxoetGPDLYl3rRKe9kq4rDpM
 fc58oKH02QmhyVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9B1B1393C;
 Tue,  4 Mar 2025 12:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xRFtM874xmc1FAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Mar 2025 12:57:50 +0000
Date: Tue, 4 Mar 2025 13:57:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250304125749.GA81126@pevik>
References: <20250304115331.524842-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250304115331.524842-1-zohar@linux.ibm.com>
X-Spamd-Result: default: False [-6.24 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-0.75)[-0.753]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.19)[-0.954]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] ima_violations.sh: force $LOG ToMToU
 violation earlier
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Violation tests are dependent on searching the $LOG file, which may
> itself result in a ToMToU violation.  Preempt getting an additional
> violation during the tests by forcing the $LOG ToMToU violation
> earlier.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 37d8d473c..22863fb72 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -30,6 +30,7 @@ setup()
>  	if [ ! -e "$LOG" ]; then
>  		tst_brk TCONF "log file not found, install auditd"
>  	fi
> +	exec 3< $LOG || tst_brk TBROK "failed to read log file"
>  	tst_res TINFO "using log $LOG"

If you don't mind, I would reverse the order to get info about which log is
used:

	tst_res TINFO "using log $LOG"
	exec 3< $LOG || tst_brk TBROK "failed to read log file"

Or, if it's needed to for some reason to run it before (no idea why, but I might
miss something), I would merge it as:

	exec 3< $LOG || tst_brk TBROK "failed to read $LOG"
	tst_res TINFO "using log $LOG"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
