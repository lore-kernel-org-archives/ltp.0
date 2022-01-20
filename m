Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984E1C433F5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 12:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86D33C96A6
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:41:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456E33C21D9
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:41:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B803C6008FE
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:41:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18120218E5;
 Thu, 20 Jan 2022 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642682497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BLyTx/IhLNNqd/YOf3pftWyhxFDr4Lrj6wONoHJm50Y=;
 b=ikondMRvO8zK/xsjVnjbihyz8aXipZZx03pFTCOXl8xVkkfiS3qyZ060B7capVgBfkK1Iv
 8WHlAlJqJjzedNol+Fx14ICjV/M7Je95NUcoZT3p822UosqsVQsY0f7TSDnEewt8L6DFY7
 EsZQ8J+OPrkuu7gf/YK7krfNxjabS6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642682497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BLyTx/IhLNNqd/YOf3pftWyhxFDr4Lrj6wONoHJm50Y=;
 b=FScKt4HU7G/4jPLa4K30/5otE+h6r5jOLb9Us1BhiiMAToGpU2agyOTe9EBD7rsqFQY9ss
 e034Htj8EDdKsHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D56E113E9E;
 Thu, 20 Jan 2022 12:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7iToMYBY6WFcZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 12:41:36 +0000
Date: Thu, 20 Jan 2022 13:41:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YelYf/wKsbjwvcHM@pevik>
References: <20220119152732.21189-1-andrea.cervesato@suse.de>
 <YelSqq5cG6JHFtyh@pevik>
 <4ab9da33-ba2d-953b-515e-8b44a12dea6b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ab9da33-ba2d-953b-515e-8b44a12dea6b@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace ltp_syscall with tst_syscall
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

> Hi Petr!

> From my point of view, it would be nice if lapi code would only contain
> fallback code, without LTP API that requires tst_test.h or test.h. So it
> would be easy to split fallback code from "utilities" headers containing the
> most common functionalities to break the test if fallback functions are
> failing. This is the case of lapi/syscalls.h where tst_syscall is defined,
> but IMHO it should be defined out, somewhere in a "utils" header imported by
> tst_test.h or by tests which requires specific functionalities.

Well, we want to use tst_{brk,res}() in lapi :(. And these depend on counting
which mmap shared memory (see setup_ipc()). Thus things depend to each other.

Kind regards,
Petr

> This is possible only if all the tests are already in the new LTP API
> version tho, since old tests require to be refactored first.
Yep, that's the first thing to do, that's why we did not concentrated on
functional rewrite like this one, but on converting tests. Luckily lots of them
has been already rewritten.


Kind regards,
Petr

> Kind regards,

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
