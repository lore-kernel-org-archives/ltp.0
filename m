Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013B0C54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 19:48:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2F113CC824
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 21:48:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37C8F3CC7C3
 for <ltp@lists.linux.it>; Wed, 21 May 2025 21:47:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 614F0100042E
 for <ltp@lists.linux.it>; Wed, 21 May 2025 21:47:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5750A209FD;
 Wed, 21 May 2025 19:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747856867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=107G3BzAvgDoSEWPqOu/cXiOpGn9Uj5TOV2UfigB5c4=;
 b=vQzciAAWPxpTm8QZs+JZr39Bu+/kPNcMjyVFCaS7WlQ2z5Tfbm1DMka5IZqH04d7xnqlax
 RzdhLzfTMkd3k2ve6Xa6fLtJGBpU29mUhsNxpFL4AbToOyEt0We6PjAjgERep6ma0iIfAJ
 icfA7OHSNgXtNEKn4ctA60yfJmLBO9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747856867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=107G3BzAvgDoSEWPqOu/cXiOpGn9Uj5TOV2UfigB5c4=;
 b=xV1c517waP7qq7w96jfSiyueHVSA9DmEGP27VL4xTYFPG/C9uEwP9g5AffPmnP84nzl71Z
 8QXXsLQRwLHX7aBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747856867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=107G3BzAvgDoSEWPqOu/cXiOpGn9Uj5TOV2UfigB5c4=;
 b=vQzciAAWPxpTm8QZs+JZr39Bu+/kPNcMjyVFCaS7WlQ2z5Tfbm1DMka5IZqH04d7xnqlax
 RzdhLzfTMkd3k2ve6Xa6fLtJGBpU29mUhsNxpFL4AbToOyEt0We6PjAjgERep6ma0iIfAJ
 icfA7OHSNgXtNEKn4ctA60yfJmLBO9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747856867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=107G3BzAvgDoSEWPqOu/cXiOpGn9Uj5TOV2UfigB5c4=;
 b=xV1c517waP7qq7w96jfSiyueHVSA9DmEGP27VL4xTYFPG/C9uEwP9g5AffPmnP84nzl71Z
 8QXXsLQRwLHX7aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48C4613888;
 Wed, 21 May 2025 19:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Bx58EeMtLminYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 May 2025 19:47:47 +0000
Date: Wed, 21 May 2025 21:47:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <aC4t2hRyrFYIGXHY@rei>
References: <20250520152551.390069-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250520152551.390069-1-japo@linux.ibm.com>
X-Spamd-Result: default: False [-0.80 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/1] overcommit_memory: Disable
 optimization for malloc to prevent false positives
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
We already have a macro for this usecase introduced in the commit:

commit 5bb0c6bc553a3393627b371275b2e34b0099de19
Author: Jan Stancek <jstancek@redhat.com>
Date:   Thu Feb 6 10:42:31 2025 +0100

    syscalls/mallinfo02: introduce LTP_VAR_USED to avoid optimization


Can you please use the LTP_VAR_USED() instead?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
