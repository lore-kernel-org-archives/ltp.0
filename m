Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA56CD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 12:51:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D92573CE3A4
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 14:51:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 393853CBDCE
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:51:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB66F1A00EA9
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:51:31 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0365D972;
 Thu,  4 Apr 2024 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712235090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RwVNM6FRDAHpjA4vN1bLP0l9epcgrHJpkOaZAgIHDI=;
 b=Hi/50x+3eExe1H01S+PCOXHOlsatGjnXPgkUexEeCRFkJfn+f5orRXx/8jubooepphw26x
 n2wxKW/SL4Ab0XML1zNpXsBCtkcKxPEfPI1PbWF0xrVp5xiK3FasOx5JyHAxmggbyeRL5i
 i+R9Rwv6+kQqapBhqIOTAUQDgJNR49A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712235090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RwVNM6FRDAHpjA4vN1bLP0l9epcgrHJpkOaZAgIHDI=;
 b=y6OsiSy+9BoO74aSUs7StPuvGdSskGDcFLxiWmb4PQVjh94dtduHRcClSNYJAM+iE9OFav
 LH7SgoGxnwsVJLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712235090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RwVNM6FRDAHpjA4vN1bLP0l9epcgrHJpkOaZAgIHDI=;
 b=Hi/50x+3eExe1H01S+PCOXHOlsatGjnXPgkUexEeCRFkJfn+f5orRXx/8jubooepphw26x
 n2wxKW/SL4Ab0XML1zNpXsBCtkcKxPEfPI1PbWF0xrVp5xiK3FasOx5JyHAxmggbyeRL5i
 i+R9Rwv6+kQqapBhqIOTAUQDgJNR49A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712235090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RwVNM6FRDAHpjA4vN1bLP0l9epcgrHJpkOaZAgIHDI=;
 b=y6OsiSy+9BoO74aSUs7StPuvGdSskGDcFLxiWmb4PQVjh94dtduHRcClSNYJAM+iE9OFav
 LH7SgoGxnwsVJLCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD27E139E8;
 Thu,  4 Apr 2024 12:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id wqoKNVGiDmbgZwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 04 Apr 2024 12:51:29 +0000
Date: Thu, 4 Apr 2024 14:51:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240404125124.GC503552@pevik>
References: <20240403082618.5829-1-chrubis@suse.cz>
 <20240403082618.5829-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240403082618.5829-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] include: doc: Convert comments into
 linuxdoc
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

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc_new/developers/api_c_tests.rst |  26 ++
>  include/tst_buffers.h              |  86 +++--
>  include/tst_capability.h           |  80 ++++-
>  include/tst_checkpoint.h           |  64 +++-
>  include/tst_hugepage.h             |   2 +
>  include/tst_parse.h                |  65 ++++
>  include/tst_res_flags.h            |  72 +++-
>  include/tst_test.h                 | 509 +++++++++++++++++++++--------
>  8 files changed, 702 insertions(+), 202 deletions(-)
>  create mode 100644 include/tst_parse.h

> diff --git a/doc_new/developers/api_c_tests.rst b/doc_new/developers/api_c_tests.rst
> index adee17f16..2c0c8419d 100644
> --- a/doc_new/developers/api_c_tests.rst
> +++ b/doc_new/developers/api_c_tests.rst
> @@ -5,3 +5,29 @@

>  Developing using C API
>  ======================
> +
> +Core LTP API
> +------------
> +
> +.. kernel-doc:: ../../include/tst_res_flags.h
> +.. kernel-doc:: ../../include/tst_test.h
> +
> +Option parsing
> +--------------
> +
> +.. kernel-doc:: ../../include/tst_parse.h
> +
> +Guarded buffers
> +---------------
> +
> +.. kernel-doc:: ../../include/tst_buffers.h
> +
> +Checkpoints
> +-----------
> +
> +.. kernel-doc:: ../../include/tst_checkpoint.h
> +
> +Capabilities
> +------------
> +
> +.. kernel-doc:: ../../include/tst_capability.h
> diff --git a/include/tst_buffers.h b/include/tst_buffers.h
> index b5f355f0f..bd1a112a2 100644
> --- a/include/tst_buffers.h
> +++ b/include/tst_buffers.h
> @@ -3,69 +3,95 @@
>   * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
>   */

