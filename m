Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3ABC001DE
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 12:09:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDF443CE66C
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 14:09:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E942B3C8A1E
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 14:09:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F20160154A
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 14:09:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57C911F8AB;
 Fri, 28 Jul 2023 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690546154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QeoJLY+R6lBIxWA2vV4Q3rmNMpkDnuaOe+LcgUEhPw=;
 b=b0JOwazXcPEBxHKSnjSci4RXVBnh50zggkcrDywfhnKa/uZQU3bWI489HiR/nAXumCXgLE
 RranC0hnI3Empm6Ejo1pFz+3M8FHi7wWKA6JQTRMHhQnWdM10AbCtXkYmlCuPaiQvqf4Mo
 vCYimXExEArw9R/smbPFYFxby3j9Vgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690546154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QeoJLY+R6lBIxWA2vV4Q3rmNMpkDnuaOe+LcgUEhPw=;
 b=WVH4VpjcP/mTF/qkIL1gU9BbfKOEQr4/nRwd5X8/lyI/mhpA6OQFBllc9w7OadBZr0nsfo
 hgLme2DV16xqtvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37C5913276;
 Fri, 28 Jul 2023 12:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pBsGDOqvw2TFXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 12:09:14 +0000
Date: Fri, 28 Jul 2023 14:09:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230728120912.GB19163@pevik>
References: <20230727150013.31835-1-mdoucha@suse.cz>
 <20230727150013.31835-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230727150013.31835-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] tst_netdevice: Add helper functions for qdisc
 and filter management
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

...
nit: missing comment here, but the meaning is obvious. Also
NETDEV_REMOVE_TRAFFIC_CLASS() (and tst_netdev_remove_traffic_filter()) look to
be unused, but I guess you expect to use it in another reproducer.
> +int tst_netdev_remove_traffic_class(const char *file, const int lineno,
> +	const char *ifname, unsigned int parent, unsigned int handle,
> +	const char *qd_kind);
> +#define NETDEV_REMOVE_TRAFFIC_CLASS(ifname, parent, handle, qd_kind) \
> +	tst_netdev_remove_traffic_class(__FILE__, __LINE__, (ifname), \
> +		(parent), (handle), (qd_kind))

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
