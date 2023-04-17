Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C61C77B76
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 14:54:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFD9D3CC199
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 16:54:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859093C31D2
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 16:54:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4305F60020A
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 16:54:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DDE21F86C;
 Mon, 17 Apr 2023 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681743281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hLCNhe4JYEKJX1H8UZxaRhK/pCdih9ggqvLtAq/h0Vc=;
 b=aFIH8NgRSxbQ/Yr5xrDIO8qoT/T+sJ1ElNYLojeepNJHtH6ZIpTc1hkHSMxyqU6vJBocaW
 ZuabrgTCLLJPROX6mReoqviXgjH4+m1Df+dAWqu31gEq70RHva5QsmUeVMAEOUb5eJp/O2
 r2QuJh5dY11hKMRFVjAt4uCYg8j2uUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681743281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hLCNhe4JYEKJX1H8UZxaRhK/pCdih9ggqvLtAq/h0Vc=;
 b=FimCk3H6usMWB6i/fxnIvhTS4FUdoY0Ba3p2zmFbPMcOu0UxX3EAGwRbwJtvp1maQA21BK
 /RZF85ZvxD6dnGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 007ED1390E;
 Mon, 17 Apr 2023 14:54:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3W5LNrBdPWQEIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Apr 2023 14:54:40 +0000
Date: Mon, 17 Apr 2023 16:54:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
Message-ID: <20230417145444.GA2423297@pevik>
References: <1681268342-24308-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1681268342-24308-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230417144758.GA2380745@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230417144758.GA2380745@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND 2/2] network/lib6/asapi_02: Convert into new api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > +static struct tcase {
> > +	char *tname;
> > +	unsigned char send_type;
> > +	unsigned char filter_type;
> > +	enum filter_macro test_macro;
> > +	int pass_packet;
> > +} tcases[] = {
> > +	{"ICMP6_FILTER_SETPASS send type 20 filter type 20", 20, 20, T_SETPASS, 1},

> First, I wonder what are these cryptic numbers 20, 21, 22.
> It'd be great to replace numbers with constants.

https://man.openbsd.org/icmp6 claims: "Suitable values are defined in
<netinet/icmp6.h>.", but I see none in their header:
http://fxr.watson.org/fxr/source/netinet/icmp6.h?v=OPENBSD;im=3

Kind regards,
Petr

> For maybe one of these:

> $ grep -E -e define.*[[:space:]]20$ -e define.*0x14 include/net*
> include/netinet/igmp.h:#define IGMP_PIM                 0x14
> include/netinet/in.h:#define IP_ORIGDSTADDR     20
> include/netinet/in.h:#define IP_MAX_MEMBERSHIPS              20
> include/netinet/in.h:#define IPV6_JOIN_GROUP         20
> ...

> $ grep -E -e define.*[[:space:]]21$ -e define.*0x15 include/net*
> include/netinet/igmp.h:#define IGMP_TRACE                       0x15
> include/netinet/in.h:#define IP_MINTTL          21
> include/netinet/in.h:#define IPV6_LEAVE_GROUP        21
> ...

> $ grep -E -e define.*[[:space:]]22$ -e define.*0x16 include/net*
> include/netinet/igmp.h:#define IGMP_V2_MEMBERSHIP_REPORT        0x16
> include/netinet/in.h:#define IPPROTO_IDP      22
> include/netinet/in.h:#define IP_NODEFRAG        22
> include/netinet/in.h:#define IPV6_ROUTER_ALERT       22
> ...
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
