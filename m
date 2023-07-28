Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48E5C0015E
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 07:46:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FCF3CD657
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 09:46:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1051C3C025E
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 09:46:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 98B9A1A001AD
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 09:45:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC5072199D;
 Fri, 28 Jul 2023 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690530357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTISwja1CWlScpZzgZql/IhaCoJP1jz6sn3KGFLRPkE=;
 b=q1GwAHWFctcybms9FD8Gzo3FQQ/PE0nL61hMV+nVnonv031+S4GJkCRBINyIdec0uKI4+3
 vRzCWdJ4ieAv0vdVaIGTBxtZzXgooo78XxO5ALXf5OASi0uZMm0iQ5Q3+MEr4V0czwyv4M
 WalB5ODaLOBEbxPz1YrXpX5f7kQw5Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690530357;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTISwja1CWlScpZzgZql/IhaCoJP1jz6sn3KGFLRPkE=;
 b=ADtOKAcJ37TRCu7rZtxW5swkRAUsbn5RzM870ni8/5+gbaLvfzLECzjoXL1zkrytlZgpUD
 oxrI8GnK/31NIODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99F1713276;
 Fri, 28 Jul 2023 07:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nHhBJDVyw2QUUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jul 2023 07:45:57 +0000
Date: Fri, 28 Jul 2023 09:46:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZMNya4WWC3IP6FZZ@yuki>
References: <20230727150013.31835-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230727150013.31835-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_netdevice: Add missing rtnetlink context
 allocation checks
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
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  lib/tst_netdevice.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
> index 4a0442932..a57f506e9 100644
> --- a/lib/tst_netdevice.c
> +++ b/lib/tst_netdevice.c
> @@ -332,6 +332,9 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
>  
>  	ctx = create_request(file, lineno, RTM_NEWLINK, 0, &info, sizeof(info));
>  
> +	if (!ctx)
> +		return 0;
> +
>  	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
>  		tst_rtnl_destroy_context(file, lineno, ctx);
>  		return 0;
> @@ -411,6 +414,9 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
>  
>  	ctx = create_request(file, lineno, action, flags, &info, sizeof(info));
>  
> +	if (!ctx)
> +		return 0;
> +
>  	if (srcaddr && !tst_rtnl_add_attr(file, lineno, ctx, RTA_SRC, srcaddr,
>  		srclen)) {
>  		tst_rtnl_destroy_context(file, lineno, ctx);

Shouldn't we tst_brk_() in these cases? This function is a base for
NETDEV_CHANGE_NS_*() which is used as a safe macro without checking it's
return value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
