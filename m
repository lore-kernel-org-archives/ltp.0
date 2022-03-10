Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2897C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 15:17:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6593C6FE1
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 16:17:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0174B3C0FA8
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 16:17:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E1BA1A004C0
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 16:17:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C39F210EA;
 Thu, 10 Mar 2022 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646925436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyiyZg8+qKIOtmY2s1PgbS8dPEBIbTxH4gtjSM0gcqI=;
 b=3XFCfsPahR65zee6eT0OWs8+uJTMkDA3xOaj8mkMu1KQCVt6JNdUDstDnq0SO7mRSfe87U
 nJDAauIAbEFq7/jiPsclIqtu+G3urNck2OcrGa2LzVDbl14beeHU6nDSbyMvqhg3+ifM9x
 0z9DbPPB1ToHS4uFKNCaTJZECUdg0sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646925436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyiyZg8+qKIOtmY2s1PgbS8dPEBIbTxH4gtjSM0gcqI=;
 b=rb+D1MVBG928IlC9oiuTFMyCxAPGpPDdcp25wIlW8wvbmzn9cs1ai94XXDm+b4/CjSuFCs
 WSQs5qixxZPdX4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78A8213A3D;
 Thu, 10 Mar 2022 15:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y6xLHHwWKmKodAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Mar 2022 15:17:16 +0000
Date: Thu, 10 Mar 2022 16:19:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YioXB0MT4HYpUbpl@yuki>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
 <20220310105916.7960-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310105916.7960-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/10] Rewrite msg_comm.c using new LTP API
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
> +	if (TST_RET > 0)
> +		tst_res(TFAIL, "SysV msg: communication with non-identical keys between namespaces");
> +	else
> +		tst_res(TPASS, "SysV msg: communication with identical keys between namespaces");

I would have changed these message to something more meaningful:

		tst_res(TFAIL, "messages leak between namespaces");
	else
		tst_res(TPASS, "messages does not leak between namespaces");


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
