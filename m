Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ACCC87FCE
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 12:30:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7983CCE66
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 14:30:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EAEE3C20D2
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:30:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7AF2D1A00EA1
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 14:30:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA4AB2128A;
 Fri, 25 Jul 2025 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753446621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxC9Iszvpvc7ixHI4FBVhNQX4nGRfcg1eU2ZHrg1jz0=;
 b=0B/KY8ljcplMjh0DtETONeLLQg3RKQ8uCNLCD+KvKe9zF7PRaRKolagfouRn7QWQzxS5Cs
 HlPiK0aKEuS8zRl1C+JJzb/jtklSz4Nj+22bI2pF4hdo3uxnZFw5o0wp205wZji6+kb7Ex
 F20X2709vukgZIk3RTgdZqSUgs9+yb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753446621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxC9Iszvpvc7ixHI4FBVhNQX4nGRfcg1eU2ZHrg1jz0=;
 b=i39XMZbVSz9qUWbt5lRhKBG9cweAxaFeNQqdVyDA98tt56gXQwHWdrN2ohiFfesDSicrS9
 xaAvnH5OzRu8JdCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753446621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxC9Iszvpvc7ixHI4FBVhNQX4nGRfcg1eU2ZHrg1jz0=;
 b=0B/KY8ljcplMjh0DtETONeLLQg3RKQ8uCNLCD+KvKe9zF7PRaRKolagfouRn7QWQzxS5Cs
 HlPiK0aKEuS8zRl1C+JJzb/jtklSz4Nj+22bI2pF4hdo3uxnZFw5o0wp205wZji6+kb7Ex
 F20X2709vukgZIk3RTgdZqSUgs9+yb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753446621;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxC9Iszvpvc7ixHI4FBVhNQX4nGRfcg1eU2ZHrg1jz0=;
 b=i39XMZbVSz9qUWbt5lRhKBG9cweAxaFeNQqdVyDA98tt56gXQwHWdrN2ohiFfesDSicrS9
 xaAvnH5OzRu8JdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 962C71373A;
 Fri, 25 Jul 2025 12:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e32KI914g2h7LAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 25 Jul 2025 12:30:21 +0000
Date: Fri, 25 Jul 2025 14:31:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Message-ID: <aIN5Btk4Sn2azE14@yuki.lan>
References: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250710170255.4190556-1-mike.tipton@oss.qualcomm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] device-drivers/cpufreq_boost: Don't hardcode
 to CPU0
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
> -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> +static int cpu;
> +
> +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";

Identifiers starting with underscore are reserved for kernel/libc
implementation we shouldn't use them here. I guess that this would be
better as governor_fmt.

> +static char governor[64];
>  static char governor_name[16];
>  
> -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";

Here as well.


Other than that it looks fine. I can push the patch with the change from
_governor to governor_fmt and _maxspeed to maxspeed_fmt if you agree.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
