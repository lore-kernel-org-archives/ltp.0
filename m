Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D1E6896C
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 10:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C2203CBE48
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:03:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51AAB3CB9F6
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:02:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AA1B8102CB5E
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:02:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 322C321D1A;
 Thu, 31 Oct 2024 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730368970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2NvecJvhHZTS+hz4Pc7N3F3WnV5lWHwdlwcP3AOVYc=;
 b=3BgsXjQpjR8APVH9SN42vU4NG1XpWaZGbe1LJJGyXGXfa6xUgicQRgecxG4NR7dJDzSekD
 pDuE3X5c5JrJ1zzK7jH/ufvzGrcY2kQelrkpyYTPtVlKCWJ+nUaHu6IqAM81Y3PBWv9jdi
 7yXGuGtRC+6ADvUmXkvYn4sufvH6Fok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730368970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2NvecJvhHZTS+hz4Pc7N3F3WnV5lWHwdlwcP3AOVYc=;
 b=cQ0JeMwaROCm2HdIzSoGGDbHyx970eC+5soDjCfSQOj2RpKcpYpioSNlcu2uDBjSOai/si
 LDzkYMBIsbWJnPAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3BgsXjQp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cQ0JeMwa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730368970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2NvecJvhHZTS+hz4Pc7N3F3WnV5lWHwdlwcP3AOVYc=;
 b=3BgsXjQpjR8APVH9SN42vU4NG1XpWaZGbe1LJJGyXGXfa6xUgicQRgecxG4NR7dJDzSekD
 pDuE3X5c5JrJ1zzK7jH/ufvzGrcY2kQelrkpyYTPtVlKCWJ+nUaHu6IqAM81Y3PBWv9jdi
 7yXGuGtRC+6ADvUmXkvYn4sufvH6Fok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730368970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2NvecJvhHZTS+hz4Pc7N3F3WnV5lWHwdlwcP3AOVYc=;
 b=cQ0JeMwaROCm2HdIzSoGGDbHyx970eC+5soDjCfSQOj2RpKcpYpioSNlcu2uDBjSOai/si
 LDzkYMBIsbWJnPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F5613A53;
 Thu, 31 Oct 2024 10:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q07yBcpVI2csNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 31 Oct 2024 10:02:50 +0000
Date: Thu, 31 Oct 2024 11:02:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyNVxrTSauZuSfWt@yuki.lan>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031095609.GC995052@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031095609.GC995052@pevik>
X-Rspamd-Queue-Id: 322C321D1A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/3] Automatically generate syscalls.h
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
> > The problem we have at the moment is that all syscalls input files must
> > be changed by hand each time we need to test a new syscall. The idea is
> > to simplify this process, providing a script that is able to read from
> > kernel sources and to generate all syscalls files we need.
> 
> > This patch set adds a new command inside the syscalls folder and
> > it refactors the previous regen.sh code.
> > The new way we have to generate the syscalls.h file is the following:
> 
> > 	include/lapi/syscalls/generate_arch.sh 		path/to/kernel/source
> > 	include/lapi/syscalls/generate_syscalls.sh 	path/to/syscalls.h
> 
> > Scripts are independent and they can be run separately.
> > generate_syscalls.sh is the equivalent of regen.sh, but its code has
> > been cleaned up.
> 
> it would be nice to have this documented (as a separate effort, not blocking
> to merge this). Specially the new generate_arch.sh, which is not part of
> ./configure run.

We need something as:

The generate_arch.sh is supposed to be run when you start writing new
test and find out that the syscall number definitions you need are not
available in the LTP fallback header include/syscalls.h. You need to
point the script to a recent Linux kernel sources and it will pull an
update for the LTP syscall number tables. The tables then needs to be
updated in a separate git commit. You also need to re-run configure to
get the header updated from the tables.


To be put into the "how to write a test" documentation.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
