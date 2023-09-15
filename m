Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC13EE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1555D3CE683
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:29:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315913CB23E
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:29:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E94A14088F8
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:29:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 583B11FD6E;
 Fri, 15 Sep 2023 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694788182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yz7Q/9lJkf+rSGHLuw7OVoPVQOpzXxWp6uarDYLY72I=;
 b=cIL5CUA8o6N55ZWI+8GiHTQ3d3YtEoQPmUqa6joW3lHKzFGqk5+xlK7dBtZE7dsT+P1ZB5
 aJ/C9a9gtM2L4Fc1wC2nutcdRpWgQXcmgFAS8yD7jKyHvXDpm3SzgBYp9T5rdFIAojIdEV
 fSW/kH0CEeNCi+Gto/3jcrX1qDF/yUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694788182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yz7Q/9lJkf+rSGHLuw7OVoPVQOpzXxWp6uarDYLY72I=;
 b=0ZkN1YpkkDeqFZBURjbu7XIsmxQXuD8rDyQzRdHQp2QG4bGl1sqazXlkUKvdrmE/HjfuY6
 xm6zogF+rPvK+jCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44AB013251;
 Fri, 15 Sep 2023 14:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2whkD1ZqBGXIfgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 15 Sep 2023 14:29:42 +0000
Date: Fri, 15 Sep 2023 16:30:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZQRqg2TWYZyDLjtz@yuki>
References: <20230915142545.16446-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915142545.16446-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add Linux Test eXecutor inside tools
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
>  [submodule "tools/kirk"]
>  	path = tools/kirk
>  	url = https://github.com/linux-test-project/kirk.git
> +[submodule "tools/ltx/ltx-src"]
> +	path = tools/ltx/ltx-src
> +	url = https://github.com/linux-test-project/ltx.git

This is added on the top of the patch that adds kirk, can you send that
one first please?

> diff --git a/tools/ltx/.gitignore b/tools/ltx/.gitignore
> new file mode 100644
> index 000000000..0205b4ec7
> --- /dev/null
> +++ b/tools/ltx/.gitignore
> @@ -0,0 +1 @@
> +ltx
> diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
> new file mode 100644
> index 000000000..0fbf7cfd9
> --- /dev/null
> +++ b/tools/ltx/Makefile
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2023 Cyril Hrubis <chrubis@suse.cz>
> +#
> +# Install script for Linux Test eXecutor
> +
> +top_srcdir		?= ../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +BINARY=ltx
> +
> +MAKE_TARGETS := $(BINARY)
> +
> +CFLAGS+=-I$(abs_srcdir)/ltx-src/ -I$(abs_srcdir)/ltx-src/msgpack/
> +
> +$(BINARY): $(wildcard $(abs_srcdir)/ltx-src/*.c $(abs_srcdir)/ltx-src/msgpack/*.c)
> +ifdef VERBOSE
> +	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +else
> +	@echo CC $@
> +	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +endif
> +
> +INSTALL_DIR := $(prefix)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/tools/ltx/ltx-src b/tools/ltx/ltx-src
> new file mode 160000
> index 000000000..d6d150947
> --- /dev/null
> +++ b/tools/ltx/ltx-src
> @@ -0,0 +1 @@
> +Subproject commit d6d1509479537f4fdfa9b5adcb67eb6312714999
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
