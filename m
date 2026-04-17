Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7939F43687
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:23:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831823E2954
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:23:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BB0A3E196A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:23:02 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C467A600A58
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:23:01 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7dbff06e4a6so501161a34.1
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776417780; x=1777022580; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLfeyPvmQ57PlCJvbSSoZnbQT/G5CJ7ThAqa7N+/7DU=;
 b=q21qbwYn5Uup1aiiCxmbB6ETZegRhkuhqXpfJCfQ1BFsGzNnMZgQBOBVl8ki/YrCdT
 GGj9mcxTCXMX3orlbM/WnGr8tOom6ZEmF/2cXSEc8yYjlEPwRy70xjeMunJP1qrXOXks
 5VMKzXv81e5ttELNR+1enAh0uyAj+YKuI7hMPF0qJ0FYD0Oa8zmy6SpK56RlQ85GfL1v
 UNOQNBdCYnar6ia2Chg5YR4S5sXdaZ1vffO+QAaJZpJqW3drEUgE3qGkjYrSrt1Rgb4h
 Zts83sCzaeaW66jBFii4KNRW7ux5wxCBXlhUQvPEhzBes3iNQv67NPBuVmNAmmNlyukU
 LrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776417780; x=1777022580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLfeyPvmQ57PlCJvbSSoZnbQT/G5CJ7ThAqa7N+/7DU=;
 b=Ht0f5ZaKTzfF0q5ZCrSuiDvrJ3ZciQbLluWvDEfEcZbtljMtOK1awndWN0SVApHD7f
 igz5i0lDfk6aUwCSvgagcymHz8XlDoVqAe/3w+zXzqoczx7YnDwc38jUsXCHLrFInWn9
 YHSs9fQVaH9Kq0RTc9PS4KXToX4C2Sq73GRdPpan3khN3QnFtc2DF+8N7Sl49PKSIiV6
 9M8eC+jMCCAKmb67Q7W0s15IuUoaIdBqlfShCcWKkY7fGVxRi0iOOufoz6YpuDLCD0JP
 araznhr3tlGfv2mvOchEK5YVvJ82A/YkcpnqdZ4SAYsQCeAxN3RDZfzERy4/KnTTzW3W
 Xd7w==
X-Gm-Message-State: AOJu0Yx2b2BIhpGRrqpbpB5cp9icDmUj0qlZRtaUpPgICyuisOXg30rY
 I1G7kJAVRSXhuWGYogZ8AX1CJZdnEVr/jrpqWBnN2B6DZvQNrJ5O8SNG
X-Gm-Gg: AeBDieu70rZPhZmbaB9mJG9HzuX33FB6LudRxdL6PbI8k5Chr3/tWceSzsew9+aqMPq
 B+C1S7k2DPinHMIZ9uQVg0dzY2cVLELSl2TRny58e9xuUPdFRqtkaXMSFYFCnNaGQYjlmNpHW/m
 bgtafzhygj7iXSBQmdqBlEh/NKxeXrFEq6mVqNGyZzt8k7qpxEvjL/vWwBH1NkdkgEk/Rf5M+K8
 zgbcQCfLOIjYEVqO6EcxUNxDeS5xMBGLGWw6c0pGHQ5lw0nSSlbKVPhE9jaIBHju9v+3eS3P0BK
 XmmfTwUB4U17zyCTrkydVr1en0BBbkQgEikB8u+czCQbBBk2i+mD4N8d4R+Y5dwvxEciZuJfxul
 zwTbRNLxkllWwJwdsNrPMpMtNu0Smg4ReqE2lSuZpF8LMB5aMFspaZlmQPr3ZeJd4Y6+UpFppM8
 pldDlvbe9KTsjY9Fm2NkYlczNDiISAbGHyZLKk9k2/Igw3dZXr5zVUfpHUSmD7R94o0YmEJGd2M
 HSimr1DaMLyLPsEiGDADpf2N8NYIFzURnbKdV5A29JYZFsbeA==
X-Received: by 2002:a05:6830:7305:b0:7d7:cea3:6d89 with SMTP id
 46e09a7af769-7dc94fc94ecmr1260024a34.4.1776417780334; 
 Fri, 17 Apr 2026 02:23:00 -0700 (PDT)
Received: from
 runnervm35a4x.xplmaoejahduziehhbpepjkxga.gx.internal.cloudapp.net
 ([52.173.181.17]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc97502488sm754129a34.5.2026.04.17.02.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:23:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hongtao Zhang <zhanghongtao35@huawei.com>
Date: Fri, 17 Apr 2026 09:22:58 +0000
Message-ID: <20260417092259.3879-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
References: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tpci: Unbind/rebind driver in test_assign_resources()
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

Hi Hongtao,

On Fri, 17 Apr 2026 10:29:49 +0800, Hongtao Zhang wrote:
> tpci: Unbind/rebind driver in test_assign_resources()

> +			if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> +				if (dev->dev.driver)
> +					device_release_driver(&dev->dev);
> +			}
> +
>  			pci_release_resource(dev, i);
>  			ret = pci_assign_resource(dev, i);
> +
> +			if (ret == 0) {
> +				if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
> +					int attach_ret;
> +
> +					attach_ret = device_attach(&dev->dev);
> +					if (attach_ret < 0)
> +						prk_info("device_attach failed for endpoint, ret: %d", attach_ret);
> +				}
> +			}

Properly unbinding before BAR reassignment and rebinding afterward
prevents the dangling resource->name pointer UAF in /proc/iomem.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
