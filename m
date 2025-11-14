Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A5CDE03C
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 08:54:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6D6E3CF811
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 09:54:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6AFD3CF384
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:53:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D9E81400DF4
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:53:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8159D1F391;
 Fri, 14 Nov 2025 08:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjBKKxYBctAljdaVbrw+OXDg1VEY355CeTddKCsB5nA=;
 b=nB+tecVpMSKqOaU9zxdmPQipN2V0LWrCtVcpxTbER2eB95h5X/ITwvsLXKgo5XsWj5cGUW
 q2NxRSciMzPiTEub7DzcrWOdGcYfjFdnoxVf15JIpKdWgkN75Aufi5n7LD0UqPbgNY3zb9
 6QwIH/HdeiBIrSt0dU0/BTZ5BZ+6RnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjBKKxYBctAljdaVbrw+OXDg1VEY355CeTddKCsB5nA=;
 b=Mjldn1Q0nD+4MoHsKMkzLgJ0HeamVCYtgOeBwdxGYx3jXsXDTN67UcpJDRGa/TcEXDS6Sh
 3nFPJZfYqgPWw1DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nB+tecVp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Mjldn1Q0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763110422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjBKKxYBctAljdaVbrw+OXDg1VEY355CeTddKCsB5nA=;
 b=nB+tecVpMSKqOaU9zxdmPQipN2V0LWrCtVcpxTbER2eB95h5X/ITwvsLXKgo5XsWj5cGUW
 q2NxRSciMzPiTEub7DzcrWOdGcYfjFdnoxVf15JIpKdWgkN75Aufi5n7LD0UqPbgNY3zb9
 6QwIH/HdeiBIrSt0dU0/BTZ5BZ+6RnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763110422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjBKKxYBctAljdaVbrw+OXDg1VEY355CeTddKCsB5nA=;
 b=Mjldn1Q0nD+4MoHsKMkzLgJ0HeamVCYtgOeBwdxGYx3jXsXDTN67UcpJDRGa/TcEXDS6Sh
 3nFPJZfYqgPWw1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7768B3EA61;
 Fri, 14 Nov 2025 08:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hb2zHBbuFmlwMAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 14 Nov 2025 08:53:42 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Nov 2025 09:53:42 +0100
Message-ID: <1937268.tdWV9SEqCh@thinkpad>
In-Reply-To: <20251107102939.1111074-4-pvorel@suse.cz>
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-4-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8159D1F391
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.de:dkim]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/8] tst_test.c: Change check_kver() return type
 to bool
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Friday, November 7, 2025 11:29:34 AM CET Petr Vorel wrote:
> Also change the value (0 becomes true), add docs (don't use kerneldoc as
> this is a internal function which does not need to be in LTP online doc).
nit: 
s/a internal/an internal
(also applies in Patch 4)

> 
> While at it, add missing static.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  lib/tst_test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index bda66c4672..1725844b54 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1056,7 +1056,12 @@ static void do_exit(int ret)
>  	exit(ret);
>  }
>  
> -int check_kver(const char *min_kver, const int brk_nosupp)
> +/*
> + * Check for the required kernel version.
> + *
> + * return: true if the kernel version is high enough, false otherwise.
> + */
> +static bool check_kver(const char *min_kver, const int brk_nosupp)
>  {
>  	char *msg;
>  	int v1, v2, v3;
> @@ -1075,10 +1080,10 @@ int check_kver(const char *min_kver, const int brk_nosupp)
>  		else
>  			tst_res(TCONF, msg, min_kver);
>  
> -		return 1;
> +		return false;
>  	}
>  
> -	return 0;
> +	return true;
>  }
>  
>  static int results_equal(struct results *a, struct results *b)
> @@ -1963,7 +1968,7 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
>  		return TCONF;
>  
> -	if (fs->min_kver && check_kver(fs->min_kver, 0))
> +	if (fs->min_kver && !check_kver(fs->min_kver, 0))
>  		return TCONF;
>  
>  	prepare_device(fs);
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
