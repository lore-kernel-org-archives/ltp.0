Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A80C021B5
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 15:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 197F23C9292
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 16:04:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8A2C3C0463
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 16:04:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B9E86007B2
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 16:04:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 563E522971;
 Fri, 21 Feb 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740150252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z17lmG4ASd0sKsLOVc3PxRhODwbgv0sfMVjewrQ/xUc=;
 b=zEI+EaKCPjlXjEhWyZJXr5HuV20LF4+hR9E1Kw4rnfDh6tzT6O2fo0nRp4H3Wlt9sFfaU4
 HR1y4SxLk9BVC1CQGo0v7P/989V86VZnFj07/iwGywlmHXn0hU2Cem3ucfqAYvFlRQGc2g
 lmcSj2KLK3W3G9M5Yn9ThqZir4NlTsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740150252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z17lmG4ASd0sKsLOVc3PxRhODwbgv0sfMVjewrQ/xUc=;
 b=J24bxnZOi/Sh8zw8nqlKktfhPKlSqC07zDMlltAOkECByqY8sKWzl+Qvb04fELpF1Ghv7g
 njvqseBdVUtZRnCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740150252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z17lmG4ASd0sKsLOVc3PxRhODwbgv0sfMVjewrQ/xUc=;
 b=zEI+EaKCPjlXjEhWyZJXr5HuV20LF4+hR9E1Kw4rnfDh6tzT6O2fo0nRp4H3Wlt9sFfaU4
 HR1y4SxLk9BVC1CQGo0v7P/989V86VZnFj07/iwGywlmHXn0hU2Cem3ucfqAYvFlRQGc2g
 lmcSj2KLK3W3G9M5Yn9ThqZir4NlTsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740150252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z17lmG4ASd0sKsLOVc3PxRhODwbgv0sfMVjewrQ/xUc=;
 b=J24bxnZOi/Sh8zw8nqlKktfhPKlSqC07zDMlltAOkECByqY8sKWzl+Qvb04fELpF1Ghv7g
 njvqseBdVUtZRnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45FDB136AD;
 Fri, 21 Feb 2025 15:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LbcSEOyVuGfJFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Feb 2025 15:04:12 +0000
