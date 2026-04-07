Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AA5EDB7D4
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 09:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1062F3E29A7
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:43:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03EC3DB86B
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:43:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5DA0120075E
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:43:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88D274E3B0;
 Tue,  7 Apr 2026 09:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775554982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwmf17h0X4s0X5AbAAq6yXxGGrJP3SmNyhfKxQsjDh4=;
 b=NkV+B4uPMeeIPs4BF6JoA9f55Wn2sC2XtAQLmeseiuRgZ9imRDjL58lScLmQ8coOKlGn1p
 44hHitMp3dDNxEKOOFkDzUqLHqMXESVipF7nMOLJHyRgRpt7JCgxoCQLNcCgFfJg4XvpGW
 Syl34E1AzShGWDIlKIm1w7Cd/1DLLGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775554982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwmf17h0X4s0X5AbAAq6yXxGGrJP3SmNyhfKxQsjDh4=;
 b=cJGsMX3hKYkAQjgNIYu2KI/M6ZU5B5RniZXgLOytchBluV/c+l7d6ga/Gu1dIIbRUqD4kk
 myskVZJefEty9MDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775554982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwmf17h0X4s0X5AbAAq6yXxGGrJP3SmNyhfKxQsjDh4=;
 b=NkV+B4uPMeeIPs4BF6JoA9f55Wn2sC2XtAQLmeseiuRgZ9imRDjL58lScLmQ8coOKlGn1p
 44hHitMp3dDNxEKOOFkDzUqLHqMXESVipF7nMOLJHyRgRpt7JCgxoCQLNcCgFfJg4XvpGW
 Syl34E1AzShGWDIlKIm1w7Cd/1DLLGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775554982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwmf17h0X4s0X5AbAAq6yXxGGrJP3SmNyhfKxQsjDh4=;
 b=cJGsMX3hKYkAQjgNIYu2KI/M6ZU5B5RniZXgLOytchBluV/c+l7d6ga/Gu1dIIbRUqD4kk
 myskVZJefEty9MDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A0A34A0B0;
 Tue,  7 Apr 2026 09:43:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xt3kHKbR1GlpaQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 09:43:02 +0000
Date: Tue, 7 Apr 2026 11:43:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <adTRqJao6jxdg-J1@yuki.lan>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-4-chrubis@suse.cz>
 <20260402214727.GE225068@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260402214727.GE225068@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/17] lib: tst_kernel: Add
 tst_check_module_driver()
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
> > -	return -1;
> > +int tst_check_module_driver(const char *driver)
> > +{
> > +	return tst_search_driver(driver, "modules.dep");
> 
> Thinking about it twice, could we check for the module by reading
> /sys/module/? Our current approach shows what module *should* be available, but
> that might not be true for some reason (i.e. loadable module not installed).

The modules.dep file contains names of all modules installed in
particular kernel modules directory. We cannot do anything better than
parsing that file because it's (re)genrated on the system each time
packages with modules have been installed/removed. If that wasn't the
case modprobe that depends on that file wouldn't work either.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
