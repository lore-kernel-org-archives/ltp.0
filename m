Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D90FC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:09:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 988073CF965
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:09:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 111F53CB8E6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:09:40 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E97220173D
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:09:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5945B21F9D;
 Tue, 30 Jan 2024 12:09:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B9C613A66;
 Tue, 30 Jan 2024 12:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EURMDgPnuGXySgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jan 2024 12:09:39 +0000
Date: Tue, 30 Jan 2024 13:09:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZbjnEzmW0RvxWhg9@yuki>
References: <20240130103319.22763-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130103319.22763-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5945B21F9D
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix dio_append/aiodio_append tests
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

Hi!
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index 057ae73d9..bd48a8252 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -33,7 +33,7 @@ static void setup(void)
>  {
>  	numchildren = 16;
>  	writesize = 64 * 1024;
> -	appends = 1000;
> +	appends = 10000;

Since we are increasing this we should probably check the free space as
well, so we should add something as:

	if (!tst_fs_has_free(".", appends, writesize))
		tst_brk(TCONF, "Not enough space to run the test");

Or even better put a function:

void tst_assert_free_space(const char *path, unsigned int size, unsigned int mult)

into the test library and this function would tst_brk(TCONF, ) if there
is not enough space and tst_res(TWARN, ) if the free space is let's say
only 10% more than the test would need to run. And we can use that in
all of these tests.

>  	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
> @@ -97,7 +97,7 @@ static struct tst_test test = {
>  	.options = (struct tst_option[]) {
>  		{"n:", &str_numchildren, "Number of processes (default 16)"},
>  		{"w:", &str_writesize, "Write size for each append (default 64K)"},
> -		{"c:", &str_appends, "Number of appends (default 1000)"},
> +		{"c:", &str_appends, "Number of appends (default 10000)"},
>  		{}
>  	},
>  	.skip_filesystems = (const char *[]) {
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
