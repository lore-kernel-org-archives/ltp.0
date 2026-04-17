Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C82F8E499
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 00:02:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3F503E7536
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 02:02:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 906433E2169
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:02:03 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F01D2600809
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:02:02 +0200 (CEST)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso142167a34.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 17:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776384121; cv=none;
 d=google.com; s=arc-20240605;
 b=Nrf5GGweG/9W4UCIezrHaK2NsXWusmQhZrD3dMPpCc6wfr7vfUTq+5qp9g2g68gD7U
 qZFs80kYu2kDL4FLWjJYONmzlM0Y53w2es1dqVE1p2gLlvt4nNgyFQhqZD3cKXLxuEyH
 6MRni5o1UbtK+S/s3Q/2/8w8Bs5WS2yHBaNVf7BUQvBFdieAdYU8QQDrS99o+22iiHvg
 nwclv0VmXH5w/As4nZ7ZA0D3JoWUG8Dxs2U/WAnYft3xY9+YWoln+aFMKHQ9E9bF/sSR
 9MknC30NS4QYcT2bVZsrJUK5NfW/PzqNewbt6wrqC4ATkvdS3hZyK2OIBW3MsaG69x2o
 cP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nl1y8JEqK1WVwmCyrPINpVVu81/8WSBhdf/whMqaKbA=;
 fh=f6+8JlFpaIXMODULnNCGsCp8pCMNRq8DhPAtkittZio=;
 b=Dppg5sARFe/FnpIeZSMh03ADc2HYne90xoY+3VgfYaa7rKPhMHHY1PnLci6xCpLLoe
 WOKfJc4DuTiAiQGnHjBsLbmf4se2YkblLtgPayTCOESkGrhIClaIAjIlTh0aXKqbivzQ
 P5HWsHD7/IjV1Ko/wBkIPRz4N75qkjFNXCUaRZkGzgJQLRMowBgH8LlQcOcDe6BH6CeL
 2dyf/pmZAq6YnPRknxiUptIfFR7G/0JWbowWzE4i0JDyNXPBwKaw6iAk/OVwFiGbb90y
 vYMNwrGCNrT1m9RuieOFZCxPuWSgCqyUY0zi+U3vHLX51hPUo5sZEmRani2QeOrAv84i
 V4Pw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776384121; x=1776988921; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl1y8JEqK1WVwmCyrPINpVVu81/8WSBhdf/whMqaKbA=;
 b=qWXxzBZqhl/bmvkfiYZOj0zsrfB3lMvpHHTS59eTfTfrWKcyqtCRGXu9+ftdPFkfUE
 KEZVHCtQ8vqujjzG5lYbWncRIKqwNk7x8jhYWZ9RDaIcRIDsWlZOjhBmSJowslQK+cOu
 gQTfl3MvGXKUzqRBDCqQz6kd4UKkATmsQmCH+zE9iNNrVmXtJEn99GVq01jMwQ+ZkxRO
 h32MtSgKMjKjwWxUu7R78kRFRTjOLN3SIZC/3VaHCtsUg6urbXjHo+jYAU/RjthEjZqk
 ocRGAaUXaIcKExrkz2exWgr5EflDPfRboAo24ghDWog4hpZUePfE0QA5P62k1BFyvTqU
 6lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384121; x=1776988921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl1y8JEqK1WVwmCyrPINpVVu81/8WSBhdf/whMqaKbA=;
 b=HfiunhXQDYbubPyWRjWC2IDHrCWcg8aEOAKYIGHKbDDzZmJGhluz2annkTMK79a3aM
 jitwdSVqd89oafCp1m31jR8nyTVrte9DsD9D3efdixxXLWlmVFTpBPiw30garLiXy/og
 CTLw+QJIhgIVtasqWgXh3XaqpjqUMOYlXY9mgYOOQpV2RgT10JSfDIO35j6n6JvMIhVQ
 R/CZVn5YBraWyrpoYkCkDtKaHl+TEzXLFNBIl8tR04sKwbbor7f+BVKgoESOwm0Z4e6+
 x30+as5BeM+dGyfbPTAWoi1GuXOjQCUtepCorNjPirgkEeIlYfA7qwVRSBxHdknc7zSK
 S1ZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ94nkTN9uymj36a/FjP2Uyl1qyGiDvvyQ3TxDiWJvPVFUONxAWfEKr4KnHp1QaNvYAUZJ0=@lists.linux.it
X-Gm-Message-State: AOJu0Yz0LR50ErnKKgzT4SQJBsG+B5babNh7zX8zmltXTqHCQoZ3RoWJ
 DiBmcA89aA90G3J9+vqBRY4aI7ooQBX1rv2esMbhFvxDQZcIaXfI/Y4bvG2X4xUufyyyIIVSFQr
 U7LMj3nakbjg47mn3dp2PIXusLjShwg==
X-Gm-Gg: AeBDieuxnQCyAisMSNL+mMNqLWk0GlmTpqxJ/3htHB7QzuKMo2kopZTB8RDxFfYmPY2
 6T+IopeoHg99OLary7cdR5/geMOk/gE/GhkYY9NE4lH3DjmXR5mTp22t2DAWpBmrA02/8oTU1MS
 fb5GBPd643E8Z6wT5MlQmyYVxX/zJ58xMO0lzCQ/8Hs0hrRzT39edHnEaIVGTB1wCLwp+TyHyOE
 cNBFlVn680AnRoGuBOSmkkDF7O9bUfvn4FrJ79dr25WJv5pFJWbGVOdMDqI8pNRLgvJIcn/WuHp
 BNG/zY6xzRIRs87ul4I8WYUBklo=
X-Received: by 2002:a05:6830:927:b0:7d7:4aa5:5210 with SMTP id
 46e09a7af769-7dc951acc22mr428892a34.19.1776384121550; Thu, 16 Apr 2026
 17:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260413204519.GB153189@pevik>
 <20260416125554.2920-1-always.starving0@gmail.com>
In-Reply-To: <20260416125554.2920-1-always.starving0@gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 17 Apr 2026 08:01:50 +0800
X-Gm-Features: AQROBzChHXW8oegnKAVTf7c2cKRFepOSMO0AqnQDMPFwZRaw2m1sBQ_kpqMmNDY
Message-ID: <CANgNiRy_V+kogZ6fS_0c9AW01xPMDwceO6TTMr2_cVObmzPkhg@mail.gmail.com>
To: Jinseok Kim <always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] close02: add test for double close EBADF
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

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
