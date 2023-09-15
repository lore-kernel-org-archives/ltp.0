Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EE7EED619
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:41:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35BF73CE6A7
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 18:41:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84D9F3CB133
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:41:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D3E5603122
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:41:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 47B31218FE;
 Fri, 15 Sep 2023 16:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694796065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iES/A4tmD0CrYhrwrc4DT4Z02BLj/EWKwG+5f5pQOkU=;
 b=Lh+qcwIUa7RacpHW0l6q/GGMPWi9jXso+ziSr5mjLG/0RKAnvcl4cepJRkn2j7lNWSXDGr
 JWFbJmA+ylO1eHYeSAi2kwyIHxqSgAlEJGi8FG2G4qvHNdn1QzjQPhBfa2rkgDNtoltidU
 3bJxQNLfHeNwZwVb2sF/F7ITMxPSEco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694796065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iES/A4tmD0CrYhrwrc4DT4Z02BLj/EWKwG+5f5pQOkU=;
 b=ryV7CFhoCpToynZsmWSwRQbA5tp1XiZdSH728wq0NT+gU/UipaxhAomb9+9+txYUEjQxcI
 UJxGZ1GC7ozBR/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 338EF13251;
 Fri, 15 Sep 2023 16:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lwoRCCGJBGW0PAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 15 Sep 2023 16:41:05 +0000
Date: Fri, 15 Sep 2023 18:41:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZQSJThJZLuAuxaMT@yuki>
References: <20230915144156.22380-1-andrea.cervesato@suse.de>
 <20230915144156.22380-3-andrea.cervesato@suse.de>
 <20230915152910.GB73280@pevik> <20230915154135.GA11318@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915154135.GA11318@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add Linux Test eXecutor inside tools
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
> This is breaking build:
> 
> 2023-09-15T13:47:12.1128844Z make -C ltx
> 2023-09-15T13:47:12.1148029Z make[3]: *** No targets specified and no makefile found.  Stop.
> 2023-09-15T13:47:12.1153175Z make[2]: *** [/__w/ltp/ltp/tools/ltx/Makefile:13: all] Error 2
> 2023-09-15T13:47:12.1159251Z make[1]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> 2023-09-15T13:47:12.1163512Z make[1]: Leaving directory '/__w/ltp/ltp/tools'
> 2023-09-15T13:47:12.1169815Z make: *** [Makefile:94: tools-all] Error 2

I suppose that we need

> Reproduce with simple:
> $ cd tools && make -C ltx
> 
> The problem is because there is no tools/ltx/Makefile

Huh? I did apply the two patches and I do have tools/ltx/Makefile

And actually there is a minor problem there, without the submodules
checked out I get:

CC ltx
gcc: fatal error: no input files
compilation terminated.
make: *** [Makefile:21: ltx] Error 1

So I guess that we need:

diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
index 0fbf7cfd9..43ed93c6b 100644
--- a/tools/ltx/Makefile
+++ b/tools/ltx/Makefile
@@ -7,6 +7,8 @@ top_srcdir              ?= ../..

 include $(top_srcdir)/include/mk/env_pre.mk

+ifneq ($(wildcard $(abs_srcdir/ltx-src/*)),)
+
 BINARY=ltx

 MAKE_TARGETS := $(BINARY)
@@ -23,4 +25,6 @@ endif

 INSTALL_DIR := $(prefix)

+endif
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk

> Why are the sources in tools/ltx/ltx-src instead of tools/ltx anyway?

Because if there is a directory with the name ltx it horribly confused
Make.

> I guess you used sparse approach, which is not necessary here.

I'm not sure that we can do things simpler, the Makefile in the ltx git
repository does not support out of tree build, so unless we remove that
from LTP this is probably the easiest solution.

> I'm ok with that if it makes things simpler, but please include the required
> Makefile.

It is there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
