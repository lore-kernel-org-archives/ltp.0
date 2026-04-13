Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC33F531C1
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 18:06:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B98C3E4B37
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 20:06:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B213F3E298E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 20:05:50 +0200 (CEST)
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com
 [IPv6:2607:f8b0:4864:20::a44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B2EE600197
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 20:05:50 +0200 (CEST)
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56d85881a68so1588589e0c.2
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776103549; x=1776708349; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj7yAlQsAUPy+r17IlDNttX5bKcM+2bxlG3i8gnFTQY=;
 b=BLw+JC6D7gITjKY4NydtS5XPo0fKDu4OaV+sGWdqRKPBZoQx6+4J9No1XilEtVNb/G
 svvfOEZqtxu565CHixVLTX746Ce5KdncmD+EhoFKAVQg1jk6d+wAulklcDuJFa052efz
 7fk624RykxeDbFFsoEBT/Q8kFqcMBuK1eYvbXto47T9b1Y28D2oGhT9cnfC+5e4kHawj
 0RjSTpZ6bIqtIURCXJ8KfKU203rPK1oF2uLhDPto1ipQ1Q4pWi8WyIZXXQRSQMWNn7qx
 akxCqqFIv4FvOm52/6/x3q0uUBDjgAwnXPCC22LKEiqKYFab9DgGW9Z6vzRZk91HdobK
 aJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103549; x=1776708349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gj7yAlQsAUPy+r17IlDNttX5bKcM+2bxlG3i8gnFTQY=;
 b=q/goE01YPiYE0CY364Y8Pj9L0b4UowrLVqwfYI5PwGdDjV4ruLaSUpcUCnYcFBaShK
 aEmPqV6NKwmYWT1gZtONUT5klXbIDqTq2HfzO+plfhyg/pnzmRJR5VWbEg0iB4dkP5QL
 ge+4s6Vfg+Drlf84NDlQ4wzyfzlsGhIy2JDGw3TFUiv0BDnNj0BYJk5CzSy1+Rdgwdef
 a5aPEYpEenpCWT92IMaNipXvWJkkzmZ9b9MCQOxp8YPu4iK564E/2DrBp8OnhIUsQwBW
 IDNv1AFteV1RAJGslI04uww5keD2xz7kdd/blgAmOPZb1zbmCYfdC2/eNhyZXF9f9Lzp
 zwXw==
X-Gm-Message-State: AOJu0Yxi21VoZcUhklZ7vTsal2ySQFaeTh82ALsjwDoHjEaxJq+zBifM
 kuGsOMUBImxOdZsgbFWLU/E9L1ZmsCte/Qx2QyAyZOYqtxwUYEpiPb/H
X-Gm-Gg: AeBDieuALp+ziHdFu03GvA0dH5GpkZQ14OtW8xOqZ9PUOU5Bci7rkmJD2PUttMKdXcm
 N0+oqoFbD2PTTBrAre2zcWABOqbgYreMTVkjVDBPj2ZD+ga88X8sG4hKpKpWXaf8SJig/yHsXSQ
 y+EbQivyymwxLlC3wiSVBJ1KBUvBfY1WmRlwaTSVxIAuxOmY36KfU7ph6QxxWZWXY9tMESnoY8l
 WEnnDxSWyI8t5cJJgJVtjJ1kw42WDZ58MUHs0Aq5t0d8l4dnFDNv7Z53Unw34Tw9GlHas87T8tX
 h+NqEucFVoMQ3HcuK3B/tClRlJo+6x504JyeEMmPaODthSr16k1GBiwEJCz0/l/raglJK+Y1TYz
 ik3v1gl1RTjYPedjW6h0XgeN2Ttc/4LfR9rirulkKFqBPjn8vNx8mV34mXoj96RdSGrLwUv30+t
 igrb8JRYGXCCf/Q/FW2EO65+P8oeCZn3RuIVE3aqfCQxb/9gAPr0MCuhf0ABiorQwplNyBLr4Wl
 6dkssZ8mTI/Z3i+0BGQCM2SZRkQAZhJ74o=
X-Received: by 2002:a05:6122:1796:b0:56d:b4d1:3c06 with SMTP id
 71dfb90a1353d-56f3bc687c4mr5588649e0c.9.1776103548805; 
 Mon, 13 Apr 2026 11:05:48 -0700 (PDT)
Received: from
 runnervm35a4x.bslcbgspqs0uxa3w1b2aduhsbc.cx.internal.cloudapp.net
 ([20.161.45.114]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb5f88a19sm882634885a.7.2026.04.13.11.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:05:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Soma Das <somadas1@linux.ibm.com>
Date: Mon, 13 Apr 2026 18:05:47 +0000
Message-ID: <20260413180547.3854-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413180725.411367-1-somadas1@linux.ibm.com>
References: <20260413180725.411367-1-somadas1@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mq_unlink01: fix EEXIST failure when run in parallel
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Soma,

our agent completed the review of the patch. The full review can be
found at: https://github.com/acerv/ltp-agent/actions/runs/24358749020

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

On Mon, 13 Apr 2026 18:07:25 +0000, Soma Das wrote:
> mq_unlink01: fix EEXIST failure when run in parallel

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
