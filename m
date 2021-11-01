Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C5C433F5
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 12:50:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBA560F45
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 12:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEBA560F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 110013C70A2
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 13:50:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D9073C7008
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 13:50:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAF296005CF
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 13:50:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 12B762197B
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635771030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIUPieEZ/F+U5GtWXg5AE45mLZ4lAmd9yPzezl+ftLw=;
 b=wOEpYoHtxo6i0NhGYag9WPF/kwZJRYFWbamzKkifOgyrHQQ5EMlMA/D6EWJdobEcdq1iT2
 gsZsQI2reVw+OKaXJF46RfDTnbMxek1BTSMm2hUWowkC0+l0M8cshaKJxUdQm0TXdDH8SX
 g6hAYulsC/gSqGrH+VKGyPRSR1BOKFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635771030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIUPieEZ/F+U5GtWXg5AE45mLZ4lAmd9yPzezl+ftLw=;
 b=llbwW3G6ELfNeSA+1kcpvItrRn6KDrTGpHOvQUwCfycfvXGR6oM0y/w0D+P+WWMF25scOu
 s5YdOUj/SnlHXMDg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 87245A3B8E;
 Mon,  1 Nov 2021 12:50:29 +0000 (UTC)
References: <20211018154800.11013-1-chrubis@suse.cz>
 <20211018154800.11013-5-chrubis@suse.cz>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 01 Nov 2021 12:36:00 +0000
In-reply-to: <20211018154800.11013-5-chrubis@suse.cz>
Message-ID: <878ry8ox9s.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] docparse: Implement ARRAY_SIZE()
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

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Adds a special handlingn for ARRAY_SIZE() macro.
>
> If we stumble upon ARRAY_SIZE() in the tst_test structure we try to
> lookup the array and count its members.

Note that this is the type of thing Sparse should be able to handle
well. As it should evaluate this to a constant. Although there is the
risk it would be too clever and eliminate some expressions (for
example).

>
> Proper parsing of .test_variants also requires that we add -I switch to
> the docparse to be able to specify include paths on a command line since
> some variants are stuck in top level include while others are in
> testcases/kernel/syscalls/utils/.
>
> + tests
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  docparse/docparse.c               | 222 +++++++++++++++++++++++++++---
>  docparse/parse.sh                 |   2 +-
>  docparse/tests/array_size01.c     |   5 +
>  docparse/tests/array_size01.c.out |   4 +
>  docparse/tests/array_size02.c     |   5 +
>  docparse/tests/array_size02.c.out |   4 +
>  docparse/tests/array_size03.c     |  10 ++
>  docparse/tests/array_size03.c.out |   4 +
>  docparse/tests/array_size04.c     |   5 +
>  docparse/tests/array_size04.c.out |   4 +
>  docparse/tests/include.h          |   6 +
>  11 files changed, 248 insertions(+), 23 deletions(-)
>  create mode 100644 docparse/tests/array_size01.c
>  create mode 100644 docparse/tests/array_size01.c.out
>  create mode 100644 docparse/tests/array_size02.c
>  create mode 100644 docparse/tests/array_size02.c.out
>  create mode 100644 docparse/tests/array_size03.c
>  create mode 100644 docparse/tests/array_size03.c.out
>  create mode 100644 docparse/tests/array_size04.c
>  create mode 100644 docparse/tests/array_size04.c.out
>
> diff --git a/docparse/docparse.c b/docparse/docparse.c
> index cab01c384..9a1ed830c 100644
> --- a/docparse/docparse.c
> +++ b/docparse/docparse.c
> @@ -15,7 +15,12 @@
>  
>  #include "data_storage.h"
>  
> +#define INCLUDE_PATH_MAX 5
> +
>  static int verbose;
> +static char *cmdline_includepath[INCLUDE_PATH_MAX];
> +static unsigned int cmdline_includepaths;
> +static char *includepath;
>  
>  #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
>  
> @@ -131,13 +136,14 @@ static void maybe_comment(FILE *f, struct data_node *doc)
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
> @@ -150,7 +156,8 @@ static char *next_token(FILE *f, struct data_node *doc)
>  					goto exit;
>  			}
>  
> -			buf[i++] = c;
> +			if (i < buf_len)
> +				buf[i++] = c;
>  			continue;
>  		}
>  
> @@ -169,7 +176,8 @@ static char *next_token(FILE *f, struct data_node *doc)
>  				goto exit;
>  			}
>  
> -			buf[i++] = c;
> +			if (i < buf_len)
> +				buf[i++] = c;
>  			goto exit;
>  		case '0' ... '9':
>  		case 'a' ... 'z':
> @@ -178,7 +186,8 @@ static char *next_token(FILE *f, struct data_node *doc)
>  		case '_':
>  		case '-':
>  		case '#':
> -			buf[i++] = c;
> +			if (i < buf_len)
> +				buf[i++] = c;

I suspect you need to remove spaces after '#' (see below).

