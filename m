Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD39CD11C2
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 08:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D8E93CEC2C
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 10:55:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BB253CE6BE
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 10:54:56 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76FF91BB95A6
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 10:54:56 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45BA121A26;
 Fri,  5 Apr 2024 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712307293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/do+cG1y+EdytwaQO2W/CtbWE5kEdrA0PqRVQsw++Tc=;
 b=ZtYMk+6lxc/sSedI2RUE3BSQzDkM8iX2TWNj6OAycuZKihOekQUvuqD9fzIn9qR81N22Qu
 8kklPEo0AlcKXXQocqB1i3Espkypqo0/ULf0KQJCd1pmLBadOyHTQiNiPxDrPxuwZ0AERw
 r5R/SloHehjP46IIE/5f69dyYTgZiRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712307293;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/do+cG1y+EdytwaQO2W/CtbWE5kEdrA0PqRVQsw++Tc=;
 b=ikPLBUmFPsvjKesO3OxQ2xeLd7SW3RXseFBrMc9f98UYfL4pMYsYkQ/nfHU8qa8v8yuxVW
 j7o592b6gErBt9Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j3FeIsIw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SXAZk+Se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712307292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/do+cG1y+EdytwaQO2W/CtbWE5kEdrA0PqRVQsw++Tc=;
 b=j3FeIsIwR5PaEN8+5VVjZ5UpetW31igemetFIJ9qJqh9onzZ4bDo9GTv+i7iEGK1nv1ll0
 XUfyLeKAVxSNbpgB+3OzszS8ie1mz1mLsxXkE+TaPD1qvCHf9Nq4ZShGhT/5wUyB8vLdZb
 fj84iRWuB687pNOhPZf97Io2BQZTb7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712307292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/do+cG1y+EdytwaQO2W/CtbWE5kEdrA0PqRVQsw++Tc=;
 b=SXAZk+SefN6xbwlN+ZKaYCWifHJ+QZ+Rgo29rla9vfCK8Ni+SXscTCnFuTubtP+cqdRNyH
 0rQYPjJIgs5rdJAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 35565139E8;
 Fri,  5 Apr 2024 08:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9dgGDFy8D2YmTAAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Fri, 05 Apr 2024 08:54:52 +0000
Date: Fri, 5 Apr 2024 10:53:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zg-8HwWdC5eOZseY@yuki>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
 <20240403032859.3826-2-wegao@suse.com> <Zg6wV8Xb004kAqkK@yuki>
 <20240404160151.GE503552@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240404160151.GE503552@pevik>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 45BA121A26
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
> > This one looks good, I would wote for merging it now, however the
> > subject suggests that the TST_EXP_PASS_PTR_* functions are implemented
> > here as well, which isn't the case.
> 
> > So I propse to fix the subject to include only EXP_FAIL_ and merge this
> > then add the EXP_PASS_ variants in another patch.
> 
> Sure, I'll fix that before merge.
> 
> BTW I fix that in the v6 patchset which I sent (and I Cc Wei and you) before Wei
> sent his v6 (my only change was adding everything into test_macros02 and use
> macros to shorten the code as more macros will be added to it in the future. I
> suppose you prefer the original code as you acked this).

I'm simply lost in the number of iterations for this patch. Also I do
not think that reducing the duplication in the library test is that
important, but feel free to push that with my reviewed-by as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
