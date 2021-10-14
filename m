Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B37C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 15:45:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FE060FDC
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 15:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39FE060FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 784F13C133E
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 17:45:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C5F73C0E6B
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 17:45:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 68EDE602068
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 17:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0A071FD3B;
 Thu, 14 Oct 2021 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634226318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18N8qV1XtesN7OmdBs9FjCZMJngIA3/5kcgX4ulGwyQ=;
 b=vbfEB7rkJ5BwPx6kW84HFrKLqxZopIBQ8Jjz4e/mYaG9EV8RrlKHKgrrhOkVyU31FmTrZj
 rYJYngqUR1RANfEySbDZS6nr2QFtyj03PKF9Fb9JprvOJPbuPcw8T7rxRHGuBw0/3HhIhJ
 XZ+zVGSkDdl9XJ/Jh9AchVMYx/nUELk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634226318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18N8qV1XtesN7OmdBs9FjCZMJngIA3/5kcgX4ulGwyQ=;
 b=dmfXx8XXD5gDFd3H5NMZsZvJ45LO7pR2UYpcralGK3ZeM3QNJG9juwQh6z0lO34ZcqNdUb
 GB3VMVSLppuFTsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ACB713D9F;
 Thu, 14 Oct 2021 15:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bHevII5QaGEcIwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 14 Oct 2021 15:45:18 +0000
Message-ID: <d24e8d85-b57c-2af8-ca63-31203c420672@suse.cz>
Date: Thu, 14 Oct 2021 17:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20211014153554.8932-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20211014153554.8932-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] creat09: Run on all_filesystems
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 14. 10. 21 17:35, Petr Vorel wrote:
> To make sure bug on XFS is detected on systems which use it.
> 
> Due setgid is test problematic on Microsoft filesystems:
> 
> creat09.c:81: TBROK: ntfs: Setgid bit not set
> creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
> creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)
> 
> thus they're disabled.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/creat/creat09.c | 57 +++++++++++++++++------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index 681b80c7d..04f92ba21 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -33,15 +33,20 @@
>  #include <stdlib.h>
>  #include <sys/types.h>
>  #include <pwd.h>
> +#include <stdio.h>
>  #include "tst_test.h"
>  #include "tst_uid.h"
>  
>  #define MODE_RWX        0777
>  #define MODE_SGID       (S_ISGID|0777)
>  
> -#define WORKDIR		"testdir"
> -#define CREAT_FILE	WORKDIR "/creat.tmp"
> -#define OPEN_FILE	WORKDIR "/open.tmp"
> +#define MNTPOINT	"mntpoint"
> +#define CREAT_FILE	"creat.tmp"
> +#define OPEN_FILE	"open.tmp"
> +
> +static char *workdir;
> +static char *creat_file;
> +static char *open_file;
>  
>  static gid_t free_gid;
>  static int fd = -1;
> @@ -51,21 +56,32 @@ static void setup(void)
>  	struct stat buf;
>  	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>  
> +	SAFE_CHDIR(MNTPOINT);
> +
>  	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
>  		(int)ltpuser->pw_gid);
>  	free_gid = tst_get_free_gid(ltpuser->pw_gid);
>  
>  	/* Create directories and set permissions */
> -	SAFE_MKDIR(WORKDIR, MODE_RWX);
> -	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
> -	SAFE_CHMOD(WORKDIR, MODE_SGID);
> -	SAFE_STAT(WORKDIR, &buf);
> +	workdir = SAFE_MALLOC(strlen(tst_device->fs_type) + 1);
> +	sprintf(workdir, "%s", tst_device->fs_type);
> +
> +	creat_file = SAFE_MALLOC(strlen(workdir) + strlen(CREAT_FILE) + 2);
> +	sprintf(creat_file, "%s/%s", workdir, CREAT_FILE);
> +
> +	open_file = SAFE_MALLOC(strlen(tst_device->fs_type) + strlen(OPEN_FILE) + 2);
> +	sprintf(open_file, "%s/%s", workdir, OPEN_FILE);
> +
> +	SAFE_MKDIR(workdir, MODE_RWX);
> +	SAFE_CHOWN(workdir, ltpuser->pw_uid, free_gid);
> +	SAFE_CHMOD(workdir, MODE_SGID);
> +	SAFE_STAT(workdir, &buf);

You do not need to do any of this. Simply prefix WORDKIR with MNTPOINT:

-#define WORKDIR	"testdir"
+#define MNTPOINT	"mntpoint"
+#define WORKDIR	MNTPOINT "/testdir"

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
