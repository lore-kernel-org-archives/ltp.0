Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9016EC44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:22:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B2013E569F
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:22:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE38A3E1D74
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:21:50 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 727051A009B7
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 14:21:50 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-38dc4f9462cso1512289a91.0
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784118109; x=1784722909; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IZcm5DdtJlGgeZ5EIMH7USnAqJblvL7xBd9twxWJVTU=;
 b=ZtNujHX/sBxn555HrFwp6xqvkUDcIWXGImadUcs+Gtkua5+slqtVUOP6/sU32iACiy
 378cU8TX98zJl9r3DtnjEqN5SWDficF76jj1v3Eiwp7BqWngrVOh0KuPwRtarPTYlfBm
 fMapxqGahkLbJwZEZ+slZwqyuny6li25VXdEedTOUHZYTKslRww+rYBSsdBRCcDn4HH7
 mxV53m14106zQs0gV2ANcvv8mCAg3GVcwlX9alxceyJZD4T9kJhuF9SAvj33ufO+pKPt
 goXMRKwHD3/rKffMPaXzyWTmyQWqewa0+o6fhV0QbnlWq8cJrk6zfZJPOLvMnHgLLzpA
 p11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118109; x=1784722909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IZcm5DdtJlGgeZ5EIMH7USnAqJblvL7xBd9twxWJVTU=;
 b=sspS+BDIBBhAY9wFVKjW4SAU49N0ZMBzMokPDYbRsd5NB/O1Kw7cR3/dEMqCfLKl6v
 +xNrIKRIZxBrLktScc1xeaptb0ULvZ8HeMfm4y37TH9MhAESFZ/FIy+DcNLEnkl0ha1Y
 YGZ4ajADxAT3ep46+vHA5okldzNcAhb+/ZoomyG9VP+2LPQOdmwkWJZhyFC9HJ6U6WGG
 RnW9VDr1mIkVYc+KEtLtr2tQvArFcBQl0PfO8aCCxlipvyLJ74KNEjTvk7G81v7nWOSd
 tjz9KJG5l8bl+eKnN6h4W2bzbCSbvRjgugJi5OKID3XP3o3C8D0gxaQibFSptQy+bXj6
 r94Q==
X-Gm-Message-State: AOJu0YztugtDfuzGegNQUwvxKEgoOM0MkxxM49tDKzhJXJcfJX5kfLyt
 sXBBnPj2sWMdpmIId5rDMYbe0GjTqhtahKqaMb4CKjCnWELbQbD7hyZMEB3sER4V
X-Gm-Gg: AfdE7cmU5aYGg88wpaMz2sSjfSDofPS2UIxvtwLVw4oWIDmgN006YBNe55LvOy43U78
 MjxXDim/kEFY1uJYST2Cw140p3zh5+gqO8fGWKiosWlm8IGcUQ6W05+IY4b0546m3w4qoJ3wjZj
 rZL4D2YYXIWtra/p9ZCqC2tzRq6Fb0fJiL/ZMedFvP8b+udOegMeFIi+o9HwOM01GgaT/irw0tI
 n0yba/GWZEcm2Zi1ejVJC9/J19jfmdhmdK60cWOCtnvN1pYtYG6Cw5Pzr8i4ugmWEzmYAqe6s5B
 +KKmHOLEdc+Sd6k00jVkTGEqbeE2Aza38gYyb7MDnQyzQZhpokSuu9e3gHJx2LDRUy5Cyd52/sI
 AbXRZNZ5HFNkHTmcEySUCeG9R0nO4s7Sqqb4iooQAFpyn1mcxDARPShiq40NyE4Oh3sb2+bGh4E
 GpeLKygYsXUi+o9p6k+8gXcoJ0Zoq8D40eRkHfZ/9HxogIRwGeX4JlOjiLCf3nnbX5L57rL+BUr
 rAWM/ipHPhVlO5fNChbddOPQ94BsT4=
X-Received: by 2002:a05:6a21:692:b0:3bf:9abb:a8be with SMTP id
 adf61e73a8af0-3c36c2ed54fmr2625525637.41.1784118108582; 
 Wed, 15 Jul 2026 05:21:48 -0700 (PDT)
Received: from
 runnervm3jd5f.33lp1vhd5baujjdqnc05fzatnh.phxx.internal.cloudapp.net
 ([172.182.244.9]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd4284a92sm786079c88.4.2026.07.15.05.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:21:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 15 Jul 2026 12:21:46 +0000
Message-ID: <20260715122146.3894-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-hugemmap35-v1-1-1d5911d1f2cf@suse.com>
References: <20260715-hugemmap35-v1-1-1d5911d1f2cf@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: add PROT_MTE fallback
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

On Wed, 15 Jul 2026, Andrea Cervesato wrote:
> lapi: add PROT_MTE fallback

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
