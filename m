Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE1AC79F85
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 16:04:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98A933E54E7
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 18:03:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C93E73C325D
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 18:03:44 +0200 (CEST)
Received: from mail-oa2-x0a.google.com (mail-oa2-x0a.google.com
 [IPv6:2607:f8b0:4864:30::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3497F600078
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 18:03:44 +0200 (CEST)
Received: by mail-oa2-x0a.google.com with SMTP id
 586e51a60fabf-476ed83b7f6so577183fac.0
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788710623; x=1789315423; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FhMU/GYo8YCOtOQxvfmYpFC8FoMkiBWazuD/oDIqOLg=;
 b=P2Gp6RUwS4pSznQ375bdWeTF1H8ZR5nHhOcHdMvSpLA0vJ2Ht9PCmXvBjstZvM2G2E
 4oZWqnt77WvGCyDNREEZG7o922cFLFZJSBACC/axvXLjA805ny0mPbdHkG9ROCYvXvli
 WWBA5qTvtylCE+OQAD1u29pF84DSikUM7y4owj9dNA5+HKrj2PB4LVgnStul/QB5P6rS
 51S4ELkQj0WC1rmDsfu70TaGOge9sclCfy8d47AJxG/WO1xW5bXiqh92iu7cByl4D86r
 RMOYT3as9Vn3q2VrhLiC3hHkur05CWPsSIvdo8WF61gqm69sDjurjf+fEKCvV12D+5tm
 y+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788710623; x=1789315423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FhMU/GYo8YCOtOQxvfmYpFC8FoMkiBWazuD/oDIqOLg=;
 b=FThpipHW14iCNkAV5HQUhMIaqiypCmcijUpG2/MwmVVQs5iD0H70JgxMetbMaIOrI1
 ZOMhcdXRgzYOWe2ko5eQkM4Fb2MC5B21sJEJ+qrFClCJNGQkhhLK6f1U6R3DN/8X1da6
 ZHnnXoEnVYqOvls6gDseY+cgI3SEfM+ztBhAbDHpINuGq1LXyXECHeBbrg3pKmSVPZGy
 57ilUvqENVfaKjocT3FXWxmOd9B/ZdWjQufW6qZiHtRmqw5zNaLV05u/7YJ2M4M7lsmX
 xUDGu5lTEBBA5TwgacDdJYFXF5zjgZFXswq28pqbVtVaO01SHBF73MRZvjQs4Lx8T/Be
 99tQ==
X-Gm-Message-State: AFuF++l2+GF66X67GMyCTZ992CUvnG30whv8jKcosK/qaX+HBW64ZJpk
 6cvlspbn2ckxJkeQ4z764YMcVlzkmR+vxjgpHN9rmaFwKeiYHxVxsKin
X-Gm-Gg: AYBFou3uHd4jYkoYDInW41daPOCBxQHUAC70e+JUEkLn3QhNc35jHnouZFiwxa5Rw9Q
 LD/dUgWSyys9xoUku7EQTT6ziYFWtDrTRBdFvMG93sCuyRVC/JoVz7g0UziFplKwjrknJmr6OcM
 UvLD2dRmW4ovIOFoniBBYq3tUi86vKr5i2FNBV9/1J6iR/GIbp77YBdzBdJ4eFpiyF6oR0PPEzO
 XK5O/sc+TM/j8B/fw3MdFomOjCp0MnQhID7lRWBD1JsVMLDq/qP4uZebTXPvbyeAXxMW065Mah7
 kY2oS+pri4o/3X9sTqMBbfTux2+nUoON8qp/kV4iXOV4nU5l/guVZWzdhwVSkCYtPf0IW5dN2sR
 Rwrjq/hCjWkTFtrXUkFOCWx1cqymJfiW9ymWaHFkjXShNCspivum7hes64bMGv3fnZS/MYS6uu7
 pN+m+M38aDMzaIGO/5fjvXKKAyBEKQttsgkaUOwKdaoCPIaNN2CajbTbYvK8dEPyBRf3wH5NnPS
 hOEupJW+unpgM5qqvLXXFXckqVe9SwWolOAqJp3gBYYkLTEnArnx3+lwkc0wvAum/UztHwW0d6p
 jw==
X-Received: by 2002:a05:6870:9111:b0:471:3325:80ca with SMTP id
 586e51a60fabf-4754fd0e32emr19222782fac.5.1788710622777; 
 Sun, 06 Sep 2026 09:03:42 -0700 (PDT)
Received: from
 runnervmejwal.5j2jo0nuqkhuzhctjlm4uo4bda.gx.internal.cloudapp.net
 ([172.212.164.17]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475543f5ac5sm8101136fac.8.2026.09.06.09.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 09:03:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun,  6 Sep 2026 16:03:41 +0000
Message-ID: <20260906160341.9140-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906150634.1032407-1-pavrampu@linux.ibm.com>
References: <20260906150634.1032407-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota
 accounting
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

On 2026-09-06, Pavithra wrote:
> hugetlb/hugemmap: add hugemmap33 to test hugetlbfs quota accounting

> 	TST_EXP_FAIL_PTR_VOID(mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, fd, 0),
> 			       ENOMEM, "mmap over quota");
> 	if (!TST_PASS)
> 		SAFE_MUNMAP(TST_RET_PTR, size);

An unexpected errno also leaves TST_PASS false but TST_RET_PTR equal to
MAP_FAILED, so SAFE_MUNMAP() reports TBROK and obscures the original failure.
Only unmap a successful mapping; the same pattern below needs the same fix.

> 		{"linux-git", "a1e78772d72b"},

Use the full commit ID:
a1e78772d72b2616ed20e54896e68e0e7044854e.

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
