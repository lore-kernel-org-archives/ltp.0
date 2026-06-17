Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0ACD98E4
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 14:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7183A3E6BFB
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 16:46:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEDBA3E5920
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 16:46:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17E8B1000A21
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 16:46:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E8FA6C185;
 Wed, 17 Jun 2026 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781707600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNxX4Z+/0O8FVrOdFy9XRRyGJwrvZ3OGue004jO2sGg=;
 b=o8yPTQfDlSmAn47vjXPAp1WSqISwXAYHZeB0g1mnJJA99yzumkH+ijVXYUfFnUuk0t/nj9
 U+vxcDs6T4QbaorUjREJ6cUju7eJ8Ex7NhYVEta+DRoEpbPbCsXGTfa5/LLogU6O5Q7IaV
 II/dC23AEO+iFf5/lbcy/vNBBYebV2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781707600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNxX4Z+/0O8FVrOdFy9XRRyGJwrvZ3OGue004jO2sGg=;
 b=TnnVmYEPu1sbjjPUOTdNBWpe3Buw66k26xBg1C2zU9l5Zw5/AGCw6aB1BCn/1KorjKLI4H
 Ig7q4+plm4UBZNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781707600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNxX4Z+/0O8FVrOdFy9XRRyGJwrvZ3OGue004jO2sGg=;
 b=o8yPTQfDlSmAn47vjXPAp1WSqISwXAYHZeB0g1mnJJA99yzumkH+ijVXYUfFnUuk0t/nj9
 U+vxcDs6T4QbaorUjREJ6cUju7eJ8Ex7NhYVEta+DRoEpbPbCsXGTfa5/LLogU6O5Q7IaV
 II/dC23AEO+iFf5/lbcy/vNBBYebV2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781707600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNxX4Z+/0O8FVrOdFy9XRRyGJwrvZ3OGue004jO2sGg=;
 b=TnnVmYEPu1sbjjPUOTdNBWpe3Buw66k26xBg1C2zU9l5Zw5/AGCw6aB1BCn/1KorjKLI4H
 Ig7q4+plm4UBZNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C546779A8;
 Wed, 17 Jun 2026 14:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QgKNBVCzMmosMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jun 2026 14:46:40 +0000
Date: Wed, 17 Jun 2026 16:46:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajKzKA_ROAlfBDys@rei.lan>
References: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
 <20260612-metadata_groups-v1-1-d7a24a7ac7a8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260612-metadata_groups-v1-1-d7a24a7ac7a8@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metadata: add tests grouping support
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
> 1. Source file path - the two nearest parent directories (immediate
>    parent first), skipping 'kernel' as too generic. For example:
>    - testcases/kernel/syscalls/clone/clone01.c -> clone, syscalls
>    - testcases/kernel/kvm/kvm_pagefault01.c -> kvm
>    - testcases/cve/cve-2017-16939.c -> cve
> 
> 2. @group tags in the doc comment block, e.g.:
>    /*    * Test description.
>     *
>     * @group stress

Maybe call it groups and allow white-space separated list?

I'm not really sure about the syntax, but I guess that @groups foo bar
will do.

>     */
> 
> Add test case for @group tag parsing.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  metadata/metaparse.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++
>  metadata/tests/groups.c      | 11 ++++++
>  metadata/tests/groups.c.json | 13 +++++++
>  3 files changed, 112 insertions(+)
> 
> diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> index 561cbb9d2d54689988c9aa49d591628696bcf847..6bc4b7af60c7449d4b60a1252fa58fed77e03066 100644
> --- a/metadata/metaparse.c
> +++ b/metadata/metaparse.c
> @@ -1168,6 +1168,92 @@ static void print_help(const char *prgname)
>  	exit(0);
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
> +	char buf[256];
> +	int offsets[8];
> +	int ndirs = 0;
> +	int ngroups = 0;
> +	char *p;
> +
> +	if (strncmp(fname, "testcases/", 10))
> +		return;
> +
> +	snprintf(buf, sizeof(buf), "%s", fname + 10);

Maybe avoid static buffers here with:

	buf = strdup(fname + 10);

> +	p = strtok(buf, "/");
> +	while (p && ndirs < 8) {
> +		offsets[ndirs++] = p - buf;

Why do we store offset rather than the pointer to the string?

		dirs[ndirs++] = p;

> +		p = strtok(NULL, "/");
> +	}
> +
> +	/* Last element is the filename, skip it */
> +	ndirs--;
> +
> +	for (int j = ndirs - 1; j >= 0 && ngroups < 2; j--) {
> +		if (!strcmp(buf + offsets[j], "kernel"))
> +			continue;
> +
> +		data_node_array_add(groups, data_node_string(buf + offsets[j]));
> +		ngroups++;
> +	}

We can avoid the complex loop by adding a function to add the group with
the "kernel" filter and just calling it twice here:

	add_group(groups, dirs[ndirs-1]);
	add_group(groups, dirs[ndirs-2]);

