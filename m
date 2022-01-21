Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6BC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F3453C970C
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:24:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BB243C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:23:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9548A600689
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:23:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1CC41F884;
 Fri, 21 Jan 2022 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642760629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65xW0ERy7f7G3sCeiC+EWeKQPfqcZpQ0lcIUe/LK1y8=;
 b=zkbSNA3d6p14qEcobWa0++q9739fA8iBOAoVHhYWHJtijQc+GOg+AaQXsdz4EcHXBE7a9G
 tNlniwd4Vi07DOTwfHCxyfc/gJ2ApH5sF0PsAVoYtqFrxoMrZVxL+QJ7uJrgh8oYJxfa3N
 oRVFOh18d5zMdfV5398nI5TztLdwunU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642760629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65xW0ERy7f7G3sCeiC+EWeKQPfqcZpQ0lcIUe/LK1y8=;
 b=pHX7QpCG3OWS6HSJ6OX/r25gPSLX48uFwK99X6wT3AYss39gIrQvPQscUl4HqrfXiHz+JH
 P/4UkoKZ+iAHSsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62F2413C32;
 Fri, 21 Jan 2022 10:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p2oVFrWJ6mHPbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 10:23:49 +0000
Date: Fri, 21 Jan 2022 11:23:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YeqJldSH5JV0duHb@pevik>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki> <Yep1Wm84sKzl3iB6@pevik>
 <Yep6u4N+phjB32Xd@pevik> <Yep8ntzBsWApxU8c@yuki>
 <Yep9LbxzJ5s3S8Gn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yep9LbxzJ5s3S8Gn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,
> Hi!
> > Also I do plan to fix this properly by V2 of the runtime patchset once
> > the release is finished, so I would go for minimal fix just before the
> > release which would be setting tst_test.timeout to sufficiently large
> > value.

> And I guess that we should do that for all the rewritten aio tests.
Sure, agree. Would be .timeout = 1800 enough (30 min)?
I can send a patch based on my last patch "aiodio: Skip tests on tmpfs" [1]

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YeqIB+Y4rO2XK57i@pevik/T/#t

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
