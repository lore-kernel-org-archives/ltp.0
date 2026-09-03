Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5F0C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF8A13E9844
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:39:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A364F3E9844
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:38:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1597A1000655
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:38:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B19A11FF05;
 Thu,  3 Sep 2026 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nxm9CDBhpgW251Wf3TyBjXPswbozJlGKdnarWZi3rk=;
 b=WsBX8z7k/Oy9d7XLJ4gYxflkImIRQmzFEF3qJ928D7soA9v33IHdsGnqAr7GM7Lvb7oJYd
 vU8TU5pXYbuH4IKyuAkaKVYGg4svphoMQRvZVFQ0/P3w2nRyBWTnlqV58oESwqTnkUWAbh
 Vs7LE6/wf0sVL97RG1S3qZd9bZ2ue3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nxm9CDBhpgW251Wf3TyBjXPswbozJlGKdnarWZi3rk=;
 b=7pCotUmtY6LpAky1yTO1rtVyhSd//2Ub4NVyAbOs/16oxvsQNn0J0ewoEctSvOnjoBsPzD
 FcZ9kj0YEStxoFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788449920;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nxm9CDBhpgW251Wf3TyBjXPswbozJlGKdnarWZi3rk=;
 b=YM6wqKwHmFf4ETKmOeN4har52jb0IFQ3qEhijLDPeySiYGmWJD0FbbM+v3uA56XcTiQgmQ
 N27fXc0//ibj0cx6jHpOf8ExidXumyjEMJXHQKanAltrtaB4C3rl7M/sN04uiIrlMYkNzq
 xMG2gJU6N6LdpqqSJZYYhgoPvgR/QVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788449920;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nxm9CDBhpgW251Wf3TyBjXPswbozJlGKdnarWZi3rk=;
 b=CAcCDlbRn6vP5FyqvSkUXOWf/e7th0ki0oYAVYhk6VDssMhvfMdFXUX2TLbvSaNjGDBeAO
 rbCzj+fXeHhkLpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E1B136E6;
 Thu,  3 Sep 2026 15:38:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 736lHoCUmWqGWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 15:38:40 +0000
Date: Thu, 3 Sep 2026 17:38:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903153830.GB1141610@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-29-chrubis@suse.cz>
 <20260903144402.GA1107507@pevik> <apmJFnITmaWWb57B@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <apmJFnITmaWWb57B@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > ...
> > > +	if (meminfo_val == sysfs_val) {
> > > +		tst_res(TPASS, "%s: /proc/meminfo (%ld) == %s (%ld)",
> > > +			what, meminfo_val, attr, sysfs_val);
> > > +	} else {
> > > +		tst_res(TFAIL, "%s: /proc/meminfo (%ld) != %s (%ld)",
> > > +			what, meminfo_val, attr, sysfs_val);
> > > +	}
> > > +}

> > It'd be nice if TST_EXP_EQ_LI() would allow to pass string as the other
> > TST_EXP_*() macros do. That's of course outside of the scope of this patchset
> > (if worth of improving at all).

> I had that same idea, but again I've limited number of library changes
> in that patchset, it's large enough as it is.

Sure, all the big patchsets with test coverage should get merged before release,
these are details. But I'm glad you see it the same way (although some people
already complain about too many macros, good doc is important).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
