Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBDEC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 08:07:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29E4E3CA2E8
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:07:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A56073C9DD8
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 09:07:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 245E01400168
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 09:07:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FE461F37E;
 Tue,  1 Mar 2022 08:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646122024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y033LdzphhNZS+rKf5K1SpbjLO/p2gQF8kxePgl6Z64=;
 b=bVYGkM5YRn9te2cCGfGHrfb3QsnOzM0MRpCwPI2YsfoqNab7KTVuGMRIiEqSoS3WXWtyeO
 hFslUGriL4eNrIVxFX9gL+YurzwgIYPeWOIMWJ+EiAlQHnl4x4ZT1WxlCjfkY9AAsutz9/
 Gduw1c9/fXPuKuBuZzeKUDc6J0I8PrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646122024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y033LdzphhNZS+rKf5K1SpbjLO/p2gQF8kxePgl6Z64=;
 b=46CNwYtlUgrYIZbvVII5gQZBxGkUQS/dRT/1I2dd3sSWNNr8xJ6NXSlVRawzgKOH6avOTL
 jhWmkyLBpNUqVVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07FD013AF5;
 Tue,  1 Mar 2022 08:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UCBEASjUHWIoNwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Mar 2022 08:07:04 +0000
Date: Tue, 1 Mar 2022 09:09:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yh3Usx2v0v9/Wp/Z@yuki>
References: <20220228094659.21959-1-chrubis@suse.cz>
 <20220228094659.21959-3-chrubis@suse.cz>
 <CAEemH2dcEH_bmn2HBSZu_dEKkZguLnO7Q-p70grwG91=A2GBTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dcEH_bmn2HBSZu_dEKkZguLnO7Q-p70grwG91=A2GBTA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ksm06: lock memory about to be merged
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
Fixed the typo and changed the TINFO to TWARN and pushed.

Thanks for the review.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
