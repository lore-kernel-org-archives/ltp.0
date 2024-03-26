Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B984CD1283
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:40:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D15403D0ED3
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:40:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BBC3CC7D4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:39:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4457D20005A
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:39:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D1BF37CCD;
 Tue, 26 Mar 2024 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711463988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyFY84O7jk3Ih1a/tNlQCdKB2qeXM19t+4aDpmoBhkI=;
 b=UTouxnCt3gQd4TVMuf8jSb+q3mmNJDYwVeONradzUqjTbIm4QE5wUpGFPecLvjYqQ0utpL
 UYRBK3yx5uzPp+HhQZ6bWewl8BJsIstq2Yq04deQ+taMSkta3NN1+4Y1KrCwwr/V2lUnD0
 Brd8szmKHl4qEGkSQpju5fFcTMBGbhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711463988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyFY84O7jk3Ih1a/tNlQCdKB2qeXM19t+4aDpmoBhkI=;
 b=JBIqGGLQFeWMVNSffUPq9Rgqys4TCpweor31Ra08kFEBtMHhMN6wAv7iC6qW40bURHNNYH
 RVeVh8LEo/yNr3CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711463988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyFY84O7jk3Ih1a/tNlQCdKB2qeXM19t+4aDpmoBhkI=;
 b=UTouxnCt3gQd4TVMuf8jSb+q3mmNJDYwVeONradzUqjTbIm4QE5wUpGFPecLvjYqQ0utpL
 UYRBK3yx5uzPp+HhQZ6bWewl8BJsIstq2Yq04deQ+taMSkta3NN1+4Y1KrCwwr/V2lUnD0
 Brd8szmKHl4qEGkSQpju5fFcTMBGbhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711463988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyFY84O7jk3Ih1a/tNlQCdKB2qeXM19t+4aDpmoBhkI=;
 b=JBIqGGLQFeWMVNSffUPq9Rgqys4TCpweor31Ra08kFEBtMHhMN6wAv7iC6qW40bURHNNYH
 RVeVh8LEo/yNr3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C92213688;
 Tue, 26 Mar 2024 14:39:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ssD3BTTeAmbNQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 26 Mar 2024 14:39:48 +0000
Date: Tue, 26 Mar 2024 15:37:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kogure =?utf-8?B?QWtpaGlzYeOAgCgg5bCP5pqu44CA5piO5LmFICk=?=
 <akihisa.kogure.ke@kyocera.jp>
Message-ID: <ZgLdmj2fx0PQzHgO@rei>
References: <TYAPR01MB6044D2E0749663D84DE1F395D9352@TYAPR01MB6044.jpnprd01.prod.outlook.com>
 <ZgLaddvHSGVBhnU1@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgLaddvHSGVBhnU1@rei>
X-Spamd-Result: default: False [-1.41 / 50.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.61)[81.89%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] input_helper: Modify the check range of the input
 event number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > If the input event number is greater than 32, the newly added event ID
> > will be 256 or later.
> 
> I've tried it and it seems to work that way, but it strange why these
> are numbered discontinously. May be even a bug.

And apparently this is intentional:

commit 7f8d4cad1e4e11a45d02bd6e024cc2812963c38a
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon Oct 8 09:07:24 2012 -0700

    Input: extend the number of event (and other) devices


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