Date: Fri, 21 Feb 2025 16:04:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z7iV8SVMDgnWBYv_@yuki.lan>
References: <20250113055231.5908-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113055231.5908-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl10.c: New case test PROCMAP_QUERY ioctl()
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
> diff --git a/configure.ac b/configure.ac
> index 6992d75ca..56380d41e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -179,6 +179,7 @@ AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error
>  		struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
>  AC_CHECK_TYPES([struct file_clone_range],,,[#include <linux/fs.h>])
>  AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
> +AC_CHECK_TYPES([struct procmap_query],,,[#include <linux/fs.h>])
>  
>  AC_CHECK_TYPES([struct file_handle],,,[
>  #define _GNU_SOURCE
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..a13811855 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -583,6 +583,7 @@ ioctl06      ioctl06
>  ioctl07      ioctl07
>  ioctl08      ioctl08
>  ioctl09      ioctl09
> +ioctl10      ioctl10
>  
>  ioctl_loop01 ioctl_loop01
>  ioctl_loop02 ioctl_loop02
> diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
> index 1f099ff95..9c3f66bf1 100644
> --- a/testcases/kernel/syscalls/ioctl/.gitignore
> +++ b/testcases/kernel/syscalls/ioctl/.gitignore
> @@ -7,6 +7,7 @@
>  /ioctl07
>  /ioctl08
>  /ioctl09
> +/ioctl10
>  /ioctl_loop01
>  /ioctl_loop02
>  /ioctl_loop03
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
> new file mode 100644
> index 000000000..cd9e3c528
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test PROCMAP_QUERY ioctl() for /proc/$PID/maps.
> + * Test base on kernel selftests proc-pid-vm.c.
> + *
> + * 1. Ioctl with exact match query_addr
> + * 2. Ioctl without match query_addr
> + * 3. Check COVERING_OR_NEXT_VMA query_flags
> + * 4. Check PROCMAP_QUERY_VMA_WRITABLE query_flags
> + * 5. Check vma_name_addr content
> + */
> +
> +#include "config.h"
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <errno.h>
> +#include <fnmatch.h>
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include <sys/sysmacros.h>
> +
> +#ifdef HAVE_STRUCT_PROCMAP_QUERY

Instead of this we should add a lapi fallback, as we do for other newly
introduced functionality.

See include/lapi/ficlone.h how that should look like.

> +#include <linux/fs.h>
> +
> +struct map_entry {
> +	unsigned long vm_start;
> +	unsigned long vm_end;
> +	char vm_flags_str[5];
> +	unsigned long vm_pgoff;
> +	unsigned int vm_major;
> +	unsigned int vm_minor;
> +	unsigned long vm_inode;
> +	char vm_name[256];
> +	unsigned int vm_flags;
> +};
> +
> +static unsigned int parse_vm_flags(const char *vm_flags_str)
> +{
> +	unsigned int flags = 0;
> +
> +	if (strchr(vm_flags_str, 'r'))
> +		flags |= PROCMAP_QUERY_VMA_READABLE;
> +	if (strchr(vm_flags_str, 'w'))
> +		flags |= PROCMAP_QUERY_VMA_WRITABLE;
> +	if (strchr(vm_flags_str, 'x'))
> +		flags |= PROCMAP_QUERY_VMA_EXECUTABLE;
> +	if (strchr(vm_flags_str, 's'))
> +		flags |= PROCMAP_QUERY_VMA_SHARED;
> +
> +	return flags;
> +
> +}
> +
> +static int parse_maps_file(const char *filename, const char *keyword, struct map_entry *entry)
> +{
> +	FILE *fp = SAFE_FOPEN(filename, "r");
> +
> +	char line[1024];
> +
> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		if (fnmatch(keyword, line, 0) == 0) {
> +			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
> +						&entry->vm_start, &entry->vm_end, entry->vm_flags_str,
> +						&entry->vm_pgoff, &entry->vm_major, &entry->vm_minor,
> +						&entry->vm_inode, entry->vm_name) < 7)
> +				return -1;
> +
> +			entry->vm_flags = parse_vm_flags(entry->vm_flags_str);
> +
> +			SAFE_FCLOSE(fp);
> +			return 0;
> +		}
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +	return -1;
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	char path_buf[256];
> +	struct procmap_query q;
> +	int fd;
> +	struct map_entry entry;
> +
> +	memset(&entry, 0, sizeof(entry));
> +
> +	snprintf(path_buf, sizeof(path_buf), "/proc/%u/maps", getpid());
> +	fd = SAFE_OPEN(path_buf, O_RDONLY);

You don't have to create the path with $PID you can pass
"/proc/self/maps" to the open() instead.

> +	TST_EXP_PASS(parse_maps_file(path_buf, "*", &entry));

This isn't a test, so we should call it in TST_EXP_PASS() instead the
function should call tst_brk() on a failure and shouldn't return a
value.

> +	/* CASE 1: exact MATCH at query_addr */
> +	memset(&q, 0, sizeof(q));
> +	q.size = sizeof(q);
> +	q.query_addr = (__u64)entry.vm_start;
                         ^
			 Should be uint64_t in userspace.

> +	q.query_flags = 0;
> +
> +	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
> +
> +	TST_EXP_EQ_LU(q.query_addr, entry.vm_start);
> +	TST_EXP_EQ_LU(q.query_flags, 0);
> +	TST_EXP_EQ_LU(q.vma_flags, entry.vm_flags);
> +	TST_EXP_EQ_LU(q.vma_start, entry.vm_start);
> +	TST_EXP_EQ_LU(q.vma_end, entry.vm_end);
> +	TST_EXP_EQ_LU(q.vma_page_size, getpagesize());
> +	TST_EXP_EQ_LU(q.vma_offset, entry.vm_pgoff);
> +	TST_EXP_EQ_LU(q.inode, entry.vm_inode);
> +	TST_EXP_EQ_LU(q.dev_major, entry.vm_major);
> +	TST_EXP_EQ_LU(q.dev_minor, entry.vm_minor);
> +
> +	/* CASE 2: NO MATCH at query_addr */
> +	memset(&q, 0, sizeof(q));
> +	q.size = sizeof(q);
> +	q.query_addr = entry.vm_start - 1;
> +	q.query_flags = 0;
> +
> +	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
> +
> +	/* CASE 3: MATCH COVERING_OR_NEXT_VMA */
> +	memset(&q, 0, sizeof(q));
> +	q.size = sizeof(q);
> +	q.query_addr = entry.vm_start - 1;
> +	q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
> +
> +	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
> +
> +	/* CASE 4: NO MATCH WRITABLE at query_addr */
> +	memset(&entry, 0, sizeof(entry));
> +	TST_EXP_PASS(parse_maps_file(path_buf, "*r-?p *", &entry));

Here as well.

> +	memset(&q, 0, sizeof(q));
> +	q.size = sizeof(q);
> +	q.query_addr = entry.vm_start;
> +	q.query_flags = PROCMAP_QUERY_VMA_WRITABLE;
> +	TST_EXP_FAIL(ioctl(fd, PROCMAP_QUERY, &q), ENOENT);
> +
> +	/* CASE 5: check vma_name_addr content */
> +	char process_name[256];
> +	char pattern[256];
> +	char buf[256];
> +
> +	SAFE_READLINK("/proc/self/exe", process_name, sizeof(process_name));
> +	sprintf(pattern, "*%s*", process_name);
> +	memset(&entry, 0, sizeof(entry));
> +	TST_EXP_PASS(parse_maps_file(path_buf, pattern, &entry));

Here as well.

> +	memset(&q, 0, sizeof(q));
> +	q.size = sizeof(q);
> +	q.query_addr = entry.vm_start;
> +	q.query_flags = 0;
> +	q.vma_name_addr = (__u64)(unsigned long)buf;

Here as well.

> +	q.vma_name_size = sizeof(buf);
> +
> +	TST_EXP_PASS(ioctl(fd, PROCMAP_QUERY, &q));
> +	TST_EXP_EQ_LU(q.vma_name_size, strlen(process_name) + 1);
> +	TST_EXP_EQ_STR((char *)q.vma_name_addr, process_name);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_ioctl,
> +	.needs_root = 1,
> +};
> +#else
> +	TST_TEST_TCONF(
> +		"This system does not provide support for ioctl(PROCMAP_QUERY)");
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
