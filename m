Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F046FEE6459
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A1073CE69C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:19:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B313CE684
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:19:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9CC3D14088EA
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:19:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7744121866;
 Fri, 15 Sep 2023 11:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694776766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK6HI+HrKvzuMl8P4kbvsZ9xZFhTaluycL0YBU6LXXs=;
 b=wifbcBE7J9jLOC2vGWBzb7GrKNMdLYK7jykrFdginJM8iWMqhuggG2bcujtQyA6Yol12aM
 3GsmPiW0ihk49M1h73gPdpxZ+1eeVQgzLkGmCkcIoLAgX6Yd76Xl25oINANoDWkfvRZMvc
 r/a7/sNFCLnoCmPpfioUbWh9WLMe2rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694776766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK6HI+HrKvzuMl8P4kbvsZ9xZFhTaluycL0YBU6LXXs=;
 b=D7Iks5FY63x/yNMA/gebix83DXLmJqOiBGUWByFLF1MqRXx2OdUOINgNSeavhUGvw58Np0
 FmhunMY24vpAiGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2493E1358A;
 Fri, 15 Sep 2023 11:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MVsSB749BGVtHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 11:19:26 +0000
Date: Fri, 15 Sep 2023 13:19:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230915111924.GB46324@pevik>
References: <20230915091547.26270-1-andrea.cervesato@suse.de>
 <ZQQ4ax1A2ZkFNwIH@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQQ4ax1A2ZkFNwIH@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace runltp-ng with kirk framework
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

Hi Cyril, Andrea,

> Hi!
> > Kirk application is a fork of runltp-ng and it aims to merge multiple
> > Linux testing frameworks in one tool, providing support for remote
> > testing via Qemu, SSH, LTX, parallel execution and much more.

> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  .gitmodules     | 6 +++---
> >  tools/kirk      | 1 +
> >  tools/runltp-ng | 1 -

> Do we also want symlink from runltp-ng to kirk?

+1

BTW I suggested Andrea in the beginning of kirk to have runltp-ng symlink,
which would behave like 'kirk --framework ltp'. I.e. this:

./kirk --framework ltp --run-suite syscalls

would be equivalent of

./runltp-ng --run-suite syscalls

Instead of having to run:
./runltp-ng --framework ltp --run-suite syscalls

In that case kirk would be a drop in replacement.
Andrea, would it be possible to implement this functionality?
(the default framework could be detected by symlink name, the same approach
busybox uses, more symlinks could be added).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