> +/**
> + * DOC: Guarded buffers introduction
> + *
> + * Guarded buffer has a page with PROT_NONE allocated right before the start of
> + * the buffer and canary after the end of the buffer. That means that any
> + * memory access before the buffer ends with EFAULT or SEGFAULT and any write
> + * after the end of the buffer will be detected because it would overwrite the
> + * canaries.
> + *
> + * It should be used for all buffers passed to syscalls to make sure off-by-one
> + * buffer accesses does not happen.
> + */
> +
>  #ifndef TST_BUFFERS_H__
>  #define TST_BUFFERS_H__

> -/*
> +/**
> + * struct tst_buffers - A guarded buffer description for allocator.
> + *
>   * Buffer description consist of a pointer to a pointer and buffer type/size
>   * encoded as a different structure members.
>   *
> - * Only one of the size and iov_sizes can be set at a time.
> + * @ptr: A pointer to the pointer to buffer. This is dereferenced and set by the
> + *       allocator.
> + * @size: A buffer size in bytes. Only one of size and iov_sizes can be set.
> + * @iov_sizes: An -1 terminated array of sizes used to construct a
> + *             struct iovec buffers.
> + * @str: If size is zero and iov_sizes is NULL this string is going to be
> + *       copied into the buffer.
>   */
>  struct tst_buffers {
> -	/*
> -	 * This pointer points to a buffer pointer.
> -	 */
>  	void *ptr;
> -	/*
> -	 * Buffer size.
> -	 */
>  	size_t size;
> -	/*
> -	 * Array of iov buffer sizes terminated by -1.
> -	 */
>  	int *iov_sizes;
> -	/*
> -	 * If size and iov_sizes is NULL this is the string we want to strdup()
> -	 * into the buffer.
> -	 */
>  	char *str;
>  };

> -/*
> - * Allocates buffers based on the tst_buffers structure.
> +/**
> + * tst_buffers_alloc() - Allocates buffers based on the tst_buffers structure.
>   *
> - * @bufs NULL terminated array of test buffer descriptions.
> + * @bufs: A NULL terminated array of test buffer descriptions.
>   *
> - * This is called from the test library if the tst_test->bufs pointer is set.
> + * This is called from the test library if the tst_test.bufs pointer is set.
>   */
>  void tst_buffers_alloc(struct tst_buffers bufs[]);

> -/*
> - * strdup() that callls tst_alloc().
> +/**
> + * tst_strdup() - Copies a string into a newly allocated guarded buffer.
> + *
> + * @str: A string to be duplicated.
> + * return: A pointer to the string duplicated in a guarded buffer.
> + *
> + * Allocates a buffer with tst_alloc() and copies the string into it.
>   */
>  char *tst_strdup(const char *str);

> -/*
> - * Allocates size bytes, returns pointer to the allocated buffer.
> +/**
> + * tst_alloc() - Allocates a guarded buffer.
> + *
> + * @size: A size of the buffer.
> + * return: A newly allocated guarded buffer.
>   */
>  void *tst_alloc(size_t size);

> -/*
> - * Printf into a guarded buffer.
> +/**
> + * tst_aprintf() - Printf into a newly allocated guarded buffer.
> + *
> + * @fmt: A printf-like format.
> + * @...: A printf-like parameters.
> + * return: A newly allocated buffer.
> + *
> + * Allocates a buffer with tst_alloc() then prints the data into it.
>   */
>  char *tst_aprintf(const char *fmt, ...)
>        __attribute__((format (printf, 1, 2)));

> -/*
> - * Allocates iovec structure including the buffers.
> +/**
> + * tst_iovec_alloc() - Allocates a complete iovec structure.
>   *
> - * @sizes -1 terminated array of buffer sizes.
> + * @sizes: A -1 terminated array of buffer sizes.
> + * return: Newly allocated iovec structure.
>   */
>  struct iovec *tst_iovec_alloc(int sizes[]);

