Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFCD38FEC
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 16:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 307853C9FD1
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 17:55:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A9BE3C9F78
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 17:55:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BAAC10001B3
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 17:55:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AF7235CE80;
 Wed, 14 Jan 2026 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768409705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+oKHdvfYj+ft1jbrQZBk0MFtiAA59hmPvW9Exn7ZpE=;
 b=ZOwrla6izy1e+uqPj7saR97+TTI7ruH7eFC1v5zJ+vDn6SxbOIEKje+trDqA95ulblHjsI
 ba/pVzfN28b2b4zEvJrdJOdM1+CJG3dn8n+00R4Om5RP/Q4Gv42hRsiOubmuFGNm96ofgR
 f8yLlCrRSkNRtTW/jL6kZOhsWnL+iFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768409705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+oKHdvfYj+ft1jbrQZBk0MFtiAA59hmPvW9Exn7ZpE=;
 b=RFGzXW63Q2nacnet4itocu+aj9qtB28QVN3jv40oCizBqhimHlwL97t6uIf1OXGcZ41YK0
 Thr3rwgI9VmqH0Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZOwrla6i;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RFGzXW63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768409705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+oKHdvfYj+ft1jbrQZBk0MFtiAA59hmPvW9Exn7ZpE=;
 b=ZOwrla6izy1e+uqPj7saR97+TTI7ruH7eFC1v5zJ+vDn6SxbOIEKje+trDqA95ulblHjsI
 ba/pVzfN28b2b4zEvJrdJOdM1+CJG3dn8n+00R4Om5RP/Q4Gv42hRsiOubmuFGNm96ofgR
 f8yLlCrRSkNRtTW/jL6kZOhsWnL+iFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768409705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+oKHdvfYj+ft1jbrQZBk0MFtiAA59hmPvW9Exn7ZpE=;
 b=RFGzXW63Q2nacnet4itocu+aj9qtB28QVN3jv40oCizBqhimHlwL97t6uIf1OXGcZ41YK0
 Thr3rwgI9VmqH0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96FA63EA63;
 Wed, 14 Jan 2026 16:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SsSWI2nKZ2kPZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 16:55:05 +0000
Date: Wed, 14 Jan 2026 17:55:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vincent Chen <vincent.chen@sifive.com>
Message-ID: <20260114165500.GA427531@pevik>
References: <20260114101834.3397158-1-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260114101834.3397158-1-vincent.chen@sifive.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AF7235CE80
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] locking/lock_torture: accept optional "[debug]"
 in result string
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

Hi Vincent,

> lock_torture.sh parses the lock_torture result from dmesg by
> matching the "End of test: <RESULT>:" line.

> When the kernel is built with lock debugging enabled (e.g.
> CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_RT_MUTEXES, CONFIG_DEBUG_SPINLOCK),
> lock_torture may print "End of test: SUCCESS [debug]: ...".
> The current regexp expects "SUCCESS:" and fails to match, causing the
> test to be reported as failure.

> Allow an optional " [debug]" token between the result string and the
> colon so the test can correctly detect SUCCESS on debug kernels.

Indeed:

torture_type, tag, cxt.debug_lock ? " [debug]": "", [1]
based on config you mentioned [2].

Thanks, merged!

Kind regards,
Petr

[1] https://elixir.bootlin.com/linux/v6.19-rc5/source/kernel/locking/locktorture.c#L1103
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/kernel/locking/locktorture.c#L1279

> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> ---
>  testcases/kernel/device-drivers/locking/lock_torture.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/device-drivers/locking/lock_torture.sh b/testcases/kernel/device-drivers/locking/lock_torture.sh
> index dfa57373f..d9bd95da2 100755
> --- a/testcases/kernel/device-drivers/locking/lock_torture.sh
> +++ b/testcases/kernel/device-drivers/locking/lock_torture.sh
> @@ -83,7 +83,7 @@ for type in $lock_type; do
>  		tst_brkm TBROK "failed to unload module"

>  	# check module status in dmesg
> -	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
> +	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+)([[:space:]]+\[debug\])?:.*/\1/p'`
>  	if [ "$result_str" = "SUCCESS" ]; then
>  		tst_resm TPASS "$type: completed"
>  	else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
