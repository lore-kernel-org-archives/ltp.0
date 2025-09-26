Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619ACCAC5B9
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D40F3CE0A9
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 11:30:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6418B3CD066
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 11:30:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF1B360095E
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 11:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2C3A5FA61;
 Fri, 26 Sep 2025 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758879033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0NHWbyxQedYluw90pNw+vnY0iF25GY2ZSoCw5iJuoo=;
 b=ET1r4tmrooOExObvIfJ+n0Uw2It4f+nU0OZUgd5aMXCmIWsZha1TIvGSFqLjMqQ9RLLtmd
 31f7HAyiT5OHjtNoTQkZylxYU137t/wMpHd38IcLK0/O9m1jadX5H0m5xx+t5nDqwYkeFp
 OoZlEMCR07f4XdsWw2CcbeWPc+KmLko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758879033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0NHWbyxQedYluw90pNw+vnY0iF25GY2ZSoCw5iJuoo=;
 b=kJln5IcTjPwA/nEqiYdtgifhrummS6vk3TGp7RsHllO6ZA6kYBu0DhQhxnEuJW1IV4p7RV
 kkMQxbY7B2EJ/TAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758879032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0NHWbyxQedYluw90pNw+vnY0iF25GY2ZSoCw5iJuoo=;
 b=eWYjPSW8s4mCtpfI5E88KLPw62Nx9+h8o3HwX4WX96KdbkjSYLEY6RkpXvokCuA25edjVr
 wd3dlfK4H57EGFm/pul7ixMGzVZtIY7aW1n4ffq5VmDIBkqIZH83A2REulPGhB4JYxjghv
 ZLCzeUIg+e++4D6YGhCaEMtD4HRm4LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758879032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0NHWbyxQedYluw90pNw+vnY0iF25GY2ZSoCw5iJuoo=;
 b=NX55jc4YJVXVjwUMz7yPGQm57PrV7oD09sDp8Ebhn26FkzFs4MqIXOvPc/teaH6AE8pjco
 1TgTNFAiSMKYNkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1DAB1386E;
 Fri, 26 Sep 2025 09:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pY0JMjhd1mj0CgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 09:30:32 +0000
