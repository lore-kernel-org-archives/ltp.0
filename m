Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB5EB64DA
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 13:35:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F5653CF12A
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 15:35:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF483C999F
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:35:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F03BC10009A0
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 15:35:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 478FC1F8BB;
 Wed, 28 Jun 2023 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687959338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfeEVBpwE2fWoQ9ApV7AS0I+bZ9StqHlBFCcTxWFwqw=;
 b=wazi3KNDZI9zd2jIRtEn6c5D/NkttjCUsiUVsItXB6D7IGljr3Bi1AKcFY+uzUdVnxUzXO
 i+hCGbU1fEfduvBRTEG2WRzYRFmNbBelrwh+yjXWJ9+NMwarRFQ9i5/tCSByi6IxGUsa1C
 qZX6472n1hO76q9gEL3YXdZzzJaUOpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687959338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfeEVBpwE2fWoQ9ApV7AS0I+bZ9StqHlBFCcTxWFwqw=;
 b=OjAtGgGptYgHInJ40BfIZLMpRrqoKo3pjcAnvvSnqgRvOlOuC54AtgZvkfTnlaCI9YSPz/
 RdMmEolgvQ1VfSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33EAD138E8;
 Wed, 28 Jun 2023 13:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b+YZCyo3nGTTAwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 28 Jun 2023 13:35:38 +0000
Date: Wed, 28 Jun 2023 15:36:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZJw3bPDB76tY3Ioz@yuki>
References: <20230628081831.123189-1-pvorel@suse.cz>
 <20230628081831.123189-2-pvorel@suse.cz> <ZJwb_wxDrqIlNqfg@yuki>
 <20230628125144.GA147674@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230628125144.GA147674@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/fcntl.h: Fix O_DIRECT definition for
 various archs
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I have no problem to remove O_DIRECT. The only question is what to do if we need
> it in the library one day. Will we be ok that whole LTP becaume _GNU_SOURCE due
> that?

Nothing stops us from adding _GNU_SOURCE into a lib/foo.c if that is
ever needed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
