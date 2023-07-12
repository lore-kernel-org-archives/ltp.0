Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8284EEB64DA
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 08:37:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ED3D3CDEB3
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 10:37:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2AE33C0424
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:37:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35E7F200936
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 10:37:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EDA2219D5;
 Wed, 12 Jul 2023 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689151024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwIB4EjBCdPzbaaebmHSMNR+h/nXcQYOZ9xH2Ae7lrA=;
 b=Shc0UzGibA1C/eM4zoPayvRzl18wTuk79wzeU3v7gvvTdgZYZCSxLA4Vmn6X0n7ggtyyIU
 3PCQdSnjmetLA05pQgbEpl27uSRgeEScj4lerIU/4CBpG1n5ouAyopUpGCpy0+IKOz8ZpS
 bme/1HjaMertlMuWD3UQwHXxYESYCDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689151024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwIB4EjBCdPzbaaebmHSMNR+h/nXcQYOZ9xH2Ae7lrA=;
 b=PTP+oFp2kZswCB/kMSt8GWluCdfvIJIsUtBXSLKGpOUhlZr3GWNXwVP+ZMTMt56TXn52UK
 c0TJFIConf2MwuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5A5113336;
 Wed, 12 Jul 2023 08:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vx6YNi9mrmRtTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jul 2023 08:37:03 +0000
Date: Wed, 12 Jul 2023 10:37:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230712083702.GB756025@pevik>
References: <20230622084648.490498-1-pvorel@suse.cz>
 <ZK5bnATPwNd-kmvO@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZK5bnATPwNd-kmvO@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
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
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Anna Schumaker <Anna.Schumaker@netapp.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

thanks a lot, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