>  		break;
>  		case '/':
>  			maybe_comment(f, doc);
> @@ -203,11 +212,33 @@ exit:
>  	return buf;
>  }
>  
> -static FILE *open_include(const char *includepath, FILE *f)
> +static char *next_token(FILE *f, struct data_node *doc)
>  {
> -	char buf[256];
> +	static char buf[4096];
> +
> +	return next_token2(f, buf, sizeof(buf), doc);
> +}
> +
> +static FILE *open_file(const char *dir, const char *fname)
> +{
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
> @@ -215,24 +246,36 @@ static FILE *open_include(const char *includepath, FILE *f)
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
> +
> +		if (verbose) {
> +			fprintf(stderr, "INCLUDE %s/%s\n",
> +				cmdline_includepath[i], fname);
> +		}
>  
> -	return inc;
> +		return inc;
> +	}
> +
> +	return NULL;
>  }
>  
>  static void close_include(FILE *inc)
> @@ -299,6 +342,127 @@ static void try_apply_macro(char **res)
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
> +			cur_buf = !cur_buf;
> +			prev_buf = !prev_buf;
> +		}
> +	}
> +}
> +
> +static int parse_array_size(FILE *f, struct data_node **res)
> +{
> +	const char *token;
> +	char *arr_id;
> +	long pos;
> +
> +	*res = NULL;
> +
> +	if (!(token = next_token(f, NULL)))
> +		return 1;
> +
> +	if (strcmp(token, "("))
> +		return 1;
> +
> +	if (!(token = next_token(f, NULL)))
> +		return 1;
> +
> +	arr_id = strdup(token);
> +
> +	if (verbose)
> +		fprintf(stderr, "COMPUTING ARRAY '%s' LENGHT\n", arr_id);
> +
> +	pos = ftell(f);
> +
> +	rewind(f);
> +
> +	look_for_array_size(f, arr_id, res);
> +
> +	if (!*res) {
> +		FILE *inc;
> +
> +		rewind(f);
> +
> +		for (;;) {
> +			if (!(token = next_token(f, NULL)))
> +				break;
> +
> +			if (!strcmp(token, "#include")) {

Are spaces removed after the '#'?

e.g.

#if X
#  include<Y>
#endif

> +				inc = open_include(f);
> +
> +				if (inc) {
> +					look_for_array_size(inc, arr_id, res);
> +					close_include(inc);
> +				}
> +			}
> +
> +			if (*res)
> +				break;
> +		}
> +	}
> +
> +	free(arr_id);
> +
> +	if (fseek(f, pos, SEEK_SET))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
>  {
>  	char *token;
> @@ -344,11 +508,17 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
>  		if (!strcmp(token, "{")) {
>  			ret = data_node_array();
>  			parse_array(f, ret);
> +		} else if (!strcmp(token, "ARRAY_SIZE")) {
> +			if (parse_array_size(f, &ret))
> +				return 1;
>  		} else {
>  			try_apply_macro(&token);
>  			ret = data_node_string(token);
>  		}
>  
> +		if (!ret)
> +			continue;
> +
>  		const char *key = id;
>  		if (key[0] == '.')
>  			key++;
> @@ -448,12 +618,12 @@ static void parse_macro(FILE *f)
>  	hsearch(e, ENTER);
>  }
>  
> -static void parse_include_macros(const char *includepath, FILE *f)
> +static void parse_include_macros(FILE *f)
>  {
>  	FILE *inc;
>  	const char *token;
>  
> -	inc = open_include(includepath, f);
> +	inc = open_include(f);
>  	if (!inc)
>  		return;
>  
> @@ -477,7 +647,7 @@ static struct data_node *parse_file(const char *fname)
>  
>  	FILE *f = fopen(fname, "r");
>  
> -	const char *includepath = dirname(strdup(fname));
> +	includepath = dirname(strdup(fname));
>  
>  	struct data_node *res = data_node_hash();
>  	struct data_node *doc = data_node_array();
> @@ -491,7 +661,7 @@ static struct data_node *parse_file(const char *fname)
>  					parse_macro(f);
>  
>  				if (!strcmp(token, "#include"))
> -					parse_include_macros(includepath, f);
> +					parse_include_macros(f);
>  			}
>  
>  			state = 0;
> @@ -504,7 +674,6 @@ static struct data_node *parse_file(const char *fname)
>  		parse_test_struct(f, doc, res);
>  	}
>  
> -
>  	if (data_node_array_len(doc)) {
>  		data_node_hash_add(res, "doc", doc);
>  		found = 1;
> @@ -564,6 +733,7 @@ static void print_help(const char *prgname)
>  {
>  	printf("usage: %s [-vh] input.c\n\n", prgname);
>  	printf("-v sets verbose mode\n");
> +	printf("-I add include path\n");
>  	printf("-h prints this help\n\n");
>  	exit(0);
>  }
> @@ -574,11 +744,19 @@ int main(int argc, char *argv[])
>  	struct data_node *res;
>  	int opt;
>  
> -	while ((opt = getopt(argc, argv, "hv")) != -1) {
> +	while ((opt = getopt(argc, argv, "hI:v")) != -1) {
>  		switch (opt) {
>  		case 'h':
>  			print_help(argv[0]);
>  		break;
> +		case 'I':
> +			if (cmdline_includepaths >= INCLUDE_PATH_MAX) {
> +				fprintf(stderr, "Too much include paths!");
> +				exit(1);
> +			}
> +
> +			cmdline_includepath[cmdline_includepaths++] = optarg;
> +		break;
>  		case 'v':
>  			verbose = 1;
>  		break;
> diff --git a/docparse/parse.sh b/docparse/parse.sh
> index 79011bc10..2ace34fa0 100755
> --- a/docparse/parse.sh
> +++ b/docparse/parse.sh
> @@ -26,7 +26,7 @@ echo ' "tests": {'
>  first=1
>  
>  for test in `find testcases/ -name '*.c'`; do
> -	a=$($top_builddir/docparse/docparse "$test")
> +	a=$($top_builddir/docparse/docparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
>  	if [ -n "$a" ]; then
>  		if [ -z "$first" ]; then
>  			echo ','
> diff --git a/docparse/tests/array_size01.c b/docparse/tests/array_size01.c
> new file mode 100644
> index 000000000..8a0b9252b
> --- /dev/null
> +++ b/docparse/tests/array_size01.c
> @@ -0,0 +1,5 @@
> +static int variants = {1};

I can see how this might work, but looks odd.

> +
> +static struct tst_test test = {
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/docparse/tests/array_size01.c.out b/docparse/tests/array_size01.c.out
> new file mode 100644
> index 000000000..ec364be12
> --- /dev/null
> +++ b/docparse/tests/array_size01.c.out
> @@ -0,0 +1,4 @@
> +  "array_size01": {
> +   "test_variants": 1,
> +   "fname": "array_size01.c"
> +  }
> \ No newline at end of file
> diff --git a/docparse/tests/array_size02.c b/docparse/tests/array_size02.c
> new file mode 100644
> index 000000000..5c7d4471e
> --- /dev/null
> +++ b/docparse/tests/array_size02.c
> @@ -0,0 +1,5 @@
> +static int variants = {{1}, {2}, {3}};

Should this be variants[]?

> +
> +static struct tst_test test = {
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/docparse/tests/array_size02.c.out b/docparse/tests/array_size02.c.out
> new file mode 100644
> index 000000000..122686952
> --- /dev/null
> +++ b/docparse/tests/array_size02.c.out
> @@ -0,0 +1,4 @@
> +  "array_size02": {
> +   "test_variants": 3,
> +   "fname": "array_size02.c"
> +  }
> \ No newline at end of file
> diff --git a/docparse/tests/array_size03.c b/docparse/tests/array_size03.c
> new file mode 100644
> index 000000000..9058db813
> --- /dev/null
> +++ b/docparse/tests/array_size03.c
> @@ -0,0 +1,10 @@
> +static struct foo variants[] = {
> +#ifdef FOO
> +	{.bar = 11},
> +#endif
> +	{.bar = 10},
> +};
> +
> +static struct tst_test test = {
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/docparse/tests/array_size03.c.out b/docparse/tests/array_size03.c.out
> new file mode 100644
> index 000000000..bb690c9f5
> --- /dev/null
> +++ b/docparse/tests/array_size03.c.out
> @@ -0,0 +1,4 @@
> +  "array_size03": {
> +   "test_variants": 2,
> +   "fname": "array_size03.c"
> +  }
> \ No newline at end of file
> diff --git a/docparse/tests/array_size04.c b/docparse/tests/array_size04.c
> new file mode 100644
> index 000000000..5f1d9986e
> --- /dev/null
> +++ b/docparse/tests/array_size04.c
> @@ -0,0 +1,5 @@
> +#include "include.h"
> +
> +static struct tst_test test = {
> +	.test_variants = ARRAY_SIZE(variants),
> +};
> diff --git a/docparse/tests/array_size04.c.out b/docparse/tests/array_size04.c.out
> new file mode 100644
> index 000000000..6b8d41792
> --- /dev/null
> +++ b/docparse/tests/array_size04.c.out
> @@ -0,0 +1,4 @@
> +  "array_size04": {
> +   "test_variants": 3,
> +   "fname": "array_size04.c"
> +  }
> \ No newline at end of file
> diff --git a/docparse/tests/include.h b/docparse/tests/include.h
> index efa11d24f..fbc69a561 100644
> --- a/docparse/tests/include.h
> +++ b/docparse/tests/include.h
> @@ -1 +1,7 @@
>  #define TEST_VARIANTS 10
> +
> +static struct variants[] = {
> +	{.bar = 10},
> +	{.bar = 11},
> +	{.bar = 12}
> +};
> -- 
> 2.32.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
