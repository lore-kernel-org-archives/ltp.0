Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42188C433F5
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 10:27:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576B261027
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 10:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 576B261027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CBD63C2E4A
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 12:27:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38353C2E4A
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 12:27:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED0141401111
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 12:27:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8629422146
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632738437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHYnjns8Q5YrV6I6FT2ENVLzTq5s1m3qZMpmZ+xncTM=;
 b=jMBtNCmrDxvb12/PfLnc+gxarF3AIhlMUEgNQNvrw0RaTKMxmFjaPRmqfyJZD8UGluWY/8
 Ww2ZBkbmwpVuv3xyyHJ0wBXGZBktfGIivk7aBYzlkaAtJbRCxINzVKP+RgKZPOrR+/kmGX
 klFiU3n/nM0sx7tsVMGIM3F7aMPBrL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632738437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHYnjns8Q5YrV6I6FT2ENVLzTq5s1m3qZMpmZ+xncTM=;
 b=/Oav/TVsLkXRfgBdINu6OiBSFucIpwnInT7++5t0BfvlR24mjUbNacKxmES+DfxK7sdxC9
 bF2/yu3Lr+oIdVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 710EF13A8A
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 10:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3si+GoWcUWFgHAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 10:27:17 +0000
Date: Mon, 27 Sep 2021 12:27:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YVGcqIa8AjhLCTl9@yuki>
References: <YTim11sKKT8ioZBe@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTim11sKKT8ioZBe@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release planning
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Since september has started already we should start preparing for next
> LTP release. Lately we tend to release at the end of the month, which
> still leaves us plenty of time for the preparations.
> 
> Looking at the calendar we should start the git freeze at the end of the
> next week on Friday 17.09. That would give us a bit less than two weeks
> for pre-release testing and then we can finalize the release at 29.09.
> or 30.09. If this schedulle does not work for you, let me know.

If nobody complains I would produce the release today in the evening, I
think that we have solved everything that had to be fixed and there is
no reason to further delay the release. If you have a last minute fix
make me know now!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