> -/*
> - * Frees all allocated buffers.
> +/**
> + * tst_free_all() - Frees all allocated buffers.
> + *
> + * It's important to free all guarded buffers because the canaries after the
> + * buffer are checked only when the buffer is being freed.
>   *
>   * This is called at the end of the test automatically.
>   */
> diff --git a/include/tst_capability.h b/include/tst_capability.h
> index 6067804a3..ccf4bd77b 100644
> --- a/include/tst_capability.h
> +++ b/include/tst_capability.h
> @@ -2,8 +2,9 @@
>  /*
>   * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
>   */
> +
>  /**
> - * @file tst_capability.h
> + * DOC: Capabilities introduction
>   *
>   * Limited capability operations without libcap.
>   */
> @@ -15,22 +16,51 @@

>  #include "lapi/capability.h"

> -#define TST_CAP_DROP 1
> -#define TST_CAP_REQ  (1 << 1)
> -
> -#define TST_CAP(action, capability) {action, capability, #capability}
> +/**
> + * enum tst_cap_act - A capability action masks.
> + *
> + * @TST_CAP_DROP: Drop capabilities.
> + * @TST_CAP_REQ: Add capabilities.
> + */
> +enum tst_cap_act {
> +	TST_CAP_DROP = 1,
> +	TST_CAP_REQ = (1 << 1)
> +};

> +/**
> + * struct tst_cap_user_header - Kernel capget(), capset() syscall header.
> + *
> + * @version: A capability API version.
> + * @pid: A process to operate on.
> + */
>  struct tst_cap_user_header {
>  	uint32_t version;
>  	int pid;
>  };

> +/**
> + * struct tst_cap_user_data - Kernel capset(), capget() syscall payload.
> + *
> + * @effective: A capability effective set.
> + * @permitted: A capability permitted set.
> + * @inheritable: A capability inheritable set.
> + */
>  struct tst_cap_user_data {
>  	uint32_t effective;
>  	uint32_t permitted;
>  	uint32_t inheritable;
>  };