Date: Fri, 26 Sep 2025 11:31:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aNZdZlTLXoiXii0N@yuki.lan>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250926085021.22141-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250926085021.22141-2-wegao@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] lib: Add support option for .needs_cmds
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
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_cmd.h     | 15 +++++++
>  include/tst_private.h |  2 +
>  include/tst_test.h    |  2 +-
>  lib/tst_cmd.c         | 98 +++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c        |  9 ++--
>  5 files changed, 121 insertions(+), 5 deletions(-)
> 
> diff --git a/include/tst_cmd.h b/include/tst_cmd.h
> index 939825646..c7e7e56c1 100644
> --- a/include/tst_cmd.h
> +++ b/include/tst_cmd.h
> @@ -5,6 +5,8 @@
>  #ifndef TST_CMD_H__
>  #define TST_CMD_H__
>  
> +#include <stdbool.h>
> +
>  enum tst_cmd_flags {
>  	/*
>  	 * return the program exit code, otherwise it will call cleanup_fn() if the
> @@ -16,6 +18,19 @@ enum tst_cmd_flags {
>  	TST_CMD_TCONF_ON_MISSING = 2,
>  };
>  
> +struct tst_cmd {
> +	const char *cmd;
> +	unsigned int required:1;

Maybe it would make more sense to flip the logic and add an 'optional'
flag here instead. So that for most of the cases we just need to
initialize the cmd member.

> +	unsigned int support:1;
                     ^
		     This should be named 'present' to match the
		     function name.

> +};
> +
> +
> +/*
> + * tst_cmd_present would loop over the tst_cmd array and return the supported flag
> + * value.
> + */
> +bool tst_cmd_present(struct tst_cmd *pcmd, const char *cmd);
> +
>  /*
>   * vfork() + execvp() specified program.
>   *
> diff --git a/include/tst_private.h b/include/tst_private.h
> index 4c6479f4b..d549cf968 100644
> --- a/include/tst_private.h
> +++ b/include/tst_private.h
> @@ -47,4 +47,6 @@ char tst_kconfig_get(const char *confname);
>   */
>  int tst_check_cmd(const char *cmd, const int brk_nosupp);
>  
> +int tst_check_needs_cmds(struct tst_cmd *cmd, const int brk_nosupp);
> +
>  #endif
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 9c21c1728..8fb7cd86c 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -617,7 +617,7 @@ struct tst_fs {
>  
>  	const struct tst_tag *tags;
>  
> -	const char *const *needs_cmds;
> +	struct tst_cmd *needs_cmds;
>  
>  	const enum tst_cg_ver needs_cgroup_ver;
>  
> diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
> index 82d60497a..7457d17c4 100644
> --- a/lib/tst_cmd.c
> +++ b/lib/tst_cmd.c
> @@ -330,3 +330,101 @@ error:
>  
>  	return 1;
>  }
> +
> +int tst_check_needs_cmds(struct tst_cmd *cmd, const int brk_nosupp)
> +{
> +	struct version_parser *p;
> +	char *cmd_token, *op_token, *version_token, *next, *str;
> +	char path[PATH_MAX];
> +	char parser_cmd[100];
> +	int ver_parser, ver_get;
> +
> +	strcpy(parser_cmd, cmd->cmd);
> +
> +	cmd_token = strtok_r(parser_cmd, " ", &next);
> +	op_token = strtok_r(NULL, " ", &next);
> +	version_token = strtok_r(NULL, " ", &next);
> +	str = strtok_r(NULL, " ", &next);
> +
> +	if (tst_get_path(cmd_token, path, sizeof(path)))
> +		if (brk_nosupp)
> +			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		else
> +			goto error;
> +
> +	if (!op_token)
> +		goto pass;
> +
> +	if (!version_token || str) {
> +		tst_brkm(TCONF, NULL,
> +			"Illegal format(%s), should use format like mkfs.ext4 >= 1.43.0",
> +			cmd->cmd);
> +	}
> +
> +	for (p = &version_parsers[0]; p->cmd; p++) {
> +		if (!strcmp(p->cmd, cmd_token)) {
> +			tst_resm(TINFO, "Parsing %s version", p->cmd);
> +			break;
> +		}
> +	}
> +
> +	if (!p->cmd) {
> +		tst_brkm(TBROK, NULL, "No version parser for %s implemented!",
> +			cmd_token);
> +	}
> +
> +	ver_parser = p->parser();
> +	if (ver_parser < 0)
> +		tst_brkm(TBROK, NULL, "Failed to parse %s version", p->cmd);
> +
> +	ver_get = p->table_get(version_token);
> +	if (ver_get < 0)
> +		tst_brkm(TBROK, NULL, "Failed to get %s version", p->cmd);
> +
> +	if (!strcmp(op_token, ">=")) {
> +		if (ver_parser < ver_get)
> +			goto error;
> +	} else if (!strcmp(op_token, ">")) {
> +		if (ver_parser <= ver_get)
> +			goto error;
> +	} else if (!strcmp(op_token, "<=")) {
> +		if (ver_parser > ver_get)
> +			goto error;
> +	} else if (!strcmp(op_token, "<")) {
> +		if (ver_parser >= ver_get)
> +			goto error;
> +	} else if (!strcmp(op_token, "==")) {
> +		if (ver_parser != ver_get)
> +			goto error;
> +	} else if (!strcmp(op_token, "!=")) {
> +		if (ver_parser == ver_get)
> +			goto error;
> +	} else {
> +		tst_brkm(TCONF, NULL, "Invalid op(%s)", op_token);
> +	}
> +pass:
> +	cmd->support = 1;
> +	return 0;
> +error:
> +	cmd->support = 0;
> +	if (brk_nosupp) {
> +		tst_brkm(TCONF, NULL, "%s requires %s %d, but got %d",
> +			cmd, op_token, ver_get, ver_parser);
> +	} else {
> +		tst_resm(TCONF, "%s requires %s %d, but got %d",
> +			cmd, op_token, ver_get, ver_parser);
> +	}
> +
> +	return 1;
> +}

There is no reason add this function at all, we can just call with the
right arguments and get the return value from tst_check_cmd() in the
tst_test.c instead.

> +bool tst_cmd_present(struct tst_cmd *pcmd, const char *cmd)

No need to pass the struct tst_cmd here, we can access it through the
global tst_test pointer instead. Also this function should go to the tst_test.c.

> +{
> +	while (pcmd->cmd) {
> +		if (!strcmp(pcmd->cmd, cmd))
> +			return pcmd->support;
> +
> +		pcmd++;
> +	}
> +	return false;

If we got here we asked for something that wasn't defined in tst_test
structure so here we should do:

tst_res(TBROK, "Invalid cmd request '%s'", cmd);

> +}


> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b8894f782..41519d4e1 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1422,11 +1422,12 @@ static void do_setup(int argc, char *argv[])
>  		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
>  
>  	if (tst_test->needs_cmds) {
> -		const char *cmd;
> -		int i;
> +		struct tst_cmd *cmd = tst_test->needs_cmds;
>  
> -		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
> -			tst_check_cmd(cmd, 1);
> +		while (cmd->cmd) {
> +			tst_check_needs_cmds(cmd,cmd->required);
> +			cmd++;
> +		}
>  	}
>  
>  	if (tst_test->needs_drivers) {
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
