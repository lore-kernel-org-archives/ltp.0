Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3C7C25B7C
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 23:18:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 499C83D03EE
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 01:18:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFF8A3CDEBC
 for <ltp@lists.linux.it>; Tue, 28 May 2024 01:18:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B7901400261
 for <ltp@lists.linux.it>; Tue, 28 May 2024 01:18:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6894621BA3;
 Mon, 27 May 2024 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716851898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0BjRYyXTPhTk3DF83/iBWNisVOGjn27Cm6VKf4m2uI=;
 b=faLk9XJ/QP1CDR75e/oK53BQAZUonQjpokIuUCbvrxsPmH/oThbbjo4SJRiYy26KG3wGQ1
 VK0mCMaa6X0iWq1zaxDhA8kGNyRHeWhe9GswnMXgWLHMvh6d9CScv9o9Fg0auwz1HYJvPt
 D932+81fi8tPPResz6MBSMqRjSylhGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716851898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0BjRYyXTPhTk3DF83/iBWNisVOGjn27Cm6VKf4m2uI=;
 b=mi45sTgqE//lmmqt6XsXz+vopL3XuGakaX6qsSF6rWqBDn+bkgtBa7NcxZ8wQfUoVpZqcc
 B3XS9/WbXu3wj6BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uLLTbndR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dFs1YqQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716851897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0BjRYyXTPhTk3DF83/iBWNisVOGjn27Cm6VKf4m2uI=;
 b=uLLTbndRgEm3FvlKXfC+66CCBIAT/fOKojVPM3Rwrf5ZzXUpsv92ZoHvU32ouDNF5gwsMl
 7Hhtxd6LQ9iFhWNVZg+ORm+YlF3YLJ2ZA7RtLTxuo/ItfFpoHg9FKtbnSMlTc49CJjDft2
 ReovVPM5bF7AenAiBJLV/yt5EOnSPzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716851897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0BjRYyXTPhTk3DF83/iBWNisVOGjn27Cm6VKf4m2uI=;
 b=dFs1YqQGNSbCOa/zEj2dJpKpaW7aJio0nFSjc/UO0uLJdVQjxWduDOJyg3N7m7Jtr5bgtK
 UnSsDz/ScAnITqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F7213A56;
 Mon, 27 May 2024 23:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NJElObgUVWZ4MQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 23:18:16 +0000
Date: Tue, 28 May 2024 01:18:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240527231807.GB375669@pevik>
References: <20240522124754.9599-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240522124754.9599-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,suse.cz:email,suse.com:url,suse.com:email];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6894621BA3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> msync04 test is inherently racy and nothing guarantees that the page
> is not written out before get_dirty_page() manages to read the page state.
> Hence the test should be reworked to verify the page contents is on disk
> when it finds dirty bit isn't set anymore...

It's nice habit to add Jan's credit :)

He did it [1], thus one would add:
Suggested-by: Jan Kara <jack@suse.cz>

+ Add a ticket:
Implements: https://github.com/linux-test-project/ltp/issues/1157

[1] https://bugzilla.suse.com/show_bug.cgi?id=1224201#c13
[2] https://lore.kernel.org/ltp/20220125121746.wrs4254pfs2mwexb@quack3.lan/

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
While at it, could you please remove dirty variable and use get_dirty_bit(...)
directly?

> +	char buffer[20];

>  	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR,
>  		0644);
> @@ -56,20 +57,27 @@ static void test_msync(void)
>  	mmaped_area[8] = 'B';
>  	dirty = get_dirty_bit(mmaped_area);
>  	if (!dirty) {
 	if (!get_dirty_bit(mmaped_area)) {

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
I know you copy old code, but it would deserve to fix: -1 is failure, anything
different than 0 or -1 is invalid value.  And you get this for free if you use
TST_EXP_PASS_SILENT().

> +			goto clean;

nit: Having if and else part in it's own functions (verify_mmaped(),
verify_dirty() would allow to get rid of goto and produced slightly nicer code
(less indentation => less split lines):

	if (!get_dirty_bit(mmaped_area))
		verify_mmaped();
	else
		verify_dirty();

	SAFE_MUNMAP(mmaped_area, pagesize);
	mmaped_area = NULL;

> +		}
> +		dirty = get_dirty_bit(mmaped_area);
> +		if (dirty)
		if (get_dirty_bit(mmaped_area)) {

> +			tst_res(TFAIL, "msync() failed to write dirty page despite"
> +					" succeeding");
I would keep this string separate
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
