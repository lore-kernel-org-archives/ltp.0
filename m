Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0408C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21ED3C9288
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:00:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FEB03C926E
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:00:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B65214013A3
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:00:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 616F11F44F;
 Thu,  6 Feb 2025 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8gVXWVjIetpvGXA9ZRYHZUhp9L7WJ8xsP5faDmcy0g=;
 b=OSrvsBGmmwmKL8NYaafdsooKR3RS+1aJNxB3OPIqdE18fTuIeB81WTdPctL8iyfX3dKpCf
 rqjWOxXtebUGfT3yZxn0bDmHseVtpTHoS/AMmxoi6/dDgQeT8E52stPCWe1oI9oFuklzLB
 Et/dJPGgJ5SuspGE/2TSJrdFY+LVNr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8gVXWVjIetpvGXA9ZRYHZUhp9L7WJ8xsP5faDmcy0g=;
 b=RRr7VwQgL+Y87z9aVe/vFCxqHv8t/TrwBb35UTgaKeuqK/gMH7tLxAkO0WNZg6uvfcm3hQ
 EhuPV4dWNHaKt2Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vZlhCa6A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=arpUbACl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8gVXWVjIetpvGXA9ZRYHZUhp9L7WJ8xsP5faDmcy0g=;
 b=vZlhCa6AO9guoAl5jSavEoCuCC4kRoD3S46F33szT4oljQBKVMsvfq86na+f+6RIj674+Z
 d8p2B9SoMHMQF7Ks1MR+xND8JYWwFKbhPo99/2uxBiegMZ3eg/DJOddKTrEZafSOZQR4SA
 hvDhHdY2+9EFFAyyP70fz2YLYJ6g2jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8gVXWVjIetpvGXA9ZRYHZUhp9L7WJ8xsP5faDmcy0g=;
 b=arpUbAClAJIItmFo1t8hbqIGWXEVDxDZaVUbfIaCSPQrgEYI1RqQhCBOrhKv6BWR1ssR0p
 GrMoUokSsnYh6VAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38BDD13A7F;
 Thu,  6 Feb 2025 15:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t5bZC4XOpGcnMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 15:00:21 +0000
Date: Thu, 6 Feb 2025 16:00:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250206150015.GB1573569@pevik>
References: <20250206143421.1571918-1-pvorel@suse.cz>
 <20250206143421.1571918-8-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250206143421.1571918-8-pvorel@suse.cz>
X-Rspamd-Queue-Id: 616F11F44F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ozlabs.org:url,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] doc/Makefile: Add dependency on
 metadata/ltp.json
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Cyril,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this should be applied after Andrea's work gets merged.
> https://patchwork.ozlabs.org/project/ltp/patch/20250206-doc_tests_list-v5-2-52110e1421a9@suse.com/

This actually fixes the regression (failure in CI introduced by 1bf344a3db
("doc: add tests catalog page").

I wrote it independently this week and forget to post. Therefore I put this what
turn out to be a fix at the end.

I would prefer to merge 5 commits (not having to rebase and have CI covering
actually the problem:

0c9b58e5b0 ("doc/Makefile: Add dependency on metadata/ltp.json")
9e46261aa6 ("configure: make: Add SPDX, update copyright")
cbbcb4a55f (".github: ci-sphinx-doc: Use make for building doc")
9624668a1f ("doc: documentation.rst: Update build instructions")
e59b9f8c8d ("doc/Makefile: Improve make targets")

E.g. not merging without any review besides configure and realtime changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
