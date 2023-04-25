Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AB7C77B61
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 14:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EEC33CE517
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 16:05:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81E273CBC05
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 16:05:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2F67600660
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 16:05:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 175A31FD9D;
 Tue, 25 Apr 2023 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682431502;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LUcykkrm0kLoARgbkXEHbLMyrDWygJXG2Dvnw0akXA=;
 b=1J1sHXskODD/HJ2+iJOdQq099zK2iyqI8+SmLVynEDZStDFe5WJjW2zMS5M/H2uFtAmc4A
 Z8spvdFYJfVWqU1OJ9Y4a5Djs53B2XdDlrqlpxZ5vUdtGI96nGQzAedcAuD0Wk1QoGQO8J
 umTWzaY/Qp4+zy/gy6l78Nc59PGPWuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682431502;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9LUcykkrm0kLoARgbkXEHbLMyrDWygJXG2Dvnw0akXA=;
 b=jr72QX5cyn1nizjdE1E/dvnMCny7zUtoKUL2u8ZbQy/rfX1QtWo3vXEp6FJjS2HnZpU6Vi
 UHeNOuOM2wcFuSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D828113466;
 Tue, 25 Apr 2023 14:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lCDTMQ3eR2THLAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Apr 2023 14:05:01 +0000
Date: Tue, 25 Apr 2023 16:05:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230425140510.GC3014439@pevik>
References: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1682413930-19764-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1682413930-19764-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] rpc/rpc-tirpc: Fix compile error on clang
 when using registerrpc
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

Hi Xu,

> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc.c
> @@ -68,8 +68,8 @@ int main(int argn, char *argc[])

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  	//call routine
>  	rslt =
> -	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing, xdr_int,
> -			xdr_int);
> +	    registerrpc(progNum, VERSNUM, PROCNUM, simplePing,
> +			(xdrproc_t) xdr_int, (xdrproc_t) xdr_int);

Maybe just put rslt = on the same line (to fix often broken style a bit?)

rslt = registerrpc(progNum, VERSNUM, PROCNUM, simplePing,
		(xdrproc_t) xdr_int, (xdrproc_t) xdr_int);
Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
