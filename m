Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739EDC433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 10:44:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D847D3C1BC0
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 11:43:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EE453C1A87
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 11:43:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 693D1600737
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 11:43:46 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id ED209210FE;
 Mon,  7 Mar 2022 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646649824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYqq2T7KtAuK5LmluabuQhFWBa7kVWHx1KM720prglE=;
 b=Mht7AiYrlRkajhuNxIGzVJZ+eNdGqjSCdty/WLSO9douFNFLs3776Y4v0Fp+TGySq/JBjP
 uNnPT+2UnY1PBfytLCq5qEJgxIJQoeQQJUTr1t8pEA1usG1FM6Hm8XGjZRB16pPm+xzys3
 SORBq6+srAvJsahYgodhjsC2/Zc4fIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646649824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYqq2T7KtAuK5LmluabuQhFWBa7kVWHx1KM720prglE=;
 b=FMnLdHNrhetRmCY0X9XpgGcwXMI84GblGR1tmUF7GXccII304qdWJVrQzddQUmXXWoAyj6
 8dUdG2SrFwK7M6Ag==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9C8E4A3B9C;
 Mon,  7 Mar 2022 10:43:44 +0000 (UTC)
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 07 Mar 2022 09:05:21 +0000
In-reply-to: <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <871qzeniu7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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

Hello Luke,

Really great work for the patch series in general! However see comments
below.

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> Implement tst_cg_load_config which consumes the state given by
> tst_cg_print_config to update the internal test state to reflect
> the given config.
>
> This allows for programs using the cgroup C API to load and reload
> state, allowing functionality such as calling tst_cg_require and
> tst_cg_cleanup to function properly between programs or between
> invocations of a binary using the C API.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
> v2: Add root null check in parse_root_config.
>     Remove checking for ltp_drain_dir key from config as it was
>     redundant.
>     Remove unsued variable in parse_ctrl_config.
>     Cleanup some compiler warnings.
> v3: Rewrite to consume each line of the config with a scanf to make
>     the parsing much simpler while using new config variables.
>
>  include/tst_cgroup.h |  7 +++++
>  lib/tst_cgroup.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index 87e55f4df..9bad0d366 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -121,6 +121,13 @@ void tst_cg_scan(void);
>   */
>  void tst_cg_print_config(void);
>  
> +/* Load the config printed out by tst_cg_print_config and configure the internal
> + * libary state to match the config. Used to allow tst_cg_cleanup to properly
> + * cleanup mounts and directories created by tst_cg_require between program
> + * invocations.
> + */
> +void tst_cg_load_config(const char *const config);
> +
>  /* Ensure the specified controller is available in the test's default
>   * CGroup, mounting/enabling it if necessary. Usually this is not
>   * necesary use tst_test.needs_cgroup_controllers instead.
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 8f95064b3..90d91d94e 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -366,6 +366,68 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
>  	return NULL;
>  }
>  
> +static void parse_config(const char *const config_entry)

cgroup_parse_config_line perhaps? or cgroup_parse_ctrl?

> +{
> +	const char ctrl_name[32], mnt_path[PATH_MAX],
> test_dir_name[NAME_MAX + 1];

These buffers are not const.

I have lsp and clangd setup in emacs which warns about this. It's easy
to miss the warning in the compiler output.

> +	int ver, we_require_it, we_mounted_it, ltp_dir_we_created_it;
> +	struct cgroup_root *root;
> +	struct cgroup_ctrl *ctrl;
> +
> +	sscanf(config_entry, CONFIG_FORMAT,
> +		ctrl_name, &ver, &we_require_it, mnt_path, &we_mounted_it,
> +		&ltp_dir_we_created_it, test_dir_name);

You need to run 'make check-tst_cgroup' in ltp/lib. The sscanf return
value is not checked which could result in segfaults and other confusing
errors if parsing fails.

> +
> +	if (!(ctrl = cgroup_find_ctrl(ctrl_name)))

check_patch.pl forbids assignments in if statements (it makes static
analysis difficult). Again this is caught with 'make check'.

> +		tst_brk(TBROK, "Could not find ctrl from config. Ctrls changing between calls?");
> +
> +	ctrl->we_require_it = we_require_it;
> +
> +	if (!(root = cgroup_find_root(mnt_path)))
> +		tst_brk(TBROK, "Could not find root from config. Config possibly malformed?");
> +
> +	if (we_mounted_it)
> +		root->we_mounted_it = 1;
> +
> +	if (!root->ltp_dir.dir_name) {
> +		cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
> +		cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
> +		if (ltp_dir_we_created_it) {
> +			root->ltp_dir.we_created_it = 1;
> +			root->drain_dir.we_created_it = 1;
> +		}
> +	}
> +
> +	if (!root->test_dir.dir_name && strcmp(test_dir_name, "NULL")) {
> +		strncpy(cgroup_test_dir, test_dir_name, NAME_MAX);

I think this could result in an unterminated string. strncpy does not
add a null char after the string that was copied. Note also that the
format string passed to sscanf does not limit the field width so it
could overwrite root and ctrl on the stack if the input is long enough.

> +		cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir, &root->test_dir);
> +		root->test_dir.we_created_it = 1;
> +	}
> +}
> +
> +/* Load the test state config provided by tst_cg_print_config
> + *
> + * This will reload some internal tst_cgroup state given by the config
> + * that might otherwise have been lost between calls or between different
> + * processes. In particular this is used by testcases/lib/tst_cgctl to
> + * provide access to this C api to shell scripts.
> + *
> + * The config keeps track of the minimal state needed for tst_cg_cleanup
> + * to cleanup mounts and directories created by tst_cg_require.
> + */
> +void tst_cg_load_config(const char *const config)
> +{
> +	char temp_config[BUFSIZ];
> +	char *line;
> +
> +	if (strlen(config) >= BUFSIZ)
> +		tst_brk(TBROK, "Config has exceeded buffer size?");
> +	strncpy(temp_config, config, BUFSIZ);

Again, this won't copy the null byte from config if strlen(config) ==
BUFSIZ. You could use memcpy here anyway if you know the string length.

> +
> +	line = strtok(temp_config, "\n");
> +	/* Make sure to consume the header. */
> +	for (line = strtok(NULL, "\n"); line; line = strtok(NULL, "\n"))
> +		parse_config(line);
> +}
>  
>  /* Determine if a mounted cgroup hierarchy is unique and record it if so.
>   *


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
