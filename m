Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5648FCD98D2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9113C3E6B30
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:08:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C8933E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:07:53 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEFD760057F
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:07:52 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-5176bbb9384so13756401cf.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781291271; x=1781896071; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msU/I+5i2kP0y2E/1GSNRv2i71p4IBzILFlkzjOBysM=;
 b=YvXsowHCJM65HF7jvrwNp2999oOJlslZHQN/PLFLJ33HWOGecUbDRolKuMEQ+bUVWV
 LflnY1VnRBG45k1c99BIRPRNSenJboBXZah2A7vTkgX9AOlSS0MdowK5xjp/gZu0Et3B
 Kv6yDnvJXJ2oTWQPwTDW+olYXLxh+voyJbDyOVT3YMgUX2HeYHIpuqczgr+sPYDCHDru
 y+EKv/o4iCjeSJCBG58FtZOQqmqbr8/fi80k6EzT7FkdBN0jJZ2JIfKxqulB09eGPDcd
 wqJ3zByfXfvkvWauPNke6aYoyzQFMSjNU/Vaz5U7fT3XCcWL02CPFwbulh1m9UhZl2Lr
 NVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781291271; x=1781896071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=msU/I+5i2kP0y2E/1GSNRv2i71p4IBzILFlkzjOBysM=;
 b=HvpwCiERQKdr/EVUtsBvtCtksRljIuWfpv0ydASFLMf8XE6ELM2avSC7uJ1YlxOQb5
 ZxKM4r6/8ZVdR1qACVL/Ykmc0xx0nlR/FLD593ZkXFRYltRgYnqeZCVZQrhldgp1Tonl
 NZqloI08KsViSa42YX8L4ECSgm0igK/YcEaT12RB1xoTNH79Iuwg66UrA+w82gl12ak0
 ne4q60g1G56p+2tb0zXoyNQTkrpX1DLQtHaMybnnclwKxxEY6okKoxr95rtcl+RlQZXZ
 FnOrRVObeIdQULtXJs9CJlc0+kKBPk9Fy+G2nog22dcu6XGpBOn6vx/Ssd8sZ+iP4XXR
 rEAg==
X-Gm-Message-State: AOJu0Yz1OmEpuTbh7O5lJCPByKvQ2xBjS7XSRITvUhDVy9eC+A0QSHnj
 BR7TwFLcU6aFyIJo3EKgwSoCM+7SlFpZkF3Ymc+z3LwStLTRjjAen9rr
X-Gm-Gg: Acq92OEDyKM8xaxOn2UlWKZWaxlJLhCSKyiPNBtu4NsDqaAwKMJrPeA8iKvnB73WtLr
 gVYHq5+SZ9uQxtD1BEnEFNU6BVYmdOxMthgvT4mgxx3EMx/ARu6S/9XiiDfJJTnDcgDpaIAzcim
 bpCt4rxoG0AmExWvCWgO2c9ZGIC918AnzdUSh6eSMHmUfRmw9Y2x0yotNf+H69DimdauSoTtkdZ
 /aADnfQ94uLfVY3TAhHYjQpMvAHjQ/xgsEKE37TjxxywDDKCs96Y/lCFS1bzPepPfr6j8olb3ZC
 P+28FiANr2DO3SOwHDtUDDJ0ipdOekH7fLnDEn0D9Coo0XRg75ZvBDfY+oDsd7ImyK9anbUQE+S
 3ZkOiaREYfZCHB+F5Jyr3aiD+KTOTujI6FHWs0lxnxmxwHpMVcVNC7eVz0BaE3tanfoArHnnTRe
 hOgJJFXRbOzznYHe9qwlnT8EA797Ypi0RCm0JKacXm39HENQrrQwaUt5yAg2BMXbr7CrfU2/q3N
 4PalY8FlRDWAGlOSuzlmtFfqszl10rGGG69TEs=
X-Received: by 2002:ac8:7d50:0:b0:517:7104:4e95 with SMTP id
 d75a77b69052e-517fe51a948mr61132211cf.17.1781291271555; 
 Fri, 12 Jun 2026 12:07:51 -0700 (PDT)
Received: from
 runnervm1li68.rze12ljwu0nehbzdfv15pjp0bh.bx.internal.cloudapp.net
 ([52.179.88.113]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb642541sm29687201cf.10.2026.06.12.12.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:07:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 12 Jun 2026 19:07:50 +0000
Message-ID: <20260612190750.3946-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612163808.293181-1-avinesh.kumar@suse.com>
References: <20260612163808.293181-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_security.sh: Use enforce toggle to trigger SELinux
 measurement
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

Hi Avinesh,

On Fri, 12 Jun 2026 18:38:04 +0200, Avinesh Kumar wrote:
> tst_security.sh: Use enforce toggle to trigger SELinux measurement

> +	orig_val=$(cat $dir/enforce)
> +	val=$((1 - orig_val))
> +	echo $val > $dir/enforce
> +	echo $orig_val > $dir/enforce

`orig_val` is not declared `local`, unlike `val` and `dir` in the
same function. This leaks `orig_val` into the caller's scope.

Should the declaration on line 145 be:

  local val orig_val

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
