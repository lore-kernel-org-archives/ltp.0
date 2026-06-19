Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08386CD4F26
	for <ltp@archiver.kernel.org>; Fri, 19 Jun 2026 08:40:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9F983E2AC7
	for <ltp@archiver.kernel.org>; Fri, 19 Jun 2026 10:40:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B40E53CACC7
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 10:40:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C18E11000DEA
 for <ltp@lists.linux.it>; Fri, 19 Jun 2026 10:40:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3A5675EFC;
 Fri, 19 Jun 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B12CB779A8;
 Fri, 19 Jun 2026 08:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1oouKnoANWokQQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Jun 2026 08:40:26 +0000
Date: Fri, 19 Jun 2026 10:40:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajUAfFOaQgGJejCW@yuki.lan>
References: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
 <20260618-metadata_groups-v2-1-6ab298932233@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260618-metadata_groups-v2-1-6ab298932233@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C3A5675EFC
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] metadata: add tests grouping support
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  metadata/metaparse.c         | 159 +++++++++++++++++++++++++++++++++++--------
>  metadata/tests/groups.c      |  11 +++
>  metadata/tests/groups.c.json |  12 ++++
>  3 files changed, 152 insertions(+), 30 deletions(-)
> 
> diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> index 561cbb9d2d54689988c9aa49d591628696bcf847..94e795c275aebda41737558d06f7d9c8c1a2f4f7 100644
> --- a/metadata/metaparse.c
> +++ b/metadata/metaparse.c
> @@ -17,6 +17,7 @@
>  #include "data_storage.h"
>  
>  #define INCLUDE_PATH_MAX 5
> +#define GROUPS_TAG "groups"
>  
>  static int verbose;
>  static char *cmdline_includepath[INCLUDE_PATH_MAX];
> @@ -50,7 +51,49 @@ static const char *eat_asterisk_space(const char *c)
>  	return c;
>  }
>  
> -static void multiline_comment(FILE *f, struct data_node *doc)
> +/*
> + * Add a group to the groups array, skipping 'kernel' as it's too generic.
> + * Returns 0 if no group was added, 1 otherwise.
> + */
> +static int add_group(struct data_node *groups, const char *name)
> +{
> +	if (name && strcmp(name, "kernel")) {
> +		data_node_array_add(groups, data_node_string(name));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Parse a '@groups foo bar baz' doc comment line, adding each
> + * whitespace-separated name to the groups array. Returns 1 if the line
> + * was a @groups tag (and should be consumed), 0 otherwise.
> + */
> +static int parse_groups(struct data_node *groups, char *line)
> +{
> +	char *s;
> +	char *name;
> +
> +	if (!groups)
> +		return 0;
> +
> +	s = (char *)eat_asterisk_space(line);

It's way cleaner to drop the const from the eat_asterisk_space() fuction
than this ugly cast.

> +	if (strncmp(s, GROUPS_TAG, sizeof(GROUPS_TAG) - 1))
> +		return 0;
> +
> +	s += sizeof(GROUPS_TAG) - 1;
> +	if (*s && *s != ' ' && *s != '\t')
> +		return 0;

I guess that we should WARN() here about empty groups tag and return 1
so that it's "consumed".

> +	for (name = strtok(s, " \t"); name; name = strtok(NULL, " \t"))
> +		add_group(groups, name);
> +
> +	return 1;
> +}
> +
> +static void multiline_comment(FILE *f, struct data_node *doc,
> +			      struct data_node *groups)
>  {
>  	int c;
>  	int state = 0;
> @@ -62,12 +105,14 @@ static void multiline_comment(FILE *f, struct data_node *doc)
>  
>  		if (doc) {
>  			if (c == '\n') {
> -				struct data_node *line;
> +				char *str;
>  				buf[bufp] = 0;
> -				line = data_node_string(eat_asterisk_space(buf));
> -				if (data_node_array_add(doc, line))
> -					WARN("doc string comment truncated");
> +				str = (char *)eat_asterisk_space(buf);
>  				bufp = 0;
> +				if (parse_groups(groups, str))
> +					continue;
> +				if (data_node_array_add(doc, data_node_string(str)))
> +					WARN("doc string comment truncated");
>  				continue;
>  			}
>  
> @@ -100,7 +145,8 @@ static void multiline_comment(FILE *f, struct data_node *doc)
>  
>  static const char doc_prefix[] = "\\\n";
>  
> -static void maybe_doc_comment(FILE *f, struct data_node *doc)
> +static void maybe_doc_comment(FILE *f, struct data_node *doc,
> +			      struct data_node *groups)
>  {
>  	int c, i;
>  
> @@ -113,14 +159,15 @@ static void maybe_doc_comment(FILE *f, struct data_node *doc)
>  		if (c == '*')
>  			ungetc(c, f);
>  
> -		multiline_comment(f, NULL);
> +		multiline_comment(f, NULL, NULL);
>  		return;
>  	}
>  
> -	multiline_comment(f, doc);
> +	multiline_comment(f, doc, groups);
>  }
>  
> -static void maybe_comment(FILE *f, struct data_node *doc)
> +static void maybe_comment(FILE *f, struct data_node *doc,
> +			  struct data_node *groups)
>  {
>  	int c = getc(f);
>  
> @@ -129,7 +176,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
>  		remove_to_newline(f);
>  	break;
>  	case '*':
> -		maybe_doc_comment(f, doc);
> +		maybe_doc_comment(f, doc, groups);
>  	break;
>  	default:
>  		ungetc(c, f);
> @@ -137,7 +184,8 @@ static void maybe_comment(FILE *f, struct data_node *doc)
>  	}
>  }
>  
> -static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *doc)
> +static char *next_token2(FILE *f, char *buf, size_t buf_len,
> +			 struct data_node *doc, struct data_node *groups)
>  {
>  	size_t i = 0;
>  	int c;
> @@ -194,7 +242,7 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
>  			buf[i++] = c;
>  		break;
>  		case '/':
> -			maybe_comment(f, doc);
> +			maybe_comment(f, doc, groups);
>  		break;
>  		case '"':
>  			in_str = 1;
> @@ -216,11 +264,11 @@ exit:
>  	return buf;
>  }
>  
> -static char *next_token(FILE *f, struct data_node *doc)
> +static char *next_token(FILE *f, struct data_node *doc, struct data_node *groups)
>  {
>  	static char buf[4096];
>  
> -	return next_token2(f, buf, sizeof(buf), doc);
> +	return next_token2(f, buf, sizeof(buf), doc, groups);
>  }
>  
>  static FILE *open_file(const char *dir, const char *fname)
> @@ -383,7 +431,7 @@ static int array_is_hash(FILE *f)
>  	int in_id = 1;
>  	char *token;
>  
> -	while ((token = next_token(f, NULL))) {
> +	while ((token = next_token(f, NULL, NULL))) {
>  
>  		if (!strcmp(token, "}")) {
>  			if (in_id && !comma_last)
> @@ -402,7 +450,7 @@ static int array_is_hash(FILE *f)
>  			int level = 1;
>  
>  			for (;;) {
> -				token = next_token(f, NULL);
> +				token = next_token(f, NULL, NULL);
>  
>  				if (!token)
>  					goto ret;
> @@ -453,7 +501,7 @@ static int parse_array(FILE *f, const char *arr_id, struct data_node **ret)
>  		*ret = data_node_array();
>  
>  	for (;;) {
> -		if (!(token = next_token(f, NULL)))
> +		if (!(token = next_token(f, NULL, NULL)))
>  			return 1;
>  
>  		if (!strcmp(token, "{")) {
> @@ -529,14 +577,14 @@ static int parse_get_array_len(FILE *f)
>  	const char *token;
>  	int cnt = 0, depth = 0, prev_comma = 0;
>  
> -	if (!(token = next_token(f, NULL)))
> +	if (!(token = next_token(f, NULL, NULL)))
>  		return 0;
>  
>  	if (strcmp(token, "{"))
>  		return 0;
>  
>  	for (;;) {
> -		if (!(token = next_token(f, NULL)))
> +		if (!(token = next_token(f, NULL, NULL)))
>  			return 0;
>  
>  		if (!strcmp(token, "{"))
> @@ -565,7 +613,7 @@ static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **
>  	int prev_buf = 1;
>  
>  	for (;;) {
> -		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL)))
> +		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL, NULL)))
>  			break;
>  
>  		if (!strcmp(token, "=") && !strcmp(buf[prev_buf], arr_id)) {
> @@ -595,13 +643,13 @@ static int parse_array_size(FILE *f, struct data_node **res)
>  
>  	*res = NULL;
>  
> -	if (!(token = next_token(f, NULL)))
> +	if (!(token = next_token(f, NULL, NULL)))
>  		return 1;
>  
>  	if (strcmp(token, "("))
>  		return 1;
>  
> -	if (!(token = next_token(f, NULL)))
> +	if (!(token = next_token(f, NULL, NULL)))
>  		return 1;
>  
>  	arr_id = strdup(token);
> @@ -621,7 +669,7 @@ static int parse_array_size(FILE *f, struct data_node **res)
>  		rewind(f);
>  
>  		for (;;) {
> -			if (!(token = next_token(f, NULL)))
> +			if (!(token = next_token(f, NULL, NULL)))
>  				break;
>  
>  			if (token[0] == '#') {
> @@ -654,7 +702,8 @@ static int parse_array_size(FILE *f, struct data_node **res)
>  	return 0;
>  }
>  
> -static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
> +static int parse_test_struct(FILE *f, struct data_node *doc,
> +			     struct data_node *groups, struct data_node *node)
>  {
>  	char *token;
>  	char *id = NULL;
> @@ -662,7 +711,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
>  	struct data_node *ret;
>  
>  	for (;;) {
> -		if (!(token = next_token(f, doc)))
> +		if (!(token = next_token(f, doc, groups)))
>  			return 1;
>  
>  		if (!strcmp(token, "}"))
> @@ -842,7 +891,7 @@ static void parse_include_macros(FILE *f, int level)
>  	if (!inc)
>  		return;
>  
> -	while ((token = next_token(inc, NULL))) {
> +	while ((token = next_token(inc, NULL, NULL))) {
>  		if (token[0] == '#') {
>  			hash = 1;
>  			continue;
> @@ -907,6 +956,47 @@ static void load_internal_macros(void)
>  		fprintf(stderr, "END PREDEFINED MACROS\n");
>  }
>  
> +/*
> + * Add groups derived from the source file path.
> + *
> + * Groups are the two nearest parent directories (immediate parent
> + * first), skipping 'kernel' as it's too generic:
> + *
> + *   testcases/kernel/syscalls/clone/clone01.c  -> clone, syscalls
> + *   testcases/kernel/kvm/kvm_pagefault01.c     -> kvm
> + *   testcases/cve/cve-2017-16939.c             -> cve
> + */
> +static void add_path_groups(struct data_node *groups, const char *fname)
> +{
> +	char *buf;
> +	char *dirs[8];
> +	int ndirs = 0;
> +	char *p;
> +
> +	if (strncmp(fname, "testcases/", 10))
> +		return;
> +
> +	buf = strdup(fname + 10);
> +	if (!buf)
> +		return;

We should do fprintf(stderr, "Allocation failed!\n"); exit(1); here
instead of silently dropping the tags if the strdup failed.

Maybe we should add ERR() macro that does print a message and calls
exit(1) since we have that pattern in many places, but that is a
completely unrelated refactor.

> +	p = strtok(buf, "/");
> +	while (p && ndirs < 8) {
> +		dirs[ndirs++] = p;
> +		p = strtok(NULL, "/");
> +	}
> +
> +	/* Last element is the filename, skip it */
> +	ndirs--;
> +
> +	if (ndirs >= 1)
> +		add_group(groups, dirs[ndirs - 1]);
> +	if (ndirs >= 2)
> +		add_group(groups, dirs[ndirs - 2]);
> +
> +	free(buf);
> +}
> +
>  static struct data_node *parse_file(const char *fname)
>  {
>  	int state = 0, found = 0;
> @@ -923,15 +1013,18 @@ static struct data_node *parse_file(const char *fname)
>  
>  	struct data_node *res = data_node_hash();
>  	struct data_node *doc = data_node_array();
> +	struct data_node *groups = data_node_array();
> +
> +	add_path_groups(groups, fname);
>  
>  	load_internal_macros();
>  
> -	while ((token = next_token(f, doc))) {
> +	while ((token = next_token(f, doc, groups))) {
>  		if (state < 6 && !strcmp(tokens[state], token)) {
>  			state++;
>  		} else {
>  			if (token[0] == '#') {
> -				token = next_token(f, doc);
> +				token = next_token(f, doc, groups);
>  				if (token) {
>  					if (!strcmp(token, "define"))
>  						parse_macro(f);
> @@ -948,7 +1041,7 @@ static struct data_node *parse_file(const char *fname)
>  			continue;
>  
>  		found = 1;
> -		parse_test_struct(f, doc, res);
> +		parse_test_struct(f, doc, groups, res);
>  	}
>  
>  	if (data_node_array_len(doc)) {
> @@ -958,6 +1051,11 @@ static struct data_node *parse_file(const char *fname)
>  		data_node_free(doc);
>  	}
>  
> +	if (data_node_array_len(groups))
> +		data_node_hash_add(res, "groups", groups);
> +	else
> +		data_node_free(groups);

The fuction that adds groups from path will add at least one group, so
this can be just data_node_hash_add(res, "groups", groups).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
