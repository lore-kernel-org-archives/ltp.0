Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1265CC982D8
	for <ltp@archiver.kernel.org>; Sun, 20 Sep 2026 14:43:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8423E6FDB
	for <ltp@archiver.kernel.org>; Sun, 20 Sep 2026 16:43:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7036D3E2147
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 16:43:15 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6C963200926
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 16:43:15 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 d75a77b69052e-530e0062c97so11415141cf.1
 for <ltp@lists.linux.it>; Sun, 20 Sep 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789915394; x=1790520194; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xt+CdIEzCePBACsGBelJhpgnjOEuCSLYMrUb0iTMgYY=;
 b=L469KxpgjVRq9LytecfUW4EDYKeQ4zC4u3tt9EXndAt0WvHGIfLGlAJ74s2EWkpeNO
 12htVGIPnRn31kIgRernBA2MpK5qYq7Ch5RSvh7A0J+kXdLT8fdMKRKU0/thX/nN8gNg
 cf7nFcx1AnNgAwGcv7an4imqePsW+IjURrRBDoEf37p+olaBGWBGTeV4HZEDPg2iJDW7
 3K9xtSldrSRkVHCFSwzQxJdg+H+geotsn828FoVxBBPlTOKiBpX+wl0u5LD57aiXN4Wy
 piINUd46kUstA8aYwkAHEVGBzPIhdfkp2+iUL98tis5v43gHQ+8TB1VRUs07VmTG4Cr9
 l4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789915394; x=1790520194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xt+CdIEzCePBACsGBelJhpgnjOEuCSLYMrUb0iTMgYY=;
 b=ep9SPNyhfUt07vfyGl5HGjOhfN/lFQx85IiMFDLDi89IyhWg9dFODkbhDZm87mNrjt
 fQFOaAUsMJtw/rd3M4jRCsFuGvTP0/WLU9kbJCez9tq1+Np8lkuHJ9V5wN4ejV4bsEDm
 OVrKoOEIQc6QfhyO6NlXM61HdWQpsA2ct0y9rRbildq7t06xn505kNY8Bqv92CiexIKz
 +6k4SUfT4RsMBj3RQnSMC9CrD0/oSQgcGdA24ArNwuSzN7+11U9O2Ifpv8J3XCi0LmdM
 EwCBR1Irwdft9seCY1ymBrjL/RFSnZAiRxPsbZtQn7Jn2hwCP9Eyxp5Uyxm7cKgnG5BT
 6Sjw==
X-Gm-Message-State: AFuF++kF3xC5XADSrjtHW0fsB+8ruOXlCAvnRFpyddVWP0kU9UDa8wlk
 pcshHt33m4VK7xNm2jb38vitz7MwNYTIpyBJy2vIS1il3c0Z9a2SYgGe8iKJR5/U
X-Gm-Gg: AYBFou1B4ur0sGtUPZYk3zsrwrTWgHGAChymrYH3yoMZptpvIg8fl1NwyJ35Gfftidz
 GGr9biX8CXwJggHWAa1bWDNA9R6wFyCNU5KbxIfI30V1A7f46eqjponpPud7blZS7BkBn6nq9Nm
 22/ltvLM0QKcjCx/F3eErUjwUWZQZOqACBXw52jfbvGJ64rPJ133xKL0bKr5s3MttHDYrZDYIMP
 i7uw9r/XVVv/Hn7wi0bhCAzmj+5uLCpYiWEUAOp7lOwZA7Dum4FCOeE11nysCtz+B8n24lcVmdf
 Dglb0xh8VmLP1+FfOHP7DRl1PwGhZZ4yye2JQWq5jmbBmDpL0noPQLZysjgnY15OfIVXTFXYYWV
 2yOExzP6CJsY95LvaSe/HHEJRbDTk5W9USCCXc3Jo3PBSY81GrdmY5LiUwD1EVwp3PhM9+YsB7R
 wljrCErXxZNmsUfIos0D4NQBKLcUtWWEogVEi6z7b9OA94YTn9ffghiklPlzIVOP6svacGDm8H3
 P8npWdsGayabqgSws66aESvatt4Cm3QqaLGjhQ4uwz2ME3ypfml6EcL5rP6YIC06omu8hX7OYiW
 6Z08HG9H/r1/
X-Received: by 2002:a05:622a:1111:b0:532:8063:69aa with SMTP id
 d75a77b69052e-532b71ec4ccmr60911291cf.6.1789915394112; 
 Sun, 20 Sep 2026 07:43:14 -0700 (PDT)
Received: from
 runnervmlun5p.uu41n0oldp1ujlswsmg00di1zf.bx.internal.cloudapp.net
 ([20.127.247.150]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae2c6a33sm43182171cf.0.2026.09.20.07.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 07:43:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun, 20 Sep 2026 14:43:13 +0000
Message-ID: <20260920144313.11003-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920113519.1138936-1-pavrampu@linux.ibm.com>
References: <20260920113519.1138936-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugefallocate: Add hugefallocate03 to stress test
 fallocate on hugetlbfs
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

Hi Pavithra,

On Sun Sep 20 17:05:19 2026 +0530, Pavithra wrote:
> hugetlb/hugefallocate: Add hugefallocate03 to stress test fallocate on hugetlbfs

> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <sys/mount.h>
> +#include <limits.h>
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <pthread.h>
> +#include <signal.h>
> +#include <setjmp.h>

Add missing #include <time.h> for time().

> +		if (err) {
> +			tst_res(TFAIL | TERRNO, "fallocate(PUNCH_HOLE) failed at page %ld:", tpage);
> +			thread_err = 1;
> +		}
> +		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
> +		if (err) {
> +			tst_res(TFAIL | TERRNO, "fallocate(fill) failed at page %ld:", tpage);
> +			thread_err = 1;
> +		}

Drop the trailing colons in the format strings; TERRNO automatically appends
": <errno>". Remove thread_err as tst_res() already records the failure.
Break the loop or return early on failure to avoid flooding the test log
with thousands of failure messages.

> +static void thread_fault_cleanup(void *arg)
> +{
> +	(void)arg;
> +
> +	if (fault_mmap_addr) {
> +		munmap(fault_mmap_addr, max_hpages * hpage_size);
> +		fault_mmap_addr = NULL;
> +	}
> +}

Use SAFE_MUNMAP() instead of munmap().

> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);

Assign free_before = nr_hpages_free instead of reading /proc/meminfo
twice in consecutive lines.

> +	if (thread_err)
> +		tst_res(TFAIL, "fallocate() failed during stress, see above");

Remove this check; tst_res() in thread_fallocate() already marks the test
as failed.

> +	.hugepages = {MAX_PAGES_TO_USE, TST_NEEDS},

Using TST_NEEDS with MAX_PAGES_TO_USE (100) causes unnecessary TCONF on
systems where hugepages are large (e.g. 16MB on ppc64le, 512MB on arm64)
or where memory is limited. Use TST_REQUEST, or require a smaller minimum
in .hugepages to keep the test portable.

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
