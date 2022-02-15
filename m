Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F4C43217
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 13:02:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53A283CA054
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 14:02:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DEC3C9FC4
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 14:02:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6415200DCC
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 14:02:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09EE01F38A;
 Tue, 15 Feb 2022 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644930156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uO9mGjQCya9xFbHJAGO26S4pXcmyQUjYbr7YSuUq7Vg=;
 b=wkg+Gn/GNbjJbcxiWGLEF2dMdZbRU/ukkyOC1O8cWkKYLuV3vIydfvGotWWbXELjiPOou6
 I4ZBAuocKLyMbj6zxKA6URoVcl3AOn1LU0VyqvHOHurHRDneDOMThlLcyY6/o+Pg8rg0HE
 yn3DfbJiFUPadiC5KTlEgdBzzcd20Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644930156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uO9mGjQCya9xFbHJAGO26S4pXcmyQUjYbr7YSuUq7Vg=;
 b=1PF4h6xBIf7AB2z73yACNXZo+AOUXApgNTiQw1Eua7f18YNbi+gGhAWN9uqrRa4ccxiSco
 hv/UVXeMYnVU/AAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E953C13C75;
 Tue, 15 Feb 2022 13:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BWOYN2ukC2IccgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 15 Feb 2022 13:02:35 +0000
Date: Tue, 15 Feb 2022 14:04:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Message-ID: <Yguk6nhRcd863ia+@yuki>
References: <20220211152751.4651-1-bogdan.lezhepekov@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220211152751.4651-1-bogdan.lezhepekov@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] lib/tst_memutils.c: Fix resource leak
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
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index 4a4974761..2e6d7d5fd 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -122,7 +122,10 @@ static int write_score(const char *path, int score)
>  		return 1;
>  
>  	if (fprintf(f, "%d", score) <= 0)
> +	{
> +		fclose(f);
>  		return 1;
> +	}

The coding style is wrong. Please run 'make check' in the respective
directory when the source code located and fix all warnings.

>  	if (fclose(f))
>  		return 1;
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
