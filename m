Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF65C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 13:08:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7FD33D1B0C
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 15:08:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F0413D0B1D
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:07:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D788608A70
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 15:07:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2AF421A25;
 Thu, 18 Jul 2024 13:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721308075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCA4/M7o/68UdU7Uegvk0yl1FUn06c5XkBD5TtF1iK0=;
 b=EjMCoiT8oCnJz8GashC365wdHPSr/Cv/NR9jreEMmVdP7vdebIZuJVYqr9ldVPuIOIaV07
 aAnV0bztUw43L8g8HP7mX5IEtjNXJBVgEJk852ZDyeuw/EID2lFnlbuCqpytDiZ6Pz8Nb3
 VsTId+RgI/s2ZlAlgWowIx7b8mELtGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721308075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCA4/M7o/68UdU7Uegvk0yl1FUn06c5XkBD5TtF1iK0=;
 b=rABOtucVTlbQ89dswFPgEfLTBNLrWzCvu1DDSBl1sxCEkJaFTNfhvTydeefJmExS1YLVdd
 sc1XLK8A0J5Sp7BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721308075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCA4/M7o/68UdU7Uegvk0yl1FUn06c5XkBD5TtF1iK0=;
 b=EjMCoiT8oCnJz8GashC365wdHPSr/Cv/NR9jreEMmVdP7vdebIZuJVYqr9ldVPuIOIaV07
 aAnV0bztUw43L8g8HP7mX5IEtjNXJBVgEJk852ZDyeuw/EID2lFnlbuCqpytDiZ6Pz8Nb3
 VsTId+RgI/s2ZlAlgWowIx7b8mELtGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721308075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCA4/M7o/68UdU7Uegvk0yl1FUn06c5XkBD5TtF1iK0=;
 b=rABOtucVTlbQ89dswFPgEfLTBNLrWzCvu1DDSBl1sxCEkJaFTNfhvTydeefJmExS1YLVdd
 sc1XLK8A0J5Sp7BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95011136F7;
 Thu, 18 Jul 2024 13:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jdHkIKsTmWY9fgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Jul 2024 13:07:55 +0000
Date: Thu, 18 Jul 2024 15:07:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZpkTmcvKtJeTsU_N@yuki>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <20240718125709.GB738326@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240718125709.GB738326@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> > This is a proof of a concept of a seamless C and shell integration. The
> > idea is that with this you can mix shell and C code as much as as you
> > wish to get the best of the two worlds.
> 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  include/tst_test.h                           | 38 +++++++++++++
> >  lib/tst_test.c                               | 51 +++++++++++++++++
> >  testcases/lib/.gitignore                     |  1 +
> >  testcases/lib/Makefile                       |  4 +-
> >  testcases/lib/run_tests.sh                   | 10 ++++
> >  testcases/lib/tests/.gitignore               |  6 ++
> >  testcases/lib/tests/Makefile                 | 11 ++++
> >  testcases/lib/tests/shell_loader.sh          |  5 ++
> >  testcases/lib/tests/shell_test01.c           | 17 ++++++
> >  testcases/lib/tests/shell_test02.c           | 18 ++++++
> >  testcases/lib/tests/shell_test03.c           | 25 +++++++++
> >  testcases/lib/tests/shell_test04.c           | 18 ++++++
> >  testcases/lib/tests/shell_test05.c           | 27 +++++++++
> >  testcases/lib/tests/shell_test06.c           | 16 ++++++
> FYI we have shell tests for new library in lib/newlib_tests (C tests) and
> lib/newlib_tests/shell/ (shell tests), is it necessary to add new location? Or,
> if you prefer this, we should move existing tests from lib/newlib_tests/shell/
> to this new location.

For a historical reasons the lib for shell is in testcases/lib/ and the
tests use paths to binaries and scripts in there so I added the code
there. We may as well move it to the top level lib/shell, or create top
level slib (as for shell lib) or anywhere else as long as we agree on a
better place to put the code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
