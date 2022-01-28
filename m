Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0489AC433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 10:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D193C973C
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 11:30:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED77A3C975B
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 11:29:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40F071000A5E
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 11:29:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63EA7212BA;
 Fri, 28 Jan 2022 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643365790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbv8Qm3MR9TQRpiOW9Psm624bOxI+vFtFLzCjl0FMSk=;
 b=O6Gxibcp/z2wilbCQ8QvbJi9mhEuZkqh4zB6ddYuaOOqNG5rhdq8OhyOG0EXchR1RqbtyL
 FcnmS6d5yqh6pkkY96aC3xnA7iW+iuEboD7ILtsPzCbFhu2RnKN49aFkGWq2h5+c7m8ONn
 x3FtoBUbF3b9QtYv7vfR805YIS/OKzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643365790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbv8Qm3MR9TQRpiOW9Psm624bOxI+vFtFLzCjl0FMSk=;
 b=tHbGMbbt6Px6I5uqut8pfYSBqTQJRh2JdOHvs7/zcuOqEX/T2Ed9jxB1Rfdx994qzGRdXV
 voFq0tgXhtLGXXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45C9613D17;
 Fri, 28 Jan 2022 10:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fTe4D57F82HtGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jan 2022 10:29:50 +0000
Date: Fri, 28 Jan 2022 11:31:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YfPGDmF0UFFjeABu@yuki>
References: <1643349071-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1643349071-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sysctl/sysctl03: Test whether return EINVAL when
 passing negative value
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
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> +# Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> +#
> +# When we pass a negative value to the proc_doulongvec_minmax() function,
> +# the function should return EINVAL and the corresponding interface value
> +# does not change.
> +#
> +# It is also a regression test for
> +# commit 1622ed7d0743 ("sysctl: returns -EINVAL when a negative value is passed
> +# to proc_doulongvec_minmax").
> +#
> +# Use fs.epoll.max_user_watches interface to test this.
> +
> +TST_TESTFUNC=do_test
> +TST_SETUP=setup
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_CMDS="sysctl"
> +TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y, CONFIG_INOTIFY_USER=y"
> +sys_name="fs.epoll.max_user_watches"
> +sys_file="/proc/sys/fs/epoll/max_user_watches"
> +
> +. tst_test.sh
> +
> +setup()
> +{
> +	orig_value=$(cat "$sys_file")
> +}
> +
> +do_test()
> +{
> +	tst_res TINFO "trying to set $sys_name=-1"
> +
> +	sysctl -w -q $sys_name=-1 2>&1 | grep -q "Invalid argument"
> +
> +	if [ $? -eq 0 ]; then
> +		tst_res TPASS "sysctl returns EINVAL when passing a negative value"
> +	else
> +		tst_res TFAIL "sysctl doesn't return EINVAL when passing a negative value"
> +	fi
> +
> +	new_value=$(cat "$sys_file")
> +	if [ $orig_value -eq $new_value ]; then
> +		tst_res TPASS "the interface value doesn't change when passing a negative value"
> +	else
> +		tst_res TFAIL "the interface value changes when passing a negative value"
> +		sysctl -w -q $sys_name=$orig_value
> +	fi
> +}
> +
> +tst_run

I'm just wondering if this wouldn't be actually easier as a C test. I
bet that simple write() to the sys_file would work exactly the same and
we wouldn't depend on sysctl being present on the system.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
