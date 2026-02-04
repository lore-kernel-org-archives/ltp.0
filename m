Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0EAE9539C
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:26:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FD7C3CE0C1
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 14:26:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 393DB3CD0B6
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:26:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0BF01400521
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:26:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBBFD5BD04;
 Wed,  4 Feb 2026 13:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770211582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhKm3zdWzjGuarksHaH8cvwDcA9n8R69tdERsO5U6k4=;
 b=0Z8SXTSwbqwOKCIC+D+5HynLzwZ2yfHi0o4XOQ3aagaamEcK1ZKJPe42Vjn+XinzjOjMKN
 GjrURQcnZcRWs7YcDfeh/505ylgzhMqesI1pNj5ntche3U/RCXvGQOQsRCS+U313OS2uJP
 0vLess6b7WOZOS6s1PqmxD6aIhKtOkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770211582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhKm3zdWzjGuarksHaH8cvwDcA9n8R69tdERsO5U6k4=;
 b=kK0xaKH2j2+OVbO3TiWOJKGpaNww4ptXu010D0yxZBjCev7g1c6nQNoxUsiLQFg/O2ybQ4
 l9rhKL8E3DHJnuAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770211582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhKm3zdWzjGuarksHaH8cvwDcA9n8R69tdERsO5U6k4=;
 b=0Z8SXTSwbqwOKCIC+D+5HynLzwZ2yfHi0o4XOQ3aagaamEcK1ZKJPe42Vjn+XinzjOjMKN
 GjrURQcnZcRWs7YcDfeh/505ylgzhMqesI1pNj5ntche3U/RCXvGQOQsRCS+U313OS2uJP
 0vLess6b7WOZOS6s1PqmxD6aIhKtOkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770211582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XhKm3zdWzjGuarksHaH8cvwDcA9n8R69tdERsO5U6k4=;
 b=kK0xaKH2j2+OVbO3TiWOJKGpaNww4ptXu010D0yxZBjCev7g1c6nQNoxUsiLQFg/O2ybQ4
 l9rhKL8E3DHJnuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB99B3EA63;
 Wed,  4 Feb 2026 13:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F3/iKP5Ig2lNSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Feb 2026 13:26:22 +0000
Date: Wed, 4 Feb 2026 14:27:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYNJTSjudAiyk459@yuki.lan>
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-4-pvorel@suse.cz>
 <aYNGgCJmEhv5nXYL@redhat.com> <20260204132143.GA209672@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260204132143.GA209672@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[14];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[free.fr];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,lists.linux.it,suse.com,suse.de,virtuozzo.com,lists.yoctoproject.org,sony.com,suse.cz,free.fr,bootlin.com,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] runltp: Remove
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
> We have /opt/ltp/kirk. Andrea suggested under 4th patch to symlink it to runltp, 
> but it'd be good to modify it to print warning it's not runltp, but kirk. See:

I would put a simple runltp script in there that would just say to
switch to kirk:

$ cat runtlp
#/bin/sh

echo "runltp was removed from LTP use kirk instead"

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
