Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95F0C369BD
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744802899; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=H/T2H8pJ3OVYmxin9P55HEaWA/HyYl2gWhUcSh2lbCQ=;
 b=SUsPnalZeA25zrE9owDO3jcIkh4z9ep7DjhCeEM9TQXqo9RxMoTfi522rkCgKcO1gCaPv
 SB0Q2eCvWvYvXnd6LFX78LzRJmZh+6FMnYQRhMPXfIs8JdEMlkK088n5CLRsr9sipDNM53G
 0acEClrPSBENTvWA9ZlIavHYPIxTNus=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2EBA3CB962
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 13:28:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705093CB8FB
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 13:27:59 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 004346001E1
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 13:27:57 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so31969985e9.1
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744802877; x=1745407677; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QoiEqQ0qmUUPs52mMW7C0+/mSLB7EPHTChI3tUAeeLA=;
 b=SvHHgbbRApPeyNEDhoJx0gnYjYIpbYUanFfeQVLTaoiN6Fj+b/saBBHmdaA3BYAaym
 NKDZUVE99hZpBo7paKTwKpwcOPCZUvASEFwWqeiF7/tKTwfSlEHtmIq/bv6vOo8XMOu1
 +Ss7fs+QHz70dKJ+pgULjb+RMidmyDy48VTLuJNNAaEN2RrOeHOF+f4K3XCKU3V1a5aX
 Dt8VTSm6R7AuO3cYk45E2EoqPC7WWK2hFV/nSK8Q/tIdttMbHctxSws/9y3bIN0TcT8Z
 qBXyQxwCZEcTG3xm7OIRhgibCtIsWLBFts5wmWEVltc/AsUiHneqQvLe6GRaSyqpm5ye
 eCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744802877; x=1745407677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QoiEqQ0qmUUPs52mMW7C0+/mSLB7EPHTChI3tUAeeLA=;
 b=MCAaNudcJc87QySMki//5eaFCFjZaZICGj01yhYKTIqCULu7a6+aZ8zIr8ASqUIEEg
 lB86qDcLG54z/wSjmAEm7Q4+5c42i4bt+nhp2pmAlM9jAZiriT+6ox1J509qBke0D5En
 zxi4sr26PadugMlj9EISWwSsLiIihoHcF5PL5bY+a5AVdFQoXI+uRt+fJVGKDraMabwu
 pcvM+xaa3U60B00/CvsSiSMBi8iHERlYSSxyIwVwBwEPGLr6FlXWSZZBXYNfR5peNBhI
 rRFuAyac8VEgzTA+zS2JQ7kTgeYEfq8S6bsREh7GqXMMHlVrw2AfozJQ2kVSFcyTzRQ/
 4ejQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgXZLFWkzCDr93JnPSREkq6H2d3XDacvxQbQiITPYvkbZm6XbzWV0JJUouQ0klQMa5FXI=@lists.linux.it
X-Gm-Message-State: AOJu0YxujPW4wxik8cpUv7xacmwiPQGNkaIOBaXy49kFUPmFBE+U3MXj
 MDoXpopP7jmzKjDbGCo54u/WQRkyLAopbOrWn2R4QOvgVOu7O3zfBsGiMk+31lA1h7sczPlgvTy
 Y
X-Gm-Gg: ASbGncu7lctzARu9FmGKSFonuMs7BdyluRWeKSRbt4aGDV0bvPIoJZMx/XeqNXNZMbk
 CMAUyBMX0P03KvFi/USJeJxrxxWfhrgrlm11X+/Vdwfpiq0jqeSXKQ6bA2WiqVYEQxwTJtCsZM3
 i6pym4LcxkBer9HAlFZa1Lw1K9MFCqgkZf942fb8e0/lvyDzi7eOzeqU7fJiGoD+T+C3CRUQyTh
 PRHbPHuwzrFNJnhs0s+i7DKpsKPWfyf7SGbQOoojIA1DnpwPo43bVliLTxsU/omnse2uKnlWXu6
 ypkXETgGGKgZTp3XIQgu6HRhzXOMucI1RpaPfSOLo/Rm2YKD9tXRvqhsh5UWepBprx0uMdv4dUl
 +Obnyj/8axUd1Uo0XEnKqvXOz7K4Os4jGDik2ex203hH3y3QIiOPCuMIVJ9Rc6YRb4no5BuqqqU
 ZZ/Q3Yl/wG/92KaA==
X-Google-Smtp-Source: AGHT+IFqkRSyThCaSZOnxOgY2245shhPvOb9srurHscUhB+5WLqIjBziiaOvw5hmHL1xy428t55QTQ==
X-Received: by 2002:a05:600c:45c9:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-4405d5fce94mr14274745e9.2.1744802877208; 
 Wed, 16 Apr 2025 04:27:57 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b50b964sm18235715e9.27.2025.04.16.04.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 04:27:56 -0700 (PDT)
