Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BB2CD98D2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 10:08:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9CDA3E5E70
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 12:08:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE733C2B4B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:08:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B60E014004EC
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:08:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B333D6AEF2;
 Thu, 11 Jun 2026 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781172499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdDpn0v7rhN/5YkLCbcILbMwdBdKeyUHYHpLDGCHHX8=;
 b=2/rEUkIH/HnfDc5FGxYeiciveZi/Wy9JSNneEBgQNSXQcceFY28RfR8G9wyb1D2FelKhmf
 xrqT6mHqh3TJdvNUQpd4FwFFzllPSLEBJ2WcRLPdXmsRExu7pk72ZJSPY1O4DM4c8BVRzW
 CronEXxI+Wh6KNflHCLKS8WceX5gmJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781172499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdDpn0v7rhN/5YkLCbcILbMwdBdKeyUHYHpLDGCHHX8=;
 b=K05C6eN+QbXuocwre9xYBa0xQKeVK8wjgH1vgd8qE2flOyS5w/e2gz2r9Y18EgkPZ6g0P9
 +Cmc18Wroh9VlVCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2/rEUkIH";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K05C6eN+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781172499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdDpn0v7rhN/5YkLCbcILbMwdBdKeyUHYHpLDGCHHX8=;
 b=2/rEUkIH/HnfDc5FGxYeiciveZi/Wy9JSNneEBgQNSXQcceFY28RfR8G9wyb1D2FelKhmf
 xrqT6mHqh3TJdvNUQpd4FwFFzllPSLEBJ2WcRLPdXmsRExu7pk72ZJSPY1O4DM4c8BVRzW
 CronEXxI+Wh6KNflHCLKS8WceX5gmJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781172499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdDpn0v7rhN/5YkLCbcILbMwdBdKeyUHYHpLDGCHHX8=;
 b=K05C6eN+QbXuocwre9xYBa0xQKeVK8wjgH1vgd8qE2flOyS5w/e2gz2r9Y18EgkPZ6g0P9
 +Cmc18Wroh9VlVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A37C6779A7;
 Thu, 11 Jun 2026 10:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tQnQJhOJKmoHSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jun 2026 10:08:19 +0000
Date: Thu, 11 Jun 2026 12:08:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aiqJCpkSQVGgPQGW@yuki.lan>
References: <aip-qWO-Ep2WxLr0@yuki.lan>
 <6a2a835f.5d1dab49.20a12a.a427@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a2a835f.5d1dab49.20a12a.a427@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B333D6AEF2
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
> > >  runtest/kernel_misc                                |   2 +-
> > >  .../{fw_load_kernel => fw_load}/.gitignore         |   1 +
> > >  .../firmware/{fw_load_kernel => fw_load}/Makefile  |   8 +-
> > >  testcases/kernel/firmware/fw_load/fw_load.h        |  18 ++
> > >  testcases/kernel/firmware/fw_load/fw_load01.c      | 165 ++++++++++++++++
> > >  .../{fw_load_kernel => fw_load}/ltp_fw_load.c      |   0
> > >  testcases/kernel/firmware/fw_load_user/.gitignore  |   1 -
> > >  testcases/kernel/firmware/fw_load_user/Makefile    |  20 --
> > >  testcases/kernel/firmware/fw_load_user/README      |  11 --
> > >  testcases/kernel/firmware/fw_load_user/fw_load.c   | 213 ---------------------
> > 
> > This is impossible to review. If you move/rename files it's usually done
> > in a separate patch that does not change the content.
> 
> I usually review with double column editor left=old, right=new :-)
> But I agree with you that diff is messed up. Should I send a new
> version?

Yes, please.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
