Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB24DCD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 09:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1B83E5E98
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 11:31:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD5B3E2B09
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 11:31:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 386D41A0098E
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 11:31:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2128759B9;
 Wed, 10 Jun 2026 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781083875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY8+OrOLU5VVEjaWwL1Map0p+D3TbN6igr8HQaFP/IE=;
 b=Vt2VIZ9x8fpXHpDN0ZtpncMMij1oo4u/COLggpnb486Zgv70qLMAVR/rLI9uMcJsrT218a
 MbPtg9TaM45W0Tw4nThm3qIj0SFprAEU6VDGCYP86R64oh9FL6yzHqsZLdllEYG+Aaol+/
 03YTyAAVc2BElqeZ4vjjT2y7GBSdvt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781083875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY8+OrOLU5VVEjaWwL1Map0p+D3TbN6igr8HQaFP/IE=;
 b=ke7nwi895o8qFFmarD+frywhOzsCCMtrtJm/c6wx3P9C/RzBbEyj2uMHOEWNxuH4P61vZ3
 /yF1OkMEBHBtmGDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781083874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY8+OrOLU5VVEjaWwL1Map0p+D3TbN6igr8HQaFP/IE=;
 b=eCQgdA3o6hZxmPuQHC+GP8eabsuGnNxkiD1fhktVOJkMMnSyoWwtpLOLrF6DnEmIrQq+qH
 hUUz7EFVNsMXrVcNJiAg9G5MZzSGlCr4V87ehMzqf7+IUKvcF+MNfUl5Pq0Bm0OlUFT5DJ
 K1VM1y7632+scuX7qjXx0knTlB207Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781083874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DY8+OrOLU5VVEjaWwL1Map0p+D3TbN6igr8HQaFP/IE=;
 b=UfWl69VuayfU+AlrkQOa2+qSqir7uut4RoTeYBmophKb6HyJI7RHuCNaAmc6vnEOG7x3dv
 yr4B56Zvfts3EjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FD35779A7;
 Wed, 10 Jun 2026 09:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QFD+JeIuKWqmPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jun 2026 09:31:14 +0000
