Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39985EB64DC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 05:11:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B719D3CC1F1
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 07:11:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622383C9D07
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 07:10:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 508F61000458
 for <ltp@lists.linux.it>; Mon,  3 Jul 2023 07:10:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3CD51FD6D;
 Mon,  3 Jul 2023 05:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688361054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TUCxsfveH45IDKaeRKB7kWChuuAhgP3mEW0ncDgrpo=;
 b=S55YraYRK9PK7dDb/k9ZCs1bXob+VA3CCymWWLOqhcDKU6oaiJOYXqI3g6Y0HJguXlB9rR
 0SgulphT+UPpdkx5cuXqjeprYg0/V0wN/2ubh+59WPCyNscKuEVax1mFl75nIvqamgPdU+
 5Rnpjmmljt0T3DbI99TFW8LHJP6bdMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688361054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+TUCxsfveH45IDKaeRKB7kWChuuAhgP3mEW0ncDgrpo=;
 b=zv6FQJA9i6auyrR5kR9M0wBrUXsbtE2fnAPNpD+NH6h3znzQnAap0ef9B1FuEU//LHP5CK
 A0vyRe612lo8geCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F84613276;
 Mon,  3 Jul 2023 05:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ygkXFl5YomRbGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 03 Jul 2023 05:10:54 +0000
Date: Mon, 3 Jul 2023 07:10:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <20230703051053.GC363557@pevik>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs
 device attribute invisible when not supported
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
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, lkft-triage@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>,
 Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Gal Pressman <gal@nvidia.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I wonder why LTP was Cc'ed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
