Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524FEEDF055
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 08:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBEF83CF224
	for <ltp@archiver.kernel.org>; Thu, 12 Feb 2026 09:09:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B453CC23E
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:09:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 592391A006F0
 for <ltp@lists.linux.it>; Thu, 12 Feb 2026 09:09:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2A2A5BDE6;
 Thu, 12 Feb 2026 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770883755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2anV9mCumM+vRJYleS5kBAvFlMXB4owxUY8ecQOvyDA=;
 b=kx/Fkd0apsw3wa20Xr7psbKvjBr5Lfqtjmg2YOoVMXCCVz9e1EUqfAhkuPvhqiNkRqVOg0
 MeBU8SuumlregqzaNuihC/km8ontZSsw/lzvv04VdSw6q3Ji0+dOtkHmjohKKyDIjOytFo
 b1q3U7as5vImpOxEw0JCY6PH0BW/ASw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770883755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2anV9mCumM+vRJYleS5kBAvFlMXB4owxUY8ecQOvyDA=;
 b=JHilETWzR/4yhuhOpEoqgIunGLon9WJAkl9fANEsgCoNo8cNUauCIuehh/SvK3303nj1fo
 pn+Ckprtuulv5JAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770883754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2anV9mCumM+vRJYleS5kBAvFlMXB4owxUY8ecQOvyDA=;
 b=a90cd3TM+aRvoQILgi1qX4zkKd4VIJ+vMBz6O4VP3igRAR6qL5PgTpHPlxDITtaIMZaVU7
 yZdJguwJ/dULMa63Bp2ViwHLsthKukY9Mb3a9kDPY+gvJZG3vXmBNnbHrXtdfAaT9Q9GMm
 WtSpd+QLF8CMC/qofJfERM7D+Hr8PdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770883754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2anV9mCumM+vRJYleS5kBAvFlMXB4owxUY8ecQOvyDA=;
 b=S9STu+dhN8Pm5lsLx6cp7rqyEAfZhHnLinfdSbvPWWeUQVUY8j+4iHnfIKr85siYxIe8Em
 ss6a51gNcErSnpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A88843EA62;
 Thu, 12 Feb 2026 08:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Yp5kKKqKjWnPWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 12 Feb 2026 08:09:14 +0000
Date: Thu, 12 Feb 2026 09:09:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <20260212080909.GA134796@pevik>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
 <20260209075146.GA450151@pevik>
 <46bdaf39-4d82-4b33-94c6-0ef8525ffaf1@canonical.com>
 <20260209114700.GA488389@pevik>
 <9ca90f43-f8c9-4f7d-ae7c-5ea9653c7742@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ca90f43-f8c9-4f7d-ae7c-5ea9653c7742@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: reserve pre-TCB space to avoid
 undefined behavior in clone10.c
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

Hi Changwei,

> Hi Petr,
> LTP uses glibc.

Side note: *you* (and we in SUSE) use LTP with glibc. FYI other people use LTP
with musl (although few tests don't compile, see rm in ci/alpine.sh), uclibc-ng,
Google uses LTP with bionic. It's probably not relevant here (it's more about
kernel arch implementations than about libc), but just safer to mention LTP is
not glibc specific.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
