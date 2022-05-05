Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCE7C433F5
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 11:17:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3682E3CA8B3
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 13:17:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975403CA852
 for <ltp@lists.linux.it>; Thu,  5 May 2022 13:17:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0E254200742
 for <ltp@lists.linux.it>; Thu,  5 May 2022 13:17:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DD8A211C0;
 Thu,  5 May 2022 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651749446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ9xRC1V6xzkRzQbpqq7ryD1Yf303Euk2Gj1VVSUUOc=;
 b=NxFx3D4pz5sKReF8kgDB0BnMr9kYtFqNtPWTRtE7hKGO7XTUhHq1yEmixxYUtiw8nn2lDh
 1fqDaP7E2RNeqm90cCNRN8TIsXUcBEOC59Ynw4GjmlRJWiKo/k8RWeitoE2jkffVeiziXR
 xxAi/hPjNmeOAR50W14Nlj6gt/BdqCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651749446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ9xRC1V6xzkRzQbpqq7ryD1Yf303Euk2Gj1VVSUUOc=;
 b=N02ccDknzWeIu+Jigp0RN7sGczPlKLjiS+tWPsok8Fg3iL3TsqbapBaQRaIbeCmYvPPub0
 aiqMoacq/+kDEFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13FAE13B11;
 Thu,  5 May 2022 11:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FA+4A0ayc2J3YAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 05 May 2022 11:17:26 +0000
Date: Thu, 5 May 2022 13:19:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YnOyzgLS2dBH5twV@yuki>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
 <CAASaF6w3Eh1f6qBDpDR7QBLPjzVD24X4=yPyV4Xw4EB_5nQ6rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w3Eh1f6qBDpDR7QBLPjzVD24X4=yPyV4Xw4EB_5nQ6rg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/30] Introduce a concept of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Previously, setting LTP_TIMEOUT_MUL meant that test could run twice as long.
> After patch, the description above could probably use more detail, to explain
> what this variable will affect and what's the difference compared to
> LTP_RUNTIME_MUL.

Indeed more documentation is needed.

The key point of this patchset is that timeout composes of two different
parts, static setup/cleanum timeout and runtime and each of them can be
tuned separately, so something along these lines should be added here as
well.

> > +| 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
> > +                          that run for more than a second or two are capped on
> > +                         runtime. You can scale the default runtime both up
> > +                         and down with this multiplier.
> >  | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
> >                            library. Setting it to empty string tell the library
> >                            that system is not a virtual machine. Other possible
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
