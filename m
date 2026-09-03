Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E7BC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 222843EAD9A
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:50:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833983E20CA
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:50:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 18A8F10009DF
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:49:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8223F1FE49;
 Thu,  3 Sep 2026 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788446994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEUgqzuY93NNIxP2ixEyWUJ9smHiGHlsDpd3c7AuuN0=;
 b=XltvCJNUy+7lmx8t/33c2AU8Fv3oESUZhrWfn2Yx1TeubE3Mkg271y/jNpc2liXq1zXqZ4
 JIoa0QYwEyzUhzYXJRbpU2Tnt2GmctQgY+9M+7BvTSd5PCG1gq3V3lIKNwgYRLvyxUO1Tg
 biu5wS/5AQBZ/X4WZE7/erowX2CH8G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788446994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEUgqzuY93NNIxP2ixEyWUJ9smHiGHlsDpd3c7AuuN0=;
 b=9fzbxoJ1mzEriZpVPpkZfXL5cU3t7KIiVIwTYoRN18I9+6/MKiQPjSCwxRW2MuppwElhuQ
 AHCIR8czUF+eKyCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788446990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEUgqzuY93NNIxP2ixEyWUJ9smHiGHlsDpd3c7AuuN0=;
 b=A5E3nFmylwoEaa3w3FoAdaH2eDMOaAI4ZSuWt09o/wC7XpkkS+823vnDqhiPmApdzG3UBu
 gbwwar8c104m8vw+pgwUBM6t0zOMktagIGy4VWBHKq88CparxLhV75EyXIy8fH67VQg7CD
 KIcz51VmssC/xhlRlq50jz/7DtktWQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788446990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEUgqzuY93NNIxP2ixEyWUJ9smHiGHlsDpd3c7AuuN0=;
 b=JJnq9kHuwraIOYY1FNYKVoaTBuID3tp4p/G1TOH5wlfkJKWOl6MtE3g76H9Y38tQ9OlrCW
 L5t3GONdegJY8lAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BB6313738;
 Thu,  3 Sep 2026 14:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YwL6FQ6JmWpfKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Sep 2026 14:49:50 +0000
Date: Thu, 3 Sep 2026 16:49:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <apmJFnITmaWWb57B@yuki.lan>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-29-chrubis@suse.cz>
 <20260903144402.GA1107507@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260903144402.GA1107507@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 28/31] testcases: sysfs: Add sys_hugepages02
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
> ...
> > +	if (meminfo_val == sysfs_val) {
> > +		tst_res(TPASS, "%s: /proc/meminfo (%ld) == %s (%ld)",
> > +			what, meminfo_val, attr, sysfs_val);
> > +	} else {
> > +		tst_res(TFAIL, "%s: /proc/meminfo (%ld) != %s (%ld)",
> > +			what, meminfo_val, attr, sysfs_val);
> > +	}
> > +}
> 
> It'd be nice if TST_EXP_EQ_LI() would allow to pass string as the other
> TST_EXP_*() macros do. That's of course outside of the scope of this patchset
> (if worth of improving at all).

I had that same idea, but again I've limited number of library changes
in that patchset, it's large enough as it is.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
