Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4599C43334
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 09:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EADE33C96E0
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 11:02:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DDF33C72FC
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 11:02:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A56E8600637
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 11:02:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E65720CFA;
 Mon, 18 Jul 2022 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658134939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4kQ+OfTHsqFToi/DsJVNcKH170F8oQj6iMFCENyVHU=;
 b=adhR4v8P+K9EItJnjnTPLt3eEdsPY2+lZ+1JGzoKMQggnNEViY16bQNLx+mhVss66w9lYm
 42DCLnk7ScAlTeK4hK4ORuPuVC415Ioxc54rsIg73AwnBPAklvWJA6DyAcRNAgKI8nsm81
 de18k8zRXQwcwfaxJX9yYMqlYv327eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658134939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4kQ+OfTHsqFToi/DsJVNcKH170F8oQj6iMFCENyVHU=;
 b=sz+1OohhHaffuyWNFoOiTVMBeYSJ5kQWPVp//WWpFeMudrlF+7HePqgcTxsz53qwihpUOC
 8mIO0uwyNdIaXmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C2DE13754;
 Mon, 18 Jul 2022 09:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cxV8GZsh1WJsIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 18 Jul 2022 09:02:19 +0000
Date: Mon, 18 Jul 2022 11:04:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <YtUiDXXLf+ob7Dm4@yuki>
References: <1656315600-22268-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1656315600-22268-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syslog11: fix console loglevel changed after test
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
Cc: ltp@lists.linux.it, Lingling Li <lilingling@loongson.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> the console loglevel is force to be 7(LOGLEVEL_DEFAULT) after test,
> which is not the desired behavior.So we reset the console loglevel
> to its original value after the test body.The method what we take
> is just same as commit:
> a2ff1c2d141d ("kmsg01: set/restore console log level").

First of all the test is mess, it would be nice to clean it up first and
convert it to the new library.

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Lingling Li <lilingling@loongson.cn>
> ---
>  testcases/kernel/syscalls/syslog/syslog11.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
> index b9540ef..78a7cc4 100644
> --- a/testcases/kernel/syscalls/syslog/syslog11.c
> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
> @@ -84,6 +84,11 @@ struct test_case_t {		/* test case structure */
>  	char *desc;		/* Test description */
>  };
>  
> +#define PRINTK "/proc/sys/kernel/printk"
> +#define CONSOLE_LOGLEVEL_QUIET   4
> +
> +static int console_loglevel = -1;
> +
>  char *TCID = "syslog11";
>  static int testno;
>  static char buf;
> @@ -195,6 +200,11 @@ void setup(void)
>  		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
>  	}
>  
> +	if (access(PRINTK, F_OK) == 0) {
> +		SAFE_FILE_SCANF(NULL, PRINTK, "%d", &console_loglevel);
> +		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);

Do we need to set the loglevel at the start of the test here?

> +	}
> +
>  	/* Pause if that option was specified
>  	 * TEST_PAUSE contains the code to fork the test with the -c option.
>  	 */
> @@ -208,5 +218,6 @@ void setup(void)
>   */
>  void cleanup(void)
>  {
> -
> +	if (console_loglevel != -1)
> +		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", console_loglevel);
>  }
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
