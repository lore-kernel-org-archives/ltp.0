Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CFEC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 06:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87533C641F
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 08:39:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABB4A3C54EA
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 08:38:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC2C92009F3
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 08:38:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFB531F97D;
 Wed,  1 Jun 2022 06:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654065532;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gjl07P5uH+PjhL7GvAYmuZuhZl9ZC9+91kGIIgvGuBg=;
 b=WVQpZL8F4Bm/p/+MGue+Dr+0t6Zi5BxLfxUCn0+aVYtlY8P7zmTAWr8LnNiFK7gvR9WsR6
 CR89mkLi4AR5teuno9JmaQjInzLAEg4akaepReUGl12EYDkSZV83GnmeAMV3qNAVoGroLm
 9GKJowM351q0CkwXfhIO1Op3xwWy1ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654065532;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gjl07P5uH+PjhL7GvAYmuZuhZl9ZC9+91kGIIgvGuBg=;
 b=r3oik/ZLfuqjWnJhw9YYmyRkxbTJZQXPXK882tbe+fM8C9Zp7M7TuF+mZrrwS4Wer+4DXz
 D0X0LXWle60oMoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 757FF1330F;
 Wed,  1 Jun 2022 06:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 03rVGnwJl2LUHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jun 2022 06:38:52 +0000
Date: Wed, 1 Jun 2022 08:38:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YpcJTxB6O5xGyfQG@pevik>
References: <20220512194557.30911-1-pvorel@suse.cz>
 <20220512194557.30911-2-pvorel@suse.cz> <YpTO1ttcqpbRzxoJ@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YpTO1ttcqpbRzxoJ@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] tst_test.sh: Add $TST_MOUNT_DEVICE
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > +	if [ "$TST_MOUNT_DEVICE" = 1 -a "$TST_MOUNT_FLAG" = 1 ]; then

> Isn't the TST_MOUNT_DEVICE redundant here? We set the mount flag only if
> the device was mounted by the library. Or do I miss something?
No, you're right $TST_MOUNT_DEVICE is redundant. I noted this after sending a
patch, just forget to note it on ML. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
