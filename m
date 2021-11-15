Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3C9C433EF
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:39:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC8D61BFE
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECC8D61BFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E36293C85FB
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 16:39:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D58413C0E98
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:39:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 564FC200065
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:39:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7081E218B5;
 Mon, 15 Nov 2021 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636990740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7pewqOIYh7SL5MvKPFzJCzFxbW70Mmm6iN2KLQ0D8w=;
 b=v3dKwuJWxnwCEUC+6XwNNZB0Ll3Io+BP9e0t0RhSezgBJ7i7drQzI562Vzb6w+jZwFeQ2F
 R7I170cCJTaCYM+7fzmWIDGM61axS2ohivHRyUOnfCEYBS1r33lj2z/QZX3u8j+uIBIwXR
 G9fHrSth0+FIOs/SXrz6eA0y4KXRkqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636990740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7pewqOIYh7SL5MvKPFzJCzFxbW70Mmm6iN2KLQ0D8w=;
 b=F9YDWEfu1kzM8z6qIqw7derabQ98OdZSgIU2MtwIC9lMNhyYlIj8C+auazJt6L+5YEIt8f
 /7pwrncLxHhnGvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C5F612FF7;
 Mon, 15 Nov 2021 15:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bA1nFRR/kmEIXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Nov 2021 15:39:00 +0000
Date: Mon, 15 Nov 2021 16:40:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZJ/VOTmXlkBzEbJ@yuki>
References: <20211115081526.384856-1-lkml@jv-coder.de>
 <20211115081526.384856-4-lkml@jv-coder.de> <YZJ7KeRXJbEne7Jz@yuki>
 <8d0d2702-1b8f-4d59-7a78-b78276a9189d@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d0d2702-1b8f-4d59-7a78-b78276a9189d@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] realtime/matrix_mult: Fix test optimization
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > These static function conversions should ideally be in a separate patch
> > as well. At least the patch description does not mention either of these
> > changes.
> I just did some cleanup here. Would it be ok, to do all cleanup in one 
> commit and the fix in a second one?

Yes, that would be perfect.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
