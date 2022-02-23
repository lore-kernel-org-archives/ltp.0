Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404CDC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 14:47:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B631E3C9AE9
	for <ltp@archiver.kernel.org>; Wed, 23 Feb 2022 15:47:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD7ED3C9769
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:47:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 765E61402FAE
 for <ltp@lists.linux.it>; Wed, 23 Feb 2022 15:47:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 77524212B9;
 Wed, 23 Feb 2022 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645627642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiUCuPPaBgCf47Rhsg5BBfqZmboSq1pZFc3/pW7sOeg=;
 b=LXNEASSrlnoK0ArtPcEafarNA1pBP5+aj5epeZTe4NYPZ8pWXKqkCahbxR9KkivHHryJlW
 wjTgUOVXk+BFPp3VYLf95LVGzlQ4Hl45SGFmDrpLE7zh+D9KMITWXOOyepF3B6oEviuJr0
 kCzP43vj6f/Qzj+1WQwiAs9sql2cAwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645627642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiUCuPPaBgCf47Rhsg5BBfqZmboSq1pZFc3/pW7sOeg=;
 b=WMg2rhNC2gQlFlEZi3vEi1m7jVM7XdAECe4f0SdURT7AcUXugmMnGgme4Hh+TU8nIYcOZJ
 Az/M9QZ/uHCOPGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F67D13D70;
 Wed, 23 Feb 2022 14:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kxf7CfpIFmI6VAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Feb 2022 14:47:22 +0000
Date: Wed, 23 Feb 2022 15:47:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YhZI99JpVu0c1HGY@pevik>
References: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
 <YhUKtWP8dwNBAcmy@yuki>
 <26fe8a19-8557-5a63-7e5f-fb126e8eed95@virtuozzo.com>
 <YhUe1yp0ukdUJs1V@yuki> <YhUsAQKHl8w9AyRq@pevik>
 <YhYsJqnjs1kIt13E@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhYsJqnjs1kIt13E@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
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
Cc: kernel@openvz.org, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Ah, right. But I guess that adding a simple tool that would behave just
> > > as echo but the first parameter would be filename may be cleaner
> > > solution than wrapping around the sysctl command.
> > +1. If really requested please create C binary testcases/lib/tst_sysctl.c.
> > Code which use simple SAFE_FILE_PRINTF() as many C code does would be fairly
> > simple, more portable and probably faster than shell script. FYI we tend to
> > rewrite shell code into C.

> I would even call it tst_write since it's pretty generic tool that does
> write to a file.
+1, good point.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
