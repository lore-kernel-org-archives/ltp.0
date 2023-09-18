Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104EC46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:12:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E79DD3CE4CA
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:12:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5AB3CA99A
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:11:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1629C61B8A0
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:11:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 90BD01FDA7;
 Mon, 18 Sep 2023 10:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695031916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYbZKjnL4sFUET7dMNETemyQKNnF9LH2XxlP9BJ2OPc=;
 b=TVGYbvGLskCtKyD5gnmpTt0S+lWFIfvTCNjVEqVE8IbseMcLG9W94oc6cSM0H0EQ+nd6Ni
 QI6VaPti6jS3k9/ormTkZlAFtuwk2SmbBnSlMh9A6DJuAfoyDc7pb0VS1YoMgPqGh/NB1z
 OHYro0cTbMot/UW4nffWTfJtaeiPGPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695031916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYbZKjnL4sFUET7dMNETemyQKNnF9LH2XxlP9BJ2OPc=;
 b=LkfWuIyyCxq2q+neTb/KOLY45sfypmXuAfiHDKxRwIDGaaIq2QyrMOMyriT6Cu2qmFZiEi
 mlahebNtfEKONzAA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 48B212C143;
 Mon, 18 Sep 2023 10:11:56 +0000 (UTC)
References: <20230918092219.24151-1-andrea.cervesato@suse.de>
 <20230918092219.24151-3-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 18 Sep 2023 11:11:41 +0100
Organization: Linux Private Site
In-reply-to: <20230918092219.24151-3-andrea.cervesato@suse.de>
Message-ID: <871qevhjti.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add Linux Test eXecutor inside tools
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> The ltx program runs on the system under test (SUT). It's primary
> purpose is to run test executables in parallel and serialise the
> results.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules        |  3 +++
>  tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
>  tools/ltx/ltx-src  |  1 +
>  3 files changed, 35 insertions(+)
>  create mode 100644 tools/ltx/Makefile
>  create mode 160000 tools/ltx/ltx-src
>
> diff --git a/.gitmodules b/.gitmodules
> index 088023039..c9a6eea31 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -7,3 +7,6 @@
>  [submodule "tools/kirk"]
>  	path = tools/kirk
>  	url = https://github.com/linux-test-project/kirk.git
> +[submodule "tools/ltx/ltx-src"]
> +	path = tools/ltx/ltx-src
> +	url = https://github.com/linux-test-project/ltx.git
> diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
> new file mode 100644
> index 000000000..4810ec8df
> --- /dev/null
> +++ b/tools/ltx/Makefile
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2023 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2023 Andrea Cervesato <andrea.cervesato@suse.com>
> +#
> +# Install script for Linux Test eXecutor
> +
> +top_srcdir		?= ../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +ifneq ($(wildcard $(abs_srcdir)/ltx-src/*),)
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
> +endif
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


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
