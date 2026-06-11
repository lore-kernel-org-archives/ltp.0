Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C01CD98C7
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:24:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CA433E2AB8
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:24:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759D83CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:24:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFEFC14000EE
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:23:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 849436AC66;
 Thu, 11 Jun 2026 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781169838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UR0lC7pmuC/D9CaltK0QrOQRie0KSdWM1DGNvm11P70=;
 b=irlu8dngOKParWEbMGaYa1FIMkd4jsALfapT3rCWnNXFzaYbOBQLHmQCY/GB/X9qmq1hA6
 cNLTjhnJC0hV8amYi+dx3N0pDUZG5/o7QeynF868okHNsiseGXllut7GgQNmIvD3TnKRRO
 YCNnhfekS0Gpx2gabLam9fQtRoSPlMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781169838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UR0lC7pmuC/D9CaltK0QrOQRie0KSdWM1DGNvm11P70=;
 b=uNZ4UYfy4gjjdIfs/8H7igt1KojSYwjn2QNTpV2MSvTjU1MGnbl8Rvu5jPewV6u0HlYkka
 FXrtjSDjBD5/neDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781169838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UR0lC7pmuC/D9CaltK0QrOQRie0KSdWM1DGNvm11P70=;
 b=irlu8dngOKParWEbMGaYa1FIMkd4jsALfapT3rCWnNXFzaYbOBQLHmQCY/GB/X9qmq1hA6
 cNLTjhnJC0hV8amYi+dx3N0pDUZG5/o7QeynF868okHNsiseGXllut7GgQNmIvD3TnKRRO
 YCNnhfekS0Gpx2gabLam9fQtRoSPlMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781169838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UR0lC7pmuC/D9CaltK0QrOQRie0KSdWM1DGNvm11P70=;
 b=uNZ4UYfy4gjjdIfs/8H7igt1KojSYwjn2QNTpV2MSvTjU1MGnbl8Rvu5jPewV6u0HlYkka
 FXrtjSDjBD5/neDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DDAE779A7;
 Thu, 11 Jun 2026 09:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y1lIGa5+KmqEIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jun 2026 09:23:58 +0000
Date: Thu, 11 Jun 2026 11:23:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aip-qWO-Ep2WxLr0@yuki.lan>
References: <20260611-fw_load-v5-0-7e21d40ae54a@suse.com>
 <20260611-fw_load-v5-1-7e21d40ae54a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fw_load-v5-1-7e21d40ae54a@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] firmware/fw_load: rewrite firmware loading
 test using new LTP API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> ---
>  runtest/kernel_misc                                |   2 +-
>  .../{fw_load_kernel => fw_load}/.gitignore         |   1 +
>  .../firmware/{fw_load_kernel => fw_load}/Makefile  |   8 +-
>  testcases/kernel/firmware/fw_load/fw_load.h        |  18 ++
>  testcases/kernel/firmware/fw_load/fw_load01.c      | 165 ++++++++++++++++
>  .../{fw_load_kernel => fw_load}/ltp_fw_load.c      |   0
>  testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
>  testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
>  testcases/kernel/firmware/fw_load_user/README      |  11 --
>  testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------

This is impossible to review. If you move/rename files it's usually done
in a separate patch that does not change the content.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
