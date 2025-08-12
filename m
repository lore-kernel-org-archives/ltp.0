Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D1CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B93493CB257
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:08:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514CC3C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:08:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8969600476
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:08:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2DDF21CDB;
 Tue, 12 Aug 2025 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754996902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcj8cprg9+8z1yIPiR1sqU+dzoq8qDxIYnxLSgWj388=;
 b=mpTmLFPAq+Rd6naQDVLREBVpxY+0F1j1+GMNIL+B45HW+ZYDyPBGz8++CTEQ0O76OvRxBG
 Ou+WIxhzkeCnWVD9t8j+clq8fAtY83rUiQq/Dc9IQ7Bx7walggRXV/LmNDNg9ROXYIu/vM
 q5uLk7+Vg8e2lr6NcZ2jvrvem0bivUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754996902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcj8cprg9+8z1yIPiR1sqU+dzoq8qDxIYnxLSgWj388=;
 b=3T7mEG8QqJOjFwSERO814+b/fmNlA80R5ttqW8/dg3OeKELqtyn4eSLQ1X3q/hkj7hcx/P
 dLw9HwlQOpcKHcCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754996900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcj8cprg9+8z1yIPiR1sqU+dzoq8qDxIYnxLSgWj388=;
 b=Rb318K3Ciz9fk4yR56ThZOPy/DiRuwuZg0y65kYpXhed27WuXF/hcAZwmPTqsGhoW6shWq
 wTmw4QNrIrrkeH/t6jzcB185nWM5APJELd+0qgxJztHKmbyJ2Ohio9NGD+a66LBXFrLeCw
 APjH770uYgm0pr1HFl2EnZy7f0YAi70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754996900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kcj8cprg9+8z1yIPiR1sqU+dzoq8qDxIYnxLSgWj388=;
 b=vjRhk1zcPn+C6L59hqJJP5CStXuIZffBOZ6R0moCXqXC3+MEe7d/UN8jUYAHBYsXQvnqQK
 i/6kshMYbEjUkpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 845221351A;
 Tue, 12 Aug 2025 11:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mKqmG6Qgm2jYFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 Aug 2025 11:08:20 +0000
Date: Tue, 12 Aug 2025 13:09:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aJsg11G8hOAqoGkw@yuki.lan>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812101237.GA835467@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812101237.GA835467@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, checkpatch.pl:url,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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
> >  testcases/cve/.gitignore       |   1 +
> >  testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++
> 
> File not added into runtest/cve.
> 
> Maybe we need to enhance 'make check' to check this via 'git grep'.
> 
> checkpatch.pl looks into resulted file, IMHO we have no tool to check the patch
> itself. But maybe enhance b4 (kind of plugin) to check this :).

Or we can genereate the cve runtest file. It should be possible to build
it from the metadata during the build.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
