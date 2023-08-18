Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA15C001DE
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 09:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51C083CCAC6
	for <ltp@archiver.kernel.org>; Fri, 18 Aug 2023 11:12:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 779143CCA76
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:11:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D4091400F94
 for <ltp@lists.linux.it>; Fri, 18 Aug 2023 11:11:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D414821884;
 Fri, 18 Aug 2023 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692349916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhfgstNuHZJ3RyMDLG6PZE8RbD5+PvZhSqsEn43mxfQ=;
 b=Chs3OMpITD1rVwViFX+CrR7fUZGhsdvflzpn23Rr1kBrNdlt3G3ra9uAWMF40PIdIWUADA
 /yMHnJ+24rCXE3Ily6ThH42OSk6dwAsTTwvRW9b9UlGAez9CtttCw8OTad3zi8fwMUY0Dh
 I7TK53gxa21TgRpSPgXtNMztfYdbY2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692349916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DhfgstNuHZJ3RyMDLG6PZE8RbD5+PvZhSqsEn43mxfQ=;
 b=5vPRD34mfK1jV65nueosnuq3fIJaQRcAe7CdcdAVIDm/DHvl0Md8XevE1erAAX3/JMyrg6
 bT5OJFJRpkqBM2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4C9313441;
 Fri, 18 Aug 2023 09:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZaLPJNw132RdIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Aug 2023 09:11:56 +0000
Date: Fri, 18 Aug 2023 11:12:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZN82E06YPdKfHMhb@yuki>
References: <20230811115647.32387-1-chrubis@suse.cz>
 <20230811115647.32387-2-chrubis@suse.cz>
 <CAEemH2fCOye2v8yL7AR6JO7Ar4tW83sB4Fi=YzJUuSCzhmtkiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fCOye2v8yL7AR6JO7Ar4tW83sB4Fi=YzJUuSCzhmtkiQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] lib: tst_buffers: Add bufs .str and
 tst_aprintf()
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
> I didn't see any place to invoke this function in the patchset,
> does it prepare for the coming case or others?

Indeed, this is added so that we can use it in setup functions for the
the *at() test rewrites done by Yang Xu.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
