Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB0EC7EE23
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 12:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60FBF3CD0AF
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 14:46:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04D2E3CCD53
 for <ltp@lists.linux.it>; Tue, 30 May 2023 14:46:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 00CBD10008F0
 for <ltp@lists.linux.it>; Tue, 30 May 2023 14:46:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 390851FD6D;
 Tue, 30 May 2023 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685450776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrsAN0+WNZGGkAi8Mj4SFZ1Tyg0Bgykyjs3dPUX0EIY=;
 b=sUo79KVUUmeSqPZyYfHT2ecXrkNLiFu34Z8RkPEWva0Tafqv+a0/Wf9kjCN27p0is6U3fQ
 Za2CBk+/9Ve2H7dvjcvh8Uo6P1Lxodmmt+gVkMoP1L9A/57cKoEj1G0zg0koEh7hetrMHV
 VkoEs2WkMWebu+I6qkL7iFG9OCqPAV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685450776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrsAN0+WNZGGkAi8Mj4SFZ1Tyg0Bgykyjs3dPUX0EIY=;
 b=vkseDRUqZ0LpP0AjR01R/VH2N2o7dWTxQKZ8HQYhVn4SHwOb2MnddgestLFqw3kK/uLdGN
 gayT/uLlB9gdf/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1811D13478;
 Tue, 30 May 2023 12:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T+DyBBjwdWRrKAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 30 May 2023 12:46:16 +0000
Message-ID: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
Date: Tue, 30 May 2023 14:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20230530093012.35470-1-liwang@redhat.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230530093012.35470-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] shmget02: reduce the shmmax test value in compat
 mode
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

On 30. 05. 23 11:30, Li Wang wrote:
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
>   testcases/kernel/syscalls/ipc/shmget/shmget02.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> index 7989ef33e..faf633ad4 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> @@ -56,7 +56,11 @@ static struct tcase {
>   	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, 0, ENOENT},
>   	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, 0, EEXIST},
>   	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> +#ifdef TST_ABI32
> +	{&shmkey1, 8192 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> +#else
>   	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
> +#endif
>   	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, 0, EINVAL},
>   	{&shmkey, SHM_SIZE, SHM_RD, 1, 0, EACCES},
>   	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 1, EPERM},
> @@ -149,4 +153,10 @@ static struct tst_test test = {
>   	.test = do_test,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.hugepages = {TST_NO_HUGEPAGES},
> +#ifdef TST_ABI32
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TBROK},
> +		{}
> +	},
> +#endif
>   };

Could this be done without the conditional compilation? For example 
change the testcase to custom shmmax limit unconditionally or read the 
actual kernel limit from /proc/sys/kernel/shmmax in setup().

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
