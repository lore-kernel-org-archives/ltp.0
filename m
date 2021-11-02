Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3666CC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:08:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E14960C51
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7E14960C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1EAF3C7172
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:08:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58EE43C6268
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:07:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F76C20112A
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:07:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9C07C1FD4C
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635851272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZOv0aQCiiQtIov1uGQQT5NK0nBd2v2LJyxsmTQ1CzxU=;
 b=hy6Dny099ZBpIa2cDSZnzoPGYqO5eEBkgkBPysXa5tJ2VgCYb3oakb1ojyAcAyhy5kcQ/A
 8Aednco2LiiGACs2zwGaKjA8MhYU2Eu9AOhQAgKNvcPK7VoQVu3mtbT+SsPJNT7iHu7ieR
 qHGwQj23hcwtY4k76IrfhAzzlGn7dq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635851272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZOv0aQCiiQtIov1uGQQT5NK0nBd2v2LJyxsmTQ1CzxU=;
 b=nJbvovPpkf86glqOyNOApSXqMGgX5NsOmQd5+/WKdESskaOTUe7rj3mkd1CRU90f5NJOof
 63jN3i6YtUkc9PBQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3A4B2A3B92;
 Tue,  2 Nov 2021 11:07:52 +0000 (UTC)
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-2-chrubis@suse.cz>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 02 Nov 2021 10:05:51 +0000
In-reply-to: <20211101145342.7166-2-chrubis@suse.cz>
Message-ID: <871r3yq0hm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] docparse: Implement #define and #include
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


Cyril Hrubis <chrubis@suse.cz> writes:

> We ignore most of the include statements and we attempt to parse only
> header files that reside in the same directory as the test source code,
> that is since we are not interested in any system or library headers as
> we are only looking for constants used in the tst_test structure that
> are always either directly in the test source or in header in the same
> directory.
>
> The macro support is very simple as well, it's a single pass as we are
> not interested in intricate macros. We just need values for constants
> that are used in the tst_test structure intializations.
>
> + Also add -v verbose mode that prints included files and defined macros
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

I don't see any issues that are likely to cause trouble
immediately. However please check the comments below to ensure they are
out-of-scope.

Reviewed-by: rpalethorpe@suse.com

