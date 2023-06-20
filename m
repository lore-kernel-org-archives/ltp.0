Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A89EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 09:13:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECA6F3CE0FB
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 11:13:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 009E23CAD3F
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:13:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B768600281
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:13:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E3AC218B1;
 Tue, 20 Jun 2023 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687252398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDC926ykHKG0aaztEC/Ck1on3g2DmQtx85Bdv/fBxNw=;
 b=mRad2ebYSw0UObb/0byXwVUaHteDmUoPKUcnMQZ9HhVMJ5o+3r8l6JLTyMVkhspzJE+gUP
 UpxwHFU5TZPRpkZBmr+6osvVekpD4Ukjhv/vflA/DbyenbePUXiWINzuY1UyjJX3z9V6Jc
 z5s2HFSJZPR8H/MOiYF0I0s8tayYZTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687252398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DDC926ykHKG0aaztEC/Ck1on3g2DmQtx85Bdv/fBxNw=;
 b=f/Pg/aX4K8zWmvZ/Dx4cJjGnWKefDAeZwApnCNKlNa0tNyPw0dCas5Z6HZWC5Yc2eL7xlt
 aLb3OVMBlwPZV7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38C54133A9;
 Tue, 20 Jun 2023 09:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WI6zDK5tkWQjNAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 09:13:18 +0000
Date: Tue, 20 Jun 2023 11:13:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Damien Le Moal <dlemoal@kernel.org>
Message-ID: <20230620091316.GB275381@pevik>
References: <20230605044131.798383-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230605044131.798383-1-dlemoal@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Improve ioprio tests
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Damien,

> The ioprio syscall tests rely on ltp internal definitions of the
> IOPRIO_XXX() macro defining priority classes and levels. With changes
> to the ioprio API to support command duration limits, these internal
> definitions are incomplete, causing test case ioprio_set03 to fail.

> Avoid this issue by having the iprio tests use the kernel header file
> definitions if that header exists. This enables additional checks in
> the header file [1] which restores the expected results with test
> ioprio_set03.

> [1] https://lore.kernel.org/linux-block/20230530061307.525644-1-dlemoal@kernel.org/

> Note: a review of this patch on the kernel block mailing list would be
> very appreciated.

I haven't found this patchset on https://lore.kernel.org/linux-block/,
did you send it there?

Kind regards,
Petr

> Damien Le Moal (2):
>   ioprio: use ioprio.h kernel header if it exists
>   ioprio: Use IOPRIO_PRIO_NUM to check prio range

>  configure.ac                                  |  1 +
>  testcases/kernel/syscalls/ioprio/ioprio.h     | 33 ++++++++++++++-----
>  .../kernel/syscalls/ioprio/ioprio_set03.c     |  2 +-
>  3 files changed, 26 insertions(+), 10 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
