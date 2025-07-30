Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7ADC87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 07:53:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 554663CAE4D
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 09:53:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B56E33CA14E
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 09:53:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF4872009DC
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 09:53:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1296321995;
 Wed, 30 Jul 2025 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753861981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kkfx5twkT0QiJZRnHVfee1/WoL9YAnNAaLP7HEOoSA=;
 b=daD9DwwgowBdyU1g3Ee546JuOs3rvCWjmaI8CESlUW4cdZ/tgGrSBEfrL/y00BBcaFzuK5
 Ri0M4EvHltTk4qtkXH1+HYBQ0yF/AudXhRW1LkhqqEfCipWfOKN4C4Cayuwb/umK7URU3l
 0SG2c7ADMJSXKtylfYyo/zy4mcm5NVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753861981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kkfx5twkT0QiJZRnHVfee1/WoL9YAnNAaLP7HEOoSA=;
 b=6PP7B8sYT3MoDmeRm4XkMFxJicqJsDLYkTfWOEcivHKZNXp6W92gI5vQ0AM4gAL2G4a4lw
 asZzoJ5ufixTqxDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fVhS8/6o";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="gK03/61U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753861980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kkfx5twkT0QiJZRnHVfee1/WoL9YAnNAaLP7HEOoSA=;
 b=fVhS8/6oSz5vWP0DgW70fASxZ6gX1G7sqvafRrOfNSVaSWVby63nRyVIFxoXwyXpUIu3DE
 9cNkm7h4bDJ2ivJLxTT9xR0TWlzhpkSQJHJ9cQ7dghO6H5K7LxfAYo4yNkVmVru9Z/L5l5
 6wYkRcDgxklmmO+28v115djto1jvYio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753861980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kkfx5twkT0QiJZRnHVfee1/WoL9YAnNAaLP7HEOoSA=;
 b=gK03/61UfSNVQ/tS+fVYIza+NPktWJAuJvBjvPF4J+wIRij4Pi6IZRtAmPQQhJwzGHGvCr
 P9RNAiuJ6gcMzeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF8D313942;
 Wed, 30 Jul 2025 07:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GdqnLVvPiWjlSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Jul 2025 07:52:59 +0000
Date: Wed, 30 Jul 2025 09:52:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ben Copeland <ben.copeland@linaro.org>
Message-ID: <20250730075254.GA50561@pevik>
References: <20250730071342.817400-1-ben.copeland@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250730071342.817400-1-ben.copeland@linaro.org>
X-Rspamd-Queue-Id: 1296321995
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] vma05: Fix false positives from stripped
 system libraries
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ben,

> The vma05 test was producing false positive failures by flagging any
> "??" symbols in gdb backtraces as vDSO kernel bugs, including those
> from normal stripped system libraries.

> This caused widespread false failures in production environments where
> system libraries like libc.so.6 are typically stripped of debug symbols.

> The fix filters out "??" symbols that originate from system libraries
> (paths containing "/lib/" or "/usr/lib/") while still detecting genuine
> unresolved symbols in application code that could indicate real vDSO bugs.

Sounds reasonable, but I would prefer Cyril or Jan acked this.

> Signed-off-by: Ben Copeland <ben.copeland@linaro.org>
> ---
>  testcases/kernel/mem/vma/vma05.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> index c560eecbc..09757a0fe 100755
> --- a/testcases/kernel/mem/vma/vma05.sh
> +++ b/testcases/kernel/mem/vma/vma05.sh
> @@ -64,11 +64,14 @@ tst_test()
>  	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
>  		vma05_vdso ./core* 2> /dev/null)

> -	if echo "$TRACE" | grep -qF "??"; then
> -		tst_res TFAIL "[vdso] bug not patched"
> +	# Only check for ?? symbols in application code, not system libraries
> +	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v "from /lib/" | grep -v "from /usr/lib/")
You can pass more regexes to grep to save one pipe:

	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v -e "from /lib/" -e "from /usr/lib/")

(or have single more complicated regexp).

> +	if [ -n "$APP_UNKNOWN" ]; then
> +		tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
>  	else
>  		tst_res TPASS "[vdso] backtrace complete"
>  	fi
> +	fi

Suggested changes.

With that you can add:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

+++ testcases/kernel/mem/vma/vma05.sh
@@ -65,13 +65,12 @@ tst_test()
 		vma05_vdso ./core* 2> /dev/null)
 
 	# Only check for ?? symbols in application code, not system libraries
-	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v "from /lib/" | grep -v "from /usr/lib/")
+	APP_UNKNOWN=$(echo "$TRACE" | grep -F "??" | grep -v -e "from /lib/" -e "from /usr/lib/")
 	if [ -n "$APP_UNKNOWN" ]; then
 		tst_res TFAIL "[vdso] bug not patched - unknown symbols in application code"
 	else
 		tst_res TPASS "[vdso] backtrace complete"
 	fi
-	fi
 }
 
 . tst_run.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
