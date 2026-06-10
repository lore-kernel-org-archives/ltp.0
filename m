Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF43CD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:49:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 123B63E6E85
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:49:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6A623C230D
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:49:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B4D01400159
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:49:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B242E75A69;
 Wed, 10 Jun 2026 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781099340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p/0ZF/e9xQnUMnVOeXVtZWd/bhWFU2VaqoWY9N8IvU=;
 b=QeHCPAoZl8nRQwaOo9JuDtYLxoz/sgl/lNgxFmIVgi+AWIMxF8Y2Jd3t4sLwqnrT4Vz/KY
 /fcQkNXRIa2qlqT+sA1dAQms9Tl136uq7VRuEwyXZ0ELfT5ptk6SixkEPGd00Y4VRMo+xJ
 BQl4ycJCOn+fpJ/EV2Sku35DcEu5upI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781099340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p/0ZF/e9xQnUMnVOeXVtZWd/bhWFU2VaqoWY9N8IvU=;
 b=ewPEsQ5Dng0WL1fm1B6+1VUeb75jzXWx/SaDWumTKsgwHCIsjYQLeEoALX83MD3+kqUiKP
 r1/F/9N+K/AJzBBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QeHCPAoZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ewPEsQ5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781099340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p/0ZF/e9xQnUMnVOeXVtZWd/bhWFU2VaqoWY9N8IvU=;
 b=QeHCPAoZl8nRQwaOo9JuDtYLxoz/sgl/lNgxFmIVgi+AWIMxF8Y2Jd3t4sLwqnrT4Vz/KY
 /fcQkNXRIa2qlqT+sA1dAQms9Tl136uq7VRuEwyXZ0ELfT5ptk6SixkEPGd00Y4VRMo+xJ
 BQl4ycJCOn+fpJ/EV2Sku35DcEu5upI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781099340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3p/0ZF/e9xQnUMnVOeXVtZWd/bhWFU2VaqoWY9N8IvU=;
 b=ewPEsQ5Dng0WL1fm1B6+1VUeb75jzXWx/SaDWumTKsgwHCIsjYQLeEoALX83MD3+kqUiKP
 r1/F/9N+K/AJzBBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DC72779A7;
 Wed, 10 Jun 2026 13:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g+nIJExrKWqmPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jun 2026 13:49:00 +0000
Date: Wed, 10 Jun 2026 15:48:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ailrQ1bb7nyc3OjC@yuki.lan>
References: <20260609-doc_add_missing_headers-v7-0-779c18caddef@suse.com>
 <20260609-doc_add_missing_headers-v7-1-779c18caddef@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260609-doc_add_missing_headers-v7-1-779c18caddef@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B242E75A69
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] doc: Add missing API references to
 api_c_tests.rst
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
Generally it would have been easier to review if the patchset was split
per header.

