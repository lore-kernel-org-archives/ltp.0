Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9E4E77184
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 21:48:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEAF43ECFD3
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 22:48:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B253ECF43
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:48:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EDF121FC25
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:48:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 072821F396;
 Tue, 17 Dec 2024 21:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734472085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TX/lko8IDk0iIHsTkMf3j6VDZ7ccjUj8TcXhIkXHxt4=;
 b=OVyr28l1r8gN20XrTGOGlzP/zvZ7b0RGSJB2XCMX/eQvd39ALkJHOH/wNahaHIunTZGxb4
 d/K4lXwD6NcKhPFsLb/hlTeMRcv10oC9vw9Y6s6byPnPfkqvCSHCdzAnxpxSOU6VoBG5vg
 7hJT+nWOXuH1FelHQsY9l9g4HA3Lxlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734472085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TX/lko8IDk0iIHsTkMf3j6VDZ7ccjUj8TcXhIkXHxt4=;
 b=uD9eLIwf+em2TKtDQGnSUme7OsqcOpMldMkl3AnnuLLRFAAqMVKK/CricfBaME6uVGM2gH
 xRIFU3jv5UWJ9rAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OVyr28l1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uD9eLIwf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734472085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TX/lko8IDk0iIHsTkMf3j6VDZ7ccjUj8TcXhIkXHxt4=;
 b=OVyr28l1r8gN20XrTGOGlzP/zvZ7b0RGSJB2XCMX/eQvd39ALkJHOH/wNahaHIunTZGxb4
 d/K4lXwD6NcKhPFsLb/hlTeMRcv10oC9vw9Y6s6byPnPfkqvCSHCdzAnxpxSOU6VoBG5vg
 7hJT+nWOXuH1FelHQsY9l9g4HA3Lxlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734472085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TX/lko8IDk0iIHsTkMf3j6VDZ7ccjUj8TcXhIkXHxt4=;
 b=uD9eLIwf+em2TKtDQGnSUme7OsqcOpMldMkl3AnnuLLRFAAqMVKK/CricfBaME6uVGM2gH
 xRIFU3jv5UWJ9rAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDDBB13A3C;
 Tue, 17 Dec 2024 21:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qg8TMJTxYWcUEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 21:48:04 +0000
Date: Tue, 17 Dec 2024 22:48:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Message-ID: <20241217214803.GC29863@pevik>
References: <20241120005926.1644064-1-zhaomzhao@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241120005926.1644064-1-zhaomzhao@126.com>
X-Rspamd-Queue-Id: 072821F396
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[126.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[126.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: Add backslash to dump full
 fail log
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

Hi Zhao Mengmeng,

> While debugging LTP cpuset_load_balance_test, when rmdir a path failed,
> it only dumps part of the log, missing the $subdir. Add backslash to fix
> it.

+1 good catch.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
>  testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> index 567178e3fd52..a374fd71f790 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
> @@ -195,7 +195,7 @@ cleanup()
>  		done < "$subdir/tasks"
>  		rmdir "$subdir"
>  		if [ $? -ne 0 ]; then
> -			tst_brkm TFAIL "Couldn't remove subdir - "
> +			tst_brkm TFAIL "Couldn't remove subdir - "\
>  						"$subdir in the cpuset"

Could we please just join the string?
			tst_brkm TFAIL "Couldn't remove subdir - $subdir in the cpuset"

Kind regards,
Petr

>  		fi
>  	done

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
