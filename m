Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5333C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 23:16:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A7843D048F
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 01:16:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840133CDEBC
 for <ltp@lists.linux.it>; Tue, 28 May 2024 01:16:41 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D2F1200937
 for <ltp@lists.linux.it>; Tue, 28 May 2024 01:16:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9590A1FFE6;
 Mon, 27 May 2024 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716851798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5ubaoMlM2mtPJ3ZuNyCFTUWWSbXYqqI0ypBotfGG+Q=;
 b=T4Rhdd15eMVUjvfzFQ3R5iVrhPwlhUQQo1h4tAnknEZPZQ8N/pTbL8H0FZTywqqcz/WBh6
 Lgx7H6JYFN5tThgew9+teVgYz20DwjzVWw2MEu+9wfdTXFNf4vUR+hda76e9hJYOJNW2ML
 kMn/rcehpo8Mgf8und2WWO+i5W3aRf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716851798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5ubaoMlM2mtPJ3ZuNyCFTUWWSbXYqqI0ypBotfGG+Q=;
 b=Isr83eyCWrg+Kw/lSTq4A3g0DnhtfNTg5gWIDLAujWaKHg5tGwLls0lql9erRrlCQKs6bk
 3rQvTP01OyzaAjDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716851798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5ubaoMlM2mtPJ3ZuNyCFTUWWSbXYqqI0ypBotfGG+Q=;
 b=T4Rhdd15eMVUjvfzFQ3R5iVrhPwlhUQQo1h4tAnknEZPZQ8N/pTbL8H0FZTywqqcz/WBh6
 Lgx7H6JYFN5tThgew9+teVgYz20DwjzVWw2MEu+9wfdTXFNf4vUR+hda76e9hJYOJNW2ML
 kMn/rcehpo8Mgf8und2WWO+i5W3aRf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716851798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5ubaoMlM2mtPJ3ZuNyCFTUWWSbXYqqI0ypBotfGG+Q=;
 b=Isr83eyCWrg+Kw/lSTq4A3g0DnhtfNTg5gWIDLAujWaKHg5tGwLls0lql9erRrlCQKs6bk
 3rQvTP01OyzaAjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B67013A56;
 Mon, 27 May 2024 23:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WbXOE1YUVWYoEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 23:16:38 +0000
Date: Tue, 28 May 2024 01:16:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240527231636.GA375669@pevik>
References: <20240522124754.9599-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240522124754.9599-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] msync04: Check disk content if dirty bit check
 failed
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan, Wei,

> msync04 test is inherently racy and nothing guarantees that the page
> is not written out before get_dirty_page() manages to read the page state.
> Hence the test should be reworked to verify the page contents is on disk
> when it finds dirty bit isn't set anymore...

@Jan some time ago [1] you asked to:

	mmap file, write to mmap, msync, abort fs, mount fs again, check the data is
	there.

Could you please have a look if this is enough? Or is it aborting fs and mounting
again necessary?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220125121746.wrs4254pfs2mwexb@quack3.lan/

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/msync/msync04.c | 34 ++++++++++++++---------
>  1 file changed, 21 insertions(+), 13 deletions(-)

> diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
> index 72ddc27a4..c296c8b20 100644
> --- a/testcases/kernel/syscalls/msync/msync04.c
> +++ b/testcases/kernel/syscalls/msync/msync04.c
> @@ -46,6 +46,7 @@ uint64_t get_dirty_bit(void *data)
>  static void test_msync(void)
>  {
>  	uint64_t dirty;
> +	char buffer[20];

>  	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
>  		0644);
> @@ -56,20 +57,27 @@ static void test_msync(void)
>  	mmaped_area[8] = 'B';
>  	dirty = get_dirty_bit(mmaped_area);
>  	if (!dirty) {
> -		tst_res(TFAIL, "Expected dirty bit to be set after writing to"
> -				" mmap()-ed area");
> -		goto clean;
> -	}
> -	if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> -		tst_res(TFAIL | TERRNO, "msync() failed");
> -		goto clean;
> +		tst_res(TINFO, "Not see dirty bit so we check content of file instead");
> +		test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY);
> +		SAFE_READ(0, test_fd, buffer, 9);
> +		if (buffer[8] == 'B')
> +			tst_res(TCONF, "write file ok but msync couldn't be tested"
> +				" because the storage was written to too quickly");
> +		else
> +			tst_res(TFAIL, "write file failed");
> +	} else {
> +		if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> +			tst_res(TFAIL | TERRNO, "msync() failed");
> +			goto clean;
> +		}
> +		dirty = get_dirty_bit(mmaped_area);
> +		if (dirty)
> +			tst_res(TFAIL, "msync() failed to write dirty page despite"
> +					" succeeding");
> +		else
> +			tst_res(TPASS, "msync() working correctly");
> +
>  	}
> -	dirty = get_dirty_bit(mmaped_area);
> -	if (dirty)
> -		tst_res(TFAIL, "msync() failed to write dirty page despite"
> -				" succeeding");
> -	else
> -		tst_res(TPASS, "msync() working correctly");

>  clean:
>  	SAFE_MUNMAP(mmaped_area, pagesize);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
