Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CC7EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 353ED3CE97F
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:26:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC0F63C0123
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:26:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B0BA1A00FA7
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:26:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9680022C86;
 Thu, 20 Jul 2023 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689866769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q70tGeeS4GH0cXsQPf7ncd6Wd0DOw7l1qR8JjrCbBUU=;
 b=vEc3rdgTPJ3ppuEkphZPccK/NdH2gTuDYsGZpCnWuEqrouQ+GDMRl87+NcKGzYoI/TJgYz
 lOjMXqFdkK+sMCCgbp3n/ViWcwBuSJifaSr8SveQ7b+fNZhKC2o+d9+TZexVBLkRYUCDXO
 HcDPstoSO4kk4VIkAyp27urkVF+FBcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689866769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q70tGeeS4GH0cXsQPf7ncd6Wd0DOw7l1qR8JjrCbBUU=;
 b=TKumWkUxkjHBvyALMPxyp6bc/hB+FMMVeF2MZgAF4H321WZxcltFu5SSJQCMySIkcC6DZk
 J6WdfsUV3ZIbmSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BFDF133DD;
 Thu, 20 Jul 2023 15:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r2GdGBFSuWQ1FgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 15:26:09 +0000
Date: Thu, 20 Jul 2023 17:26:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Min <limin154@huawei.com>
Message-ID: <20230720152607.GA1339322@pevik>
References: <20230721071831.83546-1-limin154@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230721071831.83546-1-limin154@huawei.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH]utils/sctp: bugfix for testlib/sctputil.h
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> The socket is created and bound immediately without waiting for the handshake after close(sk).
> "bind(): errno=EADDRINUSE(98): Address already in use" may be reported.
> Use SO_REUSEPORT to allow multiple sockets to be bound to the same port.

How this can happen? Running tests too quickly one after the other?
Or what is different on your SUT? I'm not sure if it's good idea to always test
with SO_REUSEADDR and SO_REUSEPORT.

> Signed-off-by: Min Li <limin154@huawei.com>
> ---
>  utils/sctp/testlib/sctputil.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
> index 176d623f0..b51a3f9b0 100644
> --- a/utils/sctp/testlib/sctputil.h
> +++ b/utils/sctp/testlib/sctputil.h
> @@ -133,6 +133,15 @@ extern int TST_CNT;
>  static inline int test_socket(int domain, int type, int protocol)
>  {
>  	int sk = socket(domain, type, protocol);
> +	int true_const=1;
What is this unused variable for?

> +
> +	if(setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &true_const, sizeof(int))){
> +		printf("set addr err\n");
Besides missing spaces in if (if (..) { ), we have SAFE_SETSOCKOPT().
Or tst_brkm(TWARN, ...) could be used (we don't use printf directly in LTP).

Kind regards,
Petr

> +	}
> +
> +	if(setsockopt(sk, SOL_SOCKET, SO_REUSEPORT, &true_const, sizeof(int))){
> +		printf("set port err\n");
> +	}

>  	if (sk == -1) {
>  		if (errno == EAFNOSUPPORT)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