> +/**
> + * struct tst_cap - A capability to alter.
> + *
> + * @action: What should we do, i.e. drop or add a capability.
> + * @id: A capability id.
> + * @name: A capability name.
> + *
> + * This structure is usually constructed with the TST_CAP() macro so that the
> + * name is created automatically.
> + */
>  struct tst_cap {
>  	uint32_t action;
>  	uint32_t id;
> @@ -38,25 +68,43 @@ struct tst_cap {
>  };

>  /**
> - * Get the capabilities as decided by hdr.
> + * TST_CAP() - Create a struct tst_cap entry.
>   *
> - * Note that the memory pointed to by data should be large enough to store two
> - * structs.
> + * @action: What should we do, i.e. drop or add capability.
> + * @capability: A capability id, e.g. CAP_BPF.
> + */
> +#define TST_CAP(action, capability) {action, capability, #capability}
> +
> +/**
> + * tst_capget() - Get the capabilities as decided by hdr.
> + *
> + * @hdr: A capability user header stores a pid to operate on and which
> + *       capability API version is used.
> + * @data: A memory to store the capabilities to. The memory pointed to by data
> + *        should be large enough to store two structs.
> + *
> + * return: Returns 0 on success, -1 on a failure and sets errno.
>   */
>  int tst_capget(struct tst_cap_user_header *hdr,
>  	       struct tst_cap_user_data *data);

>  /**
> - * Set the capabilities as decided by hdr and data
> + * tst_capset() - Set the capabilities as decided by hdr and data
>   *
> - * Note that the memory pointed to by data should be large enough to store two
> - * structs.
> + * @hdr: A capability user header stores a pid to operate on and which
> + *       capability API version is used.
> + * @data: A memory to store the capabilities to. The memory pointed to by data
> + *        should be large enough to store two structs.
> + *
> + * return: Returns 0 on success, -1 on a failure and sets errno.
>   */
>  int tst_capset(struct tst_cap_user_header *hdr,
>  	       const struct tst_cap_user_data *data);

>  /**
> - * Add, check or remove a capability
> + * tst_cap_action() - Add, check or remove a capability.
> + *
> + * @cap: An {} terminated array of capabilities to alter.
>   *
>   * It will attempt to drop or add capability to the effective set. It will
>   * try to detect if this is needed and whether it can or can't be done. If it
> @@ -71,13 +119,17 @@ void tst_cap_action(struct tst_cap *cap);


>  /**
> - * Add, check or remove a capabilities
> + * tst_cap_setup() - Add, check or remove a capabilities.
> + *
> + * @cap: An {} terminated array of capabilities to alter.
> + * @action_mask: Decides which actions are done, i.e. only drop caps, add them
> + *               or both.
>   *
>   * Takes a NULL terminated array of structs which describe whether some
>   * capabilities are needed or not and mask that determines subset of the
>   * actions to be performed. Loops over the array and if mask matches the
>   * element action it's passed to tst_cap_action().
>   */
> -void tst_cap_setup(struct tst_cap *cap, unsigned int action_mask);
> +void tst_cap_setup(struct tst_cap *cap, enum tst_cap_act action_mask);

>  #endif /* TST_CAPABILITY_H */
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index 1b6911d73..a8d66a333 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -1,24 +1,86 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
>   * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
>   */

> +/**
> + * DOC: Checkpoints introduction
> + *
> + * Checkpoints implements a futex based synchronization primitive for threads
> + * and processes. When a process calls wait function its execution is suspended
> + * until wake is called for a corresponding checkpoint. Checkpoints are
> + * numbered from 0 and process can use at least hundred of them.
> + *
> + * In order to use checkpoints the test must set the tst_test.needs_checkpoints
> + * flag.
> + */
> +
>  #ifndef TST_CHECKPOINT__
>  #define TST_CHECKPOINT__

>  #include "tst_checkpoint_fn.h"

> +/**
> + * TST_CHECKPOINT_WAIT() - Waits for a checkpoint.
> + *
> + * @id: A checkpoint id a positive integer.
> + *
> + * Suspends thread/process execution until it's woken up with a wake. The call
> + * does not wait indefinitely it gives up after 10 seconds. If an error
> + * happened or timeout was reached the function calls tst_brk(TBROK, ...) which
> + * exits the test.
> + */
>  #define TST_CHECKPOINT_WAIT(id) \
>          tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0)

> +/**
> + * TST_CHECKPOINT_WAIT2() - Waits for a checkpoint.
> + *
> + * @id: A checkpoint id a positive integer.
> + * @msec_timeout: A timeout.
> + *
> + * Suspends thread/process execution until it's woken up with a wake. If an
> + * error happened or timeout was reached the function calls tst_brk(TBROK, ...)
> + * which exits the test.
> + */
>  #define TST_CHECKPOINT_WAIT2(id, msec_timeout) \
>          tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, msec_timeout)

> +/**
> + * TST_CHECKPOINT_WAKE() - Wakes up a checkpoint.
> + *
> + * @id: A checkpoint id a positive integer.
> + *
> + * Wakes up a process suspended on a checkpoint and retries if there is no
> + * process suspended on the checkpoint yet. The call does not retry
> + * indefinitely but gives up after 10 seconds. If an error happened or timeout
> + * was reached the function calls tst_brk(TBROK, ...) which exits the test.
> + */
>  #define TST_CHECKPOINT_WAKE(id) \
>          tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1)

> +/**
> + * TST_CHECKPOINT_WAKE2() - Wakes up several checkpoints.
> + *
> + * @id: A checkpoint id a positive integer.
> + * @nr_wake: A number of processes to wake.
> + *
> + * Wakes up nr_wake processes suspended on a checkpoint and retries if there
> + * wasn't enough process suspended on the checkpoint yet. The call does not
> + * retry indefinitely but gives up if it does not wake nr_wake processes after
> + * 10 seconds. If an error happened or timeout was reached the function calls
> + * tst_brk(TBROK, ...) which exits the test.
> + */
>  #define TST_CHECKPOINT_WAKE2(id, nr_wake) \
>          tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake)

