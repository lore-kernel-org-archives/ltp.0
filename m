Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDA7C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 18:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DF363C90AA
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 19:04:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE5503C8E3E
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 19:04:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 377D5200FEF
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 19:04:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74A6A219AC;
 Fri, 14 Jan 2022 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642183483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sMfezOs7y2fMGWUdNTGGhe/YSiaNychMIwc6hmvSXY=;
 b=KsHkvBJbhaQHKFUTkVCPt5oN/95AcqacT6AfYn3TL7QSnaiAV6Y5XZNC48r0uL3DZmYJEm
 iq0FtFEA9ZBPlipbD2fsxRUb65YdxIYOtRhC/DnCIf5xSfkAqvjNBeo/KaKzmExc4ISy8g
 ycRXWD5T0Kk9kJbjdMwcW7bq4qSim9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642183483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sMfezOs7y2fMGWUdNTGGhe/YSiaNychMIwc6hmvSXY=;
 b=3oErRtTrhZKcDAJ7EPHcqaMvTMUjsQCmwtRR7YijrPzTEmFZUnTAmzxHITRW2/jXBFAia0
 gB/tuSGy+TBwEjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1932F13BB8;
 Fri, 14 Jan 2022 18:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ijGtOjq74WEBHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 18:04:42 +0000
Date: Fri, 14 Jan 2022 19:04:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YeG7OA0ezrsMiGNi@pevik>
References: <20220114104231.28338-1-pvorel@suse.cz>
 <YeGINd/M/Vgf+OET@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeGINd/M/Vgf+OET@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci/wiki-mirror: Don't check path
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

Hi all,

> Hi!
> > Because it's checked only from latest commit,
> > thus wiki does not get updated when doc change is in the latest commit
> > of the patchset.

> Looking at the file we will only do a commit when there is a diff, so
> this only runs a few more commands in the CI in the case that there are
> no changes and the end result is same.

> Looks good:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks. Merged, but unfortunately it didn't help.

I guess the problem is with
if: ${{ github.event.pull_request.head.repo.full_name == 'linux-test-project/ltp' }}

I need more time to investigate, thus updating wiki manually.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
