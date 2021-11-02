Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA8CC433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:47:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6F360EE3
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B6F360EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3A63C71AC
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:46:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1F0D3C56FB
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:46:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9F0B6001F2
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:46:46 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 209AC21639
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635853606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yyXXAXEvbIKwmNP/HiHt5HN30H894MI9zSIEtS9IVWA=;
 b=vhwVmLZxkZEr6H3bc4wk4hPUQX/xi1IF17tjQY3Kw3lj9nkdFrWOrCjC+uMPpD+OaKi2rp
 +29u3abwaZAelDgWr6G96aURLNRdeWE+cscR/3v5c71v7U0A4epyNxq3q7TBf5/4y5ZoCy
 PrbYZ9c8ED53WEd4VuAFQY/yEtHqWIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635853606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yyXXAXEvbIKwmNP/HiHt5HN30H894MI9zSIEtS9IVWA=;
 b=2g9GVaqh6xt/cMwhFPrz/oJ5EKjdPLQ5UNCx82oUqNienOdUZ8sKUCc6AANQvP9vsH5sfp
 R+yMsG4gWx6x8GBw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 96F04A3B84;
 Tue,  2 Nov 2021 11:46:45 +0000 (UTC)
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-5-chrubis@suse.cz>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 02 Nov 2021 11:39:21 +0000
In-reply-to: <20211101145342.7166-5-chrubis@suse.cz>
Message-ID: <87o872ok4b.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/7] docparse: Implement ARRAY_SIZE()
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Adds a special handlingn for ARRAY_SIZE() macro.
>
> If we stumble upon ARRAY_SIZE() in the tst_test structure we try to
> lookup the array and count its members.
>
> Proper parsing of .test_variants also requires that we add -I switch to
> the docparse to be able to specify include paths on a command line since
> some variants are stuck in top level include while others are in
> testcases/kernel/syscalls/utils/.
>
> + tests
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Again I don't see anything that would presently prevent parsing. But see
note below

Reviewed-by: rpalethorpe@suse.com

