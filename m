Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01E9C531F9
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 09:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F8693E5597
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 11:29:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 082673E1C91
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:29:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C481F2009B5
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:29:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49CE23E6F;
 Fri, 24 Jul 2026 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784885342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wjd+vCY/UmtpMEiiz1orC2WKmK2AUt9i4W9LTN1A5ck=;
 b=ZZSBh8wvc5dXw29QloZeayszlsX+R5uID5p0wucMPoSRkAMVY7ojUSCNbiDBOTo4MG3Mht
 0wZfAYGRdx8gXF/b3UVlz68+clS9hDXIN8cb7VG+qtTp79lzPrdKl6TcahrgET3M3WeKdQ
 XO34HQd+EgX7zXqmEG3ofHaZGCGl7O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784885342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wjd+vCY/UmtpMEiiz1orC2WKmK2AUt9i4W9LTN1A5ck=;
 b=2fP5yfH2bw+vr+EDgjZd6FeXvjgXgZLrDtNus2XzJs99o88i2dcusjrChkh4j7oMLvKSI0
 qMdm1PMAFd+xEWDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784885342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wjd+vCY/UmtpMEiiz1orC2WKmK2AUt9i4W9LTN1A5ck=;
 b=ZZSBh8wvc5dXw29QloZeayszlsX+R5uID5p0wucMPoSRkAMVY7ojUSCNbiDBOTo4MG3Mht
 0wZfAYGRdx8gXF/b3UVlz68+clS9hDXIN8cb7VG+qtTp79lzPrdKl6TcahrgET3M3WeKdQ
 XO34HQd+EgX7zXqmEG3ofHaZGCGl7O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784885342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wjd+vCY/UmtpMEiiz1orC2WKmK2AUt9i4W9LTN1A5ck=;
 b=2fP5yfH2bw+vr+EDgjZd6FeXvjgXgZLrDtNus2XzJs99o88i2dcusjrChkh4j7oMLvKSI0
 qMdm1PMAFd+xEWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C32E779BA;
 Fri, 24 Jul 2026 09:29:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YjyBF10wY2rrNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 24 Jul 2026 09:29:01 +0000
Date: Fri, 24 Jul 2026 11:28:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <amMwW9GFVxw_XPQH@yuki.lan>
References: <20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com>
 <20260724092558.4078-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260724092558.4078-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[yuki.lan:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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
> > diff --git a/testcases/kernel/fs/xfs/Makefile b/testcases/kernel/fs/xfs/Makefile
> > new file mode 100644
> > +top_srcdir			?= ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +LDLIBS			+= -lpthread
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> Every existing standalone CVE reproducer named cve-<id>.c
> (cve-2014-0196, cve-2016-7042, cve-2025-38236, cve-2026-46331, ...)
> already lives under testcases/cve/, whose Makefile builds every
> target from a wildcard and already carries per-target LDLIBS/CFLAGS
> overrides (e.g. "-pthread" for other threaded reproducers), plus its
> own .gitignore.
> 
> Is there a reason this one needs a brand-new
> testcases/kernel/fs/xfs/ directory instead of adding
> "cve-2026-64600: LDLIBS += -lpthread" to the existing
> testcases/cve/Makefile?

I would say that the file should be called reflux-xfs.c instead. I would
like to avoid the filenames with cve and numbers since they are hard
easy to confuse with each other.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
