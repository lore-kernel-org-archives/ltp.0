Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BD4C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94AC73C7C33
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:33:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1FD3C2165
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:33:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BAD7A680E4E
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:33:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C694D2118C
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737117197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIjzrK8ZT6fhEiA+lb9JygJegk0EQuoa+94H1Os1IOg=;
 b=A6++6v9dXdxXrBVqPnJ1ynMmBJAbqifcnQ43iEkdUmFaNMHAr6D5/RtbCtiura/Kub3Glf
 hYJF2MJ/I9QKNxLLSu96xi6ZQs1nzc35zzkUW89q32eS/oU3mGrTDuT0SzeGOceCsxXsVS
 ULze3z84OhMncGSnxCq8v4q1qEVL/6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737117197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIjzrK8ZT6fhEiA+lb9JygJegk0EQuoa+94H1Os1IOg=;
 b=veItb0WV9JpW/ZscnbR0H2fsUdeIPGyDifBV9VcJ5PmVlIDlsn6rv5MYDkqkLhYIvREAcM
 HIn3eAQ8ZbX+EpDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737117197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIjzrK8ZT6fhEiA+lb9JygJegk0EQuoa+94H1Os1IOg=;
 b=A6++6v9dXdxXrBVqPnJ1ynMmBJAbqifcnQ43iEkdUmFaNMHAr6D5/RtbCtiura/Kub3Glf
 hYJF2MJ/I9QKNxLLSu96xi6ZQs1nzc35zzkUW89q32eS/oU3mGrTDuT0SzeGOceCsxXsVS
 ULze3z84OhMncGSnxCq8v4q1qEVL/6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737117197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIjzrK8ZT6fhEiA+lb9JygJegk0EQuoa+94H1Os1IOg=;
 b=veItb0WV9JpW/ZscnbR0H2fsUdeIPGyDifBV9VcJ5PmVlIDlsn6rv5MYDkqkLhYIvREAcM
 HIn3eAQ8ZbX+EpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF44313332
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KySEKQ1OimdSZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:33:17 +0000
Date: Fri, 17 Jan 2025 13:33:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Z4pOAZJATd73M02O@yuki.lan>
References: <20250117122455.7989-1-chrubis@suse.cz>
 <20250117122455.7989-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117122455.7989-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] testcases/lib: tst_net.sh: Do not use stderr
 in tst_rhost_run()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This is another place that broke the network test on the unrelated
> changes that caused the SAFE_CLONE() to produce TINFO messages. The test
> library prints messages into the stdout, because this is something that
                                      ^
				      stderr

> is not supposed to be the command output but rather diagnostic messages.
> So there was no good reason to include the stderr in the data we got
> from the tst_rhost_run().
> 
> If this patch does not break anything it should be pushed since this
> will fix the tst_ns_* helpers even if the they start print diagnostics
> TINFO messages again.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index ee0ae1cad..60bc25b79 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -257,7 +257,7 @@ tst_rhost_run()
>  		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
>  	fi
>  
> -	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
> +	output=$($rcmd "$sh_cmd" $out || echo 'RTERR')
>  
>  	echo "$output" | grep -q 'RTERR$' && ret=1
>  	if [ $ret -eq 1 ]; then
> -- 
> 2.45.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
