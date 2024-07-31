Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE471C3DA7F
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 08:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6127F3D1E52
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 10:07:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAC053D1097
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 10:07:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D0A8D14052DC
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 10:07:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62F5B21DEE;
 Wed, 31 Jul 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D48261368F;
 Wed, 31 Jul 2024 08:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ok/IMLXwqWbXAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jul 2024 08:07:17 +0000
Date: Wed, 31 Jul 2024 10:07:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20240731080718.GA1412835@pevik>
References: <20240730211922.3648849-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240730211922.3648849-1-edliaw@google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 62F5B21DEE
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_core02: Requires cgroup2 mounted with
 nsdelegate
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, all,

Merged (with few changes below), thank you!

> If cgroup2 is not mounted with the nsdelegate option, this test will
> fail.  It has been patched in kselftests, but has not been ported to LTP
> yet.  This adds an additional tst_test configuration option,
> needs_cgroup_nsdelegate, to check for the mount option.

I mentioned also the kernel commit 4793cb599b1b ("selftests: cgroup: skip
test_cgcore_lesser_ns_open when cgroup2 mounted without nsdelegate")

> Link: https://lore.kernel.org/linux-kernel/Zg2xPtwFvT-lsSJX@slm.duckdns.org/T/
> Link: https://www.mail-archive.com/canonical-ubuntu-qa@lists.launchpad.net/msg02400.html
> Signed-off-by: Edward Liaw <edliaw@google.com>

...
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 6c76f043d..af622e507 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -578,6 +578,8 @@ struct tst_fs {
>  	const enum tst_cg_ver needs_cgroup_ver;

>  	const char *const *needs_cgroup_ctrls;
> +
> +	int needs_cgroup_nsdelegate:1;
New member also needs to be documented above:

 *
 * @needs_cgroup_nsdelegate: If set test the will run only if cgroup2 is mounted
 *                           with nsdelegate option.

I added this before merge.

>  };

>  /**
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index f6afb51d6..b18efffed 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -71,6 +71,8 @@ struct cgroup_root {
>  	/* CGroup for current test. Which may have children. */
>  	struct cgroup_dir test_dir;

> +	int nsdelegate:1;
> +
>  	int we_mounted_it:1;
>  	/* cpuset is in compatability mode */
>  	int no_cpuset_prefix:1;
> @@ -344,6 +346,11 @@ static int cgroup_v1_mounted(void)
>  	return !!roots[1].ver;
>  }

> +static int cgroup_v2_nsdelegate(void)
> +{
> +	return !!roots[0].nsdelegate;
> +}
> +
>  static int cgroup_mounted(void)
>  {
>  	return cgroup_v2_mounted() || cgroup_v1_mounted();
> @@ -568,6 +575,7 @@ static void cgroup_root_scan(const char *const mnt_type,
>  	struct cgroup_ctrl *ctrl;
>  	uint32_t ctrl_field = 0;
>  	int no_prefix = 0;
> +	int nsdelegate = 0;
>  	char buf[BUFSIZ];
>  	char *tok;
>  	const int mnt_dfd = SAFE_OPEN(mnt_dir, O_PATH | O_DIRECTORY);
> @@ -582,6 +590,9 @@ static void cgroup_root_scan(const char *const mnt_type,
>  		if (const_ctrl)
>  			add_ctrl(&ctrl_field, const_ctrl);
>  	}
> +	for (tok = strtok(mnt_opts, ","); tok; tok = strtok(NULL, ",")) {
> +		nsdelegate |= !strcmp("nsdelegate", tok);
> +	}

>  	if (root->ver && ctrl_field == root->ctrl_field)
>  		goto discard;
> @@ -632,6 +643,7 @@ backref:
>  	root->mnt_dir.dir_fd = mnt_dfd;
>  	root->ctrl_field = ctrl_field;
>  	root->no_cpuset_prefix = no_prefix;
> +	root->nsdelegate = nsdelegate;

>  	for_each_ctrl(ctrl) {
>  		if (has_ctrl(root->ctrl_field, ctrl))
> @@ -869,6 +881,11 @@ void tst_cg_require(const char *const ctrl_name,

>  mkdirs:
>  	root = ctrl->ctrl_root;
> +
> +	if (options->needs_nsdelegate && cgroup_v2_mounted() &&
> +		&& !cgroup_v2_nsdelegate())

Double && broke the build, thus I fixed it (+ added inline for readability,
otherwise it'd be better to use { } when split on two lines).

Kind regards,
Petr

> +		tst_brk(TCONF, "Requires cgroup2 to be mounted with nsdelegate");
> +
>  	add_ctrl(&root->mnt_dir.ctrl_field, ctrl);

>  	if (cgroup_ctrl_on_v2(ctrl) && options->needs_ver == TST_CG_V1) {
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e5bc5bf4d..b5aae20ab 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1130,6 +1130,7 @@ static void do_cgroup_requires(void)
>  {
>  	const struct tst_cg_opts cg_opts = {
>  		.needs_ver = tst_test->needs_cgroup_ver,
> +		.needs_nsdelegate = tst_test->needs_cgroup_nsdelegate,
>  	};
>  	const char *const *ctrl_names = tst_test->needs_cgroup_ctrls;

> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> index 1872a7dff..733e88ee7 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> @@ -121,6 +121,7 @@ static struct tst_test test = {
>  	.needs_root = 1,
>  	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
>  	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_nsdelegate = 1,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "e57457641613"},
>  		{"CVE", "2021-4197"},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
