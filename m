Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3457C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:52:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66EE93E9791
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 16:52:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 202D63E60EA
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 16:52:05 +0200 (CEST)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B9A8320110F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 16:52:04 +0200 (CEST)
Received: by mail-oo2-x06.google.com with SMTP id
 006d021491bc7-6b1b8f5a1d5so290984eaf.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788533523; x=1789138323; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLuUaxXELue2k7by/edkiugi+ZIJnEtVT3PAo0mLRg8=;
 b=Nk8i1JK75CEC4/Ws3PBsTtv/jhvVGjlEVe7g+4ZlHXBEPdoBHinYrHdJigmdtFZpII
 QdX14Mm8jUYSPx++rRGHpUv+5/MLVaMoHYI9qgyhSCtrUdD0rKOVNChiZxNHdXJcOlqT
 2RTLsH0COI2hh3/DzmKlaY3sO4wvB/px/FEwq/lC70axgVzdff9mXXfw9YlBJMGzKD8i
 y4RMf2fH6gZcjN0TPO07bTsUcqEGZoT8po83QvL8gAU20A71EQNidHLWHZ8i7yVonn8u
 oc+Z2HKd5/rOWeLZPb9B5EppOC/OUlzhUozFjeLNqgZ1NwLhKO/JMx1MDuPgHtdd5QzS
 Cr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533523; x=1789138323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLuUaxXELue2k7by/edkiugi+ZIJnEtVT3PAo0mLRg8=;
 b=f5O34H4rMR5Lr/jdwEVQ+qEBi1Xf49aoWFaiCeUr7DdTbyLpVvmaADQSIvPF1IC5Kq
 n9773FYjDmlzTg4CqLzC0UvM+iAFrltBiB4ASePG/GZMgeZQO6M2qI+ikVBNsUDZtmA+
 rTmDmzYEQWQYEV8IJUeIXpXMZdXEZq9wXYqWXo1MbxaXN96ssw8Z2inOgGiq9MGu9vX2
 W0zVgjqLkXrjBO79MyJyjzoam80+tvsnrK+tgl6QpIEROqlkteR/0qBm9HtAr+Ny3Jmh
 agkeet10prq0Qk85tG+DfW2k7DQwL/fBY4dFjpOCORpLHRiYsDhOmhAhnrxb5Iq36CAv
 PEvQ==
X-Gm-Message-State: AFuF++lRtOJL7M1+AsqLVNbySN1Q8TZkhTMyZy552gCrpVnjsT0F2ord
 ltyzdPg+Zg0RSsysDxYuuad+a4EEAhMLbMotArEeUgbfe5Yuv2g9E9LV
X-Gm-Gg: AYBFou0RRDXsUgVq8icV9HdE7hF3uaLgzCqatW0PYJyWVDHQN1mZKpgVPUiLp7m/oKo
 xnHrJPEqP33HnqNDV11P/04REsCqjboeDO6jA5VlX9wEvmLC9rfeLBoAcnOTvSUuls+Lqp7oxl1
 AFZW1SqUoMlbAPo5rAZPAeGPCSqwcAZPRHcl629Q6XYMJRM5xdDSiZgd7U0owd1YDPZTpwiuKyn
 3UZzhWfc4U0Hna5W8Dqs9RSVgYiCmOLtpzCLnEBrfGKi99k0CaD1pN+4teJRCTZniFAaTO38J5N
 gnL0iyOyyK9sWPb0Do9ArbtECBkKn9uMc6/2eJxWcNClVLv06Ic3lcJ3S7s3BqbBjUZD3VGHHLW
 Mwu4JVS54dPbpOtfvpKgtTGLIwro0iUZZ4X5V38GMYYuLdTZzjPWxb5TzUPu9zMCadkRBMx25Ng
 PQ7ufubTm1uCM7TTlpjqd/LbSkdHFPnTa6eMMAQOWVAAFZQSl+V0Pc/rdd2JrLGEtQvMyEjd/Kh
 9Bs+m5PG7yjgdjzWr/OPy4DWeLAsIRRTmOsFXJ5HNYUJV1pW9t+Wl4we0UVCqNWAVG7IL5C0BE0
 D/g=
X-Received: by 2002:a05:6820:198b:b0:6b3:52da:b343 with SMTP id
 006d021491bc7-6b6fd6d3467mr4557626eaf.28.1788533523320; 
 Fri, 04 Sep 2026 07:52:03 -0700 (PDT)
Received: from
 runnervmejwal.ujbej0qg0ive3kvrwq5foysb5c.yx.internal.cloudapp.net
 ([172.215.217.193]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432435648esm8892229c88.5.2026.09.04.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:52:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Fri,  4 Sep 2026 14:52:01 +0000
Message-ID: <20260904145201.8776-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904125031.89015-1-changwei.zou@canonical.com>
References: <20260904125031.89015-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: count only the test file's page
 cache
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Changwei,

On Sep 4, 2026, Changwei Zou wrote:
> cpuset_memory_spread: count only the test file's page cache

> +		if (query_pages_node(n, pages + off, status + off) == -1) {
> +			warn("move_pages failed");
> +			goto out;
> +		}

Medium: In Linux 7.3, move_pages() is built only when
CONFIG_NUMA_MIGRATION=y. With it disabled this returns ENOSYS, the helper
writes "0" to the FIFO, and every case reports TFAIL; require the config and
report missing syscall support as TCONF.

> +	# the unexpected nodes must hold only a negligible fraction
> +	if [ $((unexpected_sum * 100)) -ge $((total * UNEXPECTED_TOLERANCE)) ]; then
> +		return 1
> +	fi

Low: This rejects an unexpected share of exactly 5%, although the commit
message and comments say that "at most" 5% is allowed. Use -gt, or document
5% as an exclusive limit.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
