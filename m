Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87672EB64D8
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 09:07:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1B183CDE2E
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 11:07:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B87233C9CCB
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:07:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39BBB20034E
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:07:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4F6031F8AA;
 Wed, 21 Jun 2023 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687338423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTjUQCI4druMvqRdfwdrIbNEz3F/YPV5ukSZFEloubM=;
 b=fDxO2IJS+vPsQf35KJiJ4Ul3XSptnEQbtCvNsNBDpsNnmVhY2+mNnXBBRXVoTDow6BzJvu
 0xxclT4k0GEqb+e8EO0V+bTHo+OzNNdJGQ9ZR9x1KllPPYgtoM50pbz5N34fkwBvGw6G71
 f1EAXW2lzJbfcAM4w13xfO1H0PM/o5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687338423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTjUQCI4druMvqRdfwdrIbNEz3F/YPV5ukSZFEloubM=;
 b=38YV66bb5LmSEcqNgSD2rGsId1TegVCx2vm35ECjrxy932PFvuBBSK8GYSDI9Jre5V3qBF
 ytNzEsRSwlt2U3Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38F2D134B1;
 Wed, 21 Jun 2023 09:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mjCcDLe9kmRPZgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 21 Jun 2023 09:07:03 +0000
Message-ID: <1cca2a5f-64e0-2932-2971-8d7d91e01605@suse.cz>
Date: Wed, 21 Jun 2023 11:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Souta Kawahara <souta.kawahara@miraclelinux.com>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
 <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <7ac34b5102d65e6bb7112234f6ad685e98d066f2.1687306661.git.souta.kawahara@miraclelinux.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 21. 06. 23 2:20, Souta Kawahara wrote:
> Signed-off-by: Souta Kawahara <souta.kawahara@miraclelinux.com>
> ---
>   runtest/cve | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index f9a449fe7..bbc552bea 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -24,6 +24,7 @@ cve-2017-6951 request_key05
>   cve-2017-7308 setsockopt02
>   cve-2017-7472 keyctl04
>   cve-2017-7616 set_mempolicy05
> +cve-2017-8890 accept02
>   cve-2017-10661 timerfd_settime02
>   cve-2017-12192 keyctl07
>   cve-2017-12193 add_key04
> @@ -41,16 +42,19 @@ cve-2017-17805 af_alg02
>   cve-2017-17806 af_alg01
>   cve-2017-17807 request_key04
>   cve-2017-18075 pcrypt_aead01
> +cve-2017-18344 timer_create03
>   cve-2017-1000111 setsockopt07
>   cve-2017-1000112 setsockopt05
>   cve-2017-1000364 stack_clash
>   cve-2017-1000380 snd_timer01
>   cve-2017-1000405 thp04
>   cve-2018-5803 sctp_big_chunk
> +cve-2018-6927 futex_cmp_requeue02
>   cve-2018-7566 snd_seq01
>   cve-2018-8897 ptrace09
>   cve-2018-9568 connect02
>   cve-2018-10124 kill13
> +cve-2018-11508 adjtimex03
>   cve-2018-12896 timer_settime03
>   cve-2018-13405 creat09
>   cve-2018-18445 bpf_prog04
> @@ -66,15 +70,23 @@ cve-2020-14386 sendto03
>   cve-2020-14416 pty03
>   cve-2020-25705 icmp_rate_limit01
>   cve-2020-29373 io_uring02
> +cve-2020-36557 pty06
>   cve-2021-3444 bpf_prog05
>   cve-2021-3609 can_bcm01
> +cve-2021-3653 kvm_svm01
> +cve-2021-3656 kvm_svm02

All kvm_* tests are intended only for baremetal testing and they're 
built only for x86 machines. On any other arch, you'll get errors that 
the test program does not exist. In other words, they don't belong in 
this runfile.

>   cve-2021-4034 execve06
> +cve-2021-4197_1 cgroup_core01
> +cve-2021-4197_2 cgroup_core02
> +cve-2021-4204 bpf_prog06
>   cve-2021-22555 setsockopt08 -i 100
>   cve-2021-26708 vsock01
>   cve-2021-22600 setsockopt09
> +cve-2021-38198 kvm_pagefault01

Also this one.

>   cve-2021-38604 mq_notify03
>   cve-2022-0847 dirtypipe
>   cve-2022-2590 dirtyc0w_shmem
> +cve-2022-23222 bpf_prog07
>   # Tests below may cause kernel memory leak
>   cve-2020-25704 perf_event_open03
>   cve-2022-0185 fsconfig03

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
