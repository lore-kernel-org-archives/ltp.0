Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B54ACD4F2C
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:17:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA62C3E2FB1
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:17:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 346113C0970
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:16:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50B10600A47
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:16:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68E3B75E48;
 Fri, 12 Jun 2026 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781252211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y7Y4VNhDrzq6cVg51ncdAWoYaJdDB6bK0XR8WPsmfc=;
 b=qF8/ZYB1sRcrfunYv0TPGwiJgiY1aoCPHbk9+/VB9pw+SMoSTFGOFaq23YVWZ2jEsJOWB7
 5CQUN0MksyAirzRBge0jfuQp1BIoQvyv+IlrkxHT/cHbx2Hvdpc5rtEq1tWuwFMGUyVKYT
 iCRIW4dD0tD+1u1rJODpkoyKzBsSN9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781252211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y7Y4VNhDrzq6cVg51ncdAWoYaJdDB6bK0XR8WPsmfc=;
 b=X486GLzDh+3pLYQWW82gy0eMwYBJuFn9nKtGeLAPffdsx74yvYTpOxccAwDlcSDDrktB7v
 aiRdmn2WnEFIZgAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781252211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y7Y4VNhDrzq6cVg51ncdAWoYaJdDB6bK0XR8WPsmfc=;
 b=qF8/ZYB1sRcrfunYv0TPGwiJgiY1aoCPHbk9+/VB9pw+SMoSTFGOFaq23YVWZ2jEsJOWB7
 5CQUN0MksyAirzRBge0jfuQp1BIoQvyv+IlrkxHT/cHbx2Hvdpc5rtEq1tWuwFMGUyVKYT
 iCRIW4dD0tD+1u1rJODpkoyKzBsSN9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781252211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3y7Y4VNhDrzq6cVg51ncdAWoYaJdDB6bK0XR8WPsmfc=;
 b=X486GLzDh+3pLYQWW82gy0eMwYBJuFn9nKtGeLAPffdsx74yvYTpOxccAwDlcSDDrktB7v
 aiRdmn2WnEFIZgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B9DA779A7;
 Fri, 12 Jun 2026 08:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jJOaFXPAK2o+OwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 08:16:51 +0000
Date: Fri, 12 Jun 2026 10:16:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aivAcky_JDF4QqGa@yuki.lan>
References: <aik2VjAKb_EUYNsv@yuki.lan>
 <6a2bbdd6.e130e254.a31cb.0826@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a2bbdd6.e130e254.a31cb.0826@mx.google.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] doc: Complete struct tst_test table and
 shell API docs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +``TST_CHECKPOINT_WAKE_AND_WAIT``
> > > +    Wake one waiter and then wait (argument: checkpoint id).
> > 
> > This is the old shell API that is eventually going away.
> > 
> > The API that is going to stay is the JSON comment in the test.
> 
> Should I completely ignore this file then? For me it's ok.

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
