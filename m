Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E42606A32D
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pPoRAvcP
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CB783D0706
	for <ltp@archiver.kernel.org>; Sat,  7 Nov 2026 11:52:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2998D3C08A6
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 11:51:47 +0100 (CET)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6B80560063B
 for <ltp@lists.linux.it>; Sat,  7 Nov 2026 11:51:47 +0100 (CET)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-93f184dad7aso112530785a.0
 for <ltp@lists.linux.it>; Sat, 07 Nov 2026 02:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048706; x=1794653506; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AaZ4QVgJG5ZKHaWp8yKYY17+tWJ8tKadTbmeMYP4uUg=;
 b=pPoRAvcP3WU8X13jG7wkElbQT8J6s+7YABgJHEKODZi3mUI0JHfFo2WUj52CORayj9
 QP89s0nBM+fDMUpVyx8802h48OHQcvHeRpDfVtMY6vHoKWzgQhrh1OF2lbFKbLBbVmvF
 ZwzbGaiaEHLIZGx+W02xidusFpkxBr7IJg4B5duyrGQLTFCRd2yFdhyyAcJJjZ+LOQFW
 QPMo7SVCivkwWboRbm4OWVphLkEhCWwg9dWniEymWIsI6bXtfN08xDC+4hPYEgX72/pm
 hb4twfFvVgEagZOeK0iD4ia3fSf9cwYNJp8BQEAx6sMCODtiDvomyLMD9UHH+rEflJ0l
 qNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048706; x=1794653506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AaZ4QVgJG5ZKHaWp8yKYY17+tWJ8tKadTbmeMYP4uUg=;
 b=KuyZ8SbJFXw6gxAY3YPRcAnKCY3PQFU8hjxUSKo2FqM6UiOiNnSBnIHZLtKMhwQP2/
 gxjW9EGPW7+gcDxxCieoMUTiOeUe+rQPaGLd7DHZLFMOHUae3mob4pyqV8IyLPwMOQyv
 F5kupIdAKBAZz4rIoRn666apCCAz97T28hdZPNI6x29fTJYK2gUdfs1+6dukp0cL7Jsx
 xhvbJVueaCosgytCccCx+hTq/XD3ee+vvjAf394euFGHeppWix8VmKHjTgupf6pOI+2g
 B2NeeKfrOeNGsPJuUp6pcIgKkaQiwciz00jVzh0fwtdotSqccq+M9Tfg/Omla1F96AOd
 EeEw==
X-Gm-Message-State: APuU4Z/9YmpXv26Y7wtHZuBGoqkXEtr9EIp56XFXDQZFsXRUfXQrlPa5
 Kr0sUZGnQ8N8/baH7UqSlAA7b6aSQh6CyJXqOVwM096VZdj8Hl8/ar3u
X-Gm-Gg: AYBFou0FOehDP4E8AMfMJx8E4mqWX6H8bR3H5uPEVICkD4Of8QfMB1rbNJOMGBLF93s
 qSbw7+RLX9gLsN3OLPQQLo5CBjp6XbhAp4Mjqeq/cyG3jlS7WzgAorKXGlp9aTUIzMp0CXrMDIu
 t9DpbHxZAIq6hd5xopqoZL6y7R/aYMChGA1ldbuU3FyLADbupjfjkJ1hbgq1H+8cSFMSe2f/E26
 L/PEr0BAXhpOzRa8TxJjOhLV8MNZ8QgGnD4bT6w3gjPyr8xIejN9hy4kz/PNTFdil0bnArFWHfs
 lAJI3O/OmcIwr6A23KP5yahQR9R6lY+P4QEpCDhbicNC3dpE9lwGrTb4IyRjtYLC9KPivPZ2qtr
 jlWSrmczX9RowzTYbTr56tQoatvxD27eeZzkRNzQZoA2ZIgOsQrngvVp926pSo1LmzwnFnaAnf9
 YpKML1qfGAR9goH0rRP28i4omD50cqtbRaXWvmrm58nWlC+tZyL6h+mPI5zXLY6ytCILuLA8a1z
 AlNtHsTxYVbBtWfhSaAqlC1uJn2jTdRLLJ/MgDWUv3rXfF6lqg4Mb8YsvY0tUxZcJESPlhXhXYM
 NC1hWas+9i/pR4Bio6hm7n1V1ETTU1/Cw84O9IiUXYjfTa8d0ZfELwe7BXZhvMEDzS0RlU0Lb11
 5vgcao8fmhsfCt0GZoE8Gtw3jV457rtW1ioZeyc1M5Xw=
