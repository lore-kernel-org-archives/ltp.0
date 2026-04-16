Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484BF8A140
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 08:03:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097F63E297F
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:03:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AA543CDBD8
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:03:00 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12055600160
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 10:03:00 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8cfc5941028so1111136885a.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776326579; x=1776931379; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpHru6QosnpeLX/UiUL1pzdyF1uKp0ihd/6olAW/jEU=;
 b=iI2QhUUtfE1SujepNzGXpuvsXuwJlv3ssZVxjRmPfWdeCv+aLiQo8wfPqAn0lnDvfh
 0mP6BOBVBIDKD9VmiIy1Ss6Dz0l7TkuPZJNIKa3KFuRYIO2LvWaGd+GnOKy+6apXAPtN
 oczFHoKDPs5jgau49+aDM60FXr7KLtDe8ftj1gbaMg/1m2CT/8/4MOTHX2iYDGms4vOp
 buzYBoTX9CdSSbK7DyeB2zz4ryyR7gtVZEWI/O9UZUVTqr1zaAmu6f1JRnhQJSLw8bZo
 QH+VsXQtIHoAqDyvk57NA3MzyDPpQIY6VCFevMDEISceVzH0n1defiHNSgiQiejGJXVa
 K2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776326579; x=1776931379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EpHru6QosnpeLX/UiUL1pzdyF1uKp0ihd/6olAW/jEU=;
 b=FYMW+cl6J/HOmdQHovtBo3EEQjfaj9i4B12YFbA8vqk/LVLanA0/bwPMAasgbxfvzb
 uVMA2fHs0PSsfnLfimLBPPZQxyNenFPPRhOnqu9ArYTfqiYmqFsGD92uUuoNTPYS+pT6
 6tMWlJAW808kOwAqFQlqGVN1ULNdK4k4JQaOB3e7+iBkYWdfV/5do9UEIpeY4BVEuVlN
 /c8n8bLQwgSSon6ZaW8T6gYiSIWijYLa4cIOprSVHf7DDkSuRPUuX9Go4ImWlPJhYqmg
 K45rc2NMDBl9gTC8AILG/FKaN/55LFkjYiRjomO56FpRqPUAnLoMTGBg9LJcVdH1etdB
 AHDQ==
X-Gm-Message-State: AOJu0Yy7iRA2hVGz8hT6tUo0BCM+bhxhATw9AVgK+vYEom3VYQ/QXDq5
 WKN/WtbgLH8/G4B+me+aqCcGjxP86B80RdhahF3CjxSZ+EnCDe3TmMTy
X-Gm-Gg: AeBDieuqT4WhOrA5Ao9a4cy6v0DmVfUhxJuFWHErwiE/BMoG7rTBKk8LUzncPo/hW2d
 PMrUec6omrdyFKmFKzUGbESTLYe3O7heBnn4BDKch6ba6T+bZsLoW/7MN2nAmSuKFV0Z5d0YwzO
 3pSi07GdVfNt3gXmKwXe7uaRb2/FVb8FUYLtaS1Vo4ixChtMuB07CzqBx0RpP961iK59i73crhR
 CIdWoD1PyKU0oF/5wGwE/hw5F7phuaAqcKXmGu6X7ZlmQHeVrLyVZpnnO3im7LUdLf3t9v+kjoU
 X0KQiQZYDu0HVKW/Jex2Db3SRSVwWWs/DNFPvpxzQ9ez7IyxokuHlo7NYlBCY8FO66QQtZ4tSrG
 zX+fc0+hpLFYO7URiP+FQHwe2IyYEmmN5J4WBzYEISnsmRWUpZtKNAMNiCEjCEABdftlOvUm+XO
 +eFE9i5ZuQPYZOuNh9K5mga3yDz6VwtRzuqkzPtPSSrYOLiBZX0XDRpTtKwye7Fp8HwAUI64nfk
 pNCRpqusxv5W6ZZ/sD3gRnbywI+LMpnvzmPSveU3vQuFc6KvvQ=
X-Received: by 2002:a05:6214:2122:b0:8ac:af6d:6934 with SMTP id
 6a1803df08f44-8acaf6d70bemr237900536d6.13.1776326578778; 
 Thu, 16 Apr 2026 01:02:58 -0700 (PDT)
Received: from
 runnervm35a4x.bbtuyqy0xgnulbf4x1n5xyw1wf.ex.internal.cloudapp.net
 ([64.236.176.196]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cbbbb2fsm30863866d6.34.2026.04.16.01.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:02:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu, 16 Apr 2026 08:02:57 +0000
Message-ID: <20260416080257.4077-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416062302.15804-1-sachinp@linux.ibm.com>
References: <20260416062302.15804-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Add test for READV and WRITEV operations
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

Hi Sachin,

On Thu, 16 Apr 2026, Sachin Sant wrote:
> io_uring: Add test for READV and WRITEV operations

> Additionally merge io_uring_init_buffer_pattern() into unified
> init_iovec_buffers() function that supports both rotating and
> simple character patterns

This mixes two logical changes in one commit. io_uring_init_buffer_pattern()
was unused by any existing test; its removal should be a separate preceding
commit, e.g. "io_uring: remove unused io_uring_init_buffer_pattern()".

[...]

> +static void setup(void)
> +{
> +	io_uring_setup_supported_by_kernel();
> +	sigemptyset(&sig);
> +	memset(&s, 0, sizeof(s));
> +	io_uring_setup_queue(&s, QUEUE_DEPTH, 0);
> +	init_iovec_buffers(write_iovs, NUM_VECS, 'A', 1);
> +	clear_iovec_buffers(read_iovs, NUM_VECS);
> +}

read_iovs is modified by READV in run() but only cleared in setup(). With
-i, the second iteration starts with stale data. Add
clear_iovec_buffers(read_iovs, NUM_VECS) at the top of run().

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=500082

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
