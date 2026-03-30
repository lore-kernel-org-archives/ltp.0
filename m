Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDB7FB3CF5
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A9183E4F11
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:15:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6BC3E2AEA
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:15:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A3DB1A009A5
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:15:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A8C24D1F1;
 Mon, 30 Mar 2026 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774865707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bh9Flo8SlcGca88JZpKldKqQNE9ASCGpQe/Sz5ELDs=;
 b=HJxKTw93SRJ4DV3c29J5z+YLfNGYs8SYQU7m7ApP68H40QrunLGF+jQGzQTl39nTzEEdF/
 5v4hbWE8bws4ARQl/m4d983ZNxG5wjcMSWXfi3AGL5PrY1kvi3xkZMUbNa7yn9oLnG6aYb
 BfIWEuLXQYN7LZXbo1hAziekCeVSe8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774865707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bh9Flo8SlcGca88JZpKldKqQNE9ASCGpQe/Sz5ELDs=;
 b=yZ7VGdpjhTzqUd4Ogkocqt01M4smjxwOVHdE4OM67oIXA5oMZb//fFkqtnwFhdRQbcrH4k
 ryItKKv52cXmkQCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774865707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bh9Flo8SlcGca88JZpKldKqQNE9ASCGpQe/Sz5ELDs=;
 b=HJxKTw93SRJ4DV3c29J5z+YLfNGYs8SYQU7m7ApP68H40QrunLGF+jQGzQTl39nTzEEdF/
 5v4hbWE8bws4ARQl/m4d983ZNxG5wjcMSWXfi3AGL5PrY1kvi3xkZMUbNa7yn9oLnG6aYb
 BfIWEuLXQYN7LZXbo1hAziekCeVSe8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774865707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bh9Flo8SlcGca88JZpKldKqQNE9ASCGpQe/Sz5ELDs=;
 b=yZ7VGdpjhTzqUd4Ogkocqt01M4smjxwOVHdE4OM67oIXA5oMZb//fFkqtnwFhdRQbcrH4k
 ryItKKv52cXmkQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84E6D4A0A2;
 Mon, 30 Mar 2026 10:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nYqAHytNymn5UAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Mar 2026 10:15:07 +0000
Date: Mon, 30 Mar 2026 12:15:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acpNKiCdqpKyhRo-@yuki.lan>
References: <20260327160157.76906-1-rbranco@suse.de>
 <20260330072412.GA62327@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260330072412.GA62327@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Minor fixes
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
> As a separate effort: Cyril raised a question if (as a separate effort) should
> all test have some kconfig check (e.g. CONFIG_USERFAULTFD=y)
> 
> IMHO it's a question if we are ok with wide spread of needs_kconfig even if it's
> not necessary (i.e. here SAFE_USERFAULTFD() check. In that case the benefit
> would be 1) documentation of dependencies for testers in the test catalog 2)
> check earlier that before running test code. And of course disadvantage to
> really drag kconfig dependency, but we have accepted that already.
> 
> Ideally we'd decide on some policy (which may also includes .needs_drivers).
> @all I planned to reword my original policy patch [1] to Li's suggestion +
> Cyril's kconfig changes [2], but that still does not have "use kconfig to
> document dependencies".

I think that we can get rid of needs_drivers if we add more runtime
checks.

We have needs_drivers in:

- kvm tests -> CONFIG_KVM + runtime check for kvm module
- zram tests -> CONFIG_ZRAM + runtime check for zram module
- squasfs tests -> CONFIG_SQUASHFS + runtime check for squashfs module
- setxattr02 -> CONFIG_BLK_DEV_RAM + runtime check for brd module
- ioctl08 -> has both filesystems and needs_drivers set to btrfs
             likely we do not need the needs_drivers there
- ioctl_loop tests -> CONFIG_BLK_DEV_LOOP + runtime check for loop module
- madvise11 -> CONFIG_HWPOISON_INJECT + runtime check for hwpoison_inject module
- quotactl tests -> CONFIG_QUOTA_V2 + runtime check for quota_v2 module
- uinput tests -> CONFIG_BLK_DEV_LOOP + CONFIG_TUN + CONFIG_INPUT_UINPUT
- can tests -> CONFIG_CAN_VCAN + CONFIG_CAN_RAW + CONFIG_CAN_BCM


If we agree that we want to switch from needs_drivers to needs_kconfig +
runtime checks I will add mappings from congfigs to module names into
tst_kconfig and convert the tests..

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
