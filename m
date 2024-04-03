Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C29ECD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 11:01:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 434DD3CCDE6
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 13:01:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 415803C7B41
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 13:00:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 654591A01978
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 13:00:31 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4770B2231B;
 Wed,  3 Apr 2024 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712142031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R+dE57VUMx1ZAuDgklUCJrG1wzt2cdZXktv3ahXcz+c=;
 b=aD9z0+eH9z4M/1iTrCx250tQKlk/6STNB5NFeGZOZXYJOAD7R4I4USVy0P6hYL+guG/mhk
 F3Qxaidc3iOjod6lb6N67L0Ce7NG/sMiS4HeV7V7++9A8EhXXRb+qYX4K64dPoPU+8Ac3U
 Xcf3Dd3vKTcdrCncTzaa2yY61/FUlYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712142031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R+dE57VUMx1ZAuDgklUCJrG1wzt2cdZXktv3ahXcz+c=;
 b=R5ZLISZOU/CAews0uWi4QiU2tTsXIcZclU3SYv6/Dmr8gNVZCNElktUO1OhY3WRH30xMwF
 merdlCHxMDleADDg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33A6513357;
 Wed,  3 Apr 2024 11:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 0UaCC882DWZ9GQAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Wed, 03 Apr 2024 11:00:31 +0000
Date: Wed, 3 Apr 2024 12:59:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Hui Min Mina Chou <minachou@andestech.com>
Message-ID: <Zg02mbnjInBl7pw_@yuki>
References: <20240403051825.1545018-1-minachou@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240403051825.1545018-1-minachou@andestech.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: Set the core dump file location to
 temporary directory
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
Cc: tim609@andestech.com, cynthia@andestech.com, az70021@gmai.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When testing via NFS mount LTP folder on the board, with the NFS server
> configured using 'anonuid' and 'anongid' options to set specific
> uid/gid, waitid10 fails. This is due to a uid mismatch during core dump
> file creation, leading to an aborted dump, resulting in the child
> process receiving the signal CLD_KILLED instead of CLD_DUMPED.
> 
>   # ./waitid10
>   tst_buffers.c:56: TINFO: Test is using guarded buffers
>   tst_test.c:1732: TINFO: LTP version: 20240129
>   tst_test.c:1616: TINFO: Timeout per run is 0h 05m 00s
>   waitid10.c:64: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
>   [  296.482665] mnt_uid= 1036, curr_uid= 0
>   [  296.483041] Core dump to core aborted: cannot preserve file owner
>   waitid10.c:36: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
>   waitid10.c:37: TPASS: infop->si_pid == pidchild (149)
>   waitid10.c:38: TPASS: infop->si_status == SIGFPE (8)
>   waitid10.c:39: TPASS: infop->si_signo == SIGCHLD (17)
>   waitid10.c:42: TFAIL: infop->si_code (2) != CLD_DUMPED (3)
> 
> Therefore, referring to madvise08, during testing, set the core dump file
> to the temporary directory instead of the current working directory. After
> testing, restore the contents of /proc/sys/kernel/core_pattern and clear
> all test temporary file.

Thanks for the detailed description, now it's clear what happens on your
system.

>   # ./waitid10
>   tst_buffers.c:56: TINFO: Test is using guarded buffers
>   tst_test.c:1709: TINFO: LTP version: 20240129-45-g69537563d16a
>   tst_test.c:1593: TINFO: Timeout per run is 0h 05m 00s
>   waitid10.c:60: TINFO: Temporary core pattern is '/tmp/LTP_waiSzyEv2/core'
>   waitid10.c:73: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
>   [68549.534126] mnt_uid= 0, curr_uid= 0
>   waitid10.c:38: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
>   waitid10.c:39: TPASS: infop->si_pid == pidchild (163)
>   waitid10.c:40: TPASS: infop->si_status == SIGFPE (8)
>   waitid10.c:41: TPASS: infop->si_signo == SIGCHLD (17)
>   waitid10.c:44: TPASS: infop->si_code == CLD_DUMPED (3)
> 
> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> index e55e88c2325e..3e48f52d0ea8 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -16,6 +16,8 @@
>  #include <sys/prctl.h>
>  #include "tst_test.h"
>  
> +#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
> +
>  static siginfo_t *infop;
>  static int core_dumps = 1;
>  
> @@ -48,9 +50,16 @@ static void setup(void)
>  {
>  	struct rlimit rlim;
>  	char c;
> +	char cwd[1024];
> +	char tmpcpattern[1048];
>  
>  	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
> -	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
> +
> +	SAFE_GETCWD(cwd, sizeof(cwd));
> +	snprintf(tmpcpattern, sizeof(tmpcpattern), "%s/core", cwd);
> +	tst_res(TINFO, "Temporary core pattern is '%s'", tmpcpattern);
> +	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", tmpcpattern);
> +	SAFE_FILE_SCANF(CORE_PATTERN, "%c", &c);

Given the description do we really need to change the core pattern?

I guess that just adding .needs_tmpdir = 1 would fix the test since the
test $CWD would point to the test temporary directory.

>  	if (rlim.rlim_cur)
>  		return;
> @@ -76,4 +85,9 @@ static struct tst_test test = {
>  		{&infop, .size = sizeof(*infop)},
>  		{},
>  	},
> +	.needs_tmpdir = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{CORE_PATTERN, NULL, TST_SR_TCONF},
> +		{}
> +	},
>  };
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
