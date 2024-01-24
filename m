Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7663DC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:21:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00FF43CFB40
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:21:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E7873C5D1E
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:21:10 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1202B208D26
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:21:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21E551FD65;
 Wed, 24 Jan 2024 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706106069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOwnojm8CdXvYSAYi5tgrJuKd+fLZVBKvRnVH3XETaw=;
 b=RjyP/FpaUVfKyiCJGzhKfdCxqmrIVbwn6uWY2xjQ76wf/z7cAs7wphloStIdpY3Sb5iDVC
 +ZJDvjbsPILnr85w66EoPv9MxtvU2P7s37nTVW39lmFcM31TwXHg8ksg/l67OeqCpkWL24
 9+94bikd0sbg/E2ZGs/0tWzIEbNex8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706106069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOwnojm8CdXvYSAYi5tgrJuKd+fLZVBKvRnVH3XETaw=;
 b=EdF2oQkytTwKYPK8yIUl8abAIvjQiiAK4Q5tT+8ulu3Y2gpya3VZjKoxXngrqydi7hYqgI
 3NQfHgvh81sOoLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706106068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOwnojm8CdXvYSAYi5tgrJuKd+fLZVBKvRnVH3XETaw=;
 b=rQEdVAIEtltfjOsMfGiwmmXO1rvvjwEm7e8FWqOd/vxaHGj43YR49lMWKnFow80kmjwObu
 r54fD7M20GRNU9aWBq8au01FcPb1CeKrb5WtcwZGmUqk77C7dypynM70Ph4bssjMAot0cw
 P3Nc8Z81MmvHx1JrT1NTLOXlRXnM4lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706106068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOwnojm8CdXvYSAYi5tgrJuKd+fLZVBKvRnVH3XETaw=;
 b=zWHZvM3wsL9ojCbkXf0/25gSRGlqvzMVWsjOpb3aHxNcXjhCBJ/9SQ/P2ZvBaBpA6K8vJU
 WdfKStvyYd6zjjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1124E1333E;
 Wed, 24 Jan 2024 14:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xZNkAtQcsWUmWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jan 2024 14:21:08 +0000
Date: Wed, 24 Jan 2024 15:21:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbEc3IMfG1d_bm4t@yuki>
References: <20240124125813.6611-1-chrubis@suse.cz>
 <20240124141625.GC299755@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124141625.GC299755@pevik>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[29.86%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Avoid tst_brk(TCONF,
 ...) on older distros
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Actually at least here tst_syscall() needs to be called or it fails on older
> distros due missing ENOSYS check in raw syscall():

Ah, no we have to handle the ENOSYS ourselves as we do in the other
cases. Sorry for not realizing that.

We likely need just:

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index ab7de81aa..8b26ff8e5 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -141,7 +141,7 @@ static void open_pidfd(struct tst_fd *fd)
 {
        fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
        if (fd->fd < 0)
-               tst_brk(TBROK | TERRNO, "pidfd_open()");
+               tst_res(TCONF | TERRNO, "pidfd_open()");
 }


The tst_sycall() can't be called there at all _because_ it calls
tst_brk() itself.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
