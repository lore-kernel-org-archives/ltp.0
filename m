Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E5CC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 15:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161483C9774
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 16:19:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB1F53C2159
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:19:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0EAD61A0091C
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 16:19:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D7A21F391;
 Fri, 28 Jan 2022 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643383180;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ9lMLehoP4zrHtbNSYpCXK6USHx88eb7JTrYRsOSF8=;
 b=XIF+HRedeYHUjbE/650QJkb7kT7fBKh/ijZzCt89GwROefamRUSAFH4RLWTUnIJIKGyu9U
 JL1vuCn8dKQWcUfL13Y+AFCJDRPD1GA2FPNTqvud2LWj2riFAaOfua8ygZnXz/hXz0R0G2
 v8KtuPU+1b27YVK0ZTaPQFSZ8iLRJJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643383180;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZ9lMLehoP4zrHtbNSYpCXK6USHx88eb7JTrYRsOSF8=;
 b=IUF7XZEGf2RGsWAO2IWOZiMGyrQk4XY1BeiS+UV5tfytVKmGzAeAZFAA3/v6Nd4ww38SW7
 vMKyL3LTJbf2w7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD6C0139D1;
 Fri, 28 Jan 2022 15:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KX2eM4sJ9GFjQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jan 2022 15:19:39 +0000
Date: Fri, 28 Jan 2022 16:19:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfQJigTGFNDrkbB6@pevik>
References: <20220125144043.31798-1-pvorel@suse.cz>
 <20220125144043.31798-2-pvorel@suse.cz> <YfPwdgiq7MDM7E8a@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfPwdgiq7MDM7E8a@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] lapi/sched.h: Add include <sched.h>
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
> > We including headers in lapi headers instead of depending headers are
> > included in tests which use lapi headers.

> -ENOPARSE
:)

> The patch itself looks good though.

> So maybe this should be something as:

> Include <sched.h> and "lapi/syscalls.h" in "lapi/sched.h" instead of the
> tests.

Thanks! Fixed and merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