X-Received: by 2002:a05:620a:6085:b0:93c:2c15:e510 with SMTP id
 af79cd13be357-945f353374bmr705917585a.37.1794048706159; 
 Sat, 07 Nov 2026 02:51:46 -0800 (PST)
Received: from
 runnervmwuk1x.pymbk4rosloebn1wbs3h1bjgzg.bx.internal.cloudapp.net
 ([57.154.217.185]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945f5c0445bsm342620185a.34.2026.11.07.02.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 02:51:45 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat,  7 Nov 2026 10:51:45 +0000
Message-ID: <20261107105145.4103-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107062811.79329-1-pavrampu@linux.ibm.com>
References: <20261107062811.79329-1-pavrampu@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugefallocate: Add hugefallocate03 to stress test
 fallocate on hugetlbfs
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

On Sat Nov 7, 2026, Pavithra <pavrampu@linux.ibm.com> wrote:
> hugetlb/hugefallocate: Add hugefallocate03 to stress test fallocate on hugetlbfs

> +#include <pthread.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <time.h>
> +
> +#include "hugetlb.h"
> +#include "lapi/fallocate.h"
> +#include "tst_safe_pthread.h"

testcases/kernel/mem/hugetlb/hugefallocate/Makefile is missing
"hugefallocate03: CFLAGS += -pthread" (or "LDLIBS += -lpthread"). On
supported distributions with glibc < 2.34, linking fails with undefined
references to pthread_create and pthread_join.

> +	for (i = 0; i < FALLOCATE_ITERATIONS; i++) {
> +		tpage = ((long long)random()) % (max_hpages);
> +		err = fallocate(fd,
> +				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +				tpage * hpage_size, hpage_size);
> +		if (err) {
> +			tst_res(TFAIL | TERRNO, "fallocate(PUNCH_HOLE) failed at page %ld", tpage);
> +			return NULL;
> +		}
> +		err = fallocate(fd, 0, tpage * hpage_size, hpage_size);
> +		if (err) {
> +			tst_res(TFAIL | TERRNO, "fallocate(fill) failed at page %ld", tpage);
> +			return NULL;
> +		}
> +	}

Each iteration punches and refills a hugepage, which zeroes a full hugepage in
the kernel (e.g. 200 GB total for 2 MB hugepages, or 1.6 TB for 16 MB
hugepages on ppc64le) and can exceed the default 30s timeout. Set .runtime in
struct tst_test and check tst_remaining_runtime() in the loop condition.

> +	nr_hpages_free = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	max_hpages = MIN(nr_hpages_free, MAX_PAGES_TO_USE);
> +	free_before = nr_hpages_free;
> +	rsvd_before = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	/* First preallocate file with max_hpages pages */
> +	err = fallocate(fd, 0, 0, hpage_size * max_hpages);
> +	if (err) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate() Operation is not supported");
> +		tst_brk(TBROK | TERRNO, "fallocate() failed to preallocate");
> +	}

Because .hugepages uses TST_REQUEST, tst_hugepages and nr_hpages_free can be 0
when the system cannot allocate hugepages. In that case max_hpages is 0 and
fallocate(fd, 0, 0, 0) fails with EINVAL, triggering TBROK instead of TCONF;
check "if (!tst_hugepages || !nr_hpages_free) tst_brk(TCONF, ...);" first.

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
