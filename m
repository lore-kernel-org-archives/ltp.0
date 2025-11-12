Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7778BCD13CF
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762958490; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=S5Hj0+lqzUBwVZG/KgykXneE546t2grZVrwE1KVVN3c=;
 b=lLnZpeoUlITbOi73d22Pk4n7vp7a+1gmV0/9yuZgKGCf52cQdSKEaO5ZJicKam541MyYC
 nd+PNbrD2ZhJ6dEL7dALN4gqlh0mMe3ufqgNxAc6i1/i1uA0O97mpmLaxOyRdRRp+uKxSHj
 MbMVPzO+vXd55oLvmIluAMDEnB5zk9w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 071093CF7AB
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 15:41:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A70053CF774
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:40:58 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D2BA1000A2E
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:40:58 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3c965ca9so524257f8f.1
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762958457; x=1763563257; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QPrNu2LieUjQs/fcRzUHqUuJRNpf7yMiLBOeN9DFELk=;
 b=cD7EUzaYOp9dgWNzQ9tyvNVZm1VDySeh2aEhLqaw7BhvomCJbReZ13rbBI+j+2JXgd
 ABf4gsSTyv55rPzq1Gkzkdz7qUHO+5dSr66380aYNEZ028bquFbRs9qYrACU/alMQ2qS
 5CefPd9m3Hu/w9zTLdpQglLsVIX6L6sEqvEt2PzdLMefhq4Z21sTLRzgebBh/014gGZf
 DoqB/MVk4jTRFZo3Opczoi7TtCwCHnqd4Skmi0+eIWLo+tuz+AxkKAdrcSl0Hpt7rT77
 s8lfLTEGzGTGrhLYCQ7vZUnG5VCMAGZxyM+iNHf2cjX3ycfStWJGQEmuqOZbEg07+AWV
 PnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762958457; x=1763563257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPrNu2LieUjQs/fcRzUHqUuJRNpf7yMiLBOeN9DFELk=;
 b=Y16/Y2uOaLdsBYFxnHAp2+3pNOGEor6i37JEuv2KNj1yfSvn3hNMIbJtRr2Yv3QlSV
 sJq1ff7rfiJyEZxZPP3UNyVTQbdGeJjzvIqVWgNvrLSXECb2Ryc0m1Dxzl/jLzwR9MPM
 3272mYApvSwphZyYPb70syEWrxzp4F8xEL3TZ9v0ZdVaHs2Wr8tDgZ7XtvPKoeeB9Wwk
 2D6ITpI37jwkLkrKnQBy51m4n0AcrRCrtQB2L6Xwq5acTmE1G4Sm7LZZtM3/kF0vMnSC
 PVDE3NeqO4Cb9sY90B721WuKZrct/0FgDfqAbxdMflxJd4hiBc5NdI2qdzgLGg5Xp42x
 e8ig==
X-Gm-Message-State: AOJu0YxNxY8hiCYh8v3OOezCEW78PFxWDNBPGjkLGdp7I/z1ItkEMwC3
 VQg/3J4BnUqKC1fJaVMkaDDCEImDSt1/KGgk78obWoMYwA1uJCZzydx/KPSFKiA0N7U=
X-Gm-Gg: ASbGnctOMX/iVR9KGZb/LaLunto41rvgh/Oe51mfP00XX2pVcFBWOZRXGeOTe4DKTVB
 zIfgyui0RWDP9zDKBie+kiG3/Q4I7P8hzDrHOBTxgyVAlRD24HQprQyEkmsj9RRuvOvLI+5xsMe
 NaED4+JS26xvD+Y3ElRle5Zw0SPF757T1rxEEqZYuxaYWKV1bl2oZ3qB8LtLgjAwxRGTUMK7vpI
 sH98UJcEH9xhwaTPa+m5czTQE/dhn0wqfKQditUTqZgjkPYO8opZ/WO4JN5oZ5iUqzTGRzfJm7B
 KOEwv3oXaenmDsEV2CNGK1kXh/9c1RK+gHhfxauEp5rFYaAchyyr3U0NNz++UywyRfuAoaNlIg0
 5xqbyyFQdJ8yrZDNTyIGQYsSVCHyBsqbOH9/yHPYSr6BVXJQuVLrUoaBb0LkTnWtVlF06xRCkZr
 xKBc6NfEuw8jc7POlZFtekBebpe0E6i2g=
X-Google-Smtp-Source: AGHT+IGPQGQBtO414UYTar6nShh/vQ6xRg7oHPwFbBdwgo3QZccACtmQ7GvAPBrZHYE91SDlaDfPVg==
X-Received: by 2002:a05:6000:230d:b0:42b:3afa:5e1d with SMTP id
 ffacd0b85a97d-42b4bb94f93mr3154500f8f.20.1762958457352; 
 Wed, 12 Nov 2025 06:40:57 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675ca86sm34704710f8f.31.2025.11.12.06.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 06:40:57 -0800 (PST)
Date: Wed, 12 Nov 2025 15:40:55 +0100
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <g6kd2n247qvdsl4w5zdfqzp3b4bmuzixhpgj3g53gecqhuwt7z@kjybzlrjxag2>
References: <20251111-b4-memcg_stress_rewrite-v3-1-a56a0e0cb887@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251111-b4-memcg_stress_rewrite-v3-1-a56a0e0cb887@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] memory: rewrite memcg_stress_test into C API
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 11, 2025 at 02:46:23PM +0100, Andrea Cervesato <andrea.cervesato@suse.de> wrote:
> +	for (int i = 0; i < iter_per_cgroup; i++) {
> +		while (!*cgroups_avail)
> +			sched_yield();

BTW this pattern looks like a custom semaphore (initialized to
parallelism level, IIUC you picked cgroups_num).

> +static void run(void)
> +{
> +	struct tst_cg_group *cg_child[cgroups_num];
> +	pid_t child_pid;
> +
> +	for (int i = 0; i < cgroups_num; i++) {
> +		cg_child[i] = tst_cg_group_mk(tst_cg, "ltp_memcg_stress_%d", i);
> +
> +		child_pid = SAFE_FORK();
> +		if (!child_pid) {
> +			run_child(cg_child[i]);
> +			exit(0);
> +		}
> +	}
> +
> +	tst_reap_children();
> +
> +	for (int i = 0; i < cgroups_num; i++)
> +		cg_child[i] = tst_cg_group_rm(cg_child[i]);
> +

Would it make sense to drop_caches and calculate mem_avail like in the
beginning and expect the value shouldn't be smaller?

This would assume this LTP test runs alone and it would check that
nothing leaked. Thus the test would have at least some assert :-)

Michal

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
