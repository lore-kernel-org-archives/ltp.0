Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD06C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 16:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02F8F3C9900
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 17:11:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83733C98AB
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:11:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 11B471A010F3
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 17:11:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EF4421118;
 Wed,  2 Feb 2022 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643818303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlukEsLtcc5qax3q7IddFsI3k4ywGkJcaOWt2ZnGRJU=;
 b=kSf8r7ek39NU69nA2gEJIpsyFn19VvjxoAaRxhxQbyEwfgUL52wvzVjwqKksdWtBJ9/lGW
 YV1/1OiOVr2zg9wIvAwEdLLjyBIIJMOi3RWnHIvAdAEUynBqaO0YHLSGACBPD3ePszRlgv
 Lj4qBn6pj9dc0NLPzudFVeZ+potylLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643818303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlukEsLtcc5qax3q7IddFsI3k4ywGkJcaOWt2ZnGRJU=;
 b=R/CzyvP7YpBApVba8B65BS3i9gQBRdY3BQa4VYc2MY1X6MT2Ysfax6nzEvTL7rZ6l2zwwr
 Mk9mSg4IX3bzsUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F389F13E99;
 Wed,  2 Feb 2022 16:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1fi4OT6t+mFBKgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Feb 2022 16:11:42 +0000
Date: Wed, 2 Feb 2022 17:13:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yfqtsi5Y0u8Sv2P8@yuki>
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
 <YfqTqAjEPalXzOK7@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfqTqAjEPalXzOK7@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > In any case, Petr, I suggest adding a short timeout to the test
> > instead of the default 5min.
> > Test takes less than 1 second on my VM on v5.16, so...
> We usually don't lower the default timeout, but here it's a good idea since here
> it blocks. It's similar speed on my machine, but I'd be conservative and put
> timeout 10 sec. Sending patch.

Actually I hope to change the default timeout once I finish my runtime
patchset to something more reasonable as majority of LTP tests finish
under one second.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
