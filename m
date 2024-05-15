Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C49C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 10:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B04E83CF757
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:15:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 295D83CF72F
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:15:15 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9D0F600961
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:15:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 973321FE3A;
 Wed, 15 May 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 527B0139B3;
 Wed, 15 May 2024 10:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ip4DDjGLRGZ/XgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 10:15:13 +0000
Date: Wed, 15 May 2024 12:15:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240515101511.GA211618@pevik>
References: <20240515094753.1072-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240515094753.1072-1-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 973321FE3A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: Pass if the tcindex module is
 blacklisted
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

Hi Martin,

> The tcindex01 test currently fails if the tcindex module is enabled
> in kernel config but cannot be autoloaded. Some distros chose
> to blacklist the module rather than remove it completely, thus
> check for autoload failure and pass in that case.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/cve/tcindex01.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

> diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
> index 70e5639f1..07239f9c0 100644
> --- a/testcases/cve/tcindex01.c
> +++ b/testcases/cve/tcindex01.c
> @@ -106,8 +106,19 @@ static void run(void)
>  	NETDEV_ADD_QDISC(DEVNAME, AF_UNSPEC, TC_H_ROOT, qd_handle, "htb",
>  		qd_config);
>  	NETDEV_ADD_TRAFFIC_CLASS(DEVNAME, qd_handle, clsid, "htb", cls_config);
> -	NETDEV_ADD_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP, 1,
> -		"tcindex", f_config);
> +	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,

nit: we now don't use NETDEV_ADD_TRAFFIC_FILTER() macro any more. I guess it can
stay because you sooner or later will use it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +		qd_handle, 10, ETH_P_IP, 1, "tcindex", f_config);
> +	TST_ERR = tst_netlink_errno;
Out of curriosity, I suppose you save tst_netlink_errno to TST_ERR because it
would be overwritten later in other LTP netlink API functions.

> +
> +	if (!ret && TST_ERR == ENOENT) {
> +		tst_res(TPASS | TTERRNO,
> +			"tcindex module is blacklisted or unavailable");
> +		return;
> +	}

Kind regards,
Petr
> +
> +	if (!ret)
> +		tst_brk(TBROK | TTERRNO, "Cannot add tcindex filter");
> +
>  	NETDEV_REMOVE_TRAFFIC_FILTER(DEVNAME, qd_handle, 10, ETH_P_IP,
>  		1, "tcindex");
>  	ret = tst_netdev_add_traffic_filter(__FILE__, __LINE__, 0, DEVNAME,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
