Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A31C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 12:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6A43C61CF
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 13:41:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D5213C5594
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 13:41:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7CB2D1400514
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 13:41:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EF261F381;
 Wed,  9 Mar 2022 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646829687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3AemAvAa5HGiPSlTflDipkilZJOB4wWY4SL+5wNAvg=;
 b=fPDAig7yhd2lZt7TNuXJZeeEM0m6dOK2PqpdO674zkE4lsaalhu8qX9TyJq8/NoJo7JFFG
 EoyxVTlPnl8MZtiNGOzxmeoWg7nJxHHYAb0ULXE032TqXZOy8BslpfDVBxRi140X8qCL5L
 m65i5wPUHAU5hLMOovoipinhrSvFgDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646829687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P3AemAvAa5HGiPSlTflDipkilZJOB4wWY4SL+5wNAvg=;
 b=Hb3BuwKpE32gXRdphJ8ktqZg2mspFz/VX8zNml+8jdrSkC9yOcaqbdRLVh+WAq84xGW8U6
 6qEVh73I+VP775DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7065513D79;
 Wed,  9 Mar 2022 12:41:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E9d9GXegKGLaCQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Mar 2022 12:41:27 +0000
Date: Wed, 9 Mar 2022 13:43:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <YiihAgAvoHOTEyRU@yuki>
References: <20220209080510.167709-1-zhaogongyi@huawei.com>
 <20220209112312.ngyhsludc6vavcyp@quack3.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209112312.ngyhsludc6vavcyp@quack3.lan>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify/fanotify04: Bugfix for running with
 option of "-i 500"
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
Pushed, thanks for the reviews.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