> +/**
> + * TST_CHECKPOINT_WAKE_AND_WAIT() - Wakes up a checkpoint and immediately waits on it.
> + *
> + * @id: A checkpoint id a positive integer.
> + *
> + * This is a combination of TST_CHECKPOINT_WAKE() and TST_CHECKPOINT_WAIT().
> + */
>  #define TST_CHECKPOINT_WAKE_AND_WAIT(id) do { \
>          tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1); \
>          tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0); \
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> index 46327c79a..6b865b2f2 100644
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -24,6 +24,8 @@ enum tst_hp_policy {
>  	TST_NEEDS,
>  };

> +#define TST_NO_HUGEPAGES ((unsigned long)-1)
> +
>  struct tst_hugepage {
>  	const unsigned long number;
>  	enum  tst_hp_policy policy;
> diff --git a/include/tst_parse.h b/include/tst_parse.h
> new file mode 100644
> index 000000000..167d416f4
> --- /dev/null
> +++ b/include/tst_parse.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2015-2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/**
> + * DOC: Option parsing functions
> + *
> + * Implements simple helpers on the top of the strtol() and strtod() for
> + * command line option parsing.
> + */
> +
> +#ifndef TST_PARSE_H__
> +#define TST_PARSE_H__
> +
> +/**
> + * tst_parse_int() - Parse an integer from a string.
> + *
> + * @str: A string with an integer number.
> + * @val: A pointer to integer to store the result to.
> + * @min: A lower bound, pass INT_MIN for full range.
> + * @max: An upper bound, pass INT_MAX for full range.
> + * return: A zero if whole string was consumed and the value was within bounds,
> + *         an errno otherwise.
> + */
> +int tst_parse_int(const char *str, int *val, int min, int max);
> +
> +/**
> + * tst_parse_long() - Parse a long integer from a string.
> + *
> + * @str: A string with an integer number.
> + * @val: A pointer to long integer to store the result to.
> + * @min: A lower bound, pass LONG_MIN for full range.
> + * @max: An upper bound, pass LONG_MAX for full range.
> + * return: A zero if whole string was consumed and the value was within bounds,
> + *         an errno otherwise.
> + */
> +int tst_parse_long(const char *str, long *val, long min, long max);
> +
> +/**
> + * tst_parse_float() - Parse a floating point number from a string.
> + *
> + * @str: A string with a floating point number.
> + * @val: A pointer to float to store the result to.
> + * @min: A lower bound.
> + * @max: An upper bound.
> + * return: A zero if whole string was consumed and the value was within bounds,
> + *         an errno otherwise.
> + */
> +int tst_parse_float(const char *str, float *val, float min, float max);
> +
> +/**
> + * tst_parse_filesize() - Parse a file size from a string.
> + *
> + * @str: A string a positive number optionally followed by an unit, i.e. K, M,
> + *       or G for kilobytes, megabytes and gigabytes.
> + * @val: A pointer to long long integer to store the size in bytes to.
> + * @min: A lower bound.
> + * @max: An upper bound.
> + * return: A zero if whole string was consumed and the value was within bounds,
> + *         an errno otherwise.
> + */
> +int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
> +
> +#endif	/* TST_PARSE_H__ */
> diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
> index 872352144..806940e0d 100644
> --- a/include/tst_res_flags.h
> +++ b/include/tst_res_flags.h
> @@ -1,24 +1,66 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
>   * Copyright (c) Linux Test Project, 2014
>   */

>  #ifndef TST_RES_FLAGS_H
>  #define TST_RES_FLAGS_H

> -/* Use low 6 bits to encode test type */
> -#define TTYPE_MASK	0x3f
> -#define TPASS	0	/* Test passed flag */
> -#define TFAIL	1	/* Test failed flag */
> -#define TBROK	2	/* Test broken flag */
> -#define TWARN	4	/* Test warning flag */
> -#define TDEBUG	8	/* Test debug information flag */
> -#define TINFO	16	/* Test information flag */
> -#define TCONF	32	/* Test not appropriate for configuration flag */
> -#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
> +/**
> + * enum tst_res_flags - Test result reporting flags.
> + *
> + * @TPASS: Reports a single success.
> + * @TFAIL: Reports a single failure.
> + * @TBROK: Reports a single breakage.
> + * @TWARN: Reports a single warning. Warnings increment a warning counter and
> + *         show up in test results.
> + *
> + * @TDEBUG: Prints additional debugging messages, it does not change the test result counters and
> + *          the message is not displayed unless debugging is enabled with -D
> + *          test command line parameter.
> + *
> + * @TINFO: Prints an additional information, it does not change the test result
> + *         counters but unlike TDEBUG the message is always displayed.
> + *
> + * @TCONF: Reports unsupported configuration. When tests produce this result at
> + *         least a subset of test was skipped, because it couldn't run. The
> + *         usual reasons are, missing kernel modules or CONFIG options.
> + *         Unsuitable CPU architecture, not enough memory, etc.
> + *
> + * @TERRNO: Combine bitwise with result flags to append errno to the output message.
> + *
> + * @TTERRNO: Combine bitwise with result flags to append error from TST_ERR to
> + *           the message. The TST_TEST() macros store the errno into the
> + *           TST_ERR global variable in order to make sure it's not change
> + *           between the test is done and results are printed.
> + *
> + * @TRERRNO: Combine bitwise with result flags to errno from TST_RET variable
> + *           to the message. The TST_TEST() macros store return value into the
> + *           TST_RET global variable and quite a few, e.g. pthread functions,
> + *           return the error value directly instead of storing it to the errno.
> + *
> + * A result flag with optional bitwise combination of errno flag are passed to
> + * the tst_res() and tst_brk() functions. Each message counts as a single test
> + * result and tests can produce arbitrary number of results, i.e. TPASS, TFAIL,
> + * TBROK, TWARN and TCONF messages. Each such message increases a result
> + * counter in a piece of shared memory, which means that reported results are
> + * accounted immediately even from child processes and there is no need for
> + * result propagation.
> + */
> +enum tst_res_flags {
> +	TPASS = 0,
> +	TFAIL = 1,
> +	TBROK = 2,
> +	TWARN = 4,
> +	TDEBUG = 8,
> +	TINFO = 16,
> +	TCONF = 32,
> +	TERRNO = 0x100,
> +	TTERRNO = 0x200,
> +	TRERRNO	= 0x400,
> +};

> -#define TERRNO	0x100	/* Append errno information to output */
> -#define TTERRNO	0x200	/* Append TEST_ERRNO information to output */
> -#define TRERRNO	0x400	/* Capture errno information from TEST_RETURN to
> -			   output; useful for pthread-like APIs :). */
> +#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
> +#define TTYPE_MASK 0x3f