Message-ID: <3462bbea-857b-480c-90bc-b0d00cdff831@suse.com>
Date: Wed, 16 Apr 2025 13:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
Content-Language: en-US
In-Reply-To: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 0/4] Support for Patchwork CI
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged!

Thanks everyone for reviewing it.

Kind regards,
Andrea Cervesato

On 4/16/25 11:03, Andrea Cervesato wrote:
> Add support for patch-series validation in the patchwork ML.
> We use Github to schedule a trigger every 30 minutes, checking for new
> patche-series in parchwork which has not been tested yet.
>
> The way we decide if a patch-series has been tested in patchwork, is
> by looking at its status (in particular, if it's "Needs Review / ACK"),
> as well as checking if test report has been uploaded to any of the
> series patches.
>
> All communication to Patchwrok is done via REST API, using curl and js
> tools.
>
> First, we create a script called patchwork-ci.sh that provides all the
> commands to read new untested patch-series, set their status and testing
> report. Then, we create a scheduled workflow in Gitlab, checking every
> 30 minutes if there are new untested patch-series. At the end, we
> trigger the main build workflow, used to validate LTP commits in our
> Github mainline. All the times we trigger the build workflow, we also
> provide the patch-series ID, that will be fetched and applied on the
> current branch before running the tests.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v8:
> - patchwork.sh: avoid masking curl stdout with local
> - Link to v7: https://lore.kernel.org/r/20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com
>
> Changes in v7:
> - patchwork.sh: fix bashism ==
> - patchwork.sh: fix return code check for curl
> - patchwork.sh: remove IFS= from loops
> - patchwork.sh: local cmd in command_exists
> - fix message for trigger scripts commit
> - Link to v6: https://lore.kernel.org/r/20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com
>
> Changes in v6:
> - patchwork.sh: use more "[ $stuff ] || do_something" syntax
> - patchwork.sh: remove set -ex
> - patchwork.sh: variables default setup
> - patchwork.sh: move file creation in tmp folder
> - patchwork.sh: check multiple commands exist in once
> - trigger workflow now triggers only on linux-test-project/ltp repo
> - Link to v5: https://patchwork.ozlabs.org/project/ltp/list/?series=452320
>
> Changes in v5:
> - patchwork is now a utility that can be used separately
> - Link to v4: https://lore.kernel.org/r/20250411-patchwork_ci-v4-0-7f3c5ba298a1@suse.com
>
> Changes in v4:
> - make use of secrets to apply patches in order to set state to
>    needs-review-ack
> - check for curl failures and eventually exit 1
> - use a different format for stored file in 'patchwork-ci.sh verify'
>    command
> - define PATCHWORK_CI_FILE
> - some symbols like . are not supported by patchwork checks, so slurmify
>    the string before sending checks context
> - Link to v3: https://lore.kernel.org/r/20250411-patchwork_ci-v3-0-c9bb90c6961b@suse.com
>
> Changes in v3:
> - secrets are not supported by if: statement, so we remove it
> - Link to v2: https://lore.kernel.org/r/20250410-patchwork_ci-v2-0-288f4be835ff@suse.com
>
> Changes in v2:
> - check for secrets.PATCHWORK_TOKEN before sending tests results
> - v2 to re-trigger lore after missing 3/4 patch
> - Link to v1: https://lore.kernel.org/r/20250410-patchwork_ci-v1-0-def85825f46a@suse.com
>
> ---
> Andrea Cervesato (4):
>        ci: install dependences for patchwork-ci script
>        ci: add patchwork communication script
>        ci: add ci-patchwork-trigger workflow
>        ci: apply patchwork series in ci-docker-build workflow
>
>   .github/workflows/ci-docker-build.yml      |  39 ++++++-
>   .github/workflows/ci-patchwork-trigger.yml |  65 +++++++++++
>   ci/alpine-runtime.sh                       |   2 +
>   ci/alpine.sh                               |   2 +
>   ci/debian.i386.sh                          |   2 +
>   ci/debian.sh                               |   2 +
>   ci/fedora.sh                               |   2 +
>   ci/tools/patchwork.sh                      | 179 +++++++++++++++++++++++++++++
>   ci/tumbleweed.sh                           |   2 +
>   9 files changed, 294 insertions(+), 1 deletion(-)
> ---
> base-commit: 40c559787d15b2167ba657b3ba431e3299969d98
> change-id: 20250410-patchwork_ci-7dc4ae02c40d
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
