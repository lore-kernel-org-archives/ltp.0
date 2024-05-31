Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A69C25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 08:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7A4C3D0750
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 10:02:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4A43CAB27
 for <ltp@lists.linux.it>; Fri, 31 May 2024 10:01:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C36AD601119
 for <ltp@lists.linux.it>; Fri, 31 May 2024 10:01:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49B2D21ACB;
 Fri, 31 May 2024 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717142511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0/3UImCSS4Q17w3AVgmpQmQ05Enp4kgwlrucqodv1s=;
 b=uzJ4wlaH3rCBs6jz1eAHGgkPXhCETxZpol+tYui5gRgaFPGUu+67HHyNNvjvEcYz4pfppz
 06xf1EGvV5jNmkpucVn3eMArrxCuwcz7PLPYqJRtlvupU2ZaGvr+IvqaHYZdhdrdUc6IHY
 y25NHssAb0P1JhF7Q1A7VbKEXy6FgTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717142511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0/3UImCSS4Q17w3AVgmpQmQ05Enp4kgwlrucqodv1s=;
 b=i2nu4Kwzrciygr5LIKGijwUkq4A3hLV+vX52l6vifnAyl8mZ9SYez9aTzIgoslPbUG069k
 GLVzVxA6/1WceNDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uzJ4wlaH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i2nu4Kwz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717142511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0/3UImCSS4Q17w3AVgmpQmQ05Enp4kgwlrucqodv1s=;
 b=uzJ4wlaH3rCBs6jz1eAHGgkPXhCETxZpol+tYui5gRgaFPGUu+67HHyNNvjvEcYz4pfppz
 06xf1EGvV5jNmkpucVn3eMArrxCuwcz7PLPYqJRtlvupU2ZaGvr+IvqaHYZdhdrdUc6IHY
 y25NHssAb0P1JhF7Q1A7VbKEXy6FgTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717142511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0/3UImCSS4Q17w3AVgmpQmQ05Enp4kgwlrucqodv1s=;
 b=i2nu4Kwzrciygr5LIKGijwUkq4A3hLV+vX52l6vifnAyl8mZ9SYez9aTzIgoslPbUG069k
 GLVzVxA6/1WceNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A1E1137C3;
 Fri, 31 May 2024 08:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lnoZDe+DWWZ6fwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 May 2024 08:01:51 +0000
Date: Fri, 31 May 2024 10:03:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZlmESfb2JbYbSG1_@rei>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com>
 <ZlhacuOD8hYVLYS6@yuki>
 <82ac2455-ab1c-4bdf-b4e3-5ae56dfb9871@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <82ac2455-ab1c-4bdf-b4e3-5ae56dfb9871@suse.com>
X-Spamd-Result: default: False [-4.00 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 49B2D21ACB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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
> > Can we move these invalid_fd tests into a separate test and use tst_fd
> > to loop over all kinds of invalid input and output file descriptors?
> >
> I don't know if it's worth to loop over all possible cases. Each one of 
> them has a specific test case.

This was actually requested by kernel developers, to feed the syscalls
with all kind of unexpected file descriptors.

> Also, invalid_fd test cases would look so simple that it makes more 
> sense to keep it here.

Fair enough, we can keep these two here, but we need a tst_fd test as
well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
