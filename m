Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2088C4332F
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 14:05:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20B083CA968
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 16:05:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5476D3CA508
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:04:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DDEC8200163
 for <ltp@lists.linux.it>; Tue, 10 May 2022 16:04:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2145D1F896;
 Tue, 10 May 2022 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652191492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M95JLx896Y3zTI/TqjDKFfQUGYKYp/pb9T2ZVTpfd9s=;
 b=ipgZqiqfYDQ7ZPLrE86loFSJs5zWkvBqzATC0qHl5/lN3dPyDF9hnrBOHzg68bRlaGnaUh
 qMJMPztiFr9slMMEH4MPiE7jJM4v86QmhFr8NBqia5dei9X1jVpJWX/GMPfM2yyRQW87Zo
 x503mpXfCLfVM21LzaiLqDQSioanBLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652191492;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M95JLx896Y3zTI/TqjDKFfQUGYKYp/pb9T2ZVTpfd9s=;
 b=2htGdvsYo1Pn6JHAydzuhYKkoaJKbHlnkocdEscPjJBCuts2P6UDYdt3+xmp+OFInR5U/B
 1jNtCqyWjQEWOUAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF6F113AA5;
 Tue, 10 May 2022 14:04:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kaj9MANxemJ7PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 14:04:51 +0000
Date: Tue, 10 May 2022 16:04:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnpxAhZQpOG2eoE2@pevik>
References: <20220510065104.1199-1-pvorel@suse.cz>
 <20220510065104.1199-2-pvorel@suse.cz> <YnpXGnJyjjZhxuRN@yuki>
 <YnpjcH4i33YxyeFJ@pevik> <Ynpm8zmnkyi4rBik@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ynpm8zmnkyi4rBik@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] tst_net.sh: Fix for disabled IPv6
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > -       tst_net_detect_ipv6 rhost
> > +       [ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6 rhost

> That solves the case where lhost does not support ipv6 but rhost does,
> but there is still case where lhost does support it but rhost does not,
> to fix that we have to clear TST_NET_IPV6_ENABLED in the
> tst_net_detect_ipv6() as well.

Ah, correct, thanks!

> 	if [ $ret -eq 0 ]; then
> 		TST_NET_IPV6_ENABLED=1
> 	else
> 		TST_NET_IPV6_ENABLED=0
nit: I'd slightly prefer to use TST_NET_IPV6_ENABLED=
> 		tst_res TINFO "IPv6 disabled on $type"
> 	fi

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
