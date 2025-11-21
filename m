Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D315CFC28F
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 16:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC8EE3CF9F7
	for <ltp@archiver.kernel.org>; Fri, 21 Nov 2025 17:16:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B21B63CC978
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 17:15:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 31BFD2005C8
 for <ltp@lists.linux.it>; Fri, 21 Nov 2025 17:15:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E37121243;
 Fri, 21 Nov 2025 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763741747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En7K23VBB1jC0z+2ePTTLhFPCSoCPQ9jVQJxYrFp2us=;
 b=taFc220aFWlt+o443QnI89un1PmklLlGScDNM2oChaO2dWUl4KrpUdhMbefcUgZc/HQ5Ym
 iQX6CqAFjOL1ARbIWtuYuRvbJHJE1lrS8WepPTk3A2KpwoTtnk5kZK6nSMzr5yHHDlwA7U
 oGYEWk48IiHBPFFKkYK5UyHtqO2ssGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763741747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En7K23VBB1jC0z+2ePTTLhFPCSoCPQ9jVQJxYrFp2us=;
 b=REQ8eD957WFxduc4vn93nb1S/pMf1IjVlgSIgMwHN0AHD62/KtdJV5zCRXUkBgyInVi/Et
 ckGLyTLeak6mynDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=taFc220a;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=REQ8eD95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763741747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En7K23VBB1jC0z+2ePTTLhFPCSoCPQ9jVQJxYrFp2us=;
 b=taFc220aFWlt+o443QnI89un1PmklLlGScDNM2oChaO2dWUl4KrpUdhMbefcUgZc/HQ5Ym
 iQX6CqAFjOL1ARbIWtuYuRvbJHJE1lrS8WepPTk3A2KpwoTtnk5kZK6nSMzr5yHHDlwA7U
 oGYEWk48IiHBPFFKkYK5UyHtqO2ssGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763741747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En7K23VBB1jC0z+2ePTTLhFPCSoCPQ9jVQJxYrFp2us=;
 b=REQ8eD957WFxduc4vn93nb1S/pMf1IjVlgSIgMwHN0AHD62/KtdJV5zCRXUkBgyInVi/Et
 ckGLyTLeak6mynDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18E383EA61;
 Fri, 21 Nov 2025 16:15:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pthTBDOQIGk8fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Nov 2025 16:15:47 +0000
Date: Fri, 21 Nov 2025 17:15:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251121161545.GA14501@pevik>
References: <20251117034023.415246-1-wakel@google.com>
 <aRy0-9KIPlRBvnNk@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRy0-9KIPlRBvnNk@yuki.lan>
X-Rspamd-Queue-Id: 4E37121243
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Ignore cve-2022-2590_64bit CVE for Kernel
 versions below 5.16+
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
Cc: Wake Liu <wakel@google.com>,
 Kodanda Rami Reddy V <quic_kreddyv@quicinc.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kodanda, all,

> Hi!
> > CVE 2022-2590_64bit is applicable only for kernel versions 5.16 onwards.

The fix 5535be309971 (actually FOLL_COW removal) was merged into v6.0-rc3.
Probably because this is feature change it was not merged into 5.15 stable and
the older trees. If we want to mask older kernels IMHO it should be on kernels
older than 6.0.

But we don't want to hide bugs, right?

> Why? What happens if you run the test on an older kernel? This
> information should be written here.

> > Add kernel version check to skip/Ignore the test case.
> > Test Module: vts_ltp_test_arm_64
> > Test Case: cve.cve-2022-2590_64bit#cve.cve-2022-2590_64bit

very nit: the subject should not have "_64bit".

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
