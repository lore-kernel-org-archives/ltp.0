Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500DDC44512
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 05:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A59AD3E1F19
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:55:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2EE3C241C
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:55:07 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0E67600AB8
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:55:06 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-9032b580ed4so43479516d6.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784699706; x=1785304506; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p6Mxhj0NY7i5IVpk5wYFvlx6x+lUVxi4jYJfcz5Ko/s=;
 b=qijjHZEU17wxcerEv/DeBKbm4MrW7LyvYoNNo0EudBvZDN6Ya8Lq/GmIqjVTUvw25E
 vdTfi1Xh9gMak20bHdRnFRVxlQmXft0txHe9G/WG2XCTUBnKX3rzcamnABV8qCdmaOsZ
 Mj+2yAY+ilygJZQ6+MR2DlFcmZOp3XLY/Md3XxSAju5B9+9q2Xm6ir2qghIwS8MAv2RR
 ymk5mqQRpiz3rK0IkmGPg099hVu9oT091/TNXebITUUZOIVuvzq20UzXCqOChD9+MQGh
 j3JwYuqfOqZh7lDAmSi2M23l2ptpuLks6EKwqzkNwCHOxVVuEdCcNqwAeFu1BI9+lQIs
 IhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784699706; x=1785304506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p6Mxhj0NY7i5IVpk5wYFvlx6x+lUVxi4jYJfcz5Ko/s=;
 b=J+aTwjBdeNK9vlh5ED41fuUyKOcrlJgaxlPiOUUHkp3iCA5mSHDMDFbheF/au6Nuf9
 kCVuYbV9/ygwau7MjYc9IWCZ7JIi3UDlRrBp8223CSnT7Tjh3LMdempdc+Rtb71SwfDu
 fOcyFQULWKPcYajxPbgRjVB1ZSVNwqNh+1DenUTldUMcSpiBZ3gyZBqE+IQjDimQVmQu
 q4c7iXAXVIcujqqIp3jmQO9zIVhEPBmZ3EdLxJJ7gTctXqjgtr63i1F2+eu2IuI4miND
 IK13RnqNdqibfGiVaccRTjrJ6pqUTPUQiXtdMiCVzDLRx7NffAwmPmQGwf+0aE3T1/S+
 F9+g==
X-Gm-Message-State: AOJu0YwKpldB1DREJqzEwifccVDZhnJFsoVCld5ikbsaLBe7Dn9EQYof
 CIxeJaPDiHZenWymke6bGobQ3LXJmN8y2RozOM5yanwACmsDmXZag8vA
X-Gm-Gg: AR+sD134fMaegDPMEr09ktymlK0rhOZ1XGe24+GzGRP5WGzPEVrxjC4Ex6N9AtrTh+o
 Io4VXAYVDshKCQK75cZYhwbNsXZBXUj4te2sqUr5JiMSacxEZ8gfZLyJbgIRTB/gIX0eOr66TDY
 sWr+5X7oIzpefTyldnNVPIty5u6jordF6bAeLRqe7Q4EKXJ983MS3Cj4ByOJRJG/3xqxBFlYu31
 JSWhl9e66T1aZaYwb9By6nglzsQcYO2974jAjn71uDy3BCOHTKB5sZ1S8duDLwo4AeYx1SRk12l
 JAjjUq5b39GHFnARqY9k5F7ohR/ufZxOOF9AenSfTkZj5DE3ZXFVSPBaKEdzo/mB/TKt1YfOtVK
 ffY8YPB45qFji2Ns6wtPPRhgKtiVb09yfq2wXJqfIVmX3iEO/Dge7AUkO9WDaQkmV5U/obWjKPR
 mkdu1yT5+EnZsc3UyCHIUqL6A0KFdTltVR9k6L1FPVre6R/44at28Xo3vnEXUxmxwMbkd9mxWSa
 V2PiPrYmmWjjNvI
X-Received: by 2002:a05:6214:4284:b0:8ef:e3c9:533e with SMTP id
 6a1803df08f44-9077834e631mr244912796d6.9.1784699705674; 
 Tue, 21 Jul 2026 22:55:05 -0700 (PDT)
Received: from
 runnervm3jd5f.azxqbe15tnoejktjlqhfjvh14g.cx.internal.cloudapp.net
 ([48.214.53.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907baa27361sm13419266d6.43.2026.07.21.22.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 22:55:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tang Yizhou <yizhou.tang@shopee.com>
Date: Wed, 22 Jul 2026 05:55:04 +0000
Message-ID: <20260722055504.3912-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722054125.197919-1-yizhou.tang@shopee.com>
References: <20260722054125.197919-1-yizhou.tang@shopee.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] perf_event_open03: Track SUnreclaim growth instead of
 MemAvailable
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

Hi Tang,

On 07/22/2026, Tang Yizhou wrote:
> perf_event_open03: Track SUnreclaim growth instead of MemAvailable

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
