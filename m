Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CA9EE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:07:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8EF3CB2FB
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:07:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 938F23CB154
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:07:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F17D1618FEB
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:07:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F7B2218BB;
 Fri, 15 Sep 2023 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694786838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLz7X+fbwxKDXfLyYlyoYyVHTCICtA1KDudqhbN2950=;
 b=g+/4HFxSwAD2/YtWAf+3Ew8lTP8ZhhQ+TDQcvb/MKd5Z0TuN1XARAtBHwxjsH2F58KBmEE
 rwRq2PgyYoFEGOXJ6K3yNA4xc6tzkw9Hb04GuSYOoUKsrSuwz9+b7vxj40Q6UiHzEVfVNd
 dtCc6WDV8AKprq6AlwMKN7CSkADoIME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694786838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLz7X+fbwxKDXfLyYlyoYyVHTCICtA1KDudqhbN2950=;
 b=SGjNs0iaRewSIcC+KYP7jd2k6C3pEKTNJjPlk+N05NvMaeaACoC/VwTM3pot0TFyH66/W5
 29QmmNS9BC6iZiDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEA8B13251;
 Fri, 15 Sep 2023 14:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tN0SOBVlBGU6cwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 15 Sep 2023 14:07:17 +0000
Message-ID: <a16bce5b-9486-bd7e-bb03-9e8995683b54@suse.cz>
Date: Fri, 15 Sep 2023 16:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230728132120.17322-1-pvorel@suse.cz>
 <20230728132120.17322-5-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230728132120.17322-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] doc/shell-API: Document TST_SKIP_IN_{LOCKDOWN,
 SECUREBOOT}=1
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
for the whole patchset:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 28. 07. 23 15:21, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/shell-test-api.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index dde170644..4cf630dab 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -821,3 +821,8 @@ TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS, CONFIG_QUOTACTL=y"
>   
>   . tst_test.sh
>   -------------------------------------------------------------------------------
> +
> +1.8 Skipping test based on system state
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Test can be skipped on various conditions: on enabled SecureBoot
> +('TST_SKIP_IN_SECUREBOOT=1'), lockdown ('TST_SKIP_IN_LOCKDOWN=1').

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
