Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E9CD98C7
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 10:03:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A29763E6E74
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 12:03:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 313593C01E9
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:03:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 503A4600A6A
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:03:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D740A758A9;
 Wed, 10 Jun 2026 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781085789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOelChGc2w1wnaUeL+X9t/dSm1pvi1CvgC65mgyak8g=;
 b=P3WUhLPwr10CIFSev5yEO3/kphiOvfb2r/w06nDRocYAGMbNloZV9VMt0j/MHzxLzk0Get
 gH7RJ0jPfmUbze0LoC2bjreGWObrXxR4HukQaw8b3HXRGl7+ccCKhcDISZZTrTY3Frh676
 zCkA+pbMmvW9xUHagRUA7xvhWmTxQag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781085789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOelChGc2w1wnaUeL+X9t/dSm1pvi1CvgC65mgyak8g=;
 b=A+oi/GVakmX6kc4K9UmXoV2tNkCQfflpZyBTlV+Bqq+GlPnTerNbjcrUcxX5wnzDNP4k/i
 lsglI0M7mVcJFFDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781085787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOelChGc2w1wnaUeL+X9t/dSm1pvi1CvgC65mgyak8g=;
 b=ADxzWj3V+k314OFO9Mx6Rre0U0f3eU62HNTrvSbKSLHRIZZN3HiYhBxZoutdPY2Q9WUvcW
 YjSyQLbaudNfSmR3YAh8YMcwj6+GCZZ8Q1quagujvE/fvDQlGHU7K0D0Zybq/E5+g7nPvd
 RVHEIwSiAfqhLCd1oKcz+a1kt2+lFx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781085787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOelChGc2w1wnaUeL+X9t/dSm1pvi1CvgC65mgyak8g=;
 b=mE72FoP/wEJEM8s3snagnpOq4vJr49Yttt1zIKrVHD97oRtGtVB/Yt7xxbKHsIwtTmEOwn
 1ufqZDIrgbbZ0hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C93DF779A7;
 Wed, 10 Jun 2026 10:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PY8tMFs2KWo1WwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jun 2026 10:03:07 +0000
