Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE21C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 10:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97E533C6CD7
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:40:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2255C3C579E
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:40:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B01B9200921
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:40:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5EE83EA5;
 Fri, 14 Aug 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786704015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfOttgZrvG4Bs7fYg3RCBbdFgQLKPPGDxawJ1WpaaxQ=;
 b=qeD9vMBUGpNTr/bZTFig4ZijVJwjQaoRkQCN5/R7MJ9zRiGvt2yR9qH8O4sMeW25Pxad5A
 A4VgzXYAGpQocxk1E282nL0tNrtKzhXoVs970KuZNTsAa3czk+0l213/ds2TLSKwzmu/TB
 1SfArFjqetGsV5ofiMr4A+5g/XMW10I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786704015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfOttgZrvG4Bs7fYg3RCBbdFgQLKPPGDxawJ1WpaaxQ=;
 b=3WBy0RkRFviNp7plRwa45Hvc48TWr+gZJjH8eSZpM50pqT6gYo17i5kyjgof/ZTVQdqlCj
 IqS5dDdXWkkW3jDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786704011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfOttgZrvG4Bs7fYg3RCBbdFgQLKPPGDxawJ1WpaaxQ=;
 b=oWsjI/2yy604orT0t5AqMHnxW+GdVpuLtQZcfnHq6JdFQjuvcqq430C4mMVRvLVKVyLxLi
 gCp0VHJ212KYvV+Oa8DQhku/+Bhf8K0yrGmP8TSJSqIv90IUFlx+WZTI3xQnKhleXxKZdq
 WZwLsjKbUOh6nEYysOHZz30O0djThJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786704011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfOttgZrvG4Bs7fYg3RCBbdFgQLKPPGDxawJ1WpaaxQ=;
 b=O2opb0DxSiO9fIdOCdwVxAis1a4G1nC6KQdgCJxYqIMAAgU7iDrijFp+D7GsrQ3OyYfBxl
 AT99zC7jVYR9UPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 989D67832C;
 Fri, 14 Aug 2026 10:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id twHGI4vwfmrqLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Aug 2026 10:40:11 +0000
Date: Fri, 14 Aug 2026 12:40:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260814104002.GA1950245@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTyVyeeMo6EQfG@yuki.lan> <20260812130025.GB1758016@pevik>
 <an7pLCWfdgEPV6G1@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <an7pLCWfdgEPV6G1@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> > You're probably right. When I started this there were 3 tests and I thought there
> > would be more. I also thought this would be useful info in the metadata.  But
> > in later versions it turn out 2 of them are to be removed. Now I double checked
> > "tst_kvercmp >" code and it looks like none of them applies to .max_kver usage.
> > I agree that a single test is not enough as a reason to have it in the metadata.
> > Maybe there will be more in the future, but really just a few.

> I would set the threshold at at least two tests needs this. If the
> functionality is used only by one test, it's likely not worth adding the
> API.

+1

> > => I should probably send yet another version where I implement the skip in the
> > setup. Could you please comment these 2 commits (I would not resend them)?

> Which ones?

I'm about to merge the original approach for fanotify20 (just to join split
string):
https://lore.kernel.org/ltp/20260616210448.12175-2-anonymemeow@gmail.com/

I guess these 2 could be merged:
https://lore.kernel.org/ltp/20260810160048.1040517-6-pvorel@suse.cz/
https://lore.kernel.org/ltp/20260810160048.1040517-5-pvorel@suse.cz/

And then we are done with the test fixes, I wonder if it's worth to add
lib/newlib_tests/tst_max_kver_old.c (only this one) from this patchset

https://lore.kernel.org/ltp/20260810160048.1040517-8-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
