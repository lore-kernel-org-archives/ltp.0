Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFE5C27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:44:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26F123D09A4
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 15:44:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 301943D07E8
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:44:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A355F600D02
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:44:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE3A421A71;
 Wed,  5 Jun 2024 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717595048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8lDCum+z29l9jzAAL/xTl7gxvAL6qJyAbdEAE6QMk4=;
 b=K6Be1YIT0yJXpRSzpdLbnW4XuncA6Mygy9f1ZBv100gxF7EG9TWyDDMgl/EBe1F74BxelH
 bB7SaNveAwlO7r6QuEDg8Ek3l0OsHLHw/wipdBJoOp84CPqmWkBhOxKdAqqU2eHmwlA/KA
 H7eI8X3pxQE1sfNkOwOzA61Wb7rYits=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717595048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8lDCum+z29l9jzAAL/xTl7gxvAL6qJyAbdEAE6QMk4=;
 b=UIONdVEzExRcfsM8MEC1Btl7JQn3GdO6ntuR5ZAZiM8qF1xTY/RUvrNuqpSkwcadZVhyaQ
 z8h7VG6M6kTe2LAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717595048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8lDCum+z29l9jzAAL/xTl7gxvAL6qJyAbdEAE6QMk4=;
 b=K6Be1YIT0yJXpRSzpdLbnW4XuncA6Mygy9f1ZBv100gxF7EG9TWyDDMgl/EBe1F74BxelH
 bB7SaNveAwlO7r6QuEDg8Ek3l0OsHLHw/wipdBJoOp84CPqmWkBhOxKdAqqU2eHmwlA/KA
 H7eI8X3pxQE1sfNkOwOzA61Wb7rYits=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717595048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8lDCum+z29l9jzAAL/xTl7gxvAL6qJyAbdEAE6QMk4=;
 b=UIONdVEzExRcfsM8MEC1Btl7JQn3GdO6ntuR5ZAZiM8qF1xTY/RUvrNuqpSkwcadZVhyaQ
 z8h7VG6M6kTe2LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DDDF13A24;
 Wed,  5 Jun 2024 13:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fRRUJahrYGZyJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 05 Jun 2024 13:44:08 +0000
Date: Wed, 5 Jun 2024 15:44:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZmBro_t3U02xDNTe@yuki>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
 <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
 <20240605121142.GA387399@pevik> <20240605122741.GB387399@pevik>
 <ad6558e0-e834-4b35-923a-7b519384f436@suse.cz>
 <20240605132134.GA393734@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605132134.GA393734@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: ltp@lists.linux.it, Sebastian Chlad <schlad@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > It would be useful and prepare_device() implements everything that's needed
> > for it but there's a bug in do_setup() which creates a conflict between the
> > two attributes. The .all_filesystems attribute forces .needs_device but a
> > few lines below that is a check that .needs_rofs and .needs_device are not
> > set at the same time. This can be fixed.
> 
> Thanks for info, I'll have look into it.

It may not be needed. The counter argument is that if you mix a read
only filesystem tests and all_filesystems in one test you are combining
two unrelated things that are probably better to be done in a separate
tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
