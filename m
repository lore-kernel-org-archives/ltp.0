Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC2FC3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 09:47:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2A123CC29A
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 11:47:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCD053C9AEC
 for <ltp@lists.linux.it>; Mon, 12 May 2025 11:47:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7472B60080A
 for <ltp@lists.linux.it>; Mon, 12 May 2025 11:47:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA64821168;
 Mon, 12 May 2025 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747043235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbsobqHLSE0HiIDF96ZtAG/5MsjZp1ktDufTWlLV53g=;
 b=daCvqi81jKQ5ToNmZxJ1zoqFM4x66zeJC5lK75QICPttF/9bUAblwA5XztMujsmOyJ895d
 SOcdZ/O3gx1CL0tKEYmRqAfouAh85YwWF4tmr7fhEAB3jSx7QgJsSAB1EJHXkuymQl1mhs
 uCRi/eak/vpSpVfWq9CQQqxWD4m3Sbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747043235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbsobqHLSE0HiIDF96ZtAG/5MsjZp1ktDufTWlLV53g=;
 b=vG7+kmTF/TsxNzeoT65ZvcO+wY7jKEeCRnPM8EovxsBI/LjCblSJfBPFE5nXAuHQ9tx505
 GztIdvcJaCodAABw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CCdt5STR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5Lq9X7Q9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747043234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbsobqHLSE0HiIDF96ZtAG/5MsjZp1ktDufTWlLV53g=;
 b=CCdt5STRUNVZo20z+vemfqrq59Gq9dXnEeeIDiwaxatAFST7XgZpMR9G9azr5UrZbsVJxj
 HBRzl87ccn5LiHhXRDurmbIVJvaz/iVpAe0YysCoHxZaig3WKK8XxJYmuC8tJHelrvkpQF
 xBl0tgOt+WnJUvX562POO6HRiswqiQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747043234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbsobqHLSE0HiIDF96ZtAG/5MsjZp1ktDufTWlLV53g=;
 b=5Lq9X7Q9jeHBjR7Fh6+dhs4C2PMwUiIiz+owFY5DPCrGMrUaWrbREk9T6mo712xywUPDk9
 NXn0IJdB/Zt4MiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E148B1397F;
 Mon, 12 May 2025 09:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJfDNqLDIWhEQAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 12 May 2025 09:47:14 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 May 2025 11:47:14 +0200
Message-ID: <4984431.GXAFRqVoOG@thinkpad>
In-Reply-To: <20250509092813.12860-1-chrubis@suse.cz>
References: <20250509092813.12860-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EA64821168
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Add reproducible output.
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>


On Friday, May 9, 2025 11:28:13 AM CEST Cyril Hrubis wrote:
> This commit adds an environment variable LTP_REPRODUCIBLE_OUTPUT that
> when set skips printing parts of the test messages that may contain data
> that differ on subsequent runs (e.g. pids).
> 
> With this you can run a test twice under a different conditions and
> check if the test codeflow was identical by simply doing diff of the
> outputs from the two runs.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> CC: valgrind-developers@lists.sourceforge.net
> ---
>  lib/tst_test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2bb4519dd..f14627544 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -64,6 +64,7 @@ static int mntpoint_mounted;
>  static int ovl_mounted;
>  static struct timespec tst_start_time; /* valid only for test pid */
>  static int tdebug;
> +static int reproducible_output;
>  
>  struct results {
>  	int passed;
> @@ -312,6 +313,9 @@ static void print_result(const char *file, const int lineno, int ttype,
>  	str += ret;
>  	size -= ret;
>  
> +	if (reproducible_output)
> +		goto print;
> +
>  	ssize = size - 2;
>  	ret = vsnprintf(str, size, fmt, va);
>  	str += MIN(ret, ssize);
> @@ -329,6 +333,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>  				"Next message is too long and truncated:");
>  	}
>  
> +print:
>  	snprintf(str, size, "\n");
>  
>  	/* we might be called from signal handler, so use write() */
> @@ -1312,6 +1317,8 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>  		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
>  
> +	reproducible_output = !!getenv("LTP_REPRODUCIBLE_OUTPUT");
> +
>  	assert_test_fn();
>  
>  	TCID = tid = get_tid(argv);
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
