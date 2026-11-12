Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB0606A327
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=N2HDvLEE;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=sn6A276U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794477662; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VFwLj5HEqK/yaZzBpNOQ6eL4OERv0KmCgvGEsENaQ0U=;
 b=N2HDvLEEvs7+el0Pb47A1lnd9V5tqVlnr5QBWtB1to9wYfIPuFvJP4zw3iTNXtLSvYSNV
 1IJFpt/inDVTQbEperKOvLlzonFZsJcP8ynutOb02CeK103kWIXAFD8cfVHOCt/yLgZx2p/
 JoaiKTJGD5XLwj3pUp0vaNVAxBAbL24=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13CF73EA094
	for <ltp@archiver.kernel.org>; Thu, 12 Nov 2026 11:01:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8420E3E1DAF
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:00:43 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C828E1A00CC7
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 11:00:42 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B6B7940293
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794477641;
 bh=Pyh2SnpRedB1/72/GjjWkAT5bFImwPGIbrsjH5PxLq4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sn6A276UH30JbpYpmLK4cbGTVbHkv1cl7pS+I5JaizgSowtgnl6jO7HwpMctwTwIj
 39DZg1AYIu4DdzC0GEUjNbLvL6xml9pC8v3pUspFBU8qJ4e3fbQCE3q5xIIBAbrHyA
 tQgdDEs00afepnn0BNT6eF7wZmejHTTnzn0tw1hKDWWoS2DCv9NkuDa1BFWCCxniC1
 14RKKxF8Y3HbPzrYThcW+5v8u3PBUm9OVm5AyxU6V0TTLvkFnnlVONzL5QifOqALuQ
 p+0hGpf9j8xBY7mjUdsfMCbqvqatzgTCmInXLMm166YW6x09bOfQX+ujzGuOFfyDJJ
 4muEMZni2UKVT32UeduoR7IctC3jWFck2d4dP/W1ze/V5da9dyOOYTFNghJ82ndfZL
 vuF08sWTpIuUcS52w5nJ3c5Q4qvH8uy7lFCJliJPLxu9F1B1dUsCYfuqoZd+XJSuE0
 dCT1sKYVgdxtFAMLEO4/spzV9RIiSEeRegG+zcfiCl3wlDadhLpUKnoDf7VhP+9RRr
 UVODgl0w2lbYTbK8o26VRJiXd7QyOZHlbEWIBZYnS7yL0U+DZOElzWeI1K0CMwJnLO
 cWeni1HRtuQ6qAcxjOMJ+e/WjzhTbS8jn+lxIQfHIQRu3G23h0zbjdsJNx+9UdkXPn
 KnQYmsF9sw0HvzEYE7LtS/JI=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ed2c307e62so61651445ad.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 02:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794477639; x=1795082439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pyh2SnpRedB1/72/GjjWkAT5bFImwPGIbrsjH5PxLq4=;
 b=E1+gfpSTDhByUWZwhxoaKhyWWwrUVods1nASMtMmvkxig2XrEdHIbJKI5yvqZfdf2D
 xXbsD0G045nt5eDBYJjtq/GkEoG7Hey2c/VYH3kgAubvoST1h8I1c2eIPN7MPmN4Tgeg
 3dxz7MzYXhpLqExwXC5jDWCN1v6w7JCkJPiuT71bVa+TP0ioBiBGFicp+x+Ot6l8LlMQ
 KsUz7W1vI68HSkP7Ri3WkgvRYprkt6YK2lVEgYaxc8OdjfqS9MAqFO2z57/cGh3lTf3k
 i70S3oMCLSQASMeQRMkwuJqMnt/9tCWlTlecoPcRk4aBImi5LiOd8il3eC+oMmSvC8hF
 8USg==
X-Forwarded-Encrypted: i=1;
 AL+hErEayolou/0kcapZKAe+egV6F0Ym3Qh1VXQqyz2nBMZEEwNHucvP7Ro1jxYKI6h3xW+EKXY=@lists.linux.it
