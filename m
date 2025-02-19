Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E11C021AB
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 08:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00883C29B6
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:55:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 802FB3C25CE
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:55:10 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78B6110354A7
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:55:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AB6421C2C;
 Wed, 19 Feb 2025 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739955308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ltSi51ERMVU25JrqGSiecioaZ8UO6+YZALmHr5zyDg=;
 b=cM7RjG6HdUpWBJtm3BDmShVlvMsjQy7Twc9xcLhCIRyKK7AVayktlR5BqiANJczn8mtfNX
 UXHVcud/uLTlRgn5xthvsBfGEP5Y9ZCXdg2BKbJqoBy8u//m7lNeh9ujPGIckkK+zy+HVV
 lC7Sjw2xu+paKuFXdhCkTduc6tt6Fog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739955308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ltSi51ERMVU25JrqGSiecioaZ8UO6+YZALmHr5zyDg=;
 b=tdBVeGd1HYnLD/yf451ZYwgpmYK+2FmLQOiz0/Aau9LfzgVFeXu7/5CsmX6ZA5gXbWDKnz
 SzoBYeep1Zt7QHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739955308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ltSi51ERMVU25JrqGSiecioaZ8UO6+YZALmHr5zyDg=;
 b=cM7RjG6HdUpWBJtm3BDmShVlvMsjQy7Twc9xcLhCIRyKK7AVayktlR5BqiANJczn8mtfNX
 UXHVcud/uLTlRgn5xthvsBfGEP5Y9ZCXdg2BKbJqoBy8u//m7lNeh9ujPGIckkK+zy+HVV
 lC7Sjw2xu+paKuFXdhCkTduc6tt6Fog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739955308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ltSi51ERMVU25JrqGSiecioaZ8UO6+YZALmHr5zyDg=;
 b=tdBVeGd1HYnLD/yf451ZYwgpmYK+2FmLQOiz0/Aau9LfzgVFeXu7/5CsmX6ZA5gXbWDKnz
 SzoBYeep1Zt7QHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10C5313A53;
 Wed, 19 Feb 2025 08:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e5wHA2yctWdUKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 08:55:08 +0000
Date: Wed, 19 Feb 2025 09:55:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20250219085502.GA2544812@pevik>
References: <20250218121745.GA2469726@pevik>
 <20250219052009.1020281-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250219052009.1020281-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fork13: Fix the doc
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

Hi Ma Xinjian,

...
> +++ b/testcases/kernel/syscalls/fork/fork13.c
> @@ -15,21 +15,22 @@
>   * implementation.  Furthermore, many shell scripts assume that pid
>   * numbers will not be used for some length of time.
>   *
> - * [Race Description]
> - * ---------------------------------------------------------------------
> - * A                                B
> + * [Race Description] ::
>   *
> - * // pid == offset == n            // pid == offset == n + 1
> - * test_and_set_bit(offset, map->page)
> - *                                  test_and_set_bit(offset, map->page);
> - *                                  pid_ns->last_pid = pid;
> - * pid_ns->last_pid = pid;
> - *                                  // pid == n + 1 is freed (wait())
> + *    ---------------------------------------------------------------------
I removed these --- lines (they were for asciidoc code formatting).

> + *    A                                B
>   *
> - *                                  // Next fork()...
> - *                                  last = pid_ns->last_pid; // == n
> - *                                  pid = last + 1;
> - * ---------------------------------------------------------------------
> + *    // pid == offset == n            // pid == offset == n + 1
> + *    test_and_set_bit(offset, map->page)
And increase indent on the right side.

Thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
