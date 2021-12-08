Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5582FC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 17:06:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C1503C7399
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 18:06:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843503C0480
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 18:05:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7CE4D1000A3A
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 18:05:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 933A31FD2A;
 Wed,  8 Dec 2021 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638983151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kznRVPCX1QcZ41uB6fwKjb9XPY3LKLda7tAAgr6Tg0c=;
 b=QMJC4j5k8ty1d5z5MQ0JCTnYgGE2pk6r12OpD7K49FyYO5v/bzZ3ugcaPgrX2hnDnOrSu5
 eQ4Ok+DGRMDenK7NTT/aIQaMO1Td4+Wjc4vmw9tofc964niBkEFPvb2nHik1ZdvW6U0AVd
 4+OFwZ0MwDMCT10i6XLJOC/Jh95UgMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638983151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kznRVPCX1QcZ41uB6fwKjb9XPY3LKLda7tAAgr6Tg0c=;
 b=HPi+1YbGvQMU3ZeaQg7LWhTXsbMDKuLAaFpLeotm3hP/wS2fewYvIEfNScL0OhM9BbzgYj
 uRYAi90yYmiUQAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692FA13B72;
 Wed,  8 Dec 2021 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YcD+F+/lsGEXBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Dec 2021 17:05:51 +0000
Date: Wed, 8 Dec 2021 18:05:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbDl7YtVZvYXPxwp@pevik>
References: <Ya4DeVrCa1X8IFjk@yuki>
 <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] library: add cmd check handler in
 needs_cmds
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu, Cyril,

> Testcase ie statx05 needs mkfs.ext4 >= 1.43.0 because of encrypt feature.

> As Cyril suggested, add cmd check handler in needs_cmd.

Great idea, I have something like this in my TODO list as well, glad I can
delete it :).

> We don't use tst_ prefix ie tst_check_cmd since we don't export this api to user.
> This check_cmd not only check cmd whether existed but also check the cmd version whether
> meet test's requirement.

> In check_cmd function, use strtok_r to split cmd_token,op_token,version_token.
> It only supports six operations '>=' '<=' '>' '<' '==' '!='.

> Currently, for the command version check, it only supports  mkfs.ext4 command. If you
> want to support more commands, just add your own .parser and .table_get methond in
> version_parsers structure.

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v1->v2
> 1. rename tst_version_parser to check_cmd
Why not tst_cmd_check(), i.e. using tst_ prefix?

+1 for moving it into tst_cmd.c.


> 2. For mkfs_ext4_version_table_get method, use sscanf instead of strtok_r
> 3. use enum for cmd op
> 4. fix description
> 5. add more newlib test for this
>  doc/c-test-api.txt                   |  14 +++
>  lib/newlib_tests/.gitignore          |   8 ++
>  lib/newlib_tests/test_needs_cmds01.c |  25 ++++
>  lib/newlib_tests/test_needs_cmds02.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds03.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds04.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds05.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds06.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds07.c |  24 ++++
>  lib/newlib_tests/test_needs_cmds08.c |  27 +++++
Also, could you please put tests which expect TPASS or TCONF into
lib/newlib_tests/runtest.sh?


> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index a79275722..7cca209ab 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -65,6 +65,15 @@ struct results {
>  	unsigned int timeout;
>  };

> +enum cmd_op {
> +	OP_GE, /* >= */
> +	OP_GT, /* >  */
> +	OP_LE, /* <= */
> +	OP_LT, /* <  */
> +	OP_EQ, /* == */
> +	OP_NE, /* != */
> +};
> +
>  static struct results *results;

>  static int ipc_fd;
> @@ -950,6 +959,162 @@ static void prepare_device(void)
>  	}
>  }

> +static int mkfs_ext4_version_parser(void)
> +{
> +	FILE *f;
> +	int rc, major, minor, patch;
> +
> +	f = popen("mkfs.ext4 -V 2>&1", "r");
> +	if (!f) {
> +		tst_res(TWARN, "Could not run mkfs.ext4 -V 2>&1 cmd");
> +		return -1;
> +	}
> +	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);

I guess many functions will have X.Y.Z format. Maybe later we could have generic
functions similar to kernel SYSCALL_DEFINEn() macros, passing them just
necessary format string.  At least that was what I had in my mind when thinking
about this.

> +	pclose(f);
> +	if (rc != 3) {
> +		tst_res(TWARN, "Unable to parse mkfs.ext4 version");
> +		return -1;
> +	}
> +
> +	return major * 10000 +  minor * 100 + patch;
> +}
> +
> +static int mkfs_ext4_version_table_get(char *version)
> +{
> +	int major, minor, patch;
> +	int len;
> +
> +	if (sscanf(version, "%u.%u.%u %n", &major, &minor, &patch, &len) != 3) {
> +		tst_res(TWARN, "Illega version(%s), "
typo s/Illega/Illegal/

> +			"should use format like 1.43.0", version);
nit: I'd keep string on single line (easier to grep and it's not too long being
on single line like the others below).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
