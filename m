Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271BDC87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 08:17:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 695BB3CAC31
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 10:17:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E339B3C06E9
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 10:17:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 105E41A009AA
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 10:17:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA75A1F45A;
 Wed, 30 Jul 2025 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753863437;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBgsMUWcskE3ueC4rwPrazmZBBpAMdfF8qEXs3qxYJU=;
 b=BaFAq8OvycgQAX36wviCl6ktf2ogpYfLAIT6daLHNtdwD1U5j6D/oZ88YplOROuv3roTYk
 2iCk39c6B2O3rmDl/aKbTZESkmMWJRr3IAz1F3ydRd32u2ciTKkttSgjY7N8yUnzMgG7V0
 whwA3I3dwJ4nA/Tk9/6XwBOCCLbT51U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753863437;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBgsMUWcskE3ueC4rwPrazmZBBpAMdfF8qEXs3qxYJU=;
 b=RDmm/5BhqfSwTTNyXMCMTeAxH/0dqCJ8f+9SJ/WHuGwdIBxPfQpSsw8UbjZUnX02+/HWM9
 MiAQGFtvS3Jd8QDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZNUnKP5l;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rXp+I6YM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753863436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBgsMUWcskE3ueC4rwPrazmZBBpAMdfF8qEXs3qxYJU=;
 b=ZNUnKP5lAb23YJ5ql42p+QDP19Vb69V7ftb8h0t6WSF8D0yoHdAuC5QlYoUbOYvxKLn9Lf
 W1AL7s7tu3KwaPWMpRLAPYiDYbkJ8t+XZg7kj6XhTU8YedpQMv9GNtyRgAAU7byJWbgRff
 4/SljYRkRpAwDUy9kYQGmxak7MkYKkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753863436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBgsMUWcskE3ueC4rwPrazmZBBpAMdfF8qEXs3qxYJU=;
 b=rXp+I6YMThsIiMTwlXj5lokRwlpdQq/6gt9jzljDVVE87Tz5wQEsHT38j7uf9ehfINcXRC
 jQlfwZXHWONHG3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 516B21388B;
 Wed, 30 Jul 2025 08:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2fs1EgzViWhGUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Jul 2025 08:17:16 +0000
Date: Wed, 30 Jul 2025 10:17:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250730081714.GA54941@pevik>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad>
 <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik> <aIj0Jyn9cq9JVNbI@yuki.lan>
 <46e5368a-71a2-4a7d-9987-a9face630f20@suse.com>
 <aIn2hOwIadEPpxz0@MiWiFi-CR6608-srv>
 <7ac1840e-098f-45d4-a783-619a1760eca6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ac1840e-098f-45d4-a783-619a1760eca6@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: CA75A1F45A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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

> On 7/30/25 12:40 PM, Wei Gao wrote:
> > Just FYI discussion on similar case for fanotify14 handle selinux
> > https://lists.linux.it/pipermail/ltp/2024-March/037564.html

> Thanks Wei for pointing to the fanotify14 discussion. I'm going to implement
> the same solution we had there, even if I'm not 100% convinced about it.

Thank you! IMHO it's better to proactive check for some expected errnos than
skip on SELinux without bothering what actually happened.

Kind regards,
Petr

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
