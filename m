Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6010CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:41:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3746A3E4E76
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:41:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FA383C1ACE
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:41:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 752DA1A0037B
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:41:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B691F6A882;
 Mon,  8 Jun 2026 09:41:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2725779A7;
 Mon,  8 Jun 2026 09:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ssW8Jk+OJmo1EwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jun 2026 09:41:35 +0000
Date: Mon, 8 Jun 2026 11:41:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Praveen K Pandey <praveen@linux.ibm.com>
Message-ID: <aiaOSb3OCJRd1Qry@yuki.lan>
References: <20260608055000.97154-1-praveen@linux.ibm.com>
 <20260608055000.97154-2-praveen@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260608055000.97154-2-praveen@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B691F6A882
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v4 1/5] ftrace: Add common library for C
 implementation
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
> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.c b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
> new file mode 100644
> index 000000000..8b93b9849
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2010 FUJITSU LIMITED
> + * Copyright (c) 2024 Linux Test Project
> + * Copyright (c) IBM, 2026
> + *
> + * Author: Li Zefan <lizf@cn.fujitsu.com>
> + * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "ftrace_lib.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_stdio.h"
> +
> +char *tracing_path = NULL;
> +char *debugfs_path = NULL;
> +static int debugfs_mounted_by_us = 0;
> +struct ftrace_saved_state saved_state = {0};

Static variables are initialized to zero by compiler automatically, no
need to do it here.

