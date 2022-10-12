Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77884C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 14:52:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2773CAEB1
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 16:52:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB7B3CAE97
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:52:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9D20D1A0106B
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:51:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5DB121BEC;
 Wed, 12 Oct 2022 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665586318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLDafqNtZ4ZFWJ8i2MRAs+air1qhOeg4GB4j3sZvX1I=;
 b=U7b+RIQ+2on1Rmt2P8ohiDvWiaKI3NrQBRFgAsYD8JDbvkOGlGtNRO34TzFqNJg7D6N2zS
 Jxa35Vdi+DI0LidIosNCfPYKgSw9ioX1oXYa/54jIsh5bT8S/Y9V+JVSNZ2qvhgR07EEvM
 DD0goiDlYlDFowf4DmeoSLpvZ9em7nI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665586318;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLDafqNtZ4ZFWJ8i2MRAs+air1qhOeg4GB4j3sZvX1I=;
 b=bwMD1mstfgqr2u+GpSHfhRE6l9FwkgyJdem+G7AxqLdm9BBC/HY/Z/uOITKXF+oqtYLcby
 wyNcBBaljZTeOJCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A850213A5C;
 Wed, 12 Oct 2022 14:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qdZ4J47URmPjLQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Oct 2022 14:51:58 +0000
Date: Wed, 12 Oct 2022 16:51:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y0bUjRsFJLXsAcgL@pevik>
References: <20221006081709.92303897@mail.steuer-voss.de>
 <dc5e3e41cf1465ddc70cbac0d77c4f2deff0213f.camel@linux.ibm.com>
 <Y0bBxv0569P/a3kW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0bBxv0569P/a3kW@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/keyctl/keyctl09.c: fix test encrypted key
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
Cc: Jarkko Sakkinen <jarkko@kernel.org>, ltp@lists.linux.it,
 Yael Tzur <yaelt@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > > This commit fixes the test for adding encrypted keys with unencrypted data.
> > > Unencryted data must be provided hex-ascii encoding. Due to a kernel
> > > bug, the unencypted data was not decoded to binary thus the length of
> > > the key was only half the specified key size. This patch doubles the key
> > > size and adds a test with a wrong key size to trigger a corresponding
> > > error.

> > > This patch must be used with the kernel fix
> > > https://lore.kernel.org/lkml/20220919072317.E41421357@mail.steuer-voss.de

> > Petr, please correct me if I'm wrong.  Changing an existing LTP test so
> > that it only works on kernels with the kernel patch applied, doesn't
> > sound right.  The test should emit a warning if the original "valid
> > payload" successfully loads.

> We also have a policy not to work around any kernel bugs. So if this
> really fixes a kernel bug it's okay that the test will fail on older
> kernels without this fix and the patch that fixes kernel should be added
> as a tag to the test.

@Nikolaus, FYI:
https://github.com/linux-test-project/ltp/wiki/C-Test-API#138-test-tags

But the patchset has not been even accepted by kernel maintainer - searching in
the kernel thread, looking into
https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/
and to the next tree.
Or am I wrong and it has been accepted?

Even once (if ever) the patch is accepted I agree with Mimi it'd be better to
add new test than change existing old (better for diagnostic what exactly went
wrong).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
