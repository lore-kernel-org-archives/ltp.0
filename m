Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B22ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:33:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B0563CAC18
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:33:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 135703CABD6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:33:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD9362010BD
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:33:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D26405CD7F;
 Wed, 14 Sep 2022 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663187607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OSxgo1pg01ItyRpaq5F9u7T8/AJCK7KKfxKVjfZAXzo=;
 b=xogKq9av6NhY5ly7oZLa/Au/GnSBASah3tjciFLMbvDwqTGEhaHpID6X85799b/AsOV1Ed
 2SPG+t9cbjBoxMtoorgQ+f2uj3OrTkqxwwjFcpu2Z7G0Urj58s8DUw1dn7Mq4Xw8COFTIO
 NIp3t94LXKjLKkb/8X4mBdEg3/upVQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663187607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OSxgo1pg01ItyRpaq5F9u7T8/AJCK7KKfxKVjfZAXzo=;
 b=ea7ptON2dZVsu22XDTG3ZOhG0taeYlaaXE5/kQ6+MxzqBdzxPeK6o0qL4oDdY8ckctROVT
 hvBKypgs/vBqgWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACBF813494;
 Wed, 14 Sep 2022 20:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FseAKJc6ImM4LAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:33:27 +0000
Date: Wed, 14 Sep 2022 22:33:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyI6lncfJSTariC1@pevik>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-5-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220914161930.27681-5-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] readahead02: Add max_runtime
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

Hi Martin,

> Also calculate max_runtime dynamically if the test gets called with
> non-default filesize.

> Changes since v1:
> - Added dynamic runtime calculation for non-default filesize

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  testcases/kernel/syscalls/readahead/readahead02.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 4fa8cfaf8..02e866e82 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -38,7 +38,9 @@ static char testfile[PATH_MAX] = "testfile";
>  #define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
>  #define MEMINFO_FNAME "/proc/meminfo"
>  #define PROC_IO_FNAME "/proc/self/io"
> -static size_t testfile_size = 64 * 1024 * 1024;
> +#define DEFAULT_FILESIZE (64 * 1024 * 1024)
> +
> +static size_t testfile_size = DEFAULT_FILESIZE;
>  static char *opt_fsizestr;
>  static int pagesize;
>  static unsigned long cached_max;
> @@ -365,8 +367,10 @@ static void setup_readahead_length(void)

>  static void setup(void)
>  {
> -	if (opt_fsizestr)
> +	if (opt_fsizestr) {
>  		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
> +		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));
> +	}

>  	if (access(PROC_IO_FNAME, F_OK))
>  		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
> @@ -406,6 +410,7 @@ static struct tst_test test = {
>  	},
>  	.test = test_readahead,
>  	.tcnt = ARRAY_SIZE(tcases),
> +	.max_runtime = 30,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "b833a3660394"},
>  		{"linux-git", "5b910bd615ba"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