> +void ftrace_initialize(void)
> +{
> +	FILE *fp;
> +	char line[PATH_MAX];
> +	int found = 0;
> +
> +	/* Check if debugfs is already mounted */

Please avoid comment that state the obvious, e.g. say in english exactly
what the code does.

> +	fp = SAFE_FOPEN("/proc/mounts", "r");
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "debugfs")) {
> +			debugfs_path = strdup("/sys/kernel/debug");
> +			found = 1;
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(fp);

This whole thing could be just:

	if (tst_fs_is_mounted("/sys/kernel/debug")) {
		debugfs_path = strdup("/sys/kernel/debug");
		if (!debugfs_path)
			tst_brk(TBROK, ...);
	}

Ideally SAFE_STRDUP() should be added to the test library (in a separate
patch) so that we can simplify this even further to:

	if (tst_fs_is_mounted("/sys/kernel/debug"))
		debugfs_path = SAFE_STRDUP("/sys/kernel/debug");

> +	/* Mount debugfs if not already mounted */
> +	if (!found) {

No need to add found flag, we can do if (!debugfs_path) here instead.

> +		char *tmpdir = tst_tmpdir_path();
> +		debugfs_path = malloc(PATH_MAX);
> +		if (!debugfs_path)
> +			tst_brk(TBROK | TERRNO, "malloc failed");
> +		snprintf(debugfs_path, PATH_MAX, "%s/debugfs", tmpdir);

This could be single line with SAFE_ASPRINTF()

> +		SAFE_MKDIR(debugfs_path, 0755);
> +		SAFE_MOUNT("debugfs", debugfs_path, "debugfs", 0, NULL);
> +		debugfs_mounted_by_us = 1;
> +	}
> +
> +	/* Set tracing path */
> +	tracing_path = malloc(PATH_MAX);
> +	if (!tracing_path)
> +		tst_brk(TBROK | TERRNO, "malloc failed");
> +
> +	snprintf(tracing_path, PATH_MAX, "%s/tracing", debugfs_path);

This can be SAFE_ASPRINTF() as well.


> +	/* Check if tracing is supported */
> +	if (access(tracing_path, F_OK) != 0)
> +		tst_brk(TCONF, "Tracing is not supported");
> +
> +	/* Save current settings */
> +	ftrace_save_settings();
> +}
> +
> +void ftrace_cleanup(void)
> +{
> +	ftrace_restore_settings();
> +
> +	if (debugfs_mounted_by_us && debugfs_path) {
> +		tst_umount(debugfs_path);
> +		rmdir(debugfs_path);
> +	}
> +
> +	free(tracing_path);
> +	free(debugfs_path);
> +
> +	/* Free saved state */
> +	free(saved_state.trace_options);
> +	free(saved_state.tracing_on);
> +	free(saved_state.buffer_size);
> +	free(saved_state.tracing_cpumask);
> +	free(saved_state.tracing_enabled);
> +	free(saved_state.stack_tracer_enabled);
> +	free(saved_state.ftrace_enabled);
> +	free(saved_state.function_profile_enabled);
> +}
> +
> +char *ftrace_get_path(const char *filename)
> +{
> +	char *path;
> +
> +	path = malloc(PATH_MAX);
> +	if (!path)
> +		return NULL;
> +
> +	snprintf(path, PATH_MAX, "%s/%s", tracing_path, filename);

SAFE_ASPRINTF() here as well.

> +	return path;
> +}
> +
> +char *ftrace_read_file(const char *filename)
> +{
> +	char *path;
> +	FILE *fp;
> +	char *content = NULL;
> +	size_t len = 0;
> +	ssize_t read;
> +	char *line = NULL;
> +	size_t total_size = 0;
> +
> +	path = ftrace_get_path(filename);
> +	if (!path)
> +		return NULL;
> +
> +	fp = fopen(path, "r");
> +	free(path);
> +
> +	if (!fp)
> +		return NULL;
> +
> +	/* Read entire file */
> +	while ((read = getline(&line, &len, fp)) != -1) {
> +		char *new_content = realloc(content, total_size + read + 1);
> +		if (!new_content) {
> +			free(content);
> +			free(line);
> +			fclose(fp);
> +			return NULL;
> +		}
> +		content = new_content;
> +		memcpy(content + total_size, line, read);
> +		total_size += read;
> +	}
> +
> +	if (content)
> +		content[total_size] = '\0';
> +
> +	free(line);
> +	fclose(fp);
> +
> +	return content;
> +}
> +
> +int ftrace_write_file(const char *filename, const char *content)
> +{
> +	char *path;
> +	FILE *fp;
> +	int ret;
> +
> +	path = ftrace_get_path(filename);
> +	if (!path)
> +		return -1;
> +
> +	fp = fopen(path, "w");
> +	free(path);
> +
> +	if (!fp)
> +		return -1;
> +
> +	ret = fprintf(fp, "%s", content);
> +	fclose(fp);

This could be replaced by single SAFE_FILE_PRINTF()

> +	return (ret > 0) ? 0 : -1;
> +}
> +
> +int ftrace_file_exists(const char *filename)
> +{
> +	char *path;
> +	int ret;
> +
> +	path = ftrace_get_path(filename);
> +	if (!path)
> +		return 0;
> +
> +	ret = (access(path, F_OK) == 0);
> +	free(path);
> +
> +	return ret;
> +}
> +
> +void ftrace_save_settings(void)
> +{
> +	if (saved_state.saved)
> +		return;
> +
> +	saved_state.trace_options = ftrace_read_file("trace_options");
> +	saved_state.tracing_on = ftrace_read_file("tracing_on");
> +	saved_state.buffer_size = ftrace_read_file("buffer_size_kb");
> +
> +	if (ftrace_file_exists("tracing_cpumask"))
> +		saved_state.tracing_cpumask = ftrace_read_file("tracing_cpumask");
> +
> +	if (ftrace_file_exists("tracing_enabled"))
> +		saved_state.tracing_enabled = ftrace_read_file("tracing_enabled");
> +
> +	if (ftrace_file_exists("stack_max_size")) {
> +		char *path = strdup("/proc/sys/kernel/stack_tracer_enabled");
> +		FILE *fp = fopen(path, "r");
> +
> +		if (fp) {
> +			saved_state.stack_tracer_enabled = malloc(32);
> +			if (saved_state.stack_tracer_enabled)
> +				fgets(saved_state.stack_tracer_enabled, 32, fp);
> +			fclose(fp);
> +		}
> +		free(path);
> +	}
> +
> +	if (access("/proc/sys/kernel/ftrace_enabled", F_OK) == 0) {
> +		FILE *fp = fopen("/proc/sys/kernel/ftrace_enabled", "r");
> +
> +		if (fp) {
> +			saved_state.ftrace_enabled = malloc(32);
> +			if (saved_state.ftrace_enabled)
> +				fgets(saved_state.ftrace_enabled, 32, fp);
> +			fclose(fp);
> +		}
> +	}
> +
> +	if (ftrace_file_exists("function_profile_enabled"))
> +		saved_state.function_profile_enabled = ftrace_read_file("function_profile_enabled");
> +
> +	saved_state.saved = 1;
> +}
> +
> +void ftrace_restore_settings(void)
> +{
> +	if (!saved_state.saved)
> +		return;
> +
> +	/* Reset tracer and events */
> +	ftrace_write_file("current_tracer", "nop\n");
> +	ftrace_write_file("events/enable", "0\n");
> +
> +	if (ftrace_file_exists("tracing_max_latency"))
> +		ftrace_write_file("tracing_max_latency", "0\n");
> +
> +	if (saved_state.tracing_cpumask)
> +		ftrace_write_file("tracing_cpumask", saved_state.tracing_cpumask);
> +
> +	if (ftrace_file_exists("trace_clock"))
> +		ftrace_write_file("trace_clock", "local\n");
> +
> +	if (saved_state.function_profile_enabled)
> +		ftrace_write_file("function_profile_enabled", saved_state.function_profile_enabled);
> +
> +	if (saved_state.ftrace_enabled) {
> +		FILE *fp = fopen("/proc/sys/kernel/ftrace_enabled", "w");
> +		if (fp) {
> +			fprintf(fp, "%s", saved_state.ftrace_enabled);
> +			fclose(fp);
> +		}
> +	}
> +
> +	if (saved_state.stack_tracer_enabled && ftrace_file_exists("stack_max_size")) {
> +		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "w");
> +		if (fp) {
> +			fprintf(fp, "%s", saved_state.stack_tracer_enabled);
> +			fclose(fp);
> +		}
> +		ftrace_write_file("stack_max_size", "0\n");
> +	}
> +
> +	if (saved_state.buffer_size)
> +		ftrace_write_file("buffer_size_kb", saved_state.buffer_size);
> +
> +	if (saved_state.tracing_on)
> +		ftrace_write_file("tracing_on", saved_state.tracing_on);
> +
> +	if (saved_state.tracing_enabled)
> +		ftrace_write_file("tracing_enabled", saved_state.tracing_enabled);
> +
> +	/* Restore trace options */
> +	if (saved_state.trace_options) {
> +		char *options = strdup(saved_state.trace_options);
> +		char *token = strtok(options, "\n");
> +		while (token) {
> +			ftrace_write_file("trace_options", token);
> +			token = strtok(NULL, "\n");
> +		}
> +		free(options);
> +	}
> +
> +	/* Clear trace */
> +	ftrace_clear_trace();
> +
> +	/* Clear filter */
> +	if (ftrace_file_exists("set_ftrace_filter"))
> +		ftrace_write_file("set_ftrace_filter", "\n");
> +}
> +
> +char **ftrace_get_available_tracers(int *count)
> +{
> +	char *content;
> +	char **tracers = NULL;
> +	int n = 0;
> +	char *token;
> +	char *saveptr;
> +
> +	content = ftrace_read_file("available_tracers");
> +	if (!content) {
> +		*count = 0;
> +		return NULL;
> +	}
> +
> +	/* Count tracers */
> +	char *tmp = strdup(content);
> +	token = strtok_r(tmp, " \n", &saveptr);
> +	while (token) {
> +		n++;
> +		token = strtok_r(NULL, " \n", &saveptr);
> +	}
> +	free(tmp);
> +
> +	/* Allocate array */
> +	tracers = malloc(sizeof(char *) * n);
> +	if (!tracers) {
> +		free(content);
> +		*count = 0;
> +		return NULL;
> +	}
> +
> +	/* Fill array */
> +	n = 0;
> +	token = strtok_r(content, " \n", &saveptr);
> +	while (token) {
> +		tracers[n++] = strdup(token);
> +		token = strtok_r(NULL, " \n", &saveptr);
> +	}
> +
> +	free(content);
> +	*count = n;
> +	return tracers;

This would be much easier if you just read the file line by line

	f = SAFE_FOPEN(...)

	while (fgets(line, sizeof(line), f) {
		...
	}

	SAFE_FCLOSE(f);

> +}
> +
> +int ftrace_set_tracer(const char *tracer)
> +{
> +	char buf[256];
> +	snprintf(buf, sizeof(buf), "%s\n", tracer);
> +	return ftrace_write_file("current_tracer", buf);
> +}
> +
> +void ftrace_clear_trace(void)
> +{
> +	ftrace_write_file("trace", "\n");
> +}
> +
> +void ftrace_enable_tracing(void)
> +{
> +	ftrace_write_file("tracing_on", "1\n");
> +}
> +
> +void ftrace_disable_tracing(void)
> +{
> +	ftrace_write_file("tracing_on", "0\n");
> +}

Generally it would make sense to keep the paths to these files in a
global variables, set then only once in the init and then we could just
do:

void ftrace_set_tracer(const char *tracer)
{
	SAFE_FILE_PRINTF(path_ftrace_tracer, "%s", tracer);
}

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.h b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
> new file mode 100644
> index 000000000..b40877ed1
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2010 FUJITSU LIMITED
> + * Copyright (c) 2024 Linux Test Project
> + * Copyright (c) IBM, 2026
> + *
> + * Author: Li Zefan <lizf@cn.fujitsu.com>
> + * Converted to C by: Praveen K Pandey <praveen@linux.ibm.com>
> + */
> +
> +#ifndef FTRACE_LIB_H
> +#define FTRACE_LIB_H
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/mount.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <limits.h>
> +
> +/* Global paths */
> +extern char *tracing_path;
> +extern char *debugfs_path;
> +
> +/* Saved settings for cleanup */
> +struct ftrace_saved_state {
> +	char *trace_options;
> +	char *tracing_on;
> +	char *buffer_size;
> +	char *tracing_cpumask;
> +	char *tracing_enabled;
> +	char *stack_tracer_enabled;
> +	char *ftrace_enabled;
> +	char *function_profile_enabled;
> +	int saved;
> +};
> +
> +extern struct ftrace_saved_state saved_state;
> +

Why is this leaking into the tests? None of these low level details
should be exposed since you are building a library for the tests to use.

> +/**
> + * ftrace_initialize() - Initialize ftrace test environment
> + *
> + * This function:
> + * - Checks if debugfs is mounted, mounts it if needed
> + * - Verifies tracing support
> + * - Saves current ftrace settings

We use kernel doc comments that are parsed and exported into
documentation.

https://docs.kernel.org/doc-guide/kernel-doc.html

> + */
> +void ftrace_initialize(void);
> +
> +/**
> + * ftrace_cleanup() - Cleanup and restore ftrace settings
> + *
> + * Restores all saved ftrace settings and unmounts debugfs if needed
> + */
> +void ftrace_cleanup(void);
> +
> +/**
> + * ftrace_save_settings() - Save current ftrace settings
> + *
> + * Saves all ftrace configuration to restore later
> + */
> +void ftrace_save_settings(void);
> +
> +/**
> + * ftrace_restore_settings() - Restore saved ftrace settings
> + *
> + * Restores ftrace configuration saved by ftrace_save_settings()
> + */
> +void ftrace_restore_settings(void);
> +
> +/**
> + * ftrace_get_path() - Get full path to a tracing file
> + * @filename: Name of the file in tracing directory
> + *
> + * Returns: Allocated string with full path (caller must free)
> + */
> +char *ftrace_get_path(const char *filename);
> +
> +/**
> + * ftrace_read_file() - Read content from a tracing file
> + * @filename: Name of the file in tracing directory
> + *
> + * Returns: Allocated string with file content (caller must free)
> + */
> +char *ftrace_read_file(const char *filename);
> +
> +/**
> + * ftrace_write_file() - Write content to a tracing file
> + * @filename: Name of the file in tracing directory
> + * @content: Content to write
> + *
> + * Returns: 0 on success, -1 on failure
> + */
> +int ftrace_write_file(const char *filename, const char *content);
> +
> +/**
> + * ftrace_file_exists() - Check if a tracing file exists
> + * @filename: Name of the file in tracing directory
> + *
> + * Returns: 1 if exists, 0 otherwise
> + */
> +int ftrace_file_exists(const char *filename);
> +
> +/**
> + * ftrace_get_available_tracers() - Get list of available tracers
> + * @count: Pointer to store number of tracers
> + *
> + * Returns: Array of tracer names (caller must free)
> + */
> +char **ftrace_get_available_tracers(int *count);
> +
> +/**
> + * ftrace_set_tracer() - Set current tracer
> + * @tracer: Name of the tracer to set
> + *
> + * Returns: 0 on success, -1 on failure
> + */
> +int ftrace_set_tracer(const char *tracer);
> +
> +/**
> + * ftrace_clear_trace() - Clear the trace buffer
> + */
> +void ftrace_clear_trace(void);
> +
> +/**
> + * ftrace_enable_tracing() - Enable tracing
> + */
> +void ftrace_enable_tracing(void);
> +
> +/**
> + * ftrace_disable_tracing() - Disable tracing
> + */
> +void ftrace_disable_tracing(void);
> +
> +#endif /* FTRACE_LIB_H */
> -- 
> 2.50.1
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
