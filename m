Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E466C282DE
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 17:07:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DCC23CA0C2
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 18:07:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731413C1B59
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 18:07:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E4B8140006E
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 18:07:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B4231F385;
 Thu,  6 Mar 2025 17:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741280841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
 b=guU+MpGQheUyPdkR1L0Mq43txQBlzpMwoKI3Tf/019uwRJuIqFGX97owjE3/N/G5954Okr
 c8tX5lmVXj8lo2SBDGaydGKC1yUhgyiw4N7hT6XLXk9VlWa3BeIwtBJGtAVQyjTLj7u0Ws
 pQx+FXxuOBG5YpZyMUu9+PNv+rIwt1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741280841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
 b=TjxKTK66KSf5bPfBRyw4Cco49/JbxgkVLdmQjOX7ui5ZTyW9b9f+vx3OSFi5yrAMrKW6x9
 ZlEesHfbL9K4+yAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741280841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
 b=guU+MpGQheUyPdkR1L0Mq43txQBlzpMwoKI3Tf/019uwRJuIqFGX97owjE3/N/G5954Okr
 c8tX5lmVXj8lo2SBDGaydGKC1yUhgyiw4N7hT6XLXk9VlWa3BeIwtBJGtAVQyjTLj7u0Ws
 pQx+FXxuOBG5YpZyMUu9+PNv+rIwt1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741280841;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PSE8F28yWJgcLqnxdF9R3TUhrMAhG2STD0s3bHNEGFU=;
 b=TjxKTK66KSf5bPfBRyw4Cco49/JbxgkVLdmQjOX7ui5ZTyW9b9f+vx3OSFi5yrAMrKW6x9
 ZlEesHfbL9K4+yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AA5613A61;
 Thu,  6 Mar 2025 17:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /23EAEnWyWcmNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 17:07:21 +0000
Date: Thu, 6 Mar 2025 18:07:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250306170710.GA186319@pevik>
References: <20250305145421.638857-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250305145421.638857-1-zohar@linux.ibm.com>
X-Spamd-Result: default: False [-2.47 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; NEURAL_HAM_LONG(-0.97)[-0.970];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] ima_violations.sh: force $LOG ToMToU
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

FYI I already merged this from v2 (modified, just swap TINFO message with exec):
https://github.com/linux-test-project/ltp/commit/fdd6da28cf8a2e6de5104e7332724dd5eee346b0

Kind regards,
Petr

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
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
