Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD947C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 12:13:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 563D03C9F0F
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 13:13:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 349F23C9458
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 13:13:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 95EC41A0014E
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 13:13:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B70461F385;
 Fri, 11 Feb 2022 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644581586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WPeGMWOFSL0a3Sf6PwJAJkJ4LwgW25peEWufNvrH6A=;
 b=jYEkaWD28u0xz/ZohNMWku0/Z2tDZBW1bSABhikMNmzYR+FO5Wa/Tl92S7xJ83L0961KwG
 LSRvUWAFL3UJQ8o8XyuOTPoOozSlgOFSlxWmkiBvcJh+tB+vgy52OhVy80VZCroyktCg7E
 HTvwrpRaXdwevZt/XzZoCjXnfjnWY7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644581586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WPeGMWOFSL0a3Sf6PwJAJkJ4LwgW25peEWufNvrH6A=;
 b=PvAw5PZwHMInIgTRYNjdXl54D6Qrb5/znIW9ys7g8B8yglyvO9Wn8jBy1cIcaRltVAcxO3
 JrQzWsGH5uS2VeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9321D13BF3;
 Fri, 11 Feb 2022 12:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xz5jI9JSBmKcZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Feb 2022 12:13:06 +0000
Date: Fri, 11 Feb 2022 13:15:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YgZTUieAoFFLJViP@yuki>
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
 <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
 <CAEemH2c6muy5xNGAqhTpVqYwbiVUTFg-gOkHg6JZE_DHLgtxyA@mail.gmail.com>
 <CAEemH2d1ECs=3s63UGu1tLuQu8Uy-e9GSfO1t-yCUi+ZGLKsdQ@mail.gmail.com>
 <b71648c0-475a-2404-21a0-f2df8c221ead@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b71648c0-475a-2404-21a0-f2df8c221ead@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
> Hmm, that's weird, when I tried that approach yesterday, it kept leaving
> the child behind. Now it seems to be working. I guess I messed up
> somehow and the test program didn't get relinked against new libltp.a...

Just FYI the process group lifetime ends with the last process exitting
it's group. Otherwise there could be all kind of races in the case when
you send the SIGTERM signal to the whole group, e.g. if the leader got
the signal first the rest of the processes may not be terminated if the
group lifetime ended with the leader...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
