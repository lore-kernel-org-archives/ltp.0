Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2AC433FE
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 16:03:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9642261101
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 16:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9642261101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94ACF3C58AF
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 17:03:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC2DD3C58AF
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 17:03:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C0D561A005E8
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 17:03:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E09001FD29;
 Tue,  2 Nov 2021 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635869002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xv2SxzReRAnYaZK85FJInOufKrtWTgeXCtkdlt7vAz4=;
 b=sBh+mtjt6zuFWnkXVTTqCsMqSDPUIP+Y5DOq9msUUm/GgW5DVKVlIvpXmJoo2EK+ickZI8
 kEKxm4saOpHX8qVeL84OhvTq6hUzSxLd29b7bUFu/rfcnUbzofXCZu9ZwGbGSvBGNgToH+
 snzZVrbpRgVCRdKfZ4kN4Rk7J8DtCbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635869002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xv2SxzReRAnYaZK85FJInOufKrtWTgeXCtkdlt7vAz4=;
 b=ueD4aMTqtva5JlZlONFXAlKuBZjrScMcPtb5ySJP2geyan+dW2BhCQvC8ITgVQbpJM5T4l
 sYRY0JStiyGvqBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C827213DC7;
 Tue,  2 Nov 2021 16:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PzKmLkphgWHfXgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 02 Nov 2021 16:03:22 +0000
Date: Tue, 2 Nov 2021 17:04:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YYFhgS9r+TWxN0QB@yuki>
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-8-chrubis@suse.cz> <YYFXns53AsnQQg6w@pevik>
 <YYFZLdb91Tz9h6vN@yuki> <YYFbz0LCHPiY+MNB@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYFbz0LCHPiY+MNB@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/7] docparse: Split into metadata and docparse
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
> > > ltp.git/metadata $ make
> > > HOSTCC metadata/metaparse
> > > ltp.git/metadata/parse.sh > ltp.json
> > > ltp.git/metadata/parse.sh: line 33: ltp.git/metadata/../docparse/docparse: No such file or directory
> > > # => OK let's go to docparse and make first
> 
> > The docparse build should be triggered from the metadata directory,
> > since the ltp.json has to be generated first.
> 
> > But I have forgotten to update the parse.sh script. Have you seen the
> > reply to this patch?
> 
> I see, thx!

Also looking at the Makefile it may not work with out-of-tree build, so
we may need this as well:

diff --git a/metadata/Makefile b/metadata/Makefile
index 76a3aed94..9b88d8302 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -17,10 +17,10 @@ ltp.json: metaparse

 docparse: ltp.json
 ifeq ($(WITH_METADATA),yes)
-       $(MAKE) -C ../docparse/
+       $(MAKE) -C $(top_srcdir)/docparse/
 endif

 test:
-       $(MAKE) -C tests/ test
+       $(MAKE) -C $(abs_srcdir)/tests/ test

 include $(top_srcdir)/include/mk/generic_leaf_target.mk


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
