Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3476C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 02:46:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6ABA3E91BA
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 04:46:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 255143E2448
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:46:04 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BEF9B6008B9
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:46:03 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so407150a91.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785465962; x=1786070762; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qDkmWf6mIP70yD+rf1QOlyXFkzIxUoolCopRaH833jA=;
 b=Pe4nhHsMnGsu5p6xy3zCPikQLGlE4Vmhsvc0INmVJq2RgPP+snQY8lOn8w1mm0HdCz
 BiB15xeUGSRCbbVekR/oBLaeVpEdL690bjTv2AyRNKokmu8wXQXwK/I4BqZ6Nwr8rAAq
 AmxSg9tkpcFJY7Oa5xOfrxRRVtQwf7xxxyUo75WUki45Tnmwg1wi+67vblIqEm3OL+Fw
 e9jBfrHw2PMNoZ3cUeUWXrH0y0bK4dTVoAfNUP2/aSYgSrciZQQl/2FxupPwKHfXxzHZ
 MVMbbZ1nMCuLIlcqPPDFGKsnzgguY/2MjSAARtRAVv/df3Y9qXvYZUb6OLtYg2WCzVrW
 CKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785465962; x=1786070762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qDkmWf6mIP70yD+rf1QOlyXFkzIxUoolCopRaH833jA=;
 b=XOo7mWglWgE8o3iN2qa/ZwtOrotxkrG4DDuHPzkCeN1vwjuYIqLmUNwfsWDfxJitOh
 zJBWLAfMBx6MFVCl0kK2gCMBSRDHoa8TMOmXHcqG3/12D1dsZVeL6m2j6iA8izC855ec
 kxpE1ZpS+WWhwrm79WFYORQWQKfopacFsUk8uJ38soNsLPUt5B5OeQU8A7ytaG+hNtlh
 fayivpBthi03U0wVBPhFZbG1lv9A5LP+eqELsiHyxopQlXX2YpR7fkHqP7itwulpapqk
 9MYq/VZFqx4EWopTQhHWRvYmpPG+fV+aPBEWVpbk9XR9crT1ZuQX32HZKKv01CY6Ip+v
 Skbg==
X-Gm-Message-State: AOJu0YyWyWvwYCYJvtmwdHgf91EimcsU7ClRfRymVe1xDKC/Nz4NiS8w
 9X7S4NBanZSk8M4dVkcm0ezx+AVgmIrw4ERMomlJ7ShQ2+Y2i/rywjgnxBBJc+d0
X-Gm-Gg: AR+sD12/aOkj6FCLmvP81r5NmOv0IWBV20ax2KmSLhC+gQt+TLl+FOvwG4qefYO0ozB
 29y4AW5yY9FkF0bqtVIOxrJtixi7vCYNDAEdXq0o4EEIHM4i3VtgIPjkMQTc4zKLD0e8Uyg9Kpb
 ICdMI3EXJHE4lDCINAiIa9kFY2ZO6oo7vMCyr+OJ6pJGeONs8zGnCN3q/vbjRjRTqNvaFximGfi
 rEXg4yzH+lLSSjtXKggUcL/Za8L14XkbWkhb7AzHAlwCOk+0UrBo9eQMhXhF6l75+1SvPXvSM0N
 tinr0YRV4plzj+dLven7zJvW2Wbepow8eTuFFgBf9JkTENFYl03m9xRotUEIl5HP+ozu6L59x19
 nGQ7yUpi0er7TAyOaKpKH5aCLnNwFjwBENFTOBN/owP6kB807+up3DCmm2tlM8DJXzjz8KXG+7L
 fS0HNXAyI/B5XXSlqMxdbFFeLayZX9aQYfmtzbZFoHBc3vlqtLF4501SM4avnvv6qm9OrequvZG
 qfm7ctltpTSwU1rL904nNtifZaphN0qnZXzWjb+9rtCnpG6UX/g8FQOKKqeM7nXBmY0PY3HbyZk
 4o81r3w/gk6cpw==
X-Received: by 2002:a17:90b:3e8d:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-38fb10dbf62mr340076a91.6.1785465961861; 
 Thu, 30 Jul 2026 19:46:01 -0700 (PDT)
Received: from
 runnervmvrwv9.acetfemrqz3u1j03i5qnonozqe.phxx.internal.cloudapp.net
 ([20.168.110.16]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153ab8dcb3sm884856eec.5.2026.07.30.19.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 19:46:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen@kylinos.cn>
Date: Fri, 31 Jul 2026 02:46:00 +0000
Message-ID: <20260731024600.3976-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731014953.2756261-1-wangxuewen@kylinos.cn>
References: <20260731014953.2756261-1-wangxuewen@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/functional: fix memcg_failcnt intermittent timeout
 by disabling swap
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

Hi Xuewen,

On Fri, 31 Jul 2026, Xuewen Wang wrote:
> memcg/functional: fix memcg_failcnt intermittent timeout by disabling swap

> +	swapoff -a 2>/dev/null
> +
>  	start_memcg_process $2 -s ${MEMORY_TO_ALLOCATE}

The 2>/dev/null here hides errors from the very command that implements
the fix. If swapoff fails, or the command is not present, swap stays
enabled and the intermittent timeout this patch targets can recur, now
without any diagnostic to explain it.

memcg_limit_in_bytes.sh, cited as the model for this change, runs
swapoff -a and swapon -a without redirecting stderr. Would dropping the
redirect (at least on swapoff) be preferable, so a failure to disable
swap remains visible?

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
