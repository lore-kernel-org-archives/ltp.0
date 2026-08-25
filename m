Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C89CC61DC2
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787660253; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EZxV3sOg11BRIMVaeiQK/D582zfNmHBnsH3lOhS/QNQ=;
 b=OGLVnk5K0PasSjje+xlydEp/OiH5Yt+b8Ub3CpxQ7WWsTF1sFiJ+USYmkXJ4ZwxC7q0bb
 MG81JtTLBLBv7BX0P0xclpvR3rqW73y/uTqB6gmzTkS/VtlNnhyT9MA/PMYLnACuvH3E1qt
 +h7fGe2TLkxAaHbMvyAihtebIUTWnOE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAAE23C59DD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:17:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4162E3C1E1C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:17:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B7F37100099D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:17:12 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c214321dc32so906262566b.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787660232; x=1788265032; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bbUHefpikuhCPHXkUl0jqFQ68RJCLOzR2aaKLueMFrc=;
 b=WQ1b8gwLJ1OvTziOYhTCT43Vq9ZBupS10xh40Yq9RbcI2t3EgNoZDuaM4DmoeXyc36
 5LhPQ71YUOEs+018kiaK3L7btYQlMlErwDroGZQUMwVsEs5Pd4yRmc20xt4Yu6NeWBEM
 +dzZWtyVTj7ffEI5wBvRk+OpitKx2FT6Sc1l4lH52bPFbtkbyzYgnwHmBiJ81dxDwmo0
 3qZo3N8/+uDwHgrIoUvSXdbEVzG+L6OD+ZD8nR0tmTHgZ61dB/DzEe90m7l1bxwNRIhf
 EcBxDmDFBlDeIzoNoFPWZZsYlcjsD66ymUFp8ZmHDYh4P9/5Ce1vDKu91NBRrddyEBhu
 rv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660232; x=1788265032;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bbUHefpikuhCPHXkUl0jqFQ68RJCLOzR2aaKLueMFrc=;
 b=o9L9AmlqOHN6DGGkR4gfN85BodsLpXUb0cqH2W2qV8l6M3GAWAuGLaHHH3amLnDXZZ
 ehUYtiCFE+TtNr3OS3wQDmCPgrnMpMQK2BLOvxle4NtTqh3z6P2bmVOFY861p52uKOSZ
 4EVeR1Y6R5A2UsBWWouepPB/k4F2RO/pC6jGxSledG8oHq5VjaERZHnIkydJ+IIrSd8Q
 9Rn/1CPhueqsOzf7M+se90k7ZoRhgT8DvN9cM5uoD2/tokXpncfB6AwxDmai9LUdPc+q
 7dbQR7DffAThXDtYGMHSaR4k13cvh7uZ1u2tboJURxYs6llBlhMsmy9WFN2JXV2v48OX
 JyMg==
X-Forwarded-Encrypted: i=1;
 AHgh+RroWDBlK0N9hmPmiULJm4ypeS2SCrd9qYbJjL9OgSjH1wttIyrKoTykNAXW9KL6cDd9FjI=@lists.linux.it
X-Gm-Message-State: AFuF++kdMNXXsKtzUhzCwoJpVP7c1dGJCoVIpKa5xz075m1eKQ8t4mfl
 ifeE6IK8yTqStUHtWmEiVNonO0sTvXCfy1+CEQl/JTftrdHNJ9JlQfJUajX7mnI2qt4G0ohWXmy
 lAg2XG6Q=
X-Gm-Gg: AR+sD13IypTl4u2k5S9WpycAzR4/gpu3vcl6FdXeX94uDSfSdgj8lM7CqsEeU+IExOh
 FjnPmDMtUyKSBmtbEmYdcxZ7KBb7N4NZJMzbCOxQ49g0oWbTttqDbFsmdNFg4Vnj1W7Bo4GNWOG
 laCG/Zt/3w8TbIHEyaOK+LhsBMKqgzoFi+oQeEsC/5aU9wpwktACXnIPViREvZp21GJdw4XgTTX
 wAyWQaigL+cGBOZx2DcZN0lq+0n4SkGnhMLIltPfeCJLT3CsV4sClY0J7WlGiRunEyU1YhQYvlW
 2r1wNbLiB+xYnSXsP4oEBtbu88U7DIFFweMVpfkAfq49WbVoFrJvClUQqfyiitq7ksdWcqq+uwN
 u1N2c3m3paEI0MoqKGDpBthoYnUHdHIKclARXfeYVi6LdGM/qjSYjGx+HcgaRqt325XmuSaCKqx
 wOO6ZUt4yJVvx8LnBMXjhJHNT9Xqjb4qDO9SSZqbUryItyyA4hs68S3bGMcTMAiPMhXmuFD7vbl
 Q2SfVMntZ3fu71HfeGXaQHiTDu4UGsYT5UH
X-Received: by 2002:a17:907:1889:b0:c25:4a9:ab95 with SMTP id
 a640c23a62f3a-c2504a9aefcmr162769666b.14.1787660231969; 
 Tue, 25 Aug 2026 05:17:11 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b683sm1901310666b.5.2026.08.25.05.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:17:11 -0700 (PDT)
Message-ID: <6a8d87c7.797cc74e.15708a.8627@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260825112755.GA62429@pevik>
Date: Tue, 25 Aug 2026 12:17:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> And yeah, we need it in kernel 7.2 on any distro :).
> 
> Should we somehow mention relevant kernel commit at least in the commit message?
> 
> e.g.: Change needed since 03a43677ca91 ("exfat: add swap_activate support") from
> v7.2-rc1.

yes it makes sense to do it before merge.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
