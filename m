Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA27C6379F
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 12:28:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F8253CBE57
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 13:28:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6ABB13CB10B
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 13:28:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8CF1B1000CEA
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 13:28:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80E8922262;
 Fri, 17 Feb 2023 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676636920;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OPazO8YUmidn1cV91dLwDGuBlhDGr1JljUVOf+aLQyM=;
 b=qCAwdNzfrrRygy+Hn0BnYhlLgvQgALW6jcRb2n9vf8ZPWDY81GnguCWitp1Q22vmew3cQW
 5Nj8vm9VsrQbKSFpZkIotaaIInIv3IOvA9aA0S/S3MQlEU1l0Mhiy8LRdYNx8lsvT14a93
 b2CMxJ1oKtFysb/3ouwIQQ8VIMJLQZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676636920;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OPazO8YUmidn1cV91dLwDGuBlhDGr1JljUVOf+aLQyM=;
 b=lZHjjBnehhDSl5Q/PyqEP+Wk+C2RMWygPiAyIm3BAnWyIRx1KBn0eHIm+csuQj32nIk+0V
 hnEy429uVo7ywLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16AA713274;
 Fri, 17 Feb 2023 12:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S/A5A/hy72OYZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 12:28:40 +0000
Date: Fri, 17 Feb 2023 13:28:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+9y9nRhi23wQf/Q@pevik>
References: <20230126215401.29101-1-pvorel@suse.cz>
 <20230126215401.29101-7-pvorel@suse.cz> <Y+N3DxhCsh7NAQoE@yuki>
 <20230208134523.GA31469@pevik> <Y+OsQt/ReLv1pt5R@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+OsQt/ReLv1pt5R@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/9] tst_net.sh: Rename function + add doc
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

Hi Cyril,

...
> Ah, it's more complicated than a single switch, there is actually a
> master swtich, default settings and per interface settings.

> i.e. /proc/sys/net/ipv6/conf/default/disable_ipv6
>      /proc/sys/net/ipv6/conf/all/disable_ipv6
>      /proc/sys/net/ipv6/conf/${IFACE}/disable_ipv6

> Since the deafult value is I suppose inherited by newly added interfaces
> we have to check if ipv6 is disabled by sysctl in the case of network
> namespaces as well, right? Technically we could probably check the
> default/disable_ipv6 before we attempt to create new interfaces, but I
> guess that we woudl rather want to have the same code both for ssh and
> namespaces.

In the end I decided to add check for net.ipv6.conf.all.disable_ipv6=1 in
tst_init_iface() (calls ip link set ...). This way it should be tested only when
needed. That means we need 2 functions.

I wonder if it still makes sense to check net.ipv6.conf.$iface.disable_ipv6
(IMHO needed for two host based setup with IPv6 non-friendly configuration).
I'd be for this check, but it could be in function which checks cmdline.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
