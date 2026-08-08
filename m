Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E42C55174
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0CE3E700E
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 19:33:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192F83E5C9C
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 19:33:24 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92855600136
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 19:33:24 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso206990a91.0
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786210403; x=1786815203; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPfT2vZnWLXxWqvh99lWHjQfKg9i/lfZrF8ozHLRaHo=;
 b=ar5PqyiqXN4kZsG0ud7VqytsTJSqo1t/o6Vz2V7dVhRnDr9ZZROnfOWx9KEbwfMW5U
 mdpYaJywd4KEy+QbyLfj1SYttdsEoHYxHu/9Aif/xaB2igKPu6DfRmZcAwkcpQUwDo0/
 jBkieaqA5oYBuXk20Du6TbTCk1oOai/W1P74YCNBoFQ1ZyMoa07B2zLx4LmIiOBG9VuQ
 +tx+e8N49FOX44P464Dap1lu5i07GKQhO1weg4G+N3osWD+M3QQPD/NvFNhXPDQ2YMbf
 Yxu+PKLtyJKBWM+6yXwOXD2ZQIzrhhevpxE4RkCWpwUbjLJX23+z5noGlbPUbpbArQmC
 bUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210403; x=1786815203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPfT2vZnWLXxWqvh99lWHjQfKg9i/lfZrF8ozHLRaHo=;
 b=qAyZExdODKE05PLxAjYPF23N8gGxomUQL3sdsx9C7oiX6+zgP5u2Gu6Iw8U5MyG1oR
 mbxdYYX7wzW+XfuYoLd2CXxicZ8xH3y7tYc0eUqUIrL7XCm/z7O1v07D6zb4ngcU43A9
 it3QZK4vw+Z9xU975XMW/16BzEXkUBue7foVfSraBoX3hfzmCFKqoLXNhbSvG9kSQ6Az
 9vvlVqz63l+ngSWMNUWwI4nxMbQLGHnCuvsN/0QPIjsPbAIw+UC0EMeP3XlwsSRiNpvD
 k+ehKh/BijYx1e1FDb8t1x/TTueCNKJ9iiLz3oR8/Ml1hTA6y+M0OUvOeuAFekSpkogs
 ETag==
X-Gm-Message-State: AOJu0Yz2wh1Li6t6Z+mD6eHx/pTAXagwYrR/flNdQnn5weimIWXe0cPR
 G/vVQKfMiDGfAgXecsOvu9IfgSe5VQ0fe4OGSQ7W68yxAlatmNJf+2GL
X-Gm-Gg: AR+sD13dE8PhslFK8ZAJAcmAb3uVUcqIkFspKrWeBMZ7AtI9+4WMp7mFwYvGPbVLNGa
 0LVG766f7wjMBlsYn7m2Vh06dLYY6vPtjG3QL6XH1aSCWAVv9neaTkGWN5FlD2xqOeV1CG6LwfK
 X52TQ473QNPISz7JrhfeZx3DqZ+e+8jI9u2Goa0ZGl/jiOAoWIuDbmgM0JePXZ7CJDr+2SHovcS
 +ONKvxgxoW5GKbLb1U2ossdBwVWe5XCMSx+xoENtDuxdoKCPj1I/AwGSt9EqI2Q932x4D0gj1Ey
 zfRTV0gFuJrT0hhUbWRirIwK0Ae8ZptB81cJEEo5GLvvHhVRNep82F47lNYsTIZqbFY+fA6EuvV
 pqXbKfXIS6eNY5ynYkz03Su1BGSldq0385wninkhnvNb+dqzReLNbRvafoLg2gKn1a4JGNRzIt3
 zLDdd/fGPFF95LQnTh9XMD5v0hmc0ikLcZ9DbM8/SJDh2pXSJzcas0BzDTd6afbeoIAOAZFvH2e
 3ScQdyTB5NlXgsBSHKIbrdrcAZn8xvf/i5JKWfROGFPpHtgLLbwqVJbjzOYIpLkR48RE8W+XJ0r
 Gyk=
X-Received: by 2002:a17:90a:ec85:b0:380:f85c:94b4 with SMTP id
 98e67ed59e1d1-3909d8075eamr20024982a91.7.1786210402860; 
 Sat, 08 Aug 2026 10:33:22 -0700 (PDT)
Received: from
 runnervmvrwv9.fkzuwk3srtzuziqu02k1cpypyb.yx.internal.cloudapp.net
 ([172.208.158.163]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be568bd3sm21022389eec.0.2026.08.08.10.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 10:33:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat,  8 Aug 2026 17:33:21 +0000
Message-ID: <20260808173321.9129-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808170245.1548019-1-pavrampu@linux.ibm.com>
References: <20260808170245.1548019-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

On Sat, Aug 8, 2026, Pavithra wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

> +/hugetlb/hugemmap/hugemmap41

Could this entry be placed in
testcases/kernel/mem/hugetlb/hugemmap/.gitignore as /hugemmap41 instead?
New test binaries should be ignored in their leaf test directory rather
than extending the legacy testcases/kernel/mem/.gitignore list.

> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,

Could spaces be added around the "|" operator? make check-hugemmap41
reports this line as a kernel style violation.

> +	TST_EXP_EQ_LU((unsigned long)TST_RET, CONST);
> +}
> +
> +static void run_test(void)
> +{
> [...]
> +	do_poke(cpid, p);
> +	do_poke(cpid, p + getpagesize());
> [...]
> +	tst_res(TPASS, "ptrace write to hugepage succeeded");

Could the unconditional TPASS be removed? If either equality check reports
a mismatch, this line still claims that the operation succeeded. The two
TST_EXP_EQ_LU() calls already report their own pass results.

> +	.tags = (struct tst_tag[]) {
> +		{"linux-git", "ebed4bfc8da8"},
> +		{}
> +	},

Which ptrace regression is this tag intended to identify? ebed4bfc8da8 is
"hugetlb: fix absurd HugePages_Rsvd", which fixes reservation accounting
after truncating a mapped hugetlbfs file. This test neither truncates the
file nor checks HugePages_Rsvd, so a failure would print an unrelated
missing-fix hint.

Could the tag be removed, or replaced with the full 40-character hash of
the actual ptrace/hugetlb fix?

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