> +}
> +
> +/*
> + * Add groups from @group tags in the doc comment block.
> + */
> +static void add_doc_groups(struct data_node *groups, struct data_node *doc)
> +{
> +	if (!doc || doc->type != DATA_ARRAY)
> +		return;
> +
> +	for (unsigned int i = 0; i < data_node_array_len(doc); i++) {
> +		struct data_node *line = doc->array.array[i];
> +		const char *s;
> +
> +		if (line->type != DATA_STRING)
> +			continue;
> +
> +		s = line->string.val;
> +
> +		while (*s && (*s == ' ' || *s == '\t'))
> +			s++;
> +
> +		if (strncmp(s, "@group ", 7))
> +			continue;
> +
> +		s += 7;
> +		while (*s && (*s == ' ' || *s == '\t'))
> +			s++;
> +
> +		if (*s)
> +			data_node_array_add(groups, data_node_string(s));
> +	}

If we hook up into the multiline_comment() function we can consume the
line as well so that it does not appear in the parsed doc string. We
would have to pass the groups node from the main all the way to
multiline_comment() something as (uncomplete):

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 561cbb9d2..441eeb80b 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -50,7 +50,12 @@ static const char *eat_asterisk_space(const char *c)
        return c;
 }

-static void multiline_comment(FILE *f, struct data_node *doc)
+static int parse_groups(struct data_node *groups, char *line)
+{
+       ...
+}
+
+static void multiline_comment(FILE *f, struct data_node *doc, struct data_node *groups)
 {
        int c;
        int state = 0;
@@ -65,8 +70,11 @@ static void multiline_comment(FILE *f, struct data_node *doc)
                                struct data_node *line;
                                buf[bufp] = 0;
                                line = data_node_string(eat_asterisk_space(buf));
-                               if (data_node_array_add(doc, line))
-                                       WARN("doc string comment truncated");
+
+                               if (!parse_groups(groups, line)) {
+                                       if (data_node_array_add(doc, line))
+                                               WARN("doc string comment truncated");
+                               }
                                bufp = 0;
                                continue;
                        }
@@ -100,7 +108,7 @@ static void multiline_comment(FILE *f, struct data_node *doc)

 static const char doc_prefix[] = "\\\n";

-static void maybe_doc_comment(FILE *f, struct data_node *doc)
+static void maybe_doc_comment(FILE *f, struct data_node *doc, struct data_groups *groups)
 {
        int c, i;

@@ -113,14 +121,14 @@ static void maybe_doc_comment(FILE *f, struct data_node *doc)
                if (c == '*')
                        ungetc(c, f);

-               multiline_comment(f, NULL);
+               multiline_comment(f, NULL, NULL);
                return;
        }

-       multiline_comment(f, doc);
+       multiline_comment(f, doc, groups);
 }

-static void maybe_comment(FILE *f, struct data_node *doc)
+static void maybe_comment(FILE *f, struct data_node *doc, struct data_node *groups)
 {
        int c = getc(f);

@@ -129,7 +137,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
                remove_to_newline(f);
        break;
        case '*':
-               maybe_doc_comment(f, doc);
+               maybe_doc_comment(f, doc, groups);
        break;
        default:
                ungetc(c, f);
@@ -194,7 +202,7 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
                        buf[i++] = c;
                break;
                case '/':
-                       maybe_comment(f, doc);
+                       maybe_comment(f, doc, groups);
                break;
                case '"':
                        in_str = 1;


> +}
> +
> +static void build_groups(struct data_node *res, const char *fname)
> +{
> +	struct data_node *groups = data_node_array();
> +
> +	add_path_groups(groups, fname);
> +	add_doc_groups(groups, data_node_hash_get(res, "doc"));
> +
> +	if (data_node_array_len(groups))
> +		data_node_hash_add(res, "groups", groups);
> +	else
> +		data_node_free(groups);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	unsigned int i, j;
> @@ -1238,6 +1324,8 @@ int main(int argc, char *argv[])
>  	}
>  
>  	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
> +	build_groups(res, argv[optind]);
> +
>  	printf("  \"%s\": ", strip_name(argv[optind]));
>  	data_to_json(res, stdout, 2);
>  	data_node_free(res);
> diff --git a/metadata/tests/groups.c b/metadata/tests/groups.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..82f07111c1506c634f13822ee6aa95f574eb19a5
> --- /dev/null
> +++ b/metadata/tests/groups.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*\
> + * Test for @group tag parsing.
> + *
> + * @group stress
> + * @group regression
> + */
> +
> +static struct tst_test test = {
> +};
> diff --git a/metadata/tests/groups.c.json b/metadata/tests/groups.c.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..4683e6cf07eeebc60faefb9aead9370dc3f631aa
> --- /dev/null
> +++ b/metadata/tests/groups.c.json
> @@ -0,0 +1,13 @@
> +  "groups": {
> +   "doc": [
> +    "Test for @group tag parsing.",
> +    "",
> +    "@group stress",
> +    "@group regression"
> +   ],
> +   "fname": "groups.c",
> +   "groups": [
> +    "stress",
> +    "regression"
> +   ]
> +  }
> \ No newline at end of file
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
