Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B73C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 13:18:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E97FB3C2285
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 14:18:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AE613C1B93
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 14:18:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B83871000525
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 14:17:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13974210F3;
 Tue,  8 Mar 2022 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646745479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2krr1sCNN3LFirEQv8w1J97jEW0eAQOYCBYbrWR0Zs=;
 b=eHWL1kZ6agRuA76faHfGzmVAvs83RsCqClq3Wdhh7rrzBpI+pZJ4M6j/PX8zBERaFTzt6Z
 bpQXPxw77wJ5Xq6xeDFpbES75iryvP7afJORphwX75xWsWyDIgWqJhQcWAQDZ0PdBPdn2Y
 DWwqJKs9Tq9qA6yqLBe9LwZ/rujZPgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646745479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2krr1sCNN3LFirEQv8w1J97jEW0eAQOYCBYbrWR0Zs=;
 b=Av7oozGREcGZnbkFzOqEbTLn6aVGZKR98XEcQdGRqm+i4J3c0laEhNlpxtmqo0E5htJrW3
 gk/1dGbDHe/1SRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F38A513CA6;
 Tue,  8 Mar 2022 13:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3YEoO4ZXJ2IzGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Mar 2022 13:17:58 +0000
Date: Tue, 8 Mar 2022 14:20:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YidYEvHfXOGiLVw8@yuki>
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220308073709.4125677-5-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308073709.4125677-5-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] ksm: cleanup work and make use of
 .save_restore
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
> diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
> index 0a81e2016..301c4d3c2 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -66,30 +66,7 @@ static void verify_ksm(void)
>  
>  static void setup(void)
>  {
> -	if (access(PATH_KSM, F_OK) == -1)
> -		tst_brk(TCONF, "KSM configuration is not enabled");
> -
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
> -
> -	/*
> -	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
> -	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
> -	 * will prevent KSM pages being merged across numa nodes,
> -	 * which will cause the case fail, so we need to make sure
> -	 * it is enabled before testing.
> -	 */
> -	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
> -		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
> -				"%d", &merge_across_nodes);
> -		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
> -	}
> -}
> -
> -static void cleanup(void)
> -{
> -	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
> -		FILE_PRINTF(PATH_KSM "merge_across_nodes",
> -				 "%d", merge_across_nodes);
>  }
>  
>  static struct tst_test test = {
> @@ -102,11 +79,24 @@ static struct tst_test test = {
>  		{}
>  	},
>  	.setup = setup,
> -	.cleanup = cleanup,
>  	.save_restore = (const struct tst_path_val const[]) {
> +		{"!/sys/kernel/mm/ksm/run", NULL},
> +		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
>  		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> +		/*
> +		 * kernel commit 90bd6fd introduced a new KSM sysfs knob
> +		 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
> +		 * will prevent KSM pages being merged across numa nodes,
> +		 * which will cause the case fail, so we need to make sure
> +		 * it is enabled before testing.
> +		 */

I would have removed this comment, it's not in the rest of the tests
either way...

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
