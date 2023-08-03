Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB1C00528
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 10:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70C143CD51A
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:41:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A60F53CC397
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:41:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1A9E1001190
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 12:41:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA2A11F45A;
 Thu,  3 Aug 2023 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691059289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiqZijN/Rv5UqIhz/zbipn1kQOTHU2owgaaAVRMOges=;
 b=VMKO7Yk6gZ2gtXD/jh0OtBs35AHQ7BMQOh0x1Da9PG7/TIW7kcRjxZ0o3a86vfGnoBhgxy
 cfdaKXBDWcTkvcF2s6NpmUYSqovDJJFi4LaSD3ZAJpbmfi/QHSHxA/hfDNfenHBBFp6PQu
 gYqg/He5GfgpLurUvTfcxjLUVJFhsgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691059289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YiqZijN/Rv5UqIhz/zbipn1kQOTHU2owgaaAVRMOges=;
 b=4eBk1JkwGcy2thXsW6TL34OBKEDEJFlpBynE1iQIO4yKmwc5hYJHkEymX9F2EsAeY10EY2
 xtfnQGLxQk0NkzAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9718E134B0;
 Thu,  3 Aug 2023 10:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PwHUIlmEy2SRGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Aug 2023 10:41:29 +0000
Date: Thu, 3 Aug 2023 12:42:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Message-ID: <ZMuEkuWpcIkEN3QP@yuki>
References: <20230803103004.2429973-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230803103004.2429973-1-ycliang@andestech.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] hugeshmat04: Restore the correct shmmax value
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
Cc: cynthia@andestech.com, patrick@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> index 50efa8a52..b3e7c272a 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> @@ -83,12 +83,12 @@ static void setup(void)
>  	long hpage_size, orig_hugepages;
>  
>  	orig_hugepages = get_sys_tune("nr_hugepages");
> -	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
> -	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
> -	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
> +	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &orig_shmmax);
> +	SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", (long)SIZE);
> +	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
>  
>  	if (new_shmmax < SIZE)
> -		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
> +		tst_brk(TCONF,	"shmmax too low, have: %lu", new_shmmax);
>  
>  	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  
> @@ -99,7 +99,7 @@ static void setup(void)
>  static void cleanup(void)
>  {
>  	if (orig_shmmax != -1)
> -		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
> +		SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", orig_shmmax);
>  }

Can we please move the PATH_SHMMAX restoration to the .save_restore part
of the tst_test structure?

https://github.com/linux-test-project/ltp/wiki/C-Test-API#127-saving--restoring-procsys-values

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
