Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2076C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 23:00:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A32A13C7D0D
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 00:00:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E6F3C7982
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 00:00:08 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 080701027466
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 00:00:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C3DA2118A;
 Thu, 20 Feb 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740092406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9/vtvZiYYXfcKjJOkEsW/FqtFCZZSeX016LqwBJWEA=;
 b=Zajqoznc+SUXrOauWgg8HhDllQRQ0sbVKMvUj5WGJiDAU4qlgIcDoLVdx7jlajfgLtCq0O
 oQqyhLmMw4FpmCPYxzQ3mMBZPaz0HbtxMf0PDtuT8Cq3/WogOAiIlrnfhmWjyIDGCCPbsP
 Ux1LlPrshe/KRkUN+uRM0IakxJjQeSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740092406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9/vtvZiYYXfcKjJOkEsW/FqtFCZZSeX016LqwBJWEA=;
 b=51TeQHretvROaqFte0tMHqGHfWndaXBhdUfAOVUYVvRKqtK8F1bp/nVrRYWcFbJ3n2RHOS
 EdbBy2T89uFPBoCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740092405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9/vtvZiYYXfcKjJOkEsW/FqtFCZZSeX016LqwBJWEA=;
 b=M2ZGY4iuYKsamqrR6djge3ic5lormN0/QVM8RMZaS0mw27p0jU+HtdCLIvu2Dg/9XuRK1d
 Z25XtBCYCefZeit8/zBNuhvKb2D8s20zKSWIznRKEwGJayr5bhQ4Ge7QzRgMyiuTbyI7l7
 8Gt9oGMW9nwZFjVIg0bfzBvWhxK5b2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740092405;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9/vtvZiYYXfcKjJOkEsW/FqtFCZZSeX016LqwBJWEA=;
 b=gIZ09YRwt+WTU94HWuxSpiB1udOknNBg20VGuxCULL+LsJ/SowXztSh7KnLyT7lDkJwhm3
 CGaCeQaP49eDlDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8134C13A42;
 Thu, 20 Feb 2025 23:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jMi4HvWzt2egdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 23:00:05 +0000
Date: Fri, 21 Feb 2025 00:00:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250220230000.GB2726725@pevik>
References: <20250219160143.2589026-1-pvorel@suse.cz>
 <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.18)[-0.889]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

Hi Andrea,

> Hi,

> mmh..result looks really weird. Basically every table item is a link to
> tst_test. Did you check if it's possible to extend the struct parser in
> order to have a link for each attribute?

I was although thinking about it, but haven't checked the code. I suppose you'll
be much faster than me with this as you're more familiar with sphinx. I gave up
because reader is nearly at the correct location.

I suppose missing code needs to be done in linuxdoc.rstKernelDoc extension.
Because although it's possible to link to the member in linuxdoc.rstKernelDoc 
(e.g. &tst_test.needs_root), but it leads to "struct tst_test" [1] definition,
which has only anchors for Definitions [2] and Members [3]. I guess it's somehow
possible to link it via C domain [4], but it's not used in linuxdoc.rstKernelDoc
extension.

I tried linuxdoc [5] update to the latest 20240924 (not much changes anyway),
but members still do not have id sections.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#struct-tst-test
[2] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-definition
[3] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-members
[4] https://www.sphinx-doc.org/en/master/usage/domains/c.html#role-c-var
[5] https://github.com/return42/linuxdoc.git

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
