Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D5CC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:31:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C90A43C94B3
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 14:31:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3113C8D8E
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 14:31:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0EA6D1400DAA
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 14:31:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 426A01F8F1;
 Tue, 14 Jun 2022 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655209877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYGyBXxigWftuY0Wq21fAnxTS5JCSMu+QWEercAovuA=;
 b=W7l76TmIi3S5RoxaBM/sVeHGLYGyikr+/qdM7OiA34Tji2TBPI7euxzGL/QSFzoc1Xy7h8
 cE5iMaThjC9JcqcdK/TZ+2oHqoce8eudy8sqvPSWSNhmDb80oAl9SJtsACxWghODj4DkOZ
 7WkDrGKj1aNEIH0Rl69lt8UDKZzOhD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655209877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYGyBXxigWftuY0Wq21fAnxTS5JCSMu+QWEercAovuA=;
 b=mURErtDbix7fhmzrSo1BfZfiTZIu7pJk7gYdIDm8SDHsEP/ZJRd++aWaA/BHzTL7W4ZEkq
 10bW9xrHHZULWPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFE8F1361C;
 Tue, 14 Jun 2022 12:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0ejMMZR/qGIzDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Jun 2022 12:31:16 +0000
Date: Tue, 14 Jun 2022 14:31:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: LTP List <ltp@lists.linux.it>
Message-ID: <Yqh/kqJBv2xgV3O1@pevik>
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
 <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
 <YiDDoly4t0N30kfo@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiDDoly4t0N30kfo@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Create policy for testing unstable kernel features
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

as there is another set of fanotify tests for rc kernel, I'd really like to have
some policy. Therefore I suggest to stick policy suggested by Richie in this
patchset [1], i.e. adding tests into runtest/staging until mainline kernel with
this functionality is released (feature is part of the stable kernel ABI).
i.e. each kernel release content of this file must be revised and (ideally)
moved to particular runtest file where it should belong or fixed (in rare
situations when feature changed) or removed (feature was reverted).

I volunteer to maintain runtest/staging.

This feature got already ack from Mike Frysinger, Li Wang, Jan Stancek (and me).
I'll wait little longer for ack from others (Yang Xu, Cyril Hrubis).

Anybody against it?

"remove_after_release" solution [2] suggested by Cyril and Richie, which would
keep kernel version could be quite easily implemented. But IMHO it's not worth
with current number of tests which need it (< 5, often 1 or 0).

Obviously I suggest to drop my original suggestion [2] (it didn't include
runtest/staging).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220203101803.10204-1-rpalethorpe@suse.com/
[2] https://lore.kernel.org/ltp/YdW5WEXgrotentzM@yuki/
[3] https://lore.kernel.org/ltp/20211210134556.26091-1-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
