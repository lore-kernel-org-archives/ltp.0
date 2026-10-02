Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D0DCA5FD4
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:41:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7453E6B32
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:41:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0E783E11F4
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:40:45 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DD04600733
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:40:45 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 d75a77b69052e-53503aceef0so2617541cf.1
 for <ltp@lists.linux.it>; Fri, 02 Oct 2026 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948444; x=1791553244; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j0sfPQkSrRaj0Thdc4xqxYdkYm3eeMPBxFvZ61XCYhM=;
 b=WetzLVqo9AlxTXke71FfTBCu7CfpXDDaXvTAaGCKDnYHVOj6xZs0yHbs+NHCjvNhXz
 4YiAZcJ6oAoyC2aNAe8zXpE0E/qhJSzdBUvwqjyu+TnZnCNXrg2UYLWiSwcJtWgrME6J
 NiIdwyVmz6OHud+XRSH5V7p+D/AGox8cuGRNd034zfgpAJEUpvcmYQujAlSk4A7krk6N
 GBOVNglSLD0Y6PPnVKtOcJfzJjONJpyKppyrXHf9rn5/KUnWe591i/PWN0uODmpSIKvO
 kaiOly7fNI3rtln82dYkA1MigJP+ZXBUkP9vtDEJEBlUVDi+axai8jvldSQ1GLjcjwo1
 IHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948444; x=1791553244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j0sfPQkSrRaj0Thdc4xqxYdkYm3eeMPBxFvZ61XCYhM=;
 b=ztqmAySdGedrUJrSKo5C9XLgaNXa4yzsr82nYqu6N5VjCK2wVbT+7O+mXkcMb996fY
 oZ/YYeLv+BVr83Y7nZ9iHkUmOMLKUcz3qB+5JLkI32rpoP/mgEDfr8/JVoycJjLtOeG9
 dKlW5cGE4uNe7Do7TJnGXsh650JH/JRPkhFo1/ZWB457XZUlrfjxjJEWZvO0oGLKFfzF
 zTbCLPrH5Jfz/rhkDeVyH/AweiXA6tfoNPUl4Bdtu/EkS1Sy/MRl1kRGGXqg/4nl5uRE
 UM5oh73lZP7cBgN11wOFntfoXUMUrsdG+p1OcRNulRfHl/bMQB71uLn2QP5JInHF3BA6
 lGPg==
X-Gm-Message-State: AFuF++layq0Pg5y9seOfrA7ewxQilGH4/dghqyg+s6mMecK5GCTi2bKW
 9rpQRmarlTHAA1AQFPhoDzoYpskj5enpdW4V9Fg12ET1ON2qXFlfms06
X-Gm-Gg: AYBFou0XETlFKVNA/1YHSX2IZVsmXxwODKchhLZjgfT2pe33iHpw41A6DGJuddmyqFN
 mse7MshBOszZYWzSicEtnHGpQ3PgS2PRmR0eIQ4AHEKqty813HybEIROo0cEsXM/lUmrQ+nRj93
 wlOum7k9f+Qb9098sgncOX+ZOgJAEZz3eD+qAri6c4GLKxx5m7b50eqILUL3jUS+dzcxNaHgBK3
 3Y0JADmZr97lZA1hp/8f5d2UWh8MOfYOGpOIt+IxhMZwxCJLOXV2qOaU6vtGUJO0TrtDmIWAjau
 G+RKyVROLIHjCxPScuBrR+bxVjCGY93rY+PeOpNAURn8GnamAFZ4ljnVzLxkQ+9zdsShaI6Kqwo
 Biu+JOHx3d5uxb+OIuBQ/+eqIXC0CCZEq5yF3SZiwJDgMSWDp3mO7b77QDfhXuBqnsLpNLU4v6s
 zK2XAMjCYBfzmLep5/j7a/lGY14IrlKEho5I+YeNGKqbuW6OGoa+O/YQGuyij4uSquGddt8Z9zX
 7CWXguUYIPGpNUpVUbBjw+PO25bbpMGiFAfdREJkdOPL1v9l9Dmr1DgiEF2ijDrMqKcFveZML+j
 Mbt9kMlurCNAjS620+Cu0vA=
X-Received: by 2002:a05:6214:250b:b0:914:563a:b3eb with SMTP id
 6a1803df08f44-917c0166b16mr54425556d6.40.1790948443480; 
 Fri, 02 Oct 2026 06:40:43 -0700 (PDT)
Received: from
 runnervm8df0l.wgcyhu3ofd1ezmijxxwu5buxoe.bx.internal.cloudapp.net
 ([172.172.153.42]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0c0bef6sm19941246d6.39.2026.10.02.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:40:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Nirmoy Das <nirmoyd@nvidia.com>
Date: Fri,  2 Oct 2026 13:40:42 +0000
Message-ID: <20261002134042.9290-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002131717.1118384-1-nirmoyd@nvidia.com>
References: <20261002131717.1118384-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getrusage03: account for percpu RSS counter batching
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

Hi Nirmoy,

On 2026-10-02, Nirmoy Das wrote:
> getrusage03: account for percpu RSS counter batching

> 	long online_cpus = tst_ncpus();
> 	long batch = MAX(32L, online_cpus * 2);

Medium: On musl, tst_ncpus() counts the calling thread's affinity mask,
so an inherited taskset/cpuset restriction still underestimates the kernel's
global batch even before pinning. With 352 online CPUs, 64 KiB pages and
single-CPU inherited affinity, this chooses 20 MiB rather than 44 MiB and
rejects a valid 270336 KiB result for the 300 MiB allocation. Obtain the
system-wide online count independently of affinity, for example by counting
the CPU ranges in /sys/devices/system/cpu/online.

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