> -/*
> - * Detaches a file from a loop device.
> +/**
> + * tst_detach_device() - Detach a file from a loop device.
> + * @dev_path: Path to the loop device (e.g. /dev/loop0).
>   *
> - * @dev_path Path to the loop device e.g. /dev/loop0
> - * @return Zero on succes, non-zero otherwise.
> + * Opens the device internally and calls tst_detach_device_by_fd(). If the
> + * device fd is already open, use tst_detach_device_by_fd() instead.
>   *
> - * Internally this function opens the device and calls
> - * tst_detach_device_by_fd(). If you keep device file descriptor open you
> - * have to call the by_fd() variant since having the device open twice will
> - * prevent it from being detached.
> + * Return: Zero on success, non-zero otherwise.
>   */
>  int tst_detach_device(const char *dev_path);
>  
> -/*
> - * To avoid FS deferred IO metadata/cache interference, so we do syncfs
> - * simply before the tst_dev_bytes_written invocation. For easy to use,
> - * we create this inline function tst_dev_sync.
> +/**
> + * tst_dev_sync() - Sync filesystem to avoid deferred IO interference.
> + * @fd: Open file descriptor on the filesystem to sync.
> + *
> +
> + * Return: 0 on success, -1 on failure.
>   */
>  int tst_dev_sync(int fd);
>  
> -/*
> - * Reads test block device stat file and returns the bytes written since the
> - * last call of this function.
> - * @dev: test block device
> +/**
> + * tst_dev_bytes_written() - Get bytes written to a block device since last call.
> + * @dev: Test block device path.
> + *

We need to describe the common pattern, the information about the
tst_dev_sync() being used together with this function was removed from
the tst_dev_sync() too.

We need something as:

The call is usually called twice to measure a number of bytes written
during a certain operation. However in order to avoid interference from
deferred I/O the tst_dev_sync() must be called before we take the first
measurement.

> + * Return: Number of bytes written since the previous invocation.
>   */
>  unsigned long tst_dev_bytes_written(const char *dev);
>  
> -/*
> - * Find the file or path belongs to which block dev
> - * @path       Path to find the backing dev
> - * @dev        The buffer to store the block dev in
> - * @dev_size   The length of the block dev buffer
> +/**
> + * tst_find_backing_dev() - Find the block device backing a path.
> + * @path: Path to look up.
> + * @dev: Buffer to store the block device path.
> + * @dev_size: Size of @dev buffer.
>   */
>  void tst_find_backing_dev(const char *path, char *dev, size_t dev_size);
>  
> -/*
> - * Stat the device mounted on a given path.
> +/**
> + * tst_stat_mount_dev() - Stat the device mounted at a given path.
> + * @mnt_path: Mount point path.
> + * @st: Stat buffer to fill.
>   */
>  void tst_stat_mount_dev(const char *const mnt_path, struct stat *const st);
>  
> -/*
> - * Returns the size of a physical device block size for the specific path
> - * @path   Path to find the block size
> - * @return Size of the block size
> +/**
> + * tst_dev_block_size() - Get physical block size for a device.
> + * @path: Path on the filesystem to query.
> + *
> + * Return: Physical block size in bytes.
>   */
>  int tst_dev_block_size(const char *path);
>  
> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index b22364cab2bdcfbc62585dc6fd142d10489a0528..b341bb037264f93579b30ac6dd61f3d260377304 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -2,8 +2,7 @@
>  /*
>   * Copyright (c) 2017-2018 Richard Palethorpe <rpalethorpe@suse.com>
>   */
> -/**
> - * @file tst_fuzzy_sync.h
> +/*
>   * Fuzzy Synchronisation - abbreviated to fzsync
>   *
>   * This library is intended to help reproduce race conditions by synchronising
> @@ -55,8 +54,6 @@
>   *
>   * For a usage example see testcases/cve/cve-2016-7117.c or just run
>   * 'git grep tst_fuzzy_sync.h'
> - *
> - * @sa tst_fzsync_pair
>   */
>  
>  #include <math.h>
> @@ -83,7 +80,31 @@ struct tst_fzsync_stat {
>  };
>  
>  /**
> - * The state of a two way synchronisation or race.
> + * struct tst_fzsync_pair - The state of a two way synchronisation or race.
> + * @avg_alpha: Rate at which old diff samples are forgotten (default 0.25).
> + * @a_start: Internal; Thread A start time.
> + * @b_start: Internal; Thread B start time.
> + * @a_end: Internal; Thread A end time.
> + * @b_end: Internal; Thread B end time.
> + * @diff_ss: Internal; Avg. difference between a_start and b_start.
> + * @diff_sa: Internal; Avg. difference between a_start and a_end.
> + * @diff_sb: Internal; Avg. difference between b_start and b_end.
> + * @diff_ab: Internal; Avg. difference between a_end and b_end.
> + * @spins: Internal; Number of spins while waiting for the slower thread.
> + * @spins_avg: Internal; Average spins stat.
> + * @delay: Internal; Number of spins to use in the delay.
> + * @delay_bias: Internal; Bias added to delay.
> + * @sampling: Internal; Sampling state or remaining count.
> + * @min_samples: Minimum samples before random delays are calculated (default 1024).
> + * @max_dev_ratio: Maximum allowed proportional average deviation (default 0.1).
> + * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait().
> + * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait().
> + * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait().
> + * @exec_time_start: Internal; Test time remaining on tst_fzsync_pair_reset().
> + * @exec_loops: Maximum number of iterations to execute.
> + * @exec_loop: Internal; Current loop index.
> + * @thread_b: Internal; The second thread or 0.
> + * @yield_in_wait: Yield CPU while waiting on single-core machines.
>   *
>   * This contains all the necessary state for approximately synchronising two
>   * sections of code in different threads.
> @@ -96,53 +117,53 @@ struct tst_fzsync_stat {
>   * Internal fields should only be accessed by library functions.
>   */
>  struct tst_fzsync_pair {
> -	/**
> +	/*
>  	 * The rate at which old diff samples are forgotten
>  	 *
>  	 * Defaults to 0.25.
>  	 */
>  	float avg_alpha;
> -	/** Internal; Thread A start time */
> +	/* Internal; Thread A start time */
>  	struct timespec a_start;
> -	/** Internal; Thread B start time */
> +	/* Internal; Thread B start time */
>  	struct timespec b_start;
> -	/** Internal; Thread A end time */
> +	/* Internal; Thread A end time */
>  	struct timespec a_end;
> -	/** Internal; Thread B end time */
> +	/* Internal; Thread B end time */
>  	struct timespec b_end;
> -	/** Internal; Avg. difference between a_start and b_start */
> +	/* Internal; Avg. difference between a_start and b_start */
>  	struct tst_fzsync_stat diff_ss;
> -	/** Internal; Avg. difference between a_start and a_end */
> +	/* Internal; Avg. difference between a_start and a_end */
>  	struct tst_fzsync_stat diff_sa;
> -	/** Internal; Avg. difference between b_start and b_end */
> +	/* Internal; Avg. difference between b_start and b_end */
>  	struct tst_fzsync_stat diff_sb;
> -	/** Internal; Avg. difference between a_end and b_end */
> +	/* Internal; Avg. difference between a_end and b_end */
>  	struct tst_fzsync_stat diff_ab;
> -	/** Internal; Number of spins while waiting for the slower thread */
> +	/* Internal; Number of spins while waiting for the slower thread */
>  	int spins;
>  	struct tst_fzsync_stat spins_avg;
> -	/**
> +	/*
>  	 * Internal; Number of spins to use in the delay.
>  	 *
>  	 * A negative value delays thread A and a positive delays thread B.
>  	 */
>  	int delay;
>  	int delay_bias;
> -	/**
> +	/*
>  	 *  Internal; The number of samples left or the sampling state.
>  	 *
>  	 *  A positive value is the number of remaining mandatory
>  	 *  samples. Zero or a negative indicate some other state.
>  	 */
>  	int sampling;
> -	/**
> +	/*
>  	 * The Minimum number of statistical samples which must be collected.
>  	 *
>  	 * The minimum number of iterations which must be performed before a
>  	 * random delay can be calculated. Defaults to 1024.
>  	 */
>  	int min_samples;
> -	/**
> +	/*
>  	 * The maximum allowed proportional average deviation.
>  	 *
>  	 * A value in the range (0, 1) which gives the maximum average
> @@ -154,25 +175,25 @@ struct tst_fzsync_pair {
>  	 */
>  	float max_dev_ratio;
>  
> -	/** Internal; Atomic counter used by fzsync_pair_wait() */
> +	/* Internal; Atomic counter used by fzsync_pair_wait() */
>  	tst_atomic_t a_cntr;
> -	/** Internal; Atomic counter used by fzsync_pair_wait() */
> +	/* Internal; Atomic counter used by fzsync_pair_wait() */
>  	tst_atomic_t b_cntr;
> -	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
> +	/* Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
>  	tst_atomic_t exit;
> -	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
> +	/* Internal; The test time remaining on tst_fzsync_pair_reset() */
>  	float exec_time_start;
> -	/**
> +	/*
>  	 * The maximum number of iterations to execute during the test
>  	 *
>  	 * Defaults to a large number, but not too large.
>  	 */
>  	int exec_loops;
> -	/** Internal; The current loop index  */
> +	/* Internal; The current loop index  */
>  	int exec_loop;
> -	/** Internal; The second thread or 0 */
> +	/* Internal; The second thread or 0 */
>  	pthread_t thread_b;
> -	/**
> +	/*
>  	 * The flag indicates single core machines or not
>  	 *
>  	 * If running on single core machines, it would take considerable

Since we moved the comments to the top comment the ones that were inside
the structure should be removed, right? I do not think that we need two
exaclty same comments in two places.

> @@ -191,14 +212,11 @@ struct tst_fzsync_pair {
>  		tst_brk(TBROK, #param " is more than the upper bound " #hi);  \
>  	} while (0)
>  /**
> - * Ensures that any Fuzzy Sync parameters are properly set
> - *
> - * @relates tst_fzsync_pair
> + * tst_fzsync_pair_init() - Ensure Fuzzy Sync parameters are properly set.
> + * @pair: Fuzzy sync pair.
>   *
>   * Usually called from the setup function, it sets default parameter values or
>   * validates any existing non-defaults.
> - *
> - * @sa tst_fzsync_pair_reset()
>   */
>  static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  {
> @@ -213,9 +231,8 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  #undef CHK
>  
>  /**
> - * Exit and join thread B if necessary.
> - *
> - * @relates tst_fzsync_pair
> + * tst_fzsync_pair_cleanup() - Exit and join thread B if necessary.
> + * @pair: Fuzzy sync pair.
>   *
>   * Call this from your cleanup function.
>   */
> @@ -231,9 +248,8 @@ static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>  }
>  
>  /**
> - * Zero some stat fields
> - *
> - * @relates tst_fzsync_stat
> + * tst_init_stat() - Zero some stat fields.
> + * @s: Stat structure to zero.
>   */
>  static inline void tst_init_stat(struct tst_fzsync_stat *s)
>  {
> @@ -242,11 +258,9 @@ static inline void tst_init_stat(struct tst_fzsync_stat *s)
>  }
>  
>  /**
> - * Reset or initialise fzsync.
> - *
> - * @relates tst_fzsync_pair
> - * @param pair The state structure initialised with TST_FZSYNC_PAIR_INIT.
> - * @param run_b The function defining thread B or NULL.
> + * tst_fzsync_pair_reset() - Reset or initialise fzsync.
> + * @pair: Fuzzy sync pair.
> + * @run_b: Thread B function pointer.
>   *
>   * Call this from your main test function (thread A), just before entering the
>   * main loop. It will (re)set any variables needed by fzsync and (re)start
> @@ -256,8 +270,6 @@ static inline void tst_init_stat(struct tst_fzsync_stat *s)
>   * you can pass NULL to run_b and handle starting and stopping thread B
>   * yourself. You may need to place tst_fzsync_pair in some shared memory as
>   * well.
> - *
> - * @sa tst_fzsync_pair_init()
>   */
>  static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  				  void *(*run_b)(void *))
> @@ -285,9 +297,10 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
>  }
>  
>  /**
> - * Print stat
> - *
> - * @relates tst_fzsync_stat
> + * tst_fzsync_stat_info() - Print stat.
> + * @stat: Stat to print.
> + * @unit: Unit string.
> + * @name: Name string.
>   */
>  static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
>  					char *unit, char *name)
> @@ -298,9 +311,8 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
>  }
>  
>  /**
> - * Print some synchronisation statistics
> - *
> - * @relates tst_fzsync_pair
> + * tst_fzsync_pair_info() - Print some synchronisation statistics.
> + * @pair: Fuzzy sync pair.
>   */
>  static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
>  {
> @@ -313,7 +325,10 @@ static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
>  	tst_fzsync_stat_info(pair->spins_avg, "  ", "spins");
>  }
>  
> -/** Wraps clock_gettime */
> +/**
> + * tst_fzsync_time() - Wrap clock_gettime.
> + * @t: Timespec to fill.
> + */
>  static inline void tst_fzsync_time(struct timespec *t)
>  {
>  #ifdef CLOCK_MONOTONIC_RAW
> @@ -324,13 +339,12 @@ static inline void tst_fzsync_time(struct timespec *t)
>  }
>  
>  /**
> - * Exponential moving average
> - *
> - * @param alpha The preference for recent samples over old ones.
> - * @param sample The current sample
> - * @param prev_avg The average of the all the previous samples
> + * tst_exp_moving_avg() - Exponential moving average.
> + * @alpha: Smoothing factor.
> + * @sample: New sample value.
> + * @prev_avg: Previous average.
>   *
> - * @return The average including the current sample.
> + * Return: New average.
>   */
>  static inline float tst_exp_moving_avg(float alpha,
>  					float sample,
> @@ -340,9 +354,10 @@ static inline float tst_exp_moving_avg(float alpha,
>  }
>  
>  /**
> - * Update a stat with a new sample
> - *
> - * @relates tst_fzsync_stat
> + * tst_upd_stat() - Update a stat with a new sample.
> + * @s: Stat structure.
> + * @alpha: Smoothing factor.
> + * @sample: New sample value.
>   */
>  static inline void tst_upd_stat(struct tst_fzsync_stat *s,
>  				 float alpha,
> @@ -355,9 +370,11 @@ static inline void tst_upd_stat(struct tst_fzsync_stat *s,
>  }
>  
>  /**
> - * Update a stat with a new diff sample
> - *
> - * @relates tst_fzsync_stat
> + * tst_upd_diff_stat() - Update a stat with a new diff sample.
> + * @s: Stat structure.
> + * @alpha: Smoothing factor.
> + * @t1: First timespec.
> + * @t2: Second timespec.
>   */
>  static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
>  				     float alpha,
> @@ -368,10 +385,11 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
>  }
>  
>  /**
> - * Calculate various statistics and the delay
> + * tst_fzsync_pair_update() - Calculate various statistics and the delay.
> + * @pair: Fuzzy sync pair.
>   *
>   * This function helps create the fuzz in fuzzy sync. Imagine we have the
> - * following timelines in threads A and B:
> + * following timelines in threads A and B::

Why the double :: ?

>   *
>   *  start_race_a
>   *      ^                    end_race_a (a)
> @@ -398,7 +416,7 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
>   * probability of hitting the race condition is close to zero. To solve this
>   * scenario (and others) a randomised delay is introduced before the syscalls
>   * in A and B. Given enough time the following should happen where the exit
> - * paths are now synchronised:
> + * paths are now synchronised::

Here as well.

>   *  start_race_a
>   *      ^                    end_race_a (a)
> @@ -452,8 +470,6 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
>   * [1] This assumes there is always a significant difference. The algorithm
>   * may fail to introduce a delay (when one is needed) in situations where
>   * Syscall A and B finish at approximately the same time.
> - *
> - * @relates tst_fzsync_pair
>   */
>  static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>  {
> @@ -510,21 +526,17 @@ static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
