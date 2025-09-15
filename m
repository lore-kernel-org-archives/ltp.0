Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E345CAC597
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 09:15:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948943CD9BD
	for <ltp@archiver.kernel.org>; Mon, 15 Sep 2025 11:15:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 025633C0962
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 11:15:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 30D29600050
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 11:15:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDF6F33712;
 Mon, 15 Sep 2025 09:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757927705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0S5dTFoV+FFlE0qymnj2G3mcwc3tvjBPsZNI4yVFcY=;
 b=P99jhl7peKu4G4BtfJU11laRQ6qVP7mniXcZfAjbMUloJx7CWVeojV9OkcV9E6QmpIyrac
 +E3IjdjmKj26C3YpcHYNl624wRDEMxFRjhSGRc9xOnEAZDXzGV9qq0q3LEWigVyXWHI+5K
 5hZfd/RNCzW/jNY932HX8rUAIseDqbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757927705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0S5dTFoV+FFlE0qymnj2G3mcwc3tvjBPsZNI4yVFcY=;
 b=64Be+vfBORcpb1KJutjuEunk29Xvd6wJPXF5FSPzBjIkq1slrslwUiLWQpj1J6VyyEzXrI
 lWPKg3ZeANyCnwBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P99jhl7p;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=64Be+vfB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757927705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0S5dTFoV+FFlE0qymnj2G3mcwc3tvjBPsZNI4yVFcY=;
 b=P99jhl7peKu4G4BtfJU11laRQ6qVP7mniXcZfAjbMUloJx7CWVeojV9OkcV9E6QmpIyrac
 +E3IjdjmKj26C3YpcHYNl624wRDEMxFRjhSGRc9xOnEAZDXzGV9qq0q3LEWigVyXWHI+5K
 5hZfd/RNCzW/jNY932HX8rUAIseDqbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757927705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0S5dTFoV+FFlE0qymnj2G3mcwc3tvjBPsZNI4yVFcY=;
 b=64Be+vfBORcpb1KJutjuEunk29Xvd6wJPXF5FSPzBjIkq1slrslwUiLWQpj1J6VyyEzXrI
 lWPKg3ZeANyCnwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A931C1372E;
 Mon, 15 Sep 2025 09:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L4YAKRnZx2jrdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Sep 2025 09:15:05 +0000
Date: Mon, 15 Sep 2025 11:15:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jack Morgan <jmorgan@naotchy.com>
Message-ID: <aMfZOzQWQLh82r6y@yuki.lan>
References: <20250913005759.2946000-1-jmorgan@naotchy.com>
 <aMfW_bP12FUgR15H@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMfW_bP12FUgR15H@yuki.lan>
X-Rspamd-Queue-Id: BDF6F33712
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
> > +/* Enable mnt_ns_id check when system struct statmount is not defined. */
> > +#if !defined(HAVE_STRUCT_STATMOUNT) && !defined(LTP_HAVE_STATMOUNT_MNT_NS_ID)
> > +#define LTP_HAVE_STATMOUNT_MNT_NS_ID 1
> > +#endif

On a second look this looks like you are working around the
fallback definition we have. But there is no configure check for
STATMOUNT_MNT_NS_ID that has to be added to configure.ac, we need
something as:

AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>])

That would define HAVE_STRUCT_STATMOUNT_MNT_NS_ID if that field is
present in the system headers.

And then we can use that with:

#if !defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
# define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID 1
#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
