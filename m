Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58D9C433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 09:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832F73CAB84
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:19:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE12E3CAA69
 for <ltp@lists.linux.it>; Fri, 20 May 2022 11:19:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED974608A98
 for <ltp@lists.linux.it>; Fri, 20 May 2022 11:19:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0B01F88B;
 Fri, 20 May 2022 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653038385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkRoCQDXiAIpr2YVWHDwEIEO/FCWlgHb9dxD4NUWbl8=;
 b=qrc+6qMnlBK49L6E0I1jZcVh8HCTU0tZg/uVP7V/yGvZesInoveOXRAxPC+QeBSk40/qit
 8BhwoNCPhQZZio+dr/jtDPc46xWYADy13meoELt6CYD82RfRlWWh+lzB3CkoeGkSf1Ow28
 s21/BFIiyJO2C1V6GVo62M3y+XYRukM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653038385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkRoCQDXiAIpr2YVWHDwEIEO/FCWlgHb9dxD4NUWbl8=;
 b=L9QD2AcZxud4ayZ6fJWeTAl9qLj7XLybTZvoyIOcURACOXcMQZ899B3DlCVJaqsEfn0a9P
 FP5/r5G8kv3ZdBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4717513A5F;
 Fri, 20 May 2022 09:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0xGNDzFdh2LYagAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 20 May 2022 09:19:45 +0000
Date: Fri, 20 May 2022 11:21:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YoddtIk78PdTp+xZ@yuki>
References: <20220519121056.1181-1-mdoucha@suse.cz>
 <20220519121056.1181-2-mdoucha@suse.cz> <YodY7QOisdpaI3KK@pevik>
 <10ee5852-9302-22d7-832c-f581ef94c336@suse.cz>
 <YodbppwrK3MfbyFX@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YodbppwrK3MfbyFX@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pty04: Fix cleanup
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
> > I don't see why. Running pty07 with -i0 was actually quite helpful in
> > debugging this issue. If a test fails when executed with -i0, it needs
> > to be fixed.
> Do you mean that -i0 is useful to test only setup and cleanup in C API?
> If we agree we want this (not against it if it's useful), shell API should
> be unified with it (my concern was that both APIs should behave the same on
> the same getopt option).

It never occured to me that -i0 can be used to test that setup and
cleanup are coded properly but it makes a lot of sense.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
