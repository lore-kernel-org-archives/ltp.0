Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD451C77B7E
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 14:59:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6AB73CEA52
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 16:59:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 by picard.linux.it (Postfix) with ESMTP id 58EAB3CCF15
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 16:59:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 236D11A0BC36
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 16:51:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D95A1FDAD;
 Thu,  1 Jun 2023 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685631110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKxrRIvSXtn9qcBY6fHNSrCJnvLrpVeau35OUTuPU8Q=;
 b=QzRtgQHZHdf1mb5X5RdXFanlEw70JUpZx4rcD3f4S5mNfCfzhldkRR9GB3zcjFD2cwKkxB
 dh6voO8RK23LoFO1Nf0XtlFZdJSIXeRDi7ZynOkwVmT+IPAZjh+TGVFP+o2aP1KuPPEWBm
 ev2vtVOkoWoW/qTIoQSbjLGzH/otku0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685631110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKxrRIvSXtn9qcBY6fHNSrCJnvLrpVeau35OUTuPU8Q=;
 b=rUR5LPgFia2WyFZuBD60plYY2XwNkChSWJDyMdWyN7T0zHgcQIj6rxQa0M6L715UXjo2gY
 CqCV5nZBGn6TKHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08246139B7;
 Thu,  1 Jun 2023 14:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F58tAYaweGR2WgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 01 Jun 2023 14:51:50 +0000
Message-ID: <3482c8d1-4113-eac2-6eda-cc1bcc59b367@suse.cz>
Date: Thu, 1 Jun 2023 16:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
 <20230601091614.53228-1-liwang@redhat.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230601091614.53228-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] shmget02: reduce the shmmax test value in
 compat mode
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Manfred Spraul <manfred@colorfullife.com>, Arnd Bergmann <arnd@arndb.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
this looks good, just one minor note at the end.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 01. 06. 23 11:16, Li Wang wrote:
> As Arnd Bergmann pointed out that SHMMAX being defined as
> (ULONG_MAX - (1UL << 24)), so the kernel would likely use
> a large 64-bit value, while the 32-bit user space uses a
> much smaller limit.
> 
> It finally results in ENOMEM failure:
>    shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536)
>                   expected EINVAL: ENOMEM (12)
> 
> With suggest by Manfred Spraul we could reduce the value
> of '/proc/sys/kernel/shmmax' in compat mode and only test
> the overflow behavior with default+1.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> ---
> 
> Notes:
>      v1 --> v2
>      	* remove the conditional compilation for 32bit
> 
>   testcases/kernel/syscalls/ipc/shmget/shmget02.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> index 7989ef33e..e053b98d2 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> @@ -56,7 +56,7 @@ static struct tcase {
>   	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, 0, ENOENT},
>   	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, 0, EEXIST},
>   	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> -	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> +	{&shmkey1, 8192 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
>   	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, 0, EINVAL},
>   	{&shmkey, SHM_SIZE, SHM_RD, 1, 0, EACCES},
>   	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 1, EPERM},
> @@ -149,4 +149,8 @@ static struct tst_test test = {
>   	.test = do_test,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.hugepages = {TST_NO_HUGEPAGES},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TBROK},
> +		{}
> +	},
>   };

/proc/sys/kernel/shmmax can be disabled by CONFIG_SYSVIPC_SYSCTL, 
although that would be rare. I think the save_restore flags should be 
TST_SR_TCONF_MISSING | TST_SR_TBROK_RO. This can be changed during merge.

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
