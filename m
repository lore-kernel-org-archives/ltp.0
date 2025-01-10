Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A985AE77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 15:25:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDFF63C4C71
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 16:25:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247E83C3079
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 16:24:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72E4C644A16
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 16:24:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBD231F37C;
 Fri, 10 Jan 2025 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736522690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sOM/2HJTb4lwzXEbNfK1oDEU4DmL7HK7+xgk3WFqiTY=;
 b=3KmcOvt2l7m2c+t4WQpWtgyYq7eEu/M6GlKjkftqVgrwPavgj+GA3L51keWmkgq0w0GHUE
 fh15/zSMeNUFxirfUeCYyunVcWy6zJfMR/6lF/3TtvJFmPW/LO+tliY0mwTHYgKiPButPZ
 yR3rRY7F7K8DMypo11OO9mE/e+8Tu24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736522690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sOM/2HJTb4lwzXEbNfK1oDEU4DmL7HK7+xgk3WFqiTY=;
 b=8yHUqGIpNDw4ljSBdX31yRbdsm1t98tBeYZ6/K/NM+csBVMmEs1oAjl9jEHCAZK0dFrcnn
 uGyosStYz5AY8dBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3KmcOvt2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8yHUqGIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736522690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sOM/2HJTb4lwzXEbNfK1oDEU4DmL7HK7+xgk3WFqiTY=;
 b=3KmcOvt2l7m2c+t4WQpWtgyYq7eEu/M6GlKjkftqVgrwPavgj+GA3L51keWmkgq0w0GHUE
 fh15/zSMeNUFxirfUeCYyunVcWy6zJfMR/6lF/3TtvJFmPW/LO+tliY0mwTHYgKiPButPZ
 yR3rRY7F7K8DMypo11OO9mE/e+8Tu24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736522690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sOM/2HJTb4lwzXEbNfK1oDEU4DmL7HK7+xgk3WFqiTY=;
 b=8yHUqGIpNDw4ljSBdX31yRbdsm1t98tBeYZ6/K/NM+csBVMmEs1oAjl9jEHCAZK0dFrcnn
 uGyosStYz5AY8dBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC09C13763;
 Fri, 10 Jan 2025 15:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KGNDKcI7gWdVBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jan 2025 15:24:50 +0000
Date: Fri, 10 Jan 2025 16:24:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z4E7rp-4x0LRay2H@yuki.lan>
References: <20250109130032.50480-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109130032.50480-1-liwang@redhat.com>
X-Rspamd-Queue-Id: BBD231F37C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Notes:
>     Changes V2 --> V3:
>     	* Improve timeout description based on Cyril's suggestion
>     	* Move .runtime to .timeout for some tests (fsplough, ksm02, ksm04)
>     	* Drop the changes on shell test test_timeout.sh
>     	* Squash tst_set_timeout and set_mempolicy01 patches into the first one
>     	* Double the duration of a single test iteration on an RPi4 and use that
>     	  value to set .timeout for readahead02 test

Here you say timeout

> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index a109573fe..412784dbb 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -318,19 +318,6 @@ static void test_readahead(unsigned int n)
>  		tst_res(TCONF, "Page cache on your system is too small "
>  			"to hold whole testfile.");
>  	}
> -
> -	/*
> -	 * The time consuming of readahead quite depending on the platform IO
> -	 * speed, sometime test timeout when the default max_runtime is used up.
> -	 *
> -	 *  readahead02.c:221: TINFO: Test #2: POSIX_FADV_WILLNEED on file
> -	 *  readahead02.c:285: TINFO: read_testfile(0) took: 26317623 usec
> -	 *  readahead02.c:286: TINFO: read_testfile(1) took: 26101484 usec
> -	 *
> -	 * Here raise the maximum runtime dynamically.
> -	 */
> -	if ((tc+1)->readahead)
> -		tst_set_max_runtime(test.max_runtime + (usec + usec_ra) / 1000000);
>  }
>  
>  
> @@ -381,7 +368,7 @@ static void setup(void)
>  {
>  	if (opt_fsizestr) {
>  		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
> -		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> +		tst_set_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
>  	}
>  
>  	if (access(PROC_IO_FNAME, F_OK))
> @@ -422,7 +409,7 @@ static struct tst_test test = {
>  	},
>  	.test = test_readahead,
>  	.tcnt = ARRAY_SIZE(tcases),
> -	.max_runtime = 30,
> +	.runtime = 60,

But you actually set runtime instead.

>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "b833a3660394"},
>  		{"linux-git", "5b910bd615ba"},


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
