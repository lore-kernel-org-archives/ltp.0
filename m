Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECD7C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 15:03:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 606313CF95B
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 17:03:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2960E3C8ACC
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 17:02:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B514100157C
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 17:02:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC4B1218CE;
 Tue, 24 Oct 2023 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698159777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZJkNREV5AVW5F3GRxwJhrf/znQA7PGK2AJrClzY0u0=;
 b=N83aR19SVyBN6a4EJThnRSE5tLYe8CRrlSsNhot6nP2miT8L1GPGuDgr2l3KEJaXC0Ijhs
 hptDRoKhvgMpj7OQ0HkPlAtw2WZyQmCytsiD2SVoSxTkjBi7lKLKv6KzWtxq6/7JrP3yzt
 kO9oPgKdz6tOkPi0hYTHbSxq46pLlhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698159777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZJkNREV5AVW5F3GRxwJhrf/znQA7PGK2AJrClzY0u0=;
 b=X4+jlkqrfUnTyymkMGzuloWd4W6IXk4tlbe8xzDDg7zWcXopL7QlDC/ajA16RGdrGv0sbF
 cbuEdoWnN/cBJCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C64FE134F5;
 Tue, 24 Oct 2023 15:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YG+6LqHcN2V5OAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 24 Oct 2023 15:02:57 +0000
Message-ID: <b3a6bd7f-27a9-c673-35d3-7ad2d5f6cdba@suse.cz>
Date: Tue, 24 Oct 2023 17:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20231023160242.3605-1-mkittler@suse.de>
 <20231023160242.3605-4-mkittler@suse.de>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20231023160242.3605-4-mkittler@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.98 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.88)[99.50%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/5] Remove disabled code in ioctl02.c
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
the first 3 patches can be merged as is. For all patches up to here:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 23. 10. 23 18:02, Marius Kittler wrote:
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl02.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index 25b83d358..c66473a8d 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -134,20 +134,6 @@ static void chk_tty_parms(void)
>   			 termio.c_line);
>   		flag++;
>   	}
> -	/*
> -	 * The following Code Sniffet is disabled to check the value of c_cflag
> -	 * as it seems that due to some changes from 2.6.24 onwards, this
> -	 * setting is not done properly for either of (B50|CS7|CREAD|PARENB|
> -	 * PARODD|CLOCAL|(CREAD|HUPCL|CLOCAL).
> -	 * However, it has been observed that other flags are properly set.
> -	 */
> -#if 0
> -	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
> -		tst_res(TINFO, "cflag has incorrect value. %o",
> -			 termio.c_cflag);
> -		flag++;
> -	}
> -#endif
>   
>   	for (i = 0; i < NCC; i++) {
>   		if (i == VEOL2) {

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
