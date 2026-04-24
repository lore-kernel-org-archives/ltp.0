Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1401CFE5200
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:26:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 928693E5345
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:26:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 515BB3CD9FD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:25:45 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 000FE200AF1
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:25:44 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50e5eb0fabaso57813591cf.0
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777026344; x=1777631144; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dioPi/MUqlLV3/xoH9vUxUBGUFt3Klnx633cz5uwdkY=;
 b=f6HIWdbgtUOJOKRH6T4j5mZgyBgkzZ0+RTjpIyv1216AtD3NsYVkUCNvi73fbmC83E
 I6vo6G1xHU3qrLaS5S4SGDlwAdNrbZ1sPs6NTAY2DFsy3sCXdMh02y4oQXna0Tm7+PX7
 QAunOtI+D1aSw3SKwDtu8DwVcnj/F6Tqb5bL0VmyH0ivQw79xL0TFBjF6AkgUWWv6SVv
 GDiOiM2nevlUAKXMG6pF6ugDH3FKzYWJRB3ZsSYx81AbTmvCtzJ6lw2DoByILU85dXvY
 TeWTIU+IiPM1gV9e7Ff7QgSCezUrABYTYpIS8KfflMRPNgL1grOJrYJmoixWSSutdMJ8
 vGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026344; x=1777631144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dioPi/MUqlLV3/xoH9vUxUBGUFt3Klnx633cz5uwdkY=;
 b=ek1o6S5Lb8rZQyN8BZlvuRTANIE3jaSFuO4L+KMKWAC/zZM71e8byeLAC6gWVBavaF
 ZhqifFm8P46f9sUar5PhHbcRCqc6zBKWkviS78Z33eFyrNJ4bWzjE2u2YTotczxqnTnF
 4Lsr4ygXVOGnYbhGwR6jLW2k65VDe4kpUkcU1py27Na3AQGwiWaUTt/WRKYbQvqgF9Yx
 v24Gc+IH/zaq7NdOZGw/h7bxiyH0FcZRt0zr6mZorJw8wBt7pCek1VICGGj5fJRFfBdb
 qqlUDhiV/r1OqlCfajkdYn+yrGMpOH/XX8AlzC3eWjsdRBZmpcm80oPZCJjkKdoN8vlP
 COCQ==
X-Gm-Message-State: AOJu0YxLmDi3pZnJnI//NK2q1gC33+H9/vAPiUQw/rr3AoRA/mYWKdeF
 5O7vqhxrkhiMaN6z8/RmafE9DbUmbfJg5lAkP2mabj2yfXkKCkd74/9b
X-Gm-Gg: AeBDievX9nXoT1loENmRMCfd8w9qdSr+zGdDh1HOTgnsF0rS/uawpKPZj/O/CHhs4tT
 XUUeEfYZTtKeIHx+KwZiUCowMxAGBLEJJ9tLo1oUqQxnsXk8cLpaEFrX8XWtmFKynAaGhAeHTSk
 gvcEpl8/SsbKiwp5BrYLXhRSuAvHi7XqMkIr7RNEmV/XCFXkjvoOMKgtsX5W+2k2COUQqTGvLfO
 gV/nciM7PR/48d8+hO/eIIaYako2YsJq5EAytIjYOlDNnlbWsxQn0pbik5zhTnBLEow4KKvie8t
 YQoNPspZuKl5P81tlhpw4rGfznXGZl1u6b9t+8M+ejSMzN3tcJU9znNpQMSVpBM8XoETtFmIfdS
 qLccAIdNCdjvvyfAfmYllfv4atUdEnDV6RSs3stXYRLk7JsXYRcwoWxlz0qbW3ecBqDQ8MgQxl2
 BMtgIdK9/TMMmWmTzNqZ8Q/897oLPGXk6YU28vO7HYuWiyKaHai1YmUAxOt4/00dmjAA+zY9ScQ
 fgzaw2EgOCnbxoWUrWnV46lnoN2s9Logf36oZI6amA/G9wBhUA=
X-Received: by 2002:a05:622a:1446:b0:50e:d316:fa33 with SMTP id
 d75a77b69052e-50ed3170212mr295917871cf.39.1777026343765; 
 Fri, 24 Apr 2026 03:25:43 -0700 (PDT)
Received: from
 runnervmeorf1.dkjmlu0qx43exgo2czqhiqv2jf.ex.internal.cloudapp.net
 ([64.236.131.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e5d5ecffdsm132612491cf.29.2026.04.24.03.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:25:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2026 10:25:42 +0000
Message-ID: <20260424102542.3916-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424093919.500059-2-pvorel@suse.cz>
References: <20260424093919.500059-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Update spellings to next-20260423
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

Hi Petr,

--- [PATCH 4/4] ---

On 2026-04-24, Petr Vorel wrote:
> checkpatch: Enable more checks, disable ENOSYS

> -# TODO: document reason
> ---ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,CONCATENATED_STRING
> +--ignore CONST_STRUCT,VOLATILE,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,MULTIPLE_ASSIGNMENTS

PREFER_KERNEL_TYPES is already listed in the "kernel specific" --ignore block
added in patch 3/4. Remove it from this line to avoid the duplicate.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24884570475

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