>  #endif /* TST_RES_FLAGS_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 47b5902f9..e6c8747c0 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
>   * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
>   * Copyright (c) Linux Test Project, 2016-2019
> @@ -19,6 +19,7 @@

>  #include "tst_common.h"
>  #include "tst_res_flags.h"
> +#include "tst_parse.h"
>  #include "tst_test_macros.h"
>  #include "tst_checkpoint.h"
>  #include "tst_device.h"
> @@ -47,50 +48,102 @@
>  #include "tst_arch.h"
>  #include "tst_fd.h"

> -/*
> - * Reports testcase result.
> - */
>  void tst_res_(const char *file, const int lineno, int ttype,
>                const char *fmt, ...)
>                __attribute__ ((format (printf, 4, 5)));

> +/**
> + * tst_res() - Reports a test result.
> + *
> + * @ttype: An enum tst_res_type.
> + * @arg_fmt: A printf-like format.
> + * @...: A printf-like parameters.
> + *
> + * This is the main test reporting function. Each time this function is called
> + * with one of TPASS, TFAIL, TCONF, TBROK or TWARN a counter in page of shared
> + * memory is incremented. This means that there is no need to propagate test
> + * results from children and that results are accounted for once this function
> + * returns. The counters are incremented atomically which makes this function
> + * thread-safe.
> + */
>  #define tst_res(ttype, arg_fmt, ...) \
>  	({									\
>  		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
>  			!((TTYPE_RESULT(ttype) ?: TCONF) & \
> -			(TCONF | TDEBUG | TFAIL | TINFO | TPASS | TWARN))); 				\
> +			(TCONF | TDEBUG | TFAIL | TINFO | TPASS | TWARN)));				\
>  		tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
>  	})