> ---
>  docparse/docparse.c                | 221 ++++++++++++++++++++++++++---
>  docparse/parse.sh                  |   2 +-
>  docparse/tests/array_size01.c      |   5 +
>  docparse/tests/array_size01.c.json |   4 +
>  docparse/tests/array_size02.c      |   9 ++
>  docparse/tests/array_size02.c.json |   4 +
>  docparse/tests/array_size03.c      |  10 ++
>  docparse/tests/array_size03.c.json |   4 +
>  docparse/tests/array_size04.c      |   5 +
>  docparse/tests/array_size04.c.json |   4 +
>  docparse/tests/include.h           |   6 +
>  11 files changed, 255 insertions(+), 19 deletions(-)
>  create mode 100644 docparse/tests/array_size01.c
>  create mode 100644 docparse/tests/array_size01.c.json
>  create mode 100644 docparse/tests/array_size02.c
>  create mode 100644 docparse/tests/array_size02.c.json
>  create mode 100644 docparse/tests/array_size03.c
>  create mode 100644 docparse/tests/array_size03.c.json
>  create mode 100644 docparse/tests/array_size04.c
>  create mode 100644 docparse/tests/array_size04.c.json
>
> diff --git a/docparse/docparse.c b/docparse/docparse.c
> index 64f9d08d9..9133accf5 100644
> --- a/docparse/docparse.c
> +++ b/docparse/docparse.c
> @@ -15,7 +15,11 @@
>  
>  #include "data_storage.h"
>  
> +#define INCLUDE_PATH_MAX 5
> +
>  static int verbose;
> +static char *cmdline_includepath[INCLUDE_PATH_MAX];
> +static unsigned int cmdline_includepaths;
>  static char *includepath;
>  
>  #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
> @@ -132,13 +136,14 @@ static void maybe_comment(FILE *f, struct data_node *doc)
>  	}
>  }
>  
> -static char *next_token(FILE *f, struct data_node *doc)
> +static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *doc)
>  {
>  	size_t i = 0;
> -	static char buf[4096];
>  	int c;
>  	int in_str = 0;
>  
> +	buf_len--;
> +
>  	for (;;) {
>  		c = fgetc(f);
>  
> @@ -151,7 +156,8 @@ static char *next_token(FILE *f, struct data_node *doc)
>  					goto exit;
>  			}
>  
> -			buf[i++] = c;
> +			if (i < buf_len)
> +				buf[i++] = c;
>  			continue;
>  		}
>  
> @@ -171,7 +177,8 @@ static char *next_token(FILE *f, struct data_node *doc)
>  				goto exit;
>  			}
>  
> -			buf[i++] = c;
> +			if (i < buf_len)
> +				buf[i++] = c;
>  			goto exit;
>  		case '0' ... '9':
>  		case 'a' ... 'z':
> @@ -204,11 +211,33 @@ exit:
>  	return buf;
>  }
>  
> -static FILE *open_include(const char *includepath, FILE *f)
> +static char *next_token(FILE *f, struct data_node *doc)
> +{
> +	static char buf[4096];
> +
> +	return next_token2(f, buf, sizeof(buf), doc);
> +}
> +
> +static FILE *open_file(const char *dir, const char *fname)
>  {
> -	char buf[256];
> +	FILE *f;
>  	char *path;
> +
> +	if (asprintf(&path, "%s/%s", dir, fname) < 0)
> +		return NULL;
> +
> +	f = fopen(path, "r");
> +
> +	free(path);
> +
> +	return f;
> +}
> +
> +static FILE *open_include(FILE *f)
> +{
> +	char buf[256], *fname;
>  	FILE *inc;
> +	unsigned int i;
>  
>  	if (!fscanf(f, "%s\n", buf))
>  		return NULL;
> @@ -216,24 +245,36 @@ static FILE *open_include(const char *includepath, FILE *f)
>  	if (buf[0] != '"')
>  		return NULL;
>  
> -	char *filename = buf + 1;
> +	fname = buf + 1;
>  
>  	if (!buf[0])
>  		return NULL;
>  
> -	filename[strlen(filename)-1] = 0;
> +	fname[strlen(fname)-1] = 0;
>  
> -	if (asprintf(&path, "%s/%s", includepath, filename) < 0)
> -		return NULL;
> +	inc = open_file(includepath, fname);
> +	if (inc) {
> +		if (verbose)
> +			fprintf(stderr, "INCLUDE %s/%s\n", includepath, fname);
>  
> -	inc = fopen(path, "r");
> +		return inc;
> +	}
>  
> -	if (inc && verbose)
> -		fprintf(stderr, "INCLUDE %s\n", path);
> +	for (i = 0; i < cmdline_includepaths; i++) {
> +		inc = open_file(cmdline_includepath[i], fname);
>  
> -	free(path);
> +		if (!inc)
> +			continue;
>  
> -	return inc;
> +		if (verbose) {
> +			fprintf(stderr, "INCLUDE %s/%s\n",
> +				cmdline_includepath[i], fname);
> +		}
> +
> +		return inc;
> +	}
> +
> +	return NULL;
>  }
>  
>  static void close_include(FILE *inc)
> @@ -300,6 +341,136 @@ static void try_apply_macro(char **res)
>  	*res = ret->data;
>  }
>  
> +static int parse_get_array_len(FILE *f)
> +{
> +	const char *token;
> +	int cnt = 0, depth = 0, prev_comma = 0;
> +
> +	if (!(token = next_token(f, NULL)))
> +		return 0;
> +
> +	if (strcmp(token, "{"))
> +		return 0;
> +
> +	for (;;) {
> +		if (!(token = next_token(f, NULL)))
> +			return 0;
> +
> +		if (!strcmp(token, "{"))
> +			depth++;
> +
> +		if (!strcmp(token, "}"))
> +			depth--;
> +		else
> +			prev_comma = 0;
> +
> +		if (!strcmp(token, ",") && !depth) {
> +			prev_comma = 1;
> +			cnt++;
> +		}
> +
> +		if (depth < 0)
> +			return cnt + !prev_comma;
> +	}
> +}
> +
> +static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **res)
> +{
> +	const char *token;
> +	char buf[2][2048] = {};
> +	int cur_buf = 0;
> +	int prev_buf = 1;
> +
> +	for (;;) {
> +		if (!(token = next_token2(f, buf[cur_buf], 2048, NULL)))
> +			break;
> +
> +		if (!strcmp(token, "=") && !strcmp(buf[prev_buf], arr_id)) {
> +			int arr_len = parse_get_array_len(f);
> +
> +			if (verbose)
> +				fprintf(stderr, "ARRAY %s LENGTH = %i\n", arr_id, arr_len);
> +
> +			*res = data_node_int(arr_len);
> +
> +			break;
> +		}
> +
> +		if (strcmp(buf[cur_buf], "]") && strcmp(buf[cur_buf], "[")) {

So this seems to mean we would silently ignore a variants array which
was declared with an explicit size. A quick grep doesn't turn up any
instances of that. However this would be an unexpected result. People
may intuitively think adding an explicity size would make parsing
easier.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
