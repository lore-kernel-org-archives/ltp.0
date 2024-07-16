Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCD4C3DA49
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 08:14:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB82C3D1A6C
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 10:14:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67F153D1A13
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 10:14:26 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC112204B44
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 10:14:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DC1421C1F;
 Tue, 16 Jul 2024 08:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721117663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73XheMZrrInHhZTcSNtkyVbd9GMkJvTF+XMjaAxorfc=;
 b=r0dDASTwceBxgDyHLTW2N7PKrwT5llFLCs4T4TQ8gA0MZ2sbu0wyzy6DMQv0G0rpbjcFZU
 tZ3AjT66/n0rYBzZHD0fMlAPp5lQemoVi3GDUGkwNrGX+kvgJd0Kp7b3Bk9aUsygtM6Qws
 WaIGy8y0hNQsauZbCOBfNoF58k+4I/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721117663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73XheMZrrInHhZTcSNtkyVbd9GMkJvTF+XMjaAxorfc=;
 b=92/ToEqDRcxwJVh089MT03Diai4ndhCkkZTnRttVtELMj/7XtJCAaS6WJHvW+vTA4rWUfl
 s4zCwJEDx7IHYCAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721117663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73XheMZrrInHhZTcSNtkyVbd9GMkJvTF+XMjaAxorfc=;
 b=r0dDASTwceBxgDyHLTW2N7PKrwT5llFLCs4T4TQ8gA0MZ2sbu0wyzy6DMQv0G0rpbjcFZU
 tZ3AjT66/n0rYBzZHD0fMlAPp5lQemoVi3GDUGkwNrGX+kvgJd0Kp7b3Bk9aUsygtM6Qws
 WaIGy8y0hNQsauZbCOBfNoF58k+4I/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721117663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73XheMZrrInHhZTcSNtkyVbd9GMkJvTF+XMjaAxorfc=;
 b=92/ToEqDRcxwJVh089MT03Diai4ndhCkkZTnRttVtELMj/7XtJCAaS6WJHvW+vTA4rWUfl
 s4zCwJEDx7IHYCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B6D813808;
 Tue, 16 Jul 2024 08:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OL0jHd8rlmbHAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 16 Jul 2024 08:14:23 +0000
Date: Tue, 16 Jul 2024 10:16:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZpYseQ7IXlzyxt-e@rei>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
 <Zov59BQ_7j-1080J@yuki>
 <e3f88888-2a5e-4515-9805-bc605e081f52@suse.com>
 <ZpURPV6wv26kpXOb@yuki>
 <f903dd6e-6d5a-48f0-825e-71e4f216b5aa@suse.com>
 <ZpUWaGR0BmgT1j8E@yuki> <ZpVHnkY5mptj6ETA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpVHnkY5mptj6ETA@yuki>
X-Spamd-Result: default: False [0.20 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] cachestat testing suite
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
> So if you call cacestat() on a socket fd it will try to loop over empty
> list of vmas and the end result would be statistics that are full of
> zeroes. Maybe that is worth of a special test just for this case.

Thinking of it over night it may make sense to write the tst_fd test and
either expect EBADF or the statistics to be zeroed for file descriptors
that do not use page cache (i.e. are not file based).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