X-Gm-Message-State: APuU4Z9fnsn1BKM1fXYCK1cE7lHnnSyajKQncGvS5wVOKuPZ9rIcvwpK
 YvORUZeyzS8Yq5XTOkIh71DKeA1MgEkAaytEndYYQ0+TDtEUITA5+GHYFGW/FJVRb9+lAx0BAz1
 nSb3noLTRHwFI2hfNVwkAL/4pgediQ/JBsVArcTs1kpTDW+c5oZ8wbTAWaR7YbZojVx1o
X-Gm-Gg: AYBFou2hP3xJyjcunfyQI4otPQwmCW+ql/z2ARCITVTXJafF7kS+PkR2NghXtoHJCy8
 HiXNOmyus94vvdTTr6lpAPGtma9qPbhZsmA0hThz9zLwMd63esVhTrnz5nwhjKfjq+xBmJpcm25
 99+DtnZaVEHIwL8THLu3L3mCAd8utnTezgypCBYGxvMa4/qupdcfu0GQxuHJCHh7AFsrvWHTmgz
 HKYd14e1Wm7fHx9RF+H9ifoGR8lpEtVmXtJGExKksbwGUbMd2WEGZs6dj6qLXwrkZH77zl/tYJR
 SJ6ccClahI3JuGYknV5d5krF/d0myWQD+mt+iFdyIO7l9X/QOxU7rKcSKUvg9YrUHKxSz5Ebagu
 9owRXPiWbu2yyTPs5SupsSYxkzfjcmm30NTksI+QkdgWo9+UJ3XuZz38ss4k=
X-Received: by 2002:a17:903:acf:b0:2e9:4175:3077 with SMTP id
 d9443c01a7336-2edd76d2530mr56596545ad.15.1794477638898; 
 Thu, 12 Nov 2026 02:00:38 -0800 (PST)
X-Received: by 2002:a17:903:acf:b0:2e9:4175:3077 with SMTP id
 d9443c01a7336-2edd76d2530mr56596325ad.15.1794477638527; 
 Thu, 12 Nov 2026 02:00:38 -0800 (PST)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a412acsm30545105ad.4.2026.11.12.02.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:00:38 -0800 (PST)
To: pvorel@suse.cz
Date: Thu, 12 Nov 2026 21:00:31 +1100
Message-ID: <20261112100031.66668-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111135730.GA748268@pevik>
References: <20261111135730.GA748268@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Changwei Zou <changwei.zou@canonical.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Thanks for the review.

> +#else
> +TST_TEST_TCONF("test requires libnuma >= 2");
> IMHO at least this suggestion by agent in v7 was wrong. You should have kept
> using:
> TST_TEST_TCONF(NUMA_ERROR_MSG);

Agreed, that was a mistake on my side. I've restored

    TST_TEST_TCONF(NUMA_ERROR_MSG);

in v10.

While at it I also dropped ".needs_cgroup_ver = TST_CG_V1". The
SAFE_CG_HAS() check on cpuset.memory_spread_page in setup() already skips
the test with TCONF when cpuset is mounted on the unified (v2) hierarchy,
so forcing the controller version is redundant.

> BTW on which Ubuntu version do you test which still uses v1 and have
> libnuma2?

I tested on an AWS instance running Ubuntu with the 6.8.0-1069-aws kernel
(2 NUMA memory nodes, 96 CPUs, libnuma present).

To be precise, the system does not use cgroup v1 by default -- /sys/fs/cgroup
is cgroup v2 (cgroup2fs). However, systemd does not use the cpuset
controller on the v2 hierarchy there, so cpuset is idle and the LTP cgroup
library is able to mount a v1 cpuset hierarchy on the fly:

    tst_cgroup.c:793: TINFO: Mounted V1 cpuset CGroup on /tmp/cgroup_cpuset

cpuset.memory_spread_page then exists in that v1 cpuset and the test runs;
all six subtests pass. On a host where cpuset is actively bound to the v2
hierarchy the test simply skips with TCONF, which is the expected behaviour
since cpuset.memory_spread_page is a cgroup v1 only knob.

I'll submit v10 with these changes later.

Thanks,
Changwei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
