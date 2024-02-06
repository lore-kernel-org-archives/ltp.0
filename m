Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D3C48297
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 12:38:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 356623CF5DF
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 13:38:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50FF3C8921
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 13:38:10 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02A0B200A04
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 13:38:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B05F71FB7A;
 Tue,  6 Feb 2024 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707223088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7FyjbQzWMAYz6r3vTpBanbQzJ3OrYv5Y2SG+4IycvY=;
 b=ZDQp8MZ0h1O+k3QRVO+MtU/ByiwBNzmyO2ty6nl+aK48k6nQRJMAfbqFMzgj60pqapWE0B
 df977tSVHkW7gQ7zoGHBF19p84PIUzRhmHeuDuDxIER8AhuFi1181jENoQhxXWqGDdzPtf
 Djbb0iyUPnE4j1+SSqQrlJ/+MTbJ9LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707223088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7FyjbQzWMAYz6r3vTpBanbQzJ3OrYv5Y2SG+4IycvY=;
 b=+LHUtPtk0G+bBVd2uiWl6sf1o48UNt6zg9AMnf2sA9FakVCUj8xyh1FuqwwK6bI2AdZe7l
 E/NFuGqZQodwirCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707223088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7FyjbQzWMAYz6r3vTpBanbQzJ3OrYv5Y2SG+4IycvY=;
 b=ZDQp8MZ0h1O+k3QRVO+MtU/ByiwBNzmyO2ty6nl+aK48k6nQRJMAfbqFMzgj60pqapWE0B
 df977tSVHkW7gQ7zoGHBF19p84PIUzRhmHeuDuDxIER8AhuFi1181jENoQhxXWqGDdzPtf
 Djbb0iyUPnE4j1+SSqQrlJ/+MTbJ9LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707223088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7FyjbQzWMAYz6r3vTpBanbQzJ3OrYv5Y2SG+4IycvY=;
 b=+LHUtPtk0G+bBVd2uiWl6sf1o48UNt6zg9AMnf2sA9FakVCUj8xyh1FuqwwK6bI2AdZe7l
 E/NFuGqZQodwirCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86E87139D8;
 Tue,  6 Feb 2024 12:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eUsAHzAowmXTLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 12:38:08 +0000
Date: Tue, 6 Feb 2024 13:38:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240206123807.GA292190@pevik>
References: <20231026144812.6786-1-wegao@suse.com>
 <20231027010528.12330-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231027010528.12330-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZDQp8MZ0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+LHUtPtk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: B05F71FB7A
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pwritev201: Add check for RWF_APPEND
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

according to man readv(2) RWF_APPEND was added in kernel 4.16 (to <linux/fs.h>,
thus this fails openSUSE Leap 42.2 [1], we would need to add this to LAPI
include/lapi/fs.h (as a separate patch) and use it in the test.

It also fails for the same reason on MUSL, which does not include <linux/fs.h>,
I suppose adding <linux/fs.h> to the test would fix it on MUSL, which would be
solved by previous change (because include/lapi/fs.h already includes
<linux/fs.h>).

[1] https://github.com/pevik/ltp/actions/runs/7799206926/job/21269505359
[2] https://github.com/pevik/ltp/actions/runs/7799206926/job/21269504848

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../kernel/syscalls/pwritev2/pwritev201.c     | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

> diff --git a/testcases/kernel/syscalls/pwritev2/pwritev201.c b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> index eba45b7d3..1494e2925 100644
> --- a/testcases/kernel/syscalls/pwritev2/pwritev201.c
> +++ b/testcases/kernel/syscalls/pwritev2/pwritev201.c
> @@ -39,13 +39,15 @@ static struct tcase {
>  	off_t write_off;
>  	ssize_t size;
>  	off_t exp_off;
> +	int flag;
>  } tcases[] = {
> -	{0,     1, 0,          CHUNK, 0},
> -	{CHUNK, 2, 0,          CHUNK, CHUNK},
> -	{0,     1, CHUNK / 2,  CHUNK, 0},
> -	{0,     1, -1,         CHUNK, CHUNK},
> -	{0,     2, -1,         CHUNK, CHUNK},
> -	{CHUNK, 1, -1,         CHUNK, CHUNK * 2},
> +	{0,     1, 0,          CHUNK, 0, 0},
> +	{CHUNK, 2, 0,          CHUNK, CHUNK, 0},
> +	{0,     1, CHUNK / 2,  CHUNK, 0, 0},
> +	{0,     1, -1,         CHUNK, CHUNK, 0},
> +	{0,     2, -1,         CHUNK, CHUNK, 0},
> +	{CHUNK, 1, -1,         CHUNK, CHUNK * 2, 0},
> +	{CHUNK, 1, -1,         CHUNK, CHUNK * 3, RWF_APPEND},

I wonder how hard would be to cover more flags (man mentions 4 other flags).
But on a first look only RWF_APPEND looks to be easy to be added (if
complicated, it's probably better to have a separate test for them).

Also, while at it, maybe:

	TST_EXP_FD_SILENT(pwritev2(fd, wr_iovec, tc->count, tc->write_off, 0));
	if (!TST_PASS)
		return;

instead of:

	TEST(pwritev2(fd, wr_iovec, tc->count - 1, tc->write_off, 0));
	if (TST_RET < 0) {
		tst_res(TFAIL | TTERRNO, "pwritev2() failed");
		return;
	}

Kind regards,
Petr

>  };

>  static void verify_pwritev2(unsigned int n)
> @@ -57,7 +59,7 @@ static void verify_pwritev2(unsigned int n)
>  	SAFE_PWRITE(1, fd, initbuf, sizeof(initbuf), 0);
>  	SAFE_LSEEK(fd, tc->seek_off, SEEK_SET);

> -	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, 0));
> +	TEST(pwritev2(fd, wr_iovec, tc->count, tc->write_off, tc->flag));
>  	if (TST_RET < 0) {
>  		tst_res(TFAIL | TTERRNO, "pwritev2() failed");
>  		return;
> @@ -76,7 +78,9 @@ static void verify_pwritev2(unsigned int n)

>  	memset(preadbuf, 0, CHUNK);

> -	if (tc->write_off != -1)
> +	if (tc->flag == RWF_APPEND)
> +		SAFE_PREAD(1, fd, preadbuf, tc->size, sizeof(initbuf));
> +	else if (tc->write_off != -1)
>  		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->write_off);
>  	else
>  		SAFE_PREAD(1, fd, preadbuf, tc->size, tc->seek_off);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
