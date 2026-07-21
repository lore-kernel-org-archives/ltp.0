Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0422C44532
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF11C3E258D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:54:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF96E3C2603
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:53:51 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56E8B1A00988
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:53:51 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2ca4f02483cso15477175ad.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784642029; x=1785246829; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NuVsUXFXKa+zOztxKBd0nPmZ0+UWpHEVSEp5u/gKsuw=;
 b=JB8SS8WjTyLjZF55RQzxYEzViT0vsbhsS6xFXYaEb2B3yfWLMiso6kqln5kW7aoHBI
 Uc48HWQTignFy6i6kmXDgVPr23wGKb4EC9WgzrPv7d54ggKvIZ+fKb9DbX1DG+H/4lfF
 iHyBdtUc5Wpxl++DaS1l6sfE3qvEvOX/EncGAYQFPez9mnE7GVIGTaRCLaQCbNps8C6j
 qv3ZPxKrOSQpKpxa82BFq4mM+HSeonBPiojK6O8UHE6XaC0K+U+iIs7pd+GRclRL3KUy
 Mpi2nz3grVPjnKHBLAXLoWNqNpQK3W5h4zlJoxbBrLm56ou3B+TPgOHEO4362wv86yoj
 z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642029; x=1785246829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NuVsUXFXKa+zOztxKBd0nPmZ0+UWpHEVSEp5u/gKsuw=;
 b=CaiJWkO1p70mNTe5BD/yt1cJzTXcCHYkpAnjqLPLYjg1slK6RVfHrGmEY/ZbLaEBbj
 GgX5yi946EQg2hn5t+P92ycUkdR+oxUufukJJKbog+uQAYYVFz43aQv4elHNPdkS9BHe
 0x0/9hfknSKPavMcAj8hyl/XbAX6Fsy7NsgTX2GJChx1hKekyDtposaOR6xfdtl3dNWM
 w6A69gfh02hZOXvCMfWBoGybuP5cuA8RM+NQXSRCWa1t2X/ema06/UKOAS2CUB1yeqrW
 K7uifDSkQXUQ4HKrMWvQJfo+K9EB5nZEPuS/G+9U7HkG6KhkW7u660WhItAbXbE+vkAB
 8d1Q==
X-Gm-Message-State: AOJu0Yz7ujqV/EdS1SIHQFLnT4P6qrQjgOd34Uy7UpEpwjGPifLhYPDd
 nhIIMU8BPDOnScAjv+nrGNOj32svLrwRiHLeUk0d8QxmWSDun5fDyXvJ
X-Gm-Gg: AR+sD10U0l7esU9uGdVR35vd4ACZbpAokdheDqlZpF5xghmmjCz/8PMz37xXH+TK/R4
 KASNE8LA10vBfhAKMOoClNqVjuLZTnNme/tTC8who2Z1s5ijyiY4u+TE7EDKwMEro8w9Wtst1W4
 ch8Bz9HAYncmutmedsqvw26mTwcncfxfLV0D/yw+eBjzmtDjFLURQYVly16SU81/VZqwezuX5/4
 12BELr+NehHtYTEwkw5zGn550/0isQjoQMutEbwlY7nT2I+09qoZsxITv1qpOG7Sbfgaqadq0zi
 /kVAM6YtNJ0ZYXxH659FgvtAj8o4vdt2/+MrEddMeCpdRGQVLFRX44Xt9LN0XzHPKQLMgAy/toZ
 226R0boZiBARcBZzASFYxWFWRK0bl1QkoS0LufG4k38tDqRcM3Q/9BR/qXUAalOwiK9CfKiVEV5
 0w3kRzSpKugYGIgcGFyKn3eCBLyBqqJq6ua7p72KDsKBJ6Sb4lWNRaBkb9bX2DGU6xY0g91OcYN
 5x/iGFL8n3PrxQKodWX4yOOfafc
X-Received: by 2002:a17:902:b082:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2cf348444c7mr136757915ad.1.1784642029424; 
 Tue, 21 Jul 2026 06:53:49 -0700 (PDT)
Received: from
 runnervm3jd5f.jcg1zomofhku3ntm1yxmkozi4c.xx.internal.cloudapp.net
 ([52.156.108.69]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3448fb21sm79984135ad.7.2026.07.21.06.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:53:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 13:53:48 +0000
Message-ID: <20260721135348.9895-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-1-ec2c3cff6ea4@suse.com>
References: <20260721-rewrite_mremap_testing_suite-v1-1-ec2c3cff6ea4@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap01: Convert to new API
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

Hi Andrea,

On 2026-07-21, Andrea Cervesato wrote:
> mremap01: Convert to new API
> mremap02: Convert to new API
> mremap03: Convert to new API
> mremap04: Convert to new API
> mremap05: Convert to new API

Verdict - Reviewed

All five patches compile cleanly, pass `make check-mremapNN`
(checkpatch), and run to TPASS across multiple iterations. Each
conversion is traced against its original test's setup/algorithm/
oracle and preserves the full intent with no dropped scenarios, no
new leaks, and no double-unmap/double-free introduced.

The mremap04 Makefile switch from libltpipc to libltpnewipc was
verified against mremap06 and mremap07 in the same directory, neither
of which depends on the old ipc lib, so the switch does not affect
them.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
