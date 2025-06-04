Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9AEC5B543
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749047884; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=s0TxCLn8qXFgmYQCf5/n6aX2yubpDapMPbYZ/qSFfZE=;
 b=myGuiNd0Dw40UFV7UutTEbkZIXYLawWUHT1oZCyX94rAT+gYO9lwYVqQrpOpJOWGVyjy/
 zq/7cc5rxJyHMHqOBK1dlfN7PGyM5Dq4enoGWiSszZgk2pjfM/61HpmPuy4fcbtCJgH3Y65
 MelJ4/EqU1MaHRijJ34YxWACmwh698g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD7A33CA148
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 16:38:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3F763C91D9
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:37:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8309E600152
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:37:42 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so2944774f8f.1
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749047862; x=1749652662; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bn1UGnnFT7O3FFvlkvEhkCHobFXOXGyL5X7Qx1nsJQ=;
 b=D8pW2RB5FRpJflPK6+LZyLY3o/jI4YzIwiFZ6MebSu0OpCdcO4Beq5zl+ac6dgmRFs
 Kd8jvqMEu+zyUKjYRZjQOQ8oFdx8/wh0v33CWQ58CKsHoA2EWdvqAMiKiY1FZnDVr7Jf
 nkDeWOO8KfjDq7PZHJ8oOnP/tAo1Oqk8b9sP/aoTNaDALb+tgC75Wo6M9hGpxthaMuTJ
 rGm93O6JJyUpTQCATMYlzmnPlyrP7pxM4lJxUBltsAj6ptbJIOsGlekbWSmHZcoAwyHI
 Mmlx7UhL2zG5YXeUM/U43CQwfyWx55QwZm3WklQWHKtreJ8DXe9amsXUr+Fan9ckqKwM
 23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749047862; x=1749652662;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bn1UGnnFT7O3FFvlkvEhkCHobFXOXGyL5X7Qx1nsJQ=;
 b=GUDwKLEQ7tv3AqWWRmFPnZ1Hz5phLaKZ0YZkMXWbXEL6y4ybPcs3g8Mx/dzINTPqZm
 amqDcOvf4yAb48o1XZ97SC+Tlr0M6ZYBIQaX22JoiLOGKklakhHXywAIYlRgwBvD9bHv
 9aMbNWYASg1vxbtGkfUdWk34JPbyzSGQM4JFuLMvCktad3lqac+5P8TtQRV+uliXygu+
 S4UhR7t3jadkXenf/BIGiNzHj6Qi1NueluXdSOt//Bwj1w9GR2oBeMY0JFddKkgYeFSg
 RcpP2obR7CvK34CuXRHz265JvZz11x5NT27VsIODdgXStM1CUI1WYBXTTRzAM6hm4/s4
 N82g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX00+zETnE1NZX5AUytlSWPad13lGnRaMleQdGoyErhZTM2Wox3vQM+BbAZd0/vLIzaTck=@lists.linux.it
X-Gm-Message-State: AOJu0YyAnyosoh/FZkJ1eMNwPDSVWQm6U2WowUfUS5zPYNLN9982dKy+
 C8JQj6RQ1m6OLo8jrhWddCWHlmJM68AN1R0CqXwSKBFcNERRUlNXdwJ4mMNVqBZGCbLr2ikYXtE
 OqO5+
X-Gm-Gg: ASbGncsCHjP+nQddDCUKQNzo7vMReIABo8vH7azC0J6xyAdon4QjSc2l4A+y7UZZWvK
 Y/YetCulxFsmsYqAROsb432699DLiYITG4YeBE76Q9YM7FOtnwZ3HUVxBGsty5DdXElv9fv0Cir
 +BMx9mfIyqWmUoa2ayEu8zrWObv97Dpq9GYVFezMHmEuVOf8sytWkK8wV4TTw9BsoW1L8sA9E5E
 WB9kRuWPs9SyUadttZwx4L9F/bb5i3DU/8KggFQG0ZLF4tvXlsf6OcTEod7rc5zcIcPHgCWraFD
 rQYCmoGY2YWa3HFOVWL7fdLAlpaLTXHasDDI+QQ=
X-Google-Smtp-Source: AGHT+IGSPDTRbj+jF+q0QRf7XptzWcl/mTwyD/1gy1IpVHff19GBpeNMtKlELl7YP2jWtpz1KgbCOA==
X-Received: by 2002:a5d:5846:0:b0:3a4:f892:de86 with SMTP id
 ffacd0b85a97d-3a51d968b94mr2698964f8f.33.1749047861905; 
 Wed, 04 Jun 2025 07:37:41 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-53074ad9192sm10956701e0c.17.2025.06.04.07.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 07:37:41 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 04 Jun 2025 11:37:38 -0300
Message-Id: <DADTPXXKPJZH.M749YG67VIPY@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <07d8ce3b-d1e1-40ae-b3ab-2b3db7ff9f35@suse.com>
In-Reply-To: <07d8ce3b-d1e1-40ae-b3ab-2b3db7ff9f35@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/8] syscalls/mknod: Refactor all tests
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Jun 4, 2025 at 11:36 AM -03, Andrea Cervesato wrote:
> All patches look good to me. we should be able to merge them.
>
> @Petr WDYT?

Cool, thanks for reviewing! :)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
