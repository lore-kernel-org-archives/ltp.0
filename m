Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D445C001E0
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 11:04:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159153CB2FF
	for <ltp@archiver.kernel.org>; Tue, 25 Jul 2023 13:04:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 560D03C8B9D
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:04:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B95F3600F28
 for <ltp@lists.linux.it>; Tue, 25 Jul 2023 13:04:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A30261F74C;
 Tue, 25 Jul 2023 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690283057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/7EGmYOapPQjansZovJjHh+otycV7kuu7embxfHX8=;
 b=ZoJ18kgsbAKZZp6OFHZUrkJdS+RRb6BfNNY/WwiTGTgp6Eq1Dbjc77Zunr+OKx5xUCme8v
 x6yk+On8E1topnYJ/x4HSqNFBpTfcKKyTbvlDBGcmJ2DXND/5hUDTow0m/TNF6M7XzVJ8R
 u2R9O1QE5WKLylIh2w5TN7+ZRuX87qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690283057;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2/7EGmYOapPQjansZovJjHh+otycV7kuu7embxfHX8=;
 b=Hu1yKm+y2feyNlGqnnopBIGWVl4PYu8twy33cGiASY8IN826s/s+5AhTCne/6RQFVFtMYz
 b6sF4stmlZ0ruRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90CBE13342;
 Tue, 25 Jul 2023 11:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VcSuITGsv2SPEAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 25 Jul 2023 11:04:17 +0000
Message-ID: <f80349b8-a72e-454d-1ffd-b732bad7b640@suse.cz>
Date: Tue, 25 Jul 2023 13:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230721091515.1353371-1-pvorel@suse.cz>
 <20230721091515.1353371-3-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230721091515.1353371-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] tst_lockdown_enabled: Print lockdown state
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
Printing "Kernel lockdown: %s" instead would make more sense to the 
user. But that can be fixed during merge.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 21. 07. 23 11:15, Petr Vorel wrote:
> This will be used to simplify .skip_in_lockdown in next commit.
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   lib/tst_lockdown.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index 4ce4736c3..8f2ee6762 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -47,6 +47,7 @@ int tst_lockdown_enabled(void)
>   {
>   	char line[BUFSIZ];
>   	FILE *file;
> +	int ret;
>   
>   	if (access(PATH_LOCKDOWN, F_OK) != 0) {
>   		char flag;
> @@ -65,5 +66,8 @@ int tst_lockdown_enabled(void)
>   		tst_brk(TBROK | TERRNO, "fgets %s", PATH_LOCKDOWN);
>   	SAFE_FCLOSE(file);
>   
> -	return (strstr(line, "[none]") == NULL);
> +	ret = strstr(line, "[none]") == NULL;
> +	tst_res(TINFO, "Lockdown: %s", ret ? "on" : "off");
> +
> +	return ret;
>   }

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
