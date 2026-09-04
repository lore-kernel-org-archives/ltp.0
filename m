Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC99C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D051B3E936F
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:45:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8489A3E5506
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:44:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0206A600E4F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:44:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 083471F801;
 Fri,  4 Sep 2026 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788511488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M6WK+Hv5UUptUVKtNiTC1Sxo1whN2sN6KZ7sl5aZCk=;
 b=IZZB7p+gdEPN2e84aFHE6gx18vq3lLxpBcSoLFSwef3NK4lM6t397DlUUJpaG9FgI/YeyZ
 py+RIZtKE8ZUxIaU5eHXtxGP1rX9bJ43y+kpJiO4KLPoMxXOo3tgfgr7BW5zVwcCVknqjs
 kGoulR+FPh65h2s9BG14ODOkWI9VTp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788511488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M6WK+Hv5UUptUVKtNiTC1Sxo1whN2sN6KZ7sl5aZCk=;
 b=WeueZzYyTaazrl2g5bcHT3UumPVK5nppfCvuZQDHWSA/wjhZ/M3rAFdfaL4U2YoHDcq6eB
 9iaI8UfGskO2TnBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QTms3rdI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="kSJpfFZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788511484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M6WK+Hv5UUptUVKtNiTC1Sxo1whN2sN6KZ7sl5aZCk=;
 b=QTms3rdIfChFVGcR2J8urbRTeI1ErzrstUXELrVK2R2ixDtuo0w8hHh9g9/Wlsi9yTKp3Y
 zLpwqZoe2iYzQiXo94+Aqkj4ZuPXvDsCWZwT8dN4BP1ZlteeTH/snjCk5u2jbUddC2UV6H
 tgWw5RNppsWbzu0n3/wGzVjKY6J5Yis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788511484;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/M6WK+Hv5UUptUVKtNiTC1Sxo1whN2sN6KZ7sl5aZCk=;
 b=kSJpfFZ/IS3pEdPqOnsf460Ni/Glsg4JOq+WqXBhbN8CQpJktBk7+V4IAD4g+kvtyc9054
 41PHMMSWUvuuzwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FB9E13738;
 Fri,  4 Sep 2026 08:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VTllJfuEmmpsXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 08:44:43 +0000
Date: Fri, 4 Sep 2026 10:44:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20260904084438.GA1189532@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260903172419.GL1107507@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260903172419.GL1107507@pevik>
X-Rspamd-Queue-Id: 083471F801
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/31] Add sysfs sanity tests
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
Cc: linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Alejandro,

also, its nice that only /sys/fs/smackfs and /sys/kernel/cgroup/ are not
covered (both are subsystems are at least somehow covered in LTP).
=> very good test coverage.

$ for i in $(grep -h '.I /sys' ../man-pages.git/man/man5/sysfs.5 | cut -d  ' ' -f2); do git grep -q $i || echo "$i is missing"; done
/sys/fs/smackfs is missing
/sys/kernel/cgroup/ is missing

@Alejandro FYI man/man5/sysfs.5 (or other man pages) could be updated, few
/sys/ directories are missing:

man/man5/sysfs.5 (I haven't found more specific man page)
/sys/class/ata_device
/sys/class/bdi
/sys/class/hwmon
/sys/class/leds
/sys/class/thermal
/sys/class/wakeup
/sys/devices/system/cpu/vulnerabilities

man/man4/loop.4
/sys/block/loop

man/man4/rtc.4
/sys/class/rtc

I'm not sure if these should be documented in man page:

/sys/devices/system
/sys/devices/system/clockevents
/sys/devices/system/clocksource
/sys/kernel/mm/ksm
/sys/kernel/mm/swap

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