>  void tst_resm_hexd_(const char *file, const int lineno, int ttype,
>  	const void *buf, size_t size, const char *arg_fmt, ...)
>  	__attribute__ ((format (printf, 6, 7)));
> -
> +/**
> + * tst_res_hexd() - Reports a test result along with hex dump of a buffer.
> + *
> + * This call is the same as tst_res() but includes a pointer and size of the
> + * buffer that is going to be printed in the output in a hexadecimal format.
> + *
> + * @ttype: An enum tst_res_type.
> + * @buf: A pointer to a buffer to print in hexadecimal format.
> + * @size: A size of the buffer.
> + * @arg_fmt: A printf-like format.
> + * @...: A printf-like parameters.
> + */
>  #define tst_res_hexd(ttype, buf, size, arg_fmt, ...) \
>  	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
>  			(arg_fmt), ##__VA_ARGS__)

> -/*
> - * Reports result and exits a test.
> - */
>  void tst_brk_(const char *file, const int lineno, int ttype,
>                const char *fmt, ...)
>                __attribute__ ((format (printf, 4, 5)));

> +/**
> + * tst_brk() - Reports a breakage and exits the test.
> + *
> + * @ttype: An enum tst_res_type.
> + * @arg_fmt: A printf-like format.
> + * @...: A printf-like parameters.
> + *
> + * Reports either TBROK or TCONF and exits the test immediately. When called
> + * all children in the same process group as the main test library process are
> + * killed. This function, unless in a test cleanup, calls _exit() and does not
> + * return.
> + *
> + * When test is in cleanup() function TBROK is converted into TWARN by the test
> + * library and we attempt to carry on with a cleanup even when tst_brk() was
> + * called. This makes it possible to use SAFE_FOO() macros in the test cleanup
> + * without interrupting the cleanup process on a failure.
> + */
>  #define tst_brk(ttype, arg_fmt, ...)						\
>  	({									\
>  		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
> -			(TBROK | TCONF | TFAIL))); 				\
> +			(TBROK | TCONF | TFAIL)));				\
>  		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
>  	})

>  void tst_printf(const char *const fmt, ...)
>  		__attribute__((nonnull(1), format (printf, 1, 2)));

> -/* flush stderr and stdout */
> +/**
> + * tst_flush() - Flushes the output file streams.
> + *
> + * There are rare cases when we want to flush the output file streams
> + * explicitly, e.g. before we do an action that may crash the test to ensure
> + * that the messages have been written out.
> + *
> + * This is also called by the SAFE_FORK() because otherwise each child would
> + * end up with the same copy of the file in it's memory and any messages in
> + * buffers would be multiplied.
> + */
>  void tst_flush(void);

>  pid_t safe_fork(const char *filename, unsigned int lineno);
> +/**
> + * SAFE_FORK() - Forks a test child.
> + *
> + * This call makes sure that output file streams are flushed and also handles
> + * errors from fork(). Use this instead of fork() whenever possible!
> + */
>  #define SAFE_FORK() \
>  	safe_fork(__FILE__, __LINE__)

> @@ -98,15 +151,30 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
>  	({int ret = expr;                                           \
>  	  ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; }) \

> -/*
> - * Functions to convert ERRNO to its name and SIGNAL to its name.
> +/**
> + * tst_strerrno() - Converts an errno number into a name.
> + *
> + * @err: An errno number.
> + * return: An errno name e.g. "EINVAL".
>   */
>  const char *tst_strerrno(int err);
> +
> +/**
> + * tst_strsig() - Converts a signal number into a name.
> + *
> + * @sig: A signal number.
> + * return: A signal name e.g. "SIGINT".
> + */
>  const char *tst_strsig(int sig);
> -/*
> - * Returns string describing status as returned by wait().
> +
> +
> +/**
> + * tst_strstatus() - Returns string describing status as returned by wait().
> + *
> + * WARNING: Not thread safe.
>   *
> - * BEWARE: Not thread safe.
> + * @status: A status as returned by wait()
> + * return: A string description for the status e.g. "killed by SIGKILL".
>   */
>  const char *tst_strstatus(int status);

