Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ECEC4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:03:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 802913CD9FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 13:03:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EC683C0181
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:03:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30933600667
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 13:03:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 76771225B9
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667822606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUq7+s10fHZSJEzgeOawnKr/keeAHap2JrVCppZ2IxM=;
 b=ARImmmOqJ0Iye/F3jKn0oDvfGeVeRQt6d93lo47ZcbL884Xx/QL44MTz6pdALRNsUKXjIS
 +9z/7kODOy8Bd3dJj+llfVciU77ENcjsuz4xYnlyp/HQt3PXFVvjR3ZRIIR7xBb80Vnl94
 qe6vxk9Jz8alwaGgPWlLxXiaHVxs+Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667822606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HUq7+s10fHZSJEzgeOawnKr/keeAHap2JrVCppZ2IxM=;
 b=cggd04WBsPufD0sUAodP03fuwEUsd1eCDao0ImIJUuHtDeR2osQ6GvWGaLFWe76qt7r715
 Z8SPXai4ltKV/DAQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 205422C141;
 Mon,  7 Nov 2022 12:03:26 +0000 (UTC)
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-4-pvorel@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 07 Nov 2022 12:03:02 +0000
Organization: Linux Private Site
In-reply-to: <20221021115333.13725-4-pvorel@suse.cz>
Message-ID: <87zgd3vunm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] doc: Remove
 mini-howto-building-ltp-from-git.txt
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

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Document is not linked into our wiki, there is "Quick guide to running
> the tests" section in README.md visible from web and CI scripts in
> ci/*.sh and build.sh, which describe what to install and how to build.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
> Do we want any of these move to "Quick guide to running the tests"
> section in README.md?
>
>
>  doc/mini-howto-building-ltp-from-git.txt | 62 ------------------------
>  1 file changed, 62 deletions(-)
>  delete mode 100644 doc/mini-howto-building-ltp-from-git.txt
>
> diff --git a/doc/mini-howto-building-ltp-from-git.txt b/doc/mini-howto-building-ltp-from-git.txt
> deleted file mode 100644
> index 28825c20f..000000000
> --- a/doc/mini-howto-building-ltp-from-git.txt
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -Mini-Howto: Building LTP from Git
> -=================================
> -
> -******************************************************************************
> -The following document briefly describes the single steps to build LTP from
> -the Git repository located at GitHub.
> -The instructions here were tested on a Ubuntu/precise Linux system (feel free
> -to adapt to your distribution).
> -
> -Changelog:
> - * Initial version: Sedat Dilek <sedat.dilek@gmail.com>
> - * Embedded comments from Cyril Hrubis <chrubis@suse.cz>
> -******************************************************************************
> -
> -# Export language settings
> -
> -export LANG=C
> -export LC_ALL=C
> -
> -# Set some useful variables (adapt if you dislike)
> -
> -WORKING_DIR="$HOME/src/ltp"
> -
> -PREFIX="/opt/ltp"
> -
> -GIT_URL="https://github.com/linux-test-project/ltp.git"
> -
> -MAKE_JOBS=$(getconf _NPROCESSORS_ONLN)
> -
> -BUILD_LOG_FILE="build-log.txt"
> -INSTALL_LOG_FILE="install-log.txt"
> -
> -# PREREQS on Ubuntu (package-list is incomplete and may vary for other distros)
> -
> -sudo apt-get install build-essential
> -sudo apt-get install autoconf automake autotools-dev m4
> -sudo apt-get install git
> -sudo apt-get install linux-headers-$(uname -r)
> -sudo apt-get install libaio-dev libattr1-dev libcap-dev
> -
> -# Working directory
> -
> -mkdir -p $WORKING_DIR
> -cd $WORKING_DIR
> -
> -# Get the LTP source
> -
> -git clone $GIT_URL ltp-git
> -
> -# Configure LTP
> -
> -cd ltp-git/
> -make autotools
> -./configure --prefix=$PREFIX
> -
> -# Start building LTP
> -
> -make -j$MAKE_JOBS 2>&1 | tee ../$BUILD_LOG_FILE
> -
> -# Install LTP (requires superuser privileges)
> -
> -sudo make install 2>&1 | tee ../$INSTALL_LOG_FILE
> -- 
> 2.38.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
