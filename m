Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ECDC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 15:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D5CD3C9716
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 16:25:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1D723C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 16:25:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 51B411A000BB
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 16:25:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7EABD212C9;
 Fri, 21 Jan 2022 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642778703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGf4AMIbjocZMz/CEvfP4PpXN+VDg5/2hF4njQfglk4=;
 b=MDRbTNk7Ec1fb4m6S5ZGZu/jlhKaXQjykYgGNanbGbEl+/eBU18f1Zh880HnEFTJFHWnat
 sAnd4rL1RHxKtJUW54tYecGhKB9nxr+9lGnCgcbQ6hypopoO500oIa2teOvPPlE5T7lAgk
 i6HrcDh6kovE6G3Td0naHnel2eX2y0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642778703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGf4AMIbjocZMz/CEvfP4PpXN+VDg5/2hF4njQfglk4=;
 b=4MfvYSCx9e2m9sJFj6Vrum9ZVHUkI9EVXPxJKT3mbYOdpdoE36q+sxsUgL3CS2uO5G7e8y
 GHQrJ4y0sI/Q1FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5125D139FE;
 Fri, 21 Jan 2022 15:25:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HST6EE/Q6mFLBAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Jan 2022 15:25:03 +0000
Message-ID: <25efba68-899f-47b1-b4f3-e6a3ddc2ff78@suse.cz>
Date: Fri, 21 Jan 2022 16:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220121134052.30048-1-pvorel@suse.cz>
 <20220121134052.30048-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220121134052.30048-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 PATCH 2/2] dio_sparse: Set timeout 30 min
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
the commit message needs an update due to changes but otherwise:

Acked-by: Martin Doucha <mdoucha@suse.cz>

On 21. 01. 22 14:40, Petr Vorel wrote:
> Originally only ADSP075 failed (dio_sparse  -w 518192k -s 518192k -n 1000)
> but just in case increase timeout for all newly rewritten tests.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> Prolong the timeout only for dio_sparse (Martin)
> 
> Kind regards,
> Petr
> 
>  testcases/kernel/io/ltp-aiodio/dio_sparse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> index 39fc895d65..0039daa8d1 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> @@ -135,4 +135,5 @@ static struct tst_test test = {
>  		"tmpfs",
>  		NULL
>  	},
> +	.timeout = 1800,
>  };


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
