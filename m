Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489EC433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 20:34:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF7C60F6B
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 20:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DF7C60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD8943CA2C8
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 22:33:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8BF03C1AEB
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 22:33:51 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 685A81A01475
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 22:33:51 +0200 (CEST)
Received: by mail-qk1-x731.google.com with SMTP id 194so1437885qkj.11
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5V7tPbF6pqrRtnrFFjIavekV6IgZDn4iTrEFpKRzrwg=;
 b=bfI0jP0cT0z0grzyWqZ1j5eg3AUamnRouzActDHZXGjWoS/zyxL3kNV5zWnr1LtsP/
 yohMNeoKIa9aln2eHNUckLmIsXAxeGnTip5rErEViOyHX8ZPdx9EWiM5fOpl0VYgNY6H
 tNw69K5I16II3e38WcAYeSNPq+SgGiEGWy23FpxdzSzm5LTwJgfWz3tx5Ap5T8giLH04
 B4bNQBM25Lbw7kosjEnGhDglnaWS0wIy4AiE7WSW8XEct80I1IyO1MyIu5ItYagfLjd8
 Nb074uKSjPBV7+5brdcRVZ5RBJwKa+SRyVeGUHZ3hcprNVHl6uR4kN8B95S/xLRUidcn
 p76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5V7tPbF6pqrRtnrFFjIavekV6IgZDn4iTrEFpKRzrwg=;
 b=EHpLcy2LIye29m0W7rCJNIRJbrZ8QQMxC4ryKCYNFOHMJkG8jqkl1Gu279eogj+C8+
 7es/cKLGq2enySJDAt28ub+X9kQVl3q3r1NO3PgzpGIevqsW0PhXUxFW/54gkmiFGgV4
 fkypI+KTchqcXat0LfFH8L8FH083/aKZzb6vRUn6ReYYYlX2sW3iutqa9OpJZGuGOcp0
 wQ5Cp6URDwQkOa4re934Gr3VJHsQ6Jv+Hw3cLWw8zBL7VxxTgGtBMX04rYL6ZBVz131g
 aU4fJCjHMVnuVKnQtrnwKFHXWQ4hZGM0qYx91jTP7j1HFmIiPYWg8ibTtWkC/xO0Ptzl
 x6EQ==
X-Gm-Message-State: AOAM532wb5zjCYwBrjD25HQs5c6C3dpwF/B8385/U6BsOnaeMAbfWAQK
 R2/dEXDzYCKjTzPCwfqw1IE8Tg==
X-Google-Smtp-Source: ABdhPJxmI22NoDEaTPDU/zVsWKB5MU7gr0SZoWkogFGgFt4vXYibhzDjtMNhOwLka+cT3jLD6ncdig==
X-Received: by 2002:a37:6396:: with SMTP id
 x144mr21206905qkb.163.1632256430123; 
 Tue, 21 Sep 2021 13:33:50 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id c10sm68925qtb.20.2021.09.21.13.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 13:33:49 -0700 (PDT)
Date: Tue, 21 Sep 2021 16:33:49 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210921203349.GA2014441@maple.netwinder.org>
References: <20210817104625.2559362-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817104625.2559362-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

On Tue, Aug 17, 2021 at 06:46:25PM +0800, Li Wang wrote:
>
>diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
>index 55ec1aee4..74bfa4861 100644
>--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
>+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
>@@ -26,8 +26,8 @@
> #include "lapi/fallocate.h"
>
> #define MNTPOINT "mntpoint"
>-#define FALLOCATE_BLOCKS 16
>-#define DEALLOCATE_BLOCKS 4
>+#define FALLOCATE_BLOCKS 256
>+#define DEALLOCATE_BLOCKS 64
> #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
>
> static char *buf;

This change appears seems to be causing fallocate05 test to reliably 
trigger OOM (out of memory) on my test machine, which has only 256MB 
RAM.

I previously used the 20210524 and 20200120 release versions, and did 
not encounter this problem.

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
