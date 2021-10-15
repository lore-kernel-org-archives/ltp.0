Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA0CC433F5
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:06:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3D46109E
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF3D46109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A3B83C19CA
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 11:06:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 845373C0148
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 11:06:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C59E9600D35
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 11:06:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F145421A63;
 Fri, 15 Oct 2021 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634288804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjSXxX8tcTlH1lUJQ1AteXp0uMJOCwKHzNqz28RGb/g=;
 b=UnrSthRgYXBKz3aiI7ySh67VPdgiYR4djkdNu3cT6FO3kOT5lDV01htuv7J9uKrVBDIjT1
 Ui1Jo8Tij/1IAUAaf0rYAEK3vhSoxPtShU6ZW7IzZcqhTnhfzTSKZHbnlDPVSsZYmImK/o
 HY5tpokpVa8F63Yjdqp/4v6eRDX2Wdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634288804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjSXxX8tcTlH1lUJQ1AteXp0uMJOCwKHzNqz28RGb/g=;
 b=SQokWwel75fLlzNBy7JWHy5seIK1FIAfX/3l5LcxsX5DlN1PC/w5mgv4Jf5py4c2049ATR
 O239HVfEIpYkUVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEDE713B87;
 Fri, 15 Oct 2021 09:06:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id niQ6NaREaWHkJwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 15 Oct 2021 09:06:44 +0000
Message-ID: <faee57a0-727e-ae28-590a-290052f79aa3@suse.cz>
Date: Fri, 15 Oct 2021 11:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20211015083820.11903-1-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20211015083820.11903-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] creat09: Run on all_filesystems
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

Hello,
looks good to me.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 15. 10. 21 10:38, Petr Vorel wrote:
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
> changes v3->v4:
> * remove useless .needs_tmpdir
> 
> changes v2->v3:
> * add missing dir separator /
> * remove unused SAFE_CHDIR() (was needed due missing /)
> * remove unused <stdio.h>
> 
>  testcases/kernel/syscalls/creat/creat09.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index 681b80c7d..bed7bddb0 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -39,7 +39,8 @@
>  #define MODE_RWX        0777
>  #define MODE_SGID       (S_ISGID|0777)
>  
> -#define WORKDIR		"testdir"
> +#define MNTPOINT	"mntpoint"
> +#define WORKDIR		MNTPOINT "/testdir"
>  #define CREAT_FILE	WORKDIR "/creat.tmp"
>  #define OPEN_FILE	WORKDIR "/open.tmp"
>  
> @@ -118,7 +119,15 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.needs_root = 1,
> -	.needs_tmpdir = 1,
> +	.all_filesystems = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char*[]) {
> +		"exfat",
> +		"ntfs",
> +		"vfat",
> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "0fa3ecd87848"},
>  		{"CVE", "2018-13405"},
> 


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