Date: Wed, 10 Jun 2026 12:03:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aik2VjAKb_EUYNsv@yuki.lan>
References: <20260609-doc_add_missing_headers-v7-0-779c18caddef@suse.com>
 <20260609-doc_add_missing_headers-v7-2-779c18caddef@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260609-doc_add_missing_headers-v7-2-779c18caddef@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] doc: Complete struct tst_test table and
 shell API docs
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +Shell API variables
> +-------------------
> +
> +The following variables are available to shell tests. Variables marked
> +*input* are set by the test before sourcing ``tst_run.sh``; variables
> +marked *output* are set by the library for tests to read.
> +
> +Test definition (input)
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_TESTFUNC``
> +    Name of the test function (required).
> +
> +``TST_CNT``
> +    Number of test cases. When set the test function is called
> +    ``TST_CNT`` times with a counter argument.
> +
> +``TST_SETUP``
> +    Name of the setup function (called once before tests).
> +
> +``TST_CLEANUP``
> +    Name of the cleanup function (called once after tests or on
> +    ``tst_brk``).
> +
> +``TST_OPTS``
> +    Extra getopts option string.
> +
> +``TST_PARSE_ARGS``
> +    Name of a function to parse extra options from ``TST_OPTS``.
> +
> +``TST_USAGE``
> +    Name of a function printing extra usage information.
> +
> +``TST_POS_ARGS``
> +    Number of expected positional arguments.
> +
> +``TST_TEST_DATA``
> +    Space-separated data passed as a second argument to the test
> +    function.
> +
> +``TST_TEST_DATA_IFS``
> +    Custom delimiter for ``TST_TEST_DATA`` (default: space).
> +
> +Requirements (input)
> +~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_NEEDS_ROOT``
> +    Set to 1 to require root privileges.
> +
> +``TST_NEEDS_TMPDIR``
> +    Set to 1 to create a temporary directory.
> +
> +``TST_NEEDS_DEVICE``
> +    Set to 1 to prepare a block device.
> +
> +``TST_NEEDS_CMDS``
> +    Space-separated list of required commands.
> +
> +``TST_NEEDS_MODULE``
> +    Kernel module name that must be loadable.
> +
> +``TST_NEEDS_DRIVERS``
> +    Space-separated list of required kernel drivers.
> +
> +``TST_NEEDS_KCONFIGS``
> +    Space-separated list of required kernel config options
> +    (e.g. ``CONFIG_NUMA=y``).
> +
> +``TST_NEEDS_KCONFIGS_IFS``
> +    Custom delimiter for ``TST_NEEDS_KCONFIGS`` (default: comma).
> +
> +``TST_NEEDS_CHECKPOINTS``
> +    Set to 1 to enable checkpoint support.
> +
> +``TST_MIN_KVER``
> +    Minimum kernel version string (e.g. ``4.18``).
> +
> +Device and filesystem (input)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_FORMAT_DEVICE``
> +    Set to 1 to format ``TST_DEVICE`` before the test.
> +
> +``TST_MOUNT_DEVICE``
> +    Set to 1 to mount ``TST_DEVICE`` at ``TST_MNTPOINT``.
> +
> +``TST_DEV_EXTRA_OPTS``
> +    Extra options passed to ``mkfs``.
> +
> +``TST_DEV_FS_OPTS``
> +    Extra filesystem-specific ``mkfs`` options.
> +
> +``TST_FS_TYPE``
> +    Filesystem type for formatting (default: ``ext2``).
> +
> +``TST_DEVICE_SIZE``
> +    Device size in MB.
> +
> +``TST_ALL_FILESYSTEMS``
> +    Set to 1 to repeat the test for each supported filesystem.
> +
> +``TST_SKIP_FILESYSTEMS``
> +    Space-separated list of filesystems to skip.
> +
> +``TST_MNT_PARAMS``
> +    Mount flags/options string.
> +
> +Miscellaneous (input)
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_SKIP_IN_LOCKDOWN``
> +    Set to 1 to skip when kernel lockdown is active.
> +
> +``TST_SKIP_IN_SECUREBOOT``
> +    Set to 1 to skip when Secure Boot is enabled.
> +
> +``TST_DISABLE_APPARMOR``
> +    Set to 1 to disable AppArmor before the test runs (requires root).
> +
> +``TST_DISABLE_SELINUX``
> +    Set to 1 to put SELinux in permissive mode before the test runs
> +    (requires root).
> +
> +``TST_SKIP_LSM_WARNINGS``
> +    Set to 1 to suppress the library's warnings about active LSMs
> +    (AppArmor, SELinux) at startup.
> +
> +``TST_NO_DEFAULT_RUN``
> +    Set to a non-empty value to source ``tst_test.sh`` without invoking
> +    ``tst_run`` automatically. Useful for shell libraries that build on
> +    top of the test API.
> +
> +``TST_TIMEOUT``
> +    Test timeout in seconds.
> +
> +``TST_TMPDIR_RHOST``
> +    Set to 1 to also clean up the temporary directory on the remote
> +    host (used by network tests).
> +
> +Output variables
> +~~~~~~~~~~~~~~~~
> +
> +``TST_TMPDIR``
> +    Path to the temporary directory (when ``TST_NEEDS_TMPDIR=1``).
> +
> +``TST_STARTWD``
> +    Original working directory before ``chdir`` to ``TST_TMPDIR``.
> +
> +``TST_DEVICE``
> +    Block device path (when ``TST_NEEDS_DEVICE=1``).
> +
> +``TST_MNTPOINT``
> +    Mount point path.
> +
> +``TST_MODPATH``
> +    Path to the loaded kernel module.
> +
> +Checkpoint functions
> +~~~~~~~~~~~~~~~~~~~~
> +
> +``TST_CHECKPOINT_WAIT``
> +    Wait on checkpoint (argument: checkpoint id).
> +
> +``TST_CHECKPOINT_WAKE``
> +    Wake one waiter on checkpoint (argument: checkpoint id).
> +
> +``TST_CHECKPOINT_WAKE2``
> +    Wake multiple waiters (arguments: checkpoint id, count).
> +
> +``TST_CHECKPOINT_WAKE_AND_WAIT``
> +    Wake one waiter and then wait (argument: checkpoint id).

This is the old shell API that is eventually going away.

The API that is going to stay is the JSON comment in the test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
