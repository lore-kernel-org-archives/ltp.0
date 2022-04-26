Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574EFC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 14:24:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 841023CA455
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 16:24:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E563F3C9E32
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 16:24:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A48760074D
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 16:24:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44430210E4;
 Tue, 26 Apr 2022 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650983084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5C32urF8GJq1W8wOWYnSAksyilUc5CWUL1ITZy0p80=;
 b=S/Lm7S3b2QoQsUwOZiCyHKPzdaQznuU2DN91h4P1ES65qpO/X6PL3KqmPbya4lotj0+S/R
 r30+VGKGmuGvq7e3gasokDoG6D/6v2zkzRU04kr4mMfcpIRXV5RPYssuRxCh4FNf1+/hpb
 J97iA5EaXfKSCnSTBmHcL267kaERrL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650983084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5C32urF8GJq1W8wOWYnSAksyilUc5CWUL1ITZy0p80=;
 b=UMhqkHwN5/acqd1l1Y4gnRo5+0FBfaK3THCwmlcD9Bq1zEuJG79qklSUlhVB755YdcdjtU
 qiENKnmcRDb4F0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 307EC13223;
 Tue, 26 Apr 2022 14:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SmXYCqwAaGI/SQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 26 Apr 2022 14:24:44 +0000
Message-ID: <89738299-f570-b228-3094-1538a13835fd@suse.cz>
Date: Tue, 26 Apr 2022 16:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-4-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220422144141.16848-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] tst_test.sh: Cleanup getopts usage
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
the patch looks mostly good except for a few issue below.

On 22. 04. 22 16:41, Petr Vorel wrote:
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index a80fbe7fa7..673e6f8029 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -151,4 +151,5 @@ do_test()
>  	esac
>  }
>  
> +. zram_lib.sh

zram_lib.sh appears to be imported twice here after the setup/cleanup fixes.

>  tst_run
> diff --git a/testcases/network/rpc/basic_tests/rup/rup01.sh b/testcases/network/rpc/basic_tests/rup/rup01.sh
> index 44f0e73d26..dd0e71be7a 100755
> --- a/testcases/network/rpc/basic_tests/rup/rup01.sh
> +++ b/testcases/network/rpc/basic_tests/rup/rup01.sh
> @@ -19,7 +19,6 @@ TCID="rup01"
>  TST_TOTAL=7
>  
>  TST_USE_LEGACY_API=1
> -. tst_net.sh

The tst_net.sh import got completely dropped in this file likely because
there's no call to tst_run(). Instead, the test calls do_setup(),
do_test() and tst_exit() directly.

>  
>  do_setup()
>  {
> diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01.sh b/testcases/network/rpc/basic_tests/rusers/rusers01.sh
> index 554bfa01cf..8fef5757e1 100755
> --- a/testcases/network/rpc/basic_tests/rusers/rusers01.sh
> +++ b/testcases/network/rpc/basic_tests/rusers/rusers01.sh
> @@ -19,7 +19,6 @@ TCID="rusers01"
>  TST_TOTAL=5
>  
>  TST_USE_LEGACY_API=1
> -. tst_net.sh

Same here.

>  
>  do_setup()
>  {

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
