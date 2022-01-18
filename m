Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A8C433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 13:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171F33C9685
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 14:00:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EAD63C94A9
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 14:00:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 931E8200773
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 14:00:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE50E21138;
 Tue, 18 Jan 2022 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642510823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkoHCRK+5btYMnPWkCeOyJTgVkabVOknJgAIhKXxBWY=;
 b=dSGuLscrMLDWwlJmGPgfQQD9OTK6pGEFu30ZTB65+kBFn0yxMUpfOBUPAq3f0JgZjMf4zC
 iKahjDCD8v/9rCfaUtu2pH47O4GlsWOjeHJj179WVO6h5i3kITBcfOoei0bGEsbK7H+RNA
 IKVq5rrfZ5gSSnyu6l2flckw5x+vp9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642510823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkoHCRK+5btYMnPWkCeOyJTgVkabVOknJgAIhKXxBWY=;
 b=G9Kc9pP0ST5USpwbzhKTChLw+oJPK7z5Vp6ac4umpv1KcNmLepP9jLd4jp6j0n40x4HXZM
 V9TaT31ZGLGmnsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8E6413A96;
 Tue, 18 Jan 2022 13:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FqMWLee55mFaBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jan 2022 13:00:23 +0000
Date: Tue, 18 Jan 2022 14:02:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yea6TuVuOlceWN0y@yuki>
References: <20220118105044.547-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220118105044.547-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce default number of threads in
 dio_sparse.c
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
> Initialized options out of setup and reduced default number of
> threads from 1000 to 16

I've added a bit more verbose descriptioin here about how the default
has changed and pushed, thanks.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 929adbfba..8635df82f 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -33,11 +33,11 @@ static char *str_writesize;
>  static char *str_filesize;
>  static char *str_offset;
>  
> -static int numchildren;
> -static long long writesize;
> -static long long filesize;
> -static long long offset;
> -static long long alignment;
> +static int numchildren = 16;
> +static long long writesize = 1024;
> +static long long filesize = 100 * 1024 * 1024;
> +static long long offset = 0;
> +static long long alignment = 512;

I've also removed this assignment since alignment is initialized
unconditionally.

>  static void dio_sparse(int fd, int align, long long fs, int ws, long long off)
>  {
> @@ -60,12 +60,6 @@ static void setup(void)
>  {
>  	struct stat sb;
>  
> -	numchildren = 1000;
> -	writesize = 1024;
> -	filesize = 100 * 1024 * 1024;
> -	offset = 0;
> -	alignment = 512;
> -
>  	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
>  
> @@ -129,7 +123,7 @@ static struct tst_test test = {
>  	.needs_tmpdir = 1,
>  	.forks_child = 1,
>  	.options = (struct tst_option[]) {
> -		{"n:", &str_numchildren, "Number of threads (default 1000)"},
> +		{"n:", &str_numchildren, "Number of threads (default 16)"},
>  		{"w:", &str_writesize, "Size of writing blocks (default 1K)"},
>  		{"s:", &str_filesize, "Size of file (default 100M)"},
>  		{"o:", &str_offset, "File offset (default 0)"},
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
