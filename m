Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B814BC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 12:56:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1366D3C987B
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 13:56:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 928673C97C3
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 13:56:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C20B600915
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 13:56:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20C2121155;
 Tue,  1 Feb 2022 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643720200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wir31PZbEgGHsfg9dUAJDUrh0d2LIfB47eKuLfunL7E=;
 b=zaX9qEXhBzdbLm3P5UElWncyJhijOt0JKL3RnuiyBkoilgOg+3FP17LkzKr8MpRfWvD45G
 a4bWsqxsmhoMn+zOz0Nqi0OLS+a5pVHe5m5yG8gkhtuxCvW3eczeS7W/QwND6cPAVOLe06
 nuBRm70J8ClYtjPOBuZxZRJIANEohOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643720200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wir31PZbEgGHsfg9dUAJDUrh0d2LIfB47eKuLfunL7E=;
 b=Sp1VFTOmbIXPy//HxWASpVOB0GzYCGs99d2q2qdw20TvysNP1PwN5/S0vzbThpX53dzivq
 8plf2Z7bMKBthNBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07FD013D71;
 Tue,  1 Feb 2022 12:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MtJzAAgu+WG+XwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Feb 2022 12:56:40 +0000
Date: Tue, 1 Feb 2022 13:58:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YfkueuaAfXqVGOO5@yuki>
References: <20220201094451.7651-1-pvorel@suse.cz> <YfkMR3oM/QD9a3I9@yuki>
 <YfkPfjqRz9j2Jbuw@pevik>
 <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: Remove CentOS 8
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > We have CentOS 7 (EOL 2024) and also fedora:latest, which is 35
> > (their devel called rawhide is currently 36).
> 
> Is there any possibility to convert from CentOS 8 to CentOS Stream 8?

Is there an official docker image for it? As far as I can tell I do not
see it at: https://hub.docker.com/_/centos

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