Date: Wed, 10 Jun 2026 11:31:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Praveen K Pandey <praveen@linux.ibm.com>
Message-ID: <aiku3VRfJZS4dsxY@yuki.lan>
References: <20260609041632.74427-1-praveen@linux.ibm.com>
 <20260609041632.74427-2-praveen@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260609041632.74427-2-praveen@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/5] ftrace: Add common library for C
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
> +char *ftrace_get_path(const char *filename)
> +{
> +	char *path;
> +
> +	SAFE_ASPRINTF(&path, "%s/%s", tracing_path, filename);
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
> +	while ((read = getline(&line, &len, fp)) != -1) {
> +		char *new_content = realloc(content, total_size + read + 1);
> +
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
> +
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
> +		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "r");
> +
> +		if (fp) {
> +			saved_state.stack_tracer_enabled = malloc(32);
> +			if (saved_state.stack_tracer_enabled)
> +				fgets(saved_state.stack_tracer_enabled, 32, fp);
> +			fclose(fp);
> +		}
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
> +
> +		if (fp) {
> +			fprintf(fp, "%s", saved_state.ftrace_enabled);
> +			fclose(fp);
> +		}
> +	}
> +
> +	if (saved_state.stack_tracer_enabled && ftrace_file_exists("stack_max_size")) {
> +		FILE *fp = fopen("/proc/sys/kernel/stack_tracer_enabled", "w");
> +
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
> +	if (saved_state.trace_options) {
> +		char *options = strdup(saved_state.trace_options);
> +
> +		if (options) {
> +			char *token = strtok(options, "\n");
> +
> +			while (token) {
> +				ftrace_write_file("trace_options", token);
> +				token = strtok(NULL, "\n");
> +			}
> +			free(options);
> +		}
> +	}
> +
> +	ftrace_clear_trace();
> +
> +	if (ftrace_file_exists("set_ftrace_filter"))
> +		ftrace_write_file("set_ftrace_filter", "\n");
> +}
> +
> +char **ftrace_get_available_tracers(int *count)
> +{
> +	char *path;
> +	FILE *fp;
> +	char **tracers = NULL;
> +	char *line = NULL;
> +	size_t len = 0;
> +	int n = 0;
> +	int capacity = 16;
> +
> +	path = ftrace_get_path("available_tracers");
> +	if (!path) {
> +		*count = 0;
> +		return NULL;
> +	}
> +
> +	fp = fopen(path, "r");
> +	free(path);
> +
> +	if (!fp) {
> +		*count = 0;
> +		return NULL;
> +	}
> +
> +	tracers = malloc(sizeof(char *) * capacity);
> +	if (!tracers) {
> +		fclose(fp);
> +		*count = 0;
> +		return NULL;
> +	}
> +
> +	if (getline(&line, &len, fp) != -1) {
> +		char *token;
> +		char *saveptr;
> +
> +		token = strtok_r(line, " \n", &saveptr);
> +		while (token) {
> +			if (n >= capacity) {
> +				capacity *= 2;
> +				char **new_tracers = realloc(tracers, sizeof(char *) * capacity);
> +
> +				if (!new_tracers) {
> +					while (n > 0)
> +						free(tracers[--n]);
> +					free(tracers);
> +					free(line);
> +					fclose(fp);
> +					*count = 0;
> +					return NULL;
> +				}
> +				tracers = new_tracers;
> +			}
> +
> +			tracers[n] = strdup(token);
> +			if (!tracers[n]) {
> +				while (n > 0)
> +					free(tracers[--n]);
> +				free(tracers);
> +				free(line);
> +				fclose(fp);
> +				*count = 0;
> +				return NULL;
> +			}
> +			n++;
> +			token = strtok_r(NULL, " \n", &saveptr);
> +		}

The loop here does not make any sense, we are reading the file line by
line now, the strtok_r() will not split the line into tokens, there is
going to be only a single line in the buffer.

> +	}
> +
> +	free(line);
> +	fclose(fp);
> +
> +	*count = n;
> +	return tracers;
> +}
> +
> +int ftrace_set_tracer(const char *tracer)
> +{
> +	char *path;
> +
> +	path = ftrace_get_path("current_tracer");
> +	if (!path)
> +		return -1;
> +
> +	SAFE_FILE_PRINTF(path, "%s", tracer);
> +	free(path);
> +
> +	return 0;

It's way too ugly to construct the path each time we need to write to
the tracing file.

I guess that the ideal solution is to use the SAFE_FILE_PRINTFAT() that
way we will only need to open the tracing directory with O_DIRECTORY in
the ftrace_initialize() and then we can print to all these files
relative to the dirfd without construction any paths, which can replace
all the ftrace_write_file() with SAFE_FILE_PRINTFAT().

For reading small files we can use SAFE_FILE_READAT().

> diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_lib.h b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
> new file mode 100644
> index 000000000..79fdfee28
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_test/ftrace_lib.h
> @@ -0,0 +1,136 @@
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
> +extern char *tracing_path;
> +extern char *debugfs_path;
> +
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
> +/**
> + * ftrace_initialize - Initialize ftrace test environment
> + *
> + * Checks if debugfs is mounted, mounts it if needed, verifies tracing
> + * support, and saves current ftrace settings.
> + */
> +void ftrace_initialize(void);
> +
> +/**
> + * ftrace_cleanup - Cleanup and restore ftrace settings
> + *
> + * Restores all saved ftrace settings and unmounts debugfs if needed.
> + */
> +void ftrace_cleanup(void);
> +
> +/**
> + * ftrace_save_settings - Save current ftrace settings
> + *
> + * Saves all ftrace configuration to restore later.
> + */
> +void ftrace_save_settings(void);
> +
> +/**
> + * ftrace_restore_settings - Restore saved ftrace settings
> + *
> + * Restores ftrace configuration saved by ftrace_save_settings().
> + */
> +void ftrace_restore_settings(void);
> +
> +/**
> + * ftrace_get_path - Get full path to a tracing file
> + * @filename: Name of the file in tracing directory
> + *
> + * Return: Allocated string with full path (caller must free)
> + */
> +char *ftrace_get_path(const char *filename);
> +
> +/**
> + * ftrace_read_file - Read content from a tracing file
> + * @filename: Name of the file in tracing directory
> + *
> + * Return: Allocated string with file content (caller must free)
> + */
> +char *ftrace_read_file(const char *filename);
> +
> +/**
> + * ftrace_write_file - Write content to a tracing file
> + * @filename: Name of the file in tracing directory
> + * @content: Content to write
> + *
> + * Return: 0 on success, -1 on failure
> + */
> +int ftrace_write_file(const char *filename, const char *content);
> +
> +/**
> + * ftrace_file_exists - Check if a tracing file exists
> + * @filename: Name of the file in tracing directory
> + *
> + * Return: 1 if exists, 0 otherwise
> + */
> +int ftrace_file_exists(const char *filename);
> +
> +/**
> + * ftrace_get_available_tracers - Get list of available tracers
> + * @count: Pointer to store number of tracers
> + *
> + * Return: Array of tracer names (caller must free)
> + */
> +char **ftrace_get_available_tracers(int *count);
> +
> +/**
> + * ftrace_set_tracer - Set current tracer
> + * @tracer: Name of the tracer to set
> + *
> + * Return: 0 on success, -1 on failure
> + */
> +int ftrace_set_tracer(const char *tracer);
> +
> +/**
> + * ftrace_clear_trace - Clear the trace buffer
> + */
> +void ftrace_clear_trace(void);
> +
> +/**
> + * ftrace_enable_tracing - Enable tracing
> + */
> +void ftrace_enable_tracing(void);
> +
> +/**
> + * ftrace_disable_tracing - Disable tracing
> + */
> +void ftrace_disable_tracing(void);
> +
> +#endif /* FTRACE_LIB_H */
> +
> -- 
> 2.50.1

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
