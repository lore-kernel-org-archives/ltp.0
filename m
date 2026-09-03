Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41342C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:59:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6DD03EB095
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:59:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C05253EB0A8
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:59:26 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E69621000DBA
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 17:59:25 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6b1b1ca0f3aso274771eaf.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788451164; x=1789055964; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k90y3jxkHpIwle/iIOybOwegC5ZyVc3/eyvJr2xUssc=;
 b=HfqrMiB9DEPaL9ucQezi9uxpuA74eLfnTkKtkKcOwI8/ENKCGAlZcL5xKm3dn6Z7tS
 CXWLctnCgo+q+LccIZU948K45R75ZgHRYv9yPTbj/KqdTSJQtoOaSl0aMhl/V0tUhBUp
 hCcZmjGay6UQ7hOu/ciR0ePC3yyHqeOSAhxRKex/4px4YwWlSdOw+b1ayWU+u4GVzlHP
 s6BDKWIvzpTMAp3wnY6ygyzpBUQEL/Wb0JX9Xljh8V3e+5OsaXzMpzgUYZu8JNlwSBoN
 BcOZPXz7QmLEMlfsUYQjdS+xyp0YAndRdsN8xEgied9cuBATrNWN01FPdjO57ngyiulb
 TNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788451164; x=1789055964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k90y3jxkHpIwle/iIOybOwegC5ZyVc3/eyvJr2xUssc=;
 b=XzlSlx/ZvKUCJkSeN+/qfLwyLU+pIaMq/Shmtg0JIF7SRxcuqNV1rJ7tnr63XQkpWR
 ZLAa/LHSd8Mg7epoVhzDYE4mSBH6cJAtGNRnMrskhaHBAiVrSBRH30OeePtXj87NLInA
 0d2xbf9xvT3+cW+5nyVgZx93GH+ILProbxGTmrgBI/r9n1LXh2//xCaP9yHFZrrzacXe
 6iXBSd5vuq3xqt1ALq/MHK8oi5zhGHdYiBUlbqiVK0xJCUJCqbRD8aiRemCvGRVBMP9Y
 pGKs2Hcx0qFUrVHjtaKZuFsraxkt0VQiON0QskbIWKDxH8kQ7zSAtFlMnJbQmzqnw638
 ADvA==
X-Gm-Message-State: AFuF++mlv77+9uw8fvN7E6a/J9Rnw4JPBy4NdfH1N03xrnsAVXN3Af77
 D1kwHinx6pCtOu2Q+6qDqFmkTuPwXcM8ioecaxwcmq6xrEtoK/GjHqPN
X-Gm-Gg: AYBFou05sfawRk7peLLArRhSElCjHV9KybtGlaI7gyBaEYJxUZtK7g2Aznkd4aMTz9+
 Kh6BVaPtfmE1IgJedpAU1mpg3jp5DoYfAeC8l4TIFPWNF+pZwvGqxWhI1LwWFDzsUcJyyP/TYxs
 GgsKVFYoyYH4PUDiEvluNyMPymzskfmdrN97qClH0WhcuJ/KgVpR6G5vGnqN+ZL3HyVh6APtjJc
 3NspAungNTY9uNDvZbOCWIfVOqRO82985hrokAj/0LCnIugmQFgJCXM7bi60O5iI08z1NfF5sK8
 BHXMX/x3cEgqiM4a86btccFVZMn9taokXUyVom+X6+a6ZvMZRAvBgHWbDZLh0UEAe0FHHpNZuTG
 AYYeydXwRgicAjRmDu4Qo97qtd/PU1I1lxDAPQkkT5s10jbU/6nkUJ+HxiBa0Oh1QHDL4e+25bI
 2ylJ5SzpTuAWptG2VgQSCPAySRXi8J/mTpmx0vD7K1fU2X/TMCeRxpnpNH64rvRDeEfiRRI40fx
 Yq62tHmmdhrafM3ZAYNj6uwugvUwhqKNEdGMKF0/UQ0JfEGyzLZiYsVyFzp7o2WfrZxNlWvehk=
X-Received: by 2002:a05:6820:1997:b0:6b1:8ebb:7efd with SMTP id
 006d021491bc7-6b47bcc0ff1mr12384869eaf.4.1788451164520; 
 Thu, 03 Sep 2026 08:59:24 -0700 (PDT)
Received: from
 runnervmgx7h7.dbuonr3pa2ke1den2z05x4ud3h.ex.internal.cloudapp.net
 ([64.236.169.6]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f72d3d3csm272691a34.18.2026.09.03.08.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:59:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Sep 2026 15:59:21 +0000
Message-ID: <20260903155921.3989-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903124631.1100746-2-pvorel@suse.cz>
References: <20260903124631.1100746-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Remove testscripts/network.sh
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

On Thu, Sep 3, 2026, Petr Vorel wrote:
> Remove testscripts/network.sh

--- [PATCH 1/4] ---

> The network tests are executed by running the network.sh script:
> TEST_VARS ./network.sh OPTIONS
> To run the network stress testcases, use network.sh script, located in
> testscripts directory.

These instructions refer to the script deleted by this patch. Update both
network README files with the supported kirk invocation.

--- [PATCH 3/4] ---

> Run the ltp-aiodio.sh file to execute all the tests.

This instruction refers to the script deleted by this patch. Replace it with
the supported kirk-based procedure.

--- [PATCH 4/4] ---

> exit 0;		#to let PAN reprt success of test

run_cpuctl_stress_test.sh still contains this obsolete PAN reference. Remove
it as was done for the corresponding comment in run_cpuctl_test.sh.

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
