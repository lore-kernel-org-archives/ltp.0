Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA91C7EE23
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 13:17:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C70CF3CE0A7
	for <ltp@archiver.kernel.org>; Wed, 10 May 2023 15:17:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 566C43CD62F
 for <ltp@lists.linux.it>; Wed, 10 May 2023 15:17:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CF68A600807
 for <ltp@lists.linux.it>; Wed, 10 May 2023 15:17:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCABE1F45E;
 Wed, 10 May 2023 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683724633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwifN/UEMAV6wQz9BFPiOnVdrL4qni+QDbmQtDA2VpU=;
 b=Sv1G8QtSvNHEV/htrQIdETmMneG7TzTPR456ZBw4Vcw7GB+FS0dSCNj6D6M7kwlEQV66MU
 ZO1Rh1xQspVu0w0AG7QfXDX3lj5+OvY3TLxGBdmOZ9UFnXYXfJjHQ55cSA8XuF5GAnsI07
 bYb+1+awmXWdKD+iE0oJ3BW/mQnhndw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683724633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwifN/UEMAV6wQz9BFPiOnVdrL4qni+QDbmQtDA2VpU=;
 b=EcFzy7aw8PXHoKnKfEMSAnFy2QX5/L5YO9STAOI0lAom9tALpWS7NMMaAYWfWZYy4lix6Q
 NhebHWOn+n1zC0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6C0F13519;
 Wed, 10 May 2023 13:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mBu+KlmZW2TiCwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 May 2023 13:17:13 +0000
Date: Wed, 10 May 2023 15:18:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZFuZk0on2bAzLxpJ@yuki>
References: <20230508134903.83591-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508134903.83591-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap32: guarantee enough memory for gigantic
 hugepage
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
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
> index 34b322bfa..7ff23b236 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
> @@ -60,6 +60,12 @@ static void setup(void)
>  		tst_brk(TCONF, "Gigantic hugepages not supported");
>  
>  	SAFE_CLOSEDIR(dir);
> +
> +	if (tst_available_mem() < (long long)hpage_size) {
> +		g_hpage_path[0] = '\0';
> +		tst_brk(TCONF, "No enough memory for gigantic hugepage reserving");
                                                                       ^
								       reservation
> +	}
> +
>  	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
>  }

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
