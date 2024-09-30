Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF44CCF6497
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 08:49:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 228563C55DF
	for <ltp@archiver.kernel.org>; Mon, 30 Sep 2024 10:49:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F2F93C55A6
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 10:49:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B32F200BA5
 for <ltp@lists.linux.it>; Mon, 30 Sep 2024 10:49:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3DE921992;
 Mon, 30 Sep 2024 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727686159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCjQPrnAUasXcnc3mndqWLGz/stKPIOaqjlIQpxPXc8=;
 b=vWfgYVqCtUtN5nIX10P8E76c1c84xAQ9J22qw9l7nSRrgs93NJwh21/nn3QvibIjWPNzll
 ZObUIP5G9z9+vZxWJyXle0nGlhp3v/pu7UPnEzNJ7a52Kun13hlZ+X6Nrb+mYqDqI8WLCR
 x8M8Md4QDZXB8sRTGceilRCvILnzCkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727686159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCjQPrnAUasXcnc3mndqWLGz/stKPIOaqjlIQpxPXc8=;
 b=SG8CJbBL4Xf1Pov5oBJku5LnyHT6NccOPYqGypoXr1FYAYD0Pux7GASFsyhHHOOnzxIeIu
 L3yM4I2/JDDh0sDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727686159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCjQPrnAUasXcnc3mndqWLGz/stKPIOaqjlIQpxPXc8=;
 b=vWfgYVqCtUtN5nIX10P8E76c1c84xAQ9J22qw9l7nSRrgs93NJwh21/nn3QvibIjWPNzll
 ZObUIP5G9z9+vZxWJyXle0nGlhp3v/pu7UPnEzNJ7a52Kun13hlZ+X6Nrb+mYqDqI8WLCR
 x8M8Md4QDZXB8sRTGceilRCvILnzCkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727686159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCjQPrnAUasXcnc3mndqWLGz/stKPIOaqjlIQpxPXc8=;
 b=SG8CJbBL4Xf1Pov5oBJku5LnyHT6NccOPYqGypoXr1FYAYD0Pux7GASFsyhHHOOnzxIeIu
 L3yM4I2/JDDh0sDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6AD9136CB;
 Mon, 30 Sep 2024 08:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qv6rJw5m+mbNIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Sep 2024 08:49:18 +0000
Date: Mon, 30 Sep 2024 10:48:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Zvplydmhvr084pJ4@yuki.lan>
References: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
 <ZvVMJQhI_4tTFfYB@yuki.lan>
 <cc358271-b656-4314-9cc7-83429b24aba2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc358271-b656-4314-9cc7-83429b24aba2@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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
> But since this would turn into a fairly large change right before 
> release, I'd recommend reverting the ioctl_ficlone tests before the 
> release and merging them back after.

That's what I plan to do, revert the tests, tag the release and apply
them again, so that we can fix them properly in the next development
cycle.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
