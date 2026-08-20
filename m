Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A6EC5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:49:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71DC33CE094
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:49:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 426513CE11E
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:48:49 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1BA70200250
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:48:49 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so383348a91.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787212127; x=1787816927; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pfGeAW7y/df2qmt81b45t8XswcAoA5BZPSsJJK3zb1o=;
 b=QlWOnizns7RaLKim1SBP37X1LDVva2m45Zlu7B95VvcqYYRvTVfAJW4EUsQJWGhUAb
 cu00duZcTXtFkmHmifYlEglLPJ8+W+56krOu+e7LM3H/UOkmtW1WJQ2sLTIHpA/Nac3F
 e8xZKXNOJLRQV+QiC+H08mz5P1p/SBjEMzV26CZ8VZLNfm6sM2Vc8spYysYLTvXDlaG7
 Jg97rz+aXi7F8oYnjSicQsrOEHuh7l2rynQIqsbVU2EQem0JyLLn0uvIMBnk6CQ8kgsE
 FuGxUsHq5uK0Q56K40hqwNTAtN/6YxbkLF97R5e5CwiMiIwKLJ94kXW+TWjRFRmmRUxI
 E6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212127; x=1787816927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pfGeAW7y/df2qmt81b45t8XswcAoA5BZPSsJJK3zb1o=;
 b=EFD1B+8H66aUt5luVIP5KUZExqldMW1UI2aHSZWhMnDO42cq7c8iw+2KW3EnuLlcre
 2wu/+4P3nOju/lwzQ1tTEoKHEC2foyssaJscOkQoB5Z9+crM1NchlW7ITRvBlzmGTsI8
 fGWEO+AbBpR4dTGgWyh6W3iyWxXmofO6KgBR4hteISIvgO2AGEwCPRASoet5R985yO6W
 +MmQ3gV0mcP5VshtLw8iGsCgyh+GJJT/HCJtsQYITQpDuPrrr625kKMaYj2fokEAqXvX
 OvjdGrs6LbF9VOlWWj50P/sIJgn9gNVKL/aRRQrC/jOTlM0+3nkdzsXp67y9UJqZ0RYy
 MOGQ==
X-Gm-Message-State: AFuF++niMqOEpHmcx+zWe+z0x37tAoUwHN8fNgJjOTcb33AcWmFwerpw
 5iQ0QTbq8UAmFN1ABMpv5QeaURywV/WuKB0/eY31MMKrwGH9g//F7SHa
X-Gm-Gg: AR+sD104hrfZIyqJzErqCjbd7Mg04z1lTcj/rr6h/97Mkp/QfzcMHgnGY7NDj5ziEWv
 QegTRQM4lUJ/hXC/LjO/VPLXu5M31CACO0UMB9SUE596PUEtZw7hgQvgfwQ8hmoKTk2U5R5L96P
 Stphst+EmuCb/2bNL8pWrEXTjLROxZof6WENFy7fyT+OTVbsLl/vQVd/ZjF/P0U4QnzpG72RMwh
 Xe4UwZAEZfBraHCG8L8YRbn49qxB4D7Fx8vMCJKtZf3MW41MK3ed8sqeHu9nH35U7cjadV6wcYZ
 caHNwHC0Jf3EVLhbu1UAqXZSrMjSxwpXwCK7CPHPiu9B9WPu7fq0eMZkvs1augVSDhevLwhkidW
 aoOjF/am4QxtgPOuNUKRhXXx57CulGKc6Z14fZcPP7R4XuIEuXjYWVclyvNk+MVPe6NwBelKJmi
 KwX58HxMCNNcRTcTutTojGZ/PuCGCVE7awS5RagX2djYlerDf+Mk9YVqVMGZ4RKa6e7MAfGxHfd
 SydRQlR3XoRF2kuA6f5VGo2YczS6hUSJSCjjV/ZX1aHOdWOpNFnaWilP0Xi3OCqAQkMjQWV9BMz
 EY43sA==
X-Received: by 2002:a17:90b:3804:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-395813f549amr19399687a91.12.1787212127318; 
 Thu, 20 Aug 2026 00:48:47 -0700 (PDT)
Received: from
 runnervmzvulz.vwvfytfcjaberc2f5qen2hdd2d.dx.internal.cloudapp.net
 ([13.83.236.193]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad564bcsm15371216c88.5.2026.08.20.00.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:48:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Thu, 20 Aug 2026 07:48:45 +0000
Message-ID: <20260820074845.8900-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820015708.46189-1-samir@linux.ibm.com>
References: <20260820015708.46189-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap43: Migrate truncate_sigbus_versus_oom from
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

Hi Samir,

On Thu, Aug 20, 2026, Samir Mulani wrote:
> hugemmap43: Migrate truncate_sigbus_versus_oom from libhugetlbfs

> 	/* SIGBUS is what *should* happen */
> 	SAFE_FTRUNCATE(fdx, 0);
> 	if (sigsetjmp(sig_escape, 1) == 0)
> 		*((volatile unsigned int *)p);

Why is fdx truncated before faulting p? The original test keeps q
instantiated so that the hugepage pool remains exhausted. On a kernel
without ebed4bfc8da8, exhausting the pool makes allocation fail before the
missing i_size check, causing SIGKILL instead of SIGBUS.

Could this truncate be removed or moved after the fault? As written, it
releases the pages and no longer exercises the SIGBUS-versus-OOM regression
described by the commit message and test documentation.

> /*\
>  * Some kernels have a bug in the positioning of the test against
>  * i_size. This bug means that attempting to instantiate a page
>  * beyond the end of a hugepage file can result in an OOM and SIGKILL
>  * instead of the correct SIGBUS.
>  */
> [...]
> 	.needs_root = 1,

Could the description explain why root is required? LTP requires tests with
.needs_root to document the reason for the privilege requirement.

> +/hugetlb/hugemmap/hugemmap43

Could the binary instead be added to a .gitignore in the hugemmap directory?
LTP requires new test binaries to be ignored in their leaf test directory.

> 	SAFE_CLOSE(fd);
> 	SAFE_CLOSE(fdx);
> 	fd = -1;
> 	fdx = -1;

Could the explicit assignments be removed? SAFE_CLOSE() already sets each
descriptor argument to -1, and LTP's C test rules prohibit resetting it
manually.

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
