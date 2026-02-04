Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74314E95392
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:58:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E25103CE169
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:58:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFD0F3C7A58
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:57:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6D5A6005C1
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:57:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A49903E733;
 Wed,  4 Feb 2026 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770209862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8R1bW9sE/aY4leHRF7UWf/Z+6s3Itfx1sEfPYWNel8=;
 b=eSigYjv0T+lz/7vwdSKjFW/ps/1M37NfYgKSK4TuA5eEs5eh7ZDmsnhsm+4zdJsHCjFDlL
 vV5eVuuId0E6st5feIPbOxIrJAeRH3pujSrXcGu+cBrGs6utPdSnVEhSsAs056+YEG/8JQ
 LkOdZF8UySW/DaLtDn1FopyPbq1NblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770209862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8R1bW9sE/aY4leHRF7UWf/Z+6s3Itfx1sEfPYWNel8=;
 b=+81k1DamFHJsH7bUOlr1VRUjmx3/jOyJPqT2KFzz2oxxMsV18Ogbw7ZhUesqwXhV4l71fg
 HuGXfg7XlXo6Y/DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770209862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8R1bW9sE/aY4leHRF7UWf/Z+6s3Itfx1sEfPYWNel8=;
 b=eSigYjv0T+lz/7vwdSKjFW/ps/1M37NfYgKSK4TuA5eEs5eh7ZDmsnhsm+4zdJsHCjFDlL
 vV5eVuuId0E6st5feIPbOxIrJAeRH3pujSrXcGu+cBrGs6utPdSnVEhSsAs056+YEG/8JQ
 LkOdZF8UySW/DaLtDn1FopyPbq1NblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770209862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8R1bW9sE/aY4leHRF7UWf/Z+6s3Itfx1sEfPYWNel8=;
 b=+81k1DamFHJsH7bUOlr1VRUjmx3/jOyJPqT2KFzz2oxxMsV18Ogbw7ZhUesqwXhV4l71fg
 HuGXfg7XlXo6Y/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 870413EA63;
 Wed,  4 Feb 2026 12:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IOGzH0ZCg2lMewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Feb 2026 12:57:42 +0000
Date: Wed, 4 Feb 2026 13:59:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYNCmJTgdCn_pmf4@yuki.lan>
References: <20260204115339.224261-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260204115339.224261-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[14];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[free.fr]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.com,suse.de,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,suse.cz,free.fr,bootlin.com,linaro.org];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Remove runltp
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  INSTALL                                       |   4 +-
>  Makefile                                      |   2 +-
>  doc/developers/test_case_tutorial.rst         |   6 +-
>  doc/developers/todo.rst                       |  10 -
>  metadata/README.md                            |   2 +-
>  runltp                                        | 959 ------------------
>  .../kernel/fs/fs_readonly/test_robind.sh      |   2 +-
>  .../kernel/io/direct_io/dma_thread_diotest.c  |   3 +-
>  testcases/kernel/security/smack/README        |   2 +-
>  testcases/network/can/filter-tests/INSTALL    |   2 +-
>  testcases/network/rpc/rpc-tirpc/README        |   2 +-
>  testscripts/Readme_ROBind                     |   4 +-
>  testscripts/lvmtest.sh                        |   2 +-
>  tools/kirk/Makefile                           |   2 -
>  14 files changed, 16 insertions(+), 986 deletions(-)
>  delete mode 100755 runltp

This is missing the pan/ directory and old scripts that use ltp-pan.
Just do git grep ltp-pan to see what should be removed as well.

And also the scripts that format the output from runltp into html that's
toos/genhtml.pl and html_report_header.txt.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
