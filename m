Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CEDEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 10:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AAD73CDD37
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 12:12:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 490543C02B2
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 12:12:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 30FEB6011FC
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 12:12:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FE611FE2F;
 Wed, 19 Jul 2023 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689761548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUqM/MO+EcUB5Mn16viXcMG+TXGfVA9X+UgWmh5SBYk=;
 b=ptd+sOAYhgpd9OlF1Vsr0nMqc+CoSjOtuH4E1TXk1H3STaly9BI//qwCUWV/+htrbAbCPi
 pzj4l6rL9vZKb0rUY8YDRisbU6NX/3kjA9aOW7aifhZx3cAgndM1keD/JyIJOeVnuNJsan
 SfRRFn9feZmcrXYFCCNyY+EHX83BMZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689761548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUqM/MO+EcUB5Mn16viXcMG+TXGfVA9X+UgWmh5SBYk=;
 b=bADdvYMKTUnZt8XXMKTk7u+vIff+vILd8iFZQ3ncEzRWlxkj2F2Rx/OKPEc9dEzSp3zxUI
 6c1mhhgHS4NDqHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C123C13460;
 Wed, 19 Jul 2023 10:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N3BpJgu3t2Q/OAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 10:12:27 +0000
Date: Wed, 19 Jul 2023 12:12:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230719101225.GB1221211@pevik>
References: <20230718100050.1162482-1-pvorel@suse.cz>
 <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fAuHrE4XyBjpudMCJJ4ZJ+9TOu=LpHXzizUp-uRqWXdA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] compat_16: Define USE_LEGACY_COMPAT_16_H for
 legacy tests
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

Hi Li,

...
> I'm not sure here if we really need COMPAT_16_H for choosing two compat
> header file.
> As we already use hard code in C source file like #include "compat_16.h" or
> "compat_tst_16.h",
> so compile with -I the header directory is enough I guess.

> Try this simple compat_16.mk, it at least works well on my side.
> Or, did I miss anything in the 16bit compilation?

I like this simplification.

Well, touch compat_16.h causes rebuilding tests which use compat_tst_16.h.
I don't mind that. But OTOH touch compat_tst_16.h does not trigger rebuilding
tests which use compat_tst_16.h :( (tested on
testcases/kernel/syscalls/setregid). Could you please recheck that?

Kind regards,
Petr

> # cat compat_16.mk

> CPPFLAGS += -I$(abs_srcdir) -I$(abs_srcdir)/../utils

> SRCS ?= $(sort $(wildcard $(abs_srcdir)/*.c))

> MAKE_TARGETS := $(notdir $(patsubst %.c,%,$(SRCS)))
> MAKE_TARGETS_OBJS_WO_COMPAT_16 := $(addsuffix .o,$(MAKE_TARGETS))
> MAKE_TARGETS += $(addsuffix _16,$(MAKE_TARGETS))

> DEF_16 := TST_USE_COMPAT16_SYSCALL

> %_16: CPPFLAGS += -D$(DEF_16)=1

> %_16.o: %.c
> $(COMPILE.c) $(OUTPUT_OPTION) $<

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
