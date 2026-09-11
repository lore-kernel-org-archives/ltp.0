Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9AEC88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 278323E921C
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:13:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11C793C876A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:13:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D8283200AC7
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:13:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7F9621A64;
 Fri, 11 Sep 2026 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4TJfwJxNtPdC5Ig9j+XpMvCgf0V4CXUyx70eOZ9Gdc=;
 b=lMebOlz46XASopFkiDgXJyUz2F3XxfomTaM/WmiTDuiPRqvujSRWZZvxx8Qyf6nz1f/Q7G
 kUMlD4ByRLLwAEQJA0sKfelQZoeNbhdX3ZBmxuY3glSrQo92y4pweNy6+ljDv4eWFyTAbP
 HqLNdYp/LPgJx02qhcj+KGhwVSPg5OI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4TJfwJxNtPdC5Ig9j+XpMvCgf0V4CXUyx70eOZ9Gdc=;
 b=aynq4ypt5w2OEu8rEUgboqsTlMqLzBK+cXUxIT/yGkY3dBDm8zJD+2Z4LeqiUK+V4F76YZ
 Y4mC5tE4XlUWynDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4TJfwJxNtPdC5Ig9j+XpMvCgf0V4CXUyx70eOZ9Gdc=;
 b=R5gpMCHexp+HOemJeMTQsJ/BLhybHoWxWEWm1Ykk4AvD2oyO1v5+iAtrdgGx2FIdh+RZdQ
 inCuC1gv+k3A1sRkeY+qmYZaX8F8p188wrO+2x0iRp1ljMEs59m2lEIQShAx5woHG9pjVS
 4qPSOEVZP8INwzIQTW7wakSJYQqktFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4TJfwJxNtPdC5Ig9j+XpMvCgf0V4CXUyx70eOZ9Gdc=;
 b=XsWKmV6HEl7udj3g6LYZTwWzY3fECnrbso8L5YsNUi7EUqo76o5Xiod0vw70KsTszEIJPB
 2wVszzybg2eKpsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA5913715;
 Fri, 11 Sep 2026 12:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UAA6B2rwo2ovbgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 12:13:30 +0000
Date: Fri, 11 Sep 2026 14:13:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqPwdOKgL7CFPM5l@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-14-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-14-43b78b15ef9f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 14/33] keyctl22: Test KEYCTL_RESTRICT_KEYRING
 reject-all
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
> +/*\
> + * Test ``KEYCTL_RESTRICT_KEYRING`` reject-all of :manpage:`keyctl(2)`,
> + * added in Linux 4.12.
> + *
> + * [Algorithm]
> + *
> + * - restrict a keyring with ``NULL`` type and ``NULL`` restriction (reject all links),
> + *   verify subsequent links and add_key fail with ``EPERM``
> + */
> +
> +#include "keyctl_common.h"
> +
> +#define PAYLOAD		"payload"
> +
> +static key_serial_t ring_reject;
> +static key_serial_t user_key;
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	ring_reject = new_ring("ltpkeyctl22_reject");
> +	user_key = new_user_key("k", PAYLOAD, sizeof(PAYLOAD),
> +				KEY_SPEC_PROCESS_KEYRING);

Here as well.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
