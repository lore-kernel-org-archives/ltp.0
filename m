Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05346C6FD18
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 14:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C5AC3CBC05
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 16:02:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAC593CBC05
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 16:02:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BDAF3140054C
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 16:02:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5105218F4;
 Tue, 25 Apr 2023 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682431339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MifcvhkTWepsks0XwtfraFxaVWSpVWmpmpsTx6nmD0I=;
 b=Vrjn/6HHf6KIcb1QSKUA/BR9I4fcJh5/n5rb5j1/bo1tW4kDXHqY/vMpVBGDn57fbuxMkY
 SZeDk1RHzFjR0mVTH8+8adXvh3BONED+KdB5teydC6tZOrscO2xZajwSPX7zIugbw7zw+O
 i2QZLZKALxOtWIS4F2paT/qhDrxkod0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682431339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MifcvhkTWepsks0XwtfraFxaVWSpVWmpmpsTx6nmD0I=;
 b=Ed1cZ47QCDgAv3RFLjYMPMee0cMvkYjlg/cDhputj6Nshs9KysEstumzSU3do52lG7U7la
 mRd3vdv1JMQH0nBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6906413466;
 Tue, 25 Apr 2023 14:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f5aoFWvdR2RgKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Apr 2023 14:02:19 +0000
Date: Tue, 25 Apr 2023 16:02:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230425140227.GB3014439@pevik>
References: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1682413930-19764-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] rpc/rpc-tirpc: Fix compile error on clang
 when using clnt_broadcast
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

> When clang upgrade to 16.0.0-2.fc38, these case will report
> incompatible-function-pointer-types  error as below:

> rpc_clnt_broadcast_complex.c:81:46: error: incompatible function pointer types passing
> 'bool_t (char *, struct sockaddr_in *)' (aka 'int (char *, struct sockaddr_in *)') to
> parameter of type 'resultproc_t' (aka 'int (*)(char *, ...)') [-Wincompatible-function-pointer-types]
> (xdrproc_t) xdr_int, (char *)&varRec, eachResult);

> the clnt_broadcase declare as below:
> extern enum clnt_stat   clnt_broadcast(u_long, u_long, u_long,
>                                          xdrproc_t, void *,
>                                          xdrproc_t, void *,
>                                          resultproc_t);

> so we should add resultproc_t cast like tirpc_simple_rpc_broadcast[1] does.

> [1]https://github.com/linux-test-project/ltp/blob/master/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex.c#L84

Thank you for fixing this!

nit: I'd just mention tirpc_rpc_broadcast_complex.c in rpc_broadcast() call
does. (there is only single file, link will sooner or later point to the
different place, ...)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
