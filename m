Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615A9CF65CE
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 10:07:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7983C30CD
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 11:07:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BDE93C06D4
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 11:07:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98CEB6008A5
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 11:07:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20D2C3374B;
 Mon, 26 Jan 2026 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769422044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZghHQkWL171q5MuvAQFQfbRkFsaKMYVdDas7sokZTCU=;
 b=jzJJMAj3A5EGpB8iqDBLSNYc7UTFfkO99F5O+t9kE80w3d3+SV+Nv29P9EzNZ2eSzuD6cX
 K8yj+bvmY99f7myWzWCDbNnNkuCzeSrmZ/wh1Sg3rjRgDYdgXEk0szyCG5PjSBjhxqwhXN
 gxRIFsmHyHwlLM5+9GbLK7jrklu/v0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769422044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZghHQkWL171q5MuvAQFQfbRkFsaKMYVdDas7sokZTCU=;
 b=I/PWruiYkSY8E+UmRZNVO5lxXRRg1hxpiQY3HXRH0cjP8UZEIEjS2t6tka/hmSDdO9PSj+
 DAyd9pKRlp+QquCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769422044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZghHQkWL171q5MuvAQFQfbRkFsaKMYVdDas7sokZTCU=;
 b=jzJJMAj3A5EGpB8iqDBLSNYc7UTFfkO99F5O+t9kE80w3d3+SV+Nv29P9EzNZ2eSzuD6cX
 K8yj+bvmY99f7myWzWCDbNnNkuCzeSrmZ/wh1Sg3rjRgDYdgXEk0szyCG5PjSBjhxqwhXN
 gxRIFsmHyHwlLM5+9GbLK7jrklu/v0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769422044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZghHQkWL171q5MuvAQFQfbRkFsaKMYVdDas7sokZTCU=;
 b=I/PWruiYkSY8E+UmRZNVO5lxXRRg1hxpiQY3HXRH0cjP8UZEIEjS2t6tka/hmSDdO9PSj+
 DAyd9pKRlp+QquCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6940E139F0;
 Mon, 26 Jan 2026 10:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UIbUFNs8d2khBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 Jan 2026 10:07:23 +0000
Date: Mon, 26 Jan 2026 11:07:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260126100721.GA56703@pevik>
References: <20260123-fix_dio_sparse_slow-v1-1-65bd0dc0d52f@suse.com>
 <20260123175629.GA358728@pevik>
 <DFYDWAQTUSSA.PXU6P9MZPDRW@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFYDWAQTUSSA.PXU6P9MZPDRW@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io: fix really slow dio_sparse on certain systems
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!


> > LGTM. IMHO good for a release.


> Should I merge it with your review tag? I also noticed that I forgot to
> update the default value in the test options. I send v2, then we should
> merge it if possible because this issue causes test to complete in 4
> hours on certain systems.

+1. Please Cc me, I'll add my RBT in v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