> @@ -116,30 +184,49 @@ const char *tst_strstatus(int status);
>  #include "tst_clone.h"
>  #include "tst_cgroup.h"

> -/*
> - * Wait for all children and exit with TBROK if
> - * any of them returned a non-zero exit status.
> +/**
> + * tst_reap_children() - Waits for all child processes to exit.
> + *
> + * Wait for all children and exit with TBROK if any of them returned a non-zero
> + * exit status.
>   */
>  void tst_reap_children(void);

> +/**
> + * struct tst_option - Test command line option.
> + *
> + * @optstr: A short command line option, e.g. "a" or "a:".
> + * @arg: A pointer to store the option value to.
> + * @help: A help string for the option displayed when test is passed '-h' on
> + *        the command-line.
> + */
>  struct tst_option {
>  	char *optstr;
>  	char **arg;
>  	char *help;
>  };

> -/*
> - * Options parsing helpers.
> +/**
> + * struct tst_tag - A test tag.
>   *
> - * If str is NULL these are No-op.
> + * @name: A tag name.
> + * @value: A tag value.
>   *
> - * On failure non-zero (errno) is returned.
> + * This structure is used to encode pointers to upstream commits in regression
> + * tests as well as CVE numbers or any additional useful hints.
> + *
> + * The content of these tags is printed by the test on a failure to help the
> + * testers with debugging.
> + *
> + * The supported tags are:
> + *
> + * - "linux-git" with first 12 numbers from an upstream kernel git hash.
> + * - "CVE" with a CVE number e.g. "2000-1234".
> + * - "glibc-git" with first 12 numbers from an upstream glibc git hash.
> + * - "musl-git" with first 12 numbers from an upstream musl git hash.
> + * - "known-fail" a message describing something that is supposed to work but
> + *   rather than that produces a longstanding failures.
>   */
> -int tst_parse_int(const char *str, int *val, int min, int max);
> -int tst_parse_long(const char *str, long *val, long min, long max);
> -int tst_parse_float(const char *str, float *val, float min, float max);
> -int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
> -
>  struct tst_tag {
>  	const char *name;
>  	const char *value;
> @@ -147,30 +234,246 @@ struct tst_tag {

>  extern unsigned int tst_variant;

> -#define TST_NO_HUGEPAGES ((unsigned long)-1)
> -
>  #define TST_UNLIMITED_RUNTIME (-1)

> +/**
> + * struct tst_ulimit_val - An ulimit resource and value.
> + *
> + * @resource: Which resource limits should be adjusted. See setrlimit(2) for
> + *            the list of the RLIMIT_* constants.
> + * @rlim_cur: A limit value.
> + */
>  struct tst_ulimit_val {
>  	int resource;
>  	rlim_t rlim_cur;
>  };

> -struct tst_test {
> -	/* number of tests available in test() function */
> +/**
> + * struct tst_test - A test description.
> + *
> + * @tcnt: A number of tests. If set the test() callback is called tcnt times
> + *        and each time passed an increasing counter value.

Very nit: I would prefer if the formatting would not force the indent, e.g.:

 * @tcnt: A number of tests. If set the test() callback is called tcnt times
 * and each time passed an increasing counter value.

Because variables with long name will require more lines, but feel free to
ignore it.

> + * @options: An NULL optstr terminated array of struct tst_option.
> + *
> + * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> + *
> + * @supported_archs: A NULL terminated array of architectures the test runs on
> + *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
> + *                   check if current CPU architecture is supported and exits
> + *                   the test with TCONF if it's not.
> + *

...
>  	void (*setup)(void);
>  	void (*cleanup)(void);
> -
>  	void (*test)(unsigned int test_nr);
>  	void (*test_all)(void);

> -	/* Syscall name used by the timer measurement library */
We decided to drop this comment. Isn't it useful?
>  	const char *scall;
> -
> -	/* Sampling function for timer measurement testcases */
>  	int (*sample)(int clk_id, long long usec);
And this one as well.

The rest LGTM. Thanks for working on this!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