> ---
>  docparse/docparse.c | 234 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 224 insertions(+), 10 deletions(-)
>
> diff --git a/docparse/docparse.c b/docparse/docparse.c
> index 8cd0d0eef..64f9d08d9 100644
> --- a/docparse/docparse.c
> +++ b/docparse/docparse.c
> @@ -1,9 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2019-2021 Cyril Hrubis <chrubis@suse.cz>
>   * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
>   */
>  
> +#define _GNU_SOURCE
> +
> +#include <search.h>
>  #include <stdio.h>
>  #include <string.h>
>  #include <libgen.h>
> @@ -12,6 +15,9 @@
>  
>  #include "data_storage.h"
>  
> +static int verbose;
> +static char *includepath;
> +
>  #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
>  
>  static void oneline_comment(FILE *f)
> @@ -126,7 +132,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
>  	}
>  }
>  
> -const char *next_token(FILE *f, struct data_node *doc)
> +static char *next_token(FILE *f, struct data_node *doc)
>  {
>  	size_t i = 0;
>  	static char buf[4096];
> @@ -159,6 +165,7 @@ const char *next_token(FILE *f, struct data_node *doc)
>  		case ',':
>  		case '[':
>  		case ']':
> +		case '#':
>  			if (i) {
>  				ungetc(c, f);
>  				goto exit;
> @@ -197,6 +204,46 @@ exit:
>  	return buf;
>  }
>  
> +static FILE *open_include(const char *includepath, FILE *f)
> +{
> +	char buf[256];
> +	char *path;
> +	FILE *inc;
> +
> +	if (!fscanf(f, "%s\n", buf))
> +		return NULL;
> +
> +	if (buf[0] != '"')
> +		return NULL;
> +
> +	char *filename = buf + 1;
> +
> +	if (!buf[0])
> +		return NULL;
> +
> +	filename[strlen(filename)-1] = 0;
> +
> +	if (asprintf(&path, "%s/%s", includepath, filename) < 0)
> +		return NULL;
> +
> +	inc = fopen(path, "r");
> +
> +	if (inc && verbose)
> +		fprintf(stderr, "INCLUDE %s\n", path);
> +
> +	free(path);
> +
> +	return inc;
> +}
> +
> +static void close_include(FILE *inc)
> +{
> +	if (verbose)
> +		fprintf(stderr, "INCLUDE END\n");
> +
> +	fclose(inc);
> +}
> +
>  static int parse_array(FILE *f, struct data_node *node)
>  {
>  	const char *token;
> @@ -234,9 +281,28 @@ static int parse_array(FILE *f, struct data_node *node)
>  	return 0;
>  }
>  
> +static void try_apply_macro(char **res)
> +{
> +	ENTRY macro = {
> +		.key = *res,
> +	};
> +
> +	ENTRY *ret;
> +
> +	ret = hsearch(macro, FIND);
> +
> +	if (!ret)
> +		return;
> +
> +	if (verbose)
> +		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
> +
> +	*res = ret->data;
> +}
> +
>  static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
>  {
> -	const char *token;
> +	char *token;
>  	char *id = NULL;
>  	int state = 0;
>  	struct data_node *ret;
> @@ -280,6 +346,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
>  			ret = data_node_array();
>  			parse_array(f, ret);
>  		} else {
> +			try_apply_macro(&token);
>  			ret = data_node_string(token);
>  		}
>  
> @@ -302,6 +369,114 @@ static const char *tokens[] = {
>  	"{",
>  };
>  
> +static void macro_get_string(FILE *f, char *buf, char *buf_end)
> +{
> +	int c;
> +
> +	for (;;) {
> +		c = fgetc(f);
> +
> +		switch (c) {
> +		case '"':

Luckily there are no instances of '#define MACRO "...\"...\"..."' in LTP
AFAICT. Also there don't appear to be any '#define MACRO "..." \\n' that
we would care about.

> +		case EOF:
> +			*buf = 0;
> +			return;
> +		default:
> +			if (buf < buf_end)
> +				*(buf++) = c;
> +		}
> +	}
> +}
> +
> +static void macro_get_val(FILE *f, char *buf, size_t buf_len)
> +{
> +	int c, prev = 0;
> +	char *buf_end = buf + buf_len - 1;
> +
> +	c = fgetc(f);
> +	if (c == '"') {

I guess this could be whitespace unless scanf slurps any trailing
whitespace?

Again no actual instances of this AFAICT.

> +		macro_get_string(f, buf, buf_end);
> +		return;
> +	}
> +
> +	for (;;) {
> +		switch (c) {
> +		case '\n':
> +			if (prev == '\\') {
> +				buf--;
> +			} else {
> +				*buf = 0;
> +				return;
> +			}
> +		break;
> +		case EOF:
> +			*buf = 0;
> +			return;
> +		case ' ':
> +		case '\t':
> +		break;
> +		default:
> +			if (buf < buf_end)
> +				*(buf++) = c;
> +		}
> +
> +		prev = c;
> +		c = fgetc(f);
> +	}
> +}
> +
> +static void parse_macro(FILE *f)
> +{
> +	char name[128];
> +	char val[256];
> +
> +	if (!fscanf(f, "%s[^\n]", name))
> +		return;
> +
> +	if (fgetc(f) == '\n')
> +		return;
> +
> +	macro_get_val(f, val, sizeof(val));
> +
> +	ENTRY e = {
> +		.key = strdup(name),
> +		.data = strdup(val),
> +	};
> +
> +	if (verbose)
> +		fprintf(stderr, " MACRO %s=%s\n", e.key, (char*)e.data);
> +
> +	hsearch(e, ENTER);
> +}
> +
> +static void parse_include_macros(FILE *f)
> +{
> +	FILE *inc;
> +	const char *token;
> +	int hash = 0;
> +
> +	inc = open_include(includepath, f);
> +	if (!inc)
> +		return;
> +
> +	while ((token = next_token(inc, NULL))) {
> +		if (token[0] == '#') {
> +			hash = 1;
> +			continue;
> +		}
> +
> +		if (!hash)
> +			continue;
> +
> +		if (!strcmp(token, "define"))
> +			parse_macro(inc);
> +
> +		hash = 0;
> +	}
> +
> +	close_include(inc);
> +}
> +
>  static struct data_node *parse_file(const char *fname)
>  {
>  	int state = 0, found = 0;
> @@ -314,14 +489,28 @@ static struct data_node *parse_file(const char *fname)
>  
>  	FILE *f = fopen(fname, "r");
>  
> +	includepath = dirname(strdup(fname));
> +
>  	struct data_node *res = data_node_hash();
>  	struct data_node *doc = data_node_array();
>  
>  	while ((token = next_token(f, doc))) {
> -		if (state < 6 && !strcmp(tokens[state], token))
> +		if (state < 6 && !strcmp(tokens[state], token)) {
>  			state++;
> -		else
> +		} else {
> +			if (token[0] == '#') {
> +				token = next_token(f, doc);
> +				if (token) {
> +					if (!strcmp(token, "define"))
> +						parse_macro(f);
> +
> +					if (!strcmp(token, "include"))
> +						parse_include_macros(f);
> +				}
> +			}
> +
>  			state = 0;
> +		}
>  
>  		if (state < 6)
>  			continue;
> @@ -386,17 +575,42 @@ const char *strip_name(char *path)
>  	return name;
>  }
>  
> +static void print_help(const char *prgname)
> +{
> +	printf("usage: %s [-vh] input.c\n\n", prgname);
> +	printf("-v sets verbose mode\n");
> +	printf("-h prints this help\n\n");
> +	exit(0);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	unsigned int i, j;
>  	struct data_node *res;
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "hv")) != -1) {
> +		switch (opt) {
> +		case 'h':
> +			print_help(argv[0]);
> +		break;
> +		case 'v':
> +			verbose = 1;
> +		break;
> +		}
> +	}
> +
> +	if (optind >= argc) {
> +		fprintf(stderr, "No input filename.c\n");
> +		return 1;
> +	}
>  
> -	if (argc != 2) {
> -		fprintf(stderr, "Usage: docparse filename.c\n");
> +	if (!hcreate(128)) {
> +		fprintf(stderr, "Failed to initialize hash table\n");
>  		return 1;
>  	}
>  
> -	res = parse_file(argv[1]);
> +	res = parse_file(argv[optind]);
>  	if (!res)
>  		return 0;
>  
> @@ -425,8 +639,8 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	data_node_hash_add(res, "fname", data_node_string(argv[1]));
> -	printf("  \"%s\": ", strip_name(argv[1]));
> +	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
> +	printf("  \"%s\": ", strip_name(argv[optind]));
>  	data_to_json(res, stdout, 2);
>  	data_node_free(res);
>  
> -- 
> 2.32.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
