Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0BBC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 17:14:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50D723C9669
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 19:14:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 351283C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 19:14:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C9B7200061
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 19:14:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1910E34736;
 Mon, 15 Aug 2022 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660583651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1nnwczu5N00Lw35emjA8qoGZ6TwDp2lMM14c0HhRqU=;
 b=YazbaXlvPW3Qzu8CGI1t54mAQqNnMkvF9EKT47vJ4Q6aimmb/f+EeleDzzEIkv2jUF74KZ
 Dkse607dRj7YFc3ssFgwfVJh10xdZBwylfvz55wehA2zTO7m1lkGYJ3rJDynEzv0E9qQib
 f1eXQLeEkysi/TSsiIe/dYxXL49CZRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660583651;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F1nnwczu5N00Lw35emjA8qoGZ6TwDp2lMM14c0HhRqU=;
 b=Ic8GEQFcxcF2z73g8BQspLNxPvqHlGL4hQCT1JMJggsm+zXis6MsBOhNXl7FLIeKQpnhNL
 jvkBJlD8CKX2oqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E046C13A99;
 Mon, 15 Aug 2022 17:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b91xNOF++mIVKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 17:14:09 +0000
Date: Mon, 15 Aug 2022 19:14:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yvp+4KDx837DJeIA@pevik>
References: <20220808071439.741-1-pvorel@suse.cz>
 <20220808071439.741-2-pvorel@suse.cz> <YvoWEVb9eZIHqrBI@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvoWEVb9eZIHqrBI@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] github: pull_request_template.md
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
Cc: Petr Vorel <pevik@users.noreply.github.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> So this text is filled in the pull request as a message when user
> creates it, right?

> I guess that this is a creative misuse but I kind of like it :-).

BTW lazy reporters can just click on preview to get formatting + working symlinks :).
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
