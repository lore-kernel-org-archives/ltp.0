Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E9C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 13:01:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37523C93F3
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 15:01:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F8C3C1BBD
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 15:01:27 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 571581000426
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 15:01:27 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id o8so18856601wro.3
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6Y0ATUV8Qb4XZ2PUuFjYWiAEtClTIxxHJKputShJ2zA=;
 b=SxFRCysvo2ayNNvRxbNmb2m3TtNeYut7NtJ6Y+am/HXsSaVoL3J0TuLErblx443GDc
 EpZrC2rIylJZ/YJ72tFldX6Qpe2AoLBeBD3cBYRihIBWKd6KGbBTyZtqvpIEzzijZzLH
 a/ne8Gy9d3HjTKAsiy11MQPKGENUFt8lJX9iGe2rNdDaHL22U0fR52zebFJ//a7GeEl8
 415jHF5PqNOKmPt/mWITyZ6omTLM/onIHt7jILtV4Mor7b+afC4Ji1Xh+K8/A+kHC6k7
 RrMMAf7oegYrI8/wV5UWZ3jlE2xEQT9zVGz1GWJ+lZgeWhAowO1Nv6WSZBq2xdKJAVBn
 1NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=6Y0ATUV8Qb4XZ2PUuFjYWiAEtClTIxxHJKputShJ2zA=;
 b=w7A2pW2E2FJ/DR0K7RJJey0LDVUecx26SYrF1hhNaxUyspfwHJVBeTTUU2PHkGFz4j
 PX7ob7o8VqqL1+soit8zNCuJHt8TjPGFF2uTiwMoHy17uA0yjqW3z7x2O/4r+YhqR/FW
 APQnPLddkq+XmLBuVeuX922OHpc+ozTtwbDo20LRbP5/t+zgDNOPETSpYP0aDn5zmAPk
 xtuJeJz/f5JK68BQ1aDqEQAnv42xlLw1OVfwOgV7Tc9MsINWw9yEYGp5jgmV9zlfJuEm
 zESC9ehCFH8ilmaXui228NK60aYZ5vCo+XVoka2+vPDGprI4qpX1Wovfp3z81+OvGdbW
 Wehw==
X-Gm-Message-State: AJIora9LlB4Pv8fjmfLNrdua6xNwzfwPMcboRhOimbogJ0Kg2OhM0Eg9
 L1tLci+2fSaGxvW1lD7IKQY=
X-Google-Smtp-Source: AGRyM1vo+xb8luqoL3byYFbo+WDU6/cNpN4MpBrUrjsxEByYipZtEKB6XXcpChcQlOEJXq1ziaWg6g==
X-Received: by 2002:a05:6000:1e1b:b0:219:e32d:cbe8 with SMTP id
 bj27-20020a0560001e1b00b00219e32dcbe8mr28439512wrb.129.1655816486830; 
 Tue, 21 Jun 2022 06:01:26 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id
 n1-20020a5d6b81000000b0021b9416fa13sm4608770wrx.90.2022.06.21.06.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jun 2022 06:01:26 -0700 (PDT)
Message-ID: <3d18d50a-b96f-befc-d905-c9f68f7542ab@gmail.com>
Date: Tue, 21 Jun 2022 15:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org
References: <20220621120355.2903-1-chrubis@suse.cz>
From: Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220621120355.2903-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch@vger.kernel.org, linux-man <linux-man@vger.kernel.org>,
 libc-alpha@sourceware.org, linux-api@vger.kernel.org, dhowells@redhat.com,
 David.Laight@aculab.com, zack@owlfolio.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 6/21/22 14:03, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace for C code.
> 
> We cannot make the change for C++ since that would be non-backwards
> compatible change and may cause possible regressions and even
> compilation failures, e.g. overloaded function may no longer find a
> correct match.
> 
> This allows us to use the kernel structure definitions in userspace in C
> code. For example we can use PRIu64 and PRId64 modifiers in printf() to
> print structure membere. Morever with this there would be no need to
> redefine these structures in an libc implementations as it is done now.
> 
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
> 
> 	printf("%" PRIu64 "\n", stx.stx_size);
> 
> We get:
> 
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Acked-by: Alejandro Colomar <alx.manpages@gmail.com>

> ---
>   include/uapi/asm-generic/types.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> v2: Make sure we do not break C++ applications
> v3: Update commit message to explain C++ exclusion
> 
> diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
> index dfaa50d99d8f..11e468a39d1e 100644

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
