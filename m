Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD5CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 10:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8150C3C31F2
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 12:40:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693103C2362
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 12:40:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D66BD1A00EF1
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 12:40:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E66B1FBA5;
 Mon,  2 Sep 2024 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725273623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aefGOdn6L/rxdrxg5XyT8ie1yrkDAx/1wVTeKiRgh88=;
 b=dkQfT6+YtbwPoZlPA3QsfOmt1/OOphMtMNXs2n+0bLQIYE/sPdPGG8chBgBllptZOIDW9H
 YH52kC7Xm6jFAkJF1Fngh/yXRBG2BDLuflzTyFogcjrrDvmRZN3XP55lJPLdS7V1aRczQ9
 cJRXNKRs+gKDGeY3ds7hlTOFewIi9ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725273623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aefGOdn6L/rxdrxg5XyT8ie1yrkDAx/1wVTeKiRgh88=;
 b=Yg2BH87dHh8nrO9tF61o+jUqHYYGTjbZUrjcszuARYNGnoQSRQV+fkOTlEP+xDMbD9B5QX
 JT/DRKbLh00AM1DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dkQfT6+Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Yg2BH87d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725273623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aefGOdn6L/rxdrxg5XyT8ie1yrkDAx/1wVTeKiRgh88=;
 b=dkQfT6+YtbwPoZlPA3QsfOmt1/OOphMtMNXs2n+0bLQIYE/sPdPGG8chBgBllptZOIDW9H
 YH52kC7Xm6jFAkJF1Fngh/yXRBG2BDLuflzTyFogcjrrDvmRZN3XP55lJPLdS7V1aRczQ9
 cJRXNKRs+gKDGeY3ds7hlTOFewIi9ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725273623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aefGOdn6L/rxdrxg5XyT8ie1yrkDAx/1wVTeKiRgh88=;
 b=Yg2BH87dHh8nrO9tF61o+jUqHYYGTjbZUrjcszuARYNGnoQSRQV+fkOTlEP+xDMbD9B5QX
 JT/DRKbLh00AM1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F4C413AE0;
 Mon,  2 Sep 2024 10:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AWjRHReW1WagawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Sep 2024 10:40:23 +0000
Date: Mon, 2 Sep 2024 12:39:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZtWV0R_oDb7BQdKm@yuki.lan>
References: <20240830095758.20018-1-wegao@suse.com>
 <20240830103835.GA42409@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830103835.GA42409@pevik>
X-Rspamd-Queue-Id: 8E66B1FBA5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mpls01.sh: Add --allow-unsupported for modprobe
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
> I'm not sure with ROD.  --allow-unsupported is SUSE specific modprobe extension,
> which is used for SLES.  It is also on Tumbleweed [1] [2] where does nothing.
> 
> If you try to run it with ROD, which quits testing on failure, all distros
> except SUSE products/openSUSE (e.g. Debian, Fedora, ...) which don't have
> mpls_router will TBROK in setup:
> 
> 	modprobe: unrecognised option '--allow-unsupported'.
> 
> And I'm not talking about these small distros which use busybox kmod
> implementation, which would also fail.
> 
> Also you remove /dev/null 2>&1 from the first command, thus other distros would
> not see error message about missing mpls_router module. Without looking into the
> source the tester will be pretty confused.
> 
> I would do:
> 
> 	if grep -q suse /etc/os-release; then

There are a couple of english words that contain "suse" as a substring
if one of these ends up in the os-release it would match, e.g. the
os-release may contain VERSION="24 (Disused Miracle)".  And yes both
Fedora and Ubuntu seems to include the the code names in the file.

So I would be stricter here and checked for ID=suse.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
