Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4CCC3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90CC3D1F6A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 13:36:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D5F63C1BDA
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 13:35:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9AC660046D
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 13:35:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDCA9218FF;
 Fri,  2 Aug 2024 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722598551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6AXskO3k5C7oUpz9BDaEReZPQ2bI7uHwx3ldDpaRTk=;
 b=wIvKbn4TdVY1h9ECm/anZ0wAgnc66CgkGiEvQA4RfSge/yTCP7DnbRO/d/JTEd5SnoVSFr
 iSV+Yh6uJKYepPKB8M2s9Kj6Hp096niYZIWEbiq9wXz+uZ2NjZco2k4Wev86sHy6S9G12z
 Lz7nGXd+y7wOW3NlVzrMy+rx9RYoB/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722598551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6AXskO3k5C7oUpz9BDaEReZPQ2bI7uHwx3ldDpaRTk=;
 b=ko7JzJdKTx/3hNZn5TKpKYoP6mgk7l/rhwbztA6sleKNQA1KsEOC8M6EravFEiNlKZl6H/
 69jlkm6g1d66apCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1mWXN4wm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=epFFEzv4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722598549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6AXskO3k5C7oUpz9BDaEReZPQ2bI7uHwx3ldDpaRTk=;
 b=1mWXN4wmwz7+3QLh6ZTnfXHsb4fdMzGsPbETgZ5TGn+qNRmqN5H9Y7hhrLLngYrsV9YCGQ
 IwtmunanxWyUBahJURktgSAmbeR4u59fhcu/bDQqYHe62eIddKP0GylrswuRH27RuxMsQG
 6Vn9LrKyyIQBC8DzVgXlkVOt68mGG5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722598549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6AXskO3k5C7oUpz9BDaEReZPQ2bI7uHwx3ldDpaRTk=;
 b=epFFEzv4HYTrDVGI3bAR/Xx35rxYYAa5e28cV+f6DwmXIfmRKaLOLQ0ObgdhyXS1AX7U3i
 /4K+rRRiblT3prDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 892A51388E;
 Fri,  2 Aug 2024 11:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qcLLH5XErGbiTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 02 Aug 2024 11:35:49 +0000
Date: Fri, 2 Aug 2024 13:35:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240802113546.GA1627111@pevik>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
 <20240802-fchmodat2-v6-4-dcb0293979b3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802-fchmodat2-v6-4-dcb0293979b3@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDCA9218FF
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/5] Add fchmodat2_01 test
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test verifies that fchmodat2() syscall is properly working with
> AT_SYMLINK_NOFOLLOW on regular files. When AT_SYMLINK_NOFOLLOW is used
> on symbolic links instead, we check for EOPNOTSUPP, since the feature is
> not implemented for VFS.
nit: I would replace "not implemented for VFS" with:

creating symlink is *blocked* by VFS since kernel commit 5d1f903f75a8
(previously it was never supposed to be supported by filesystems, there was a
series of bugs that lead to it working by accident on some filesystems)

> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that fchmodat2() syscall is properly working with
> + * regular files, symbolic links and directories. AT_SYMLINK_NOFOLLOW is a
> + * special feature that is not enabled in VFS for symbolic links since
nit: maybe s/ enabled/blocked/
> + * (introduced by 5d1f903f75a8), so we only verify that EOPNOTSUPP is correctly
> + * raised when used on those particular files.
> + */

Feel free to merge whole patchset :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
