Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD941C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787916829; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=9nnGFHf/0AWVHPfaZ4kvmJmkiFmyB5yq95mGuD5H5es=;
 b=TfXBXPEdecUVqXIMDwodLu/SV/RczudWJjrmsXYYMJRtSXZUlRw+IexvwTGyIYcMMMBUS
 /qpEOQlQ4x1eCo+JxPIHrhvp7jz6r53BCCm70RLXZaPrV8+hcH99DA4Bsszl/85zF4udVPg
 AjsftsuQRIXWMo8SNncr3v8pZXj9rQo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E43E13E2FC7
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:33:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 406303C5751
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:33:28 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33D9D600B9C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:33:28 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so7567165e9.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787916807; x=1788521607; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2x07qe/b23NHbLbfr9IbDbPS+j61FzY5Bx47W4x/ttU=;
 b=FfLHfFwmXa80z2umqvg/+Gv+NUYn3oDmoDDqhfy2u6FCbvc8abhrRtyd77a0of2GB7
 SH04KVDucTJQxSuy3ZjbLkyECjZgvE1AvyT9xCN9HnSCzI6tUywZN/vGZBF1xuNKI7e/
 dEE8AFXlYVQPCqYTdcg8jEDitVGOREdkDMb1uMaLbyMDSZlgHh30Fy5NxqkjqhsXBKRV
 XIP+iSCxdbNGHDKW2ysspZsAQR4zPhtK/iRn9WfhITOKSYNza/0cl7UJqD8Ysv4lOm/K
 crg5JI3cguyirmKbrdnKDy/uy2+WfHawWSbBvrURklzuEu/26hR0GuE/5xBaykJW33R/
 mASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916807; x=1788521607;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2x07qe/b23NHbLbfr9IbDbPS+j61FzY5Bx47W4x/ttU=;
 b=cvYSVt04fzXfMAGP0jEMLrWCLwhqk7DY8p8Ahi0FGY5IN4O8heqIKVlUK1dNLTCOrl
 1pMMYBYoEzqIDuK3uZlWhkASbSMB37vX2TfYUWOFl4Xfhaw3psq9kCtnpkmcGcb6/Oyy
 aEHCuVZXelrwPKFJYLuiJVaTPf2VgatL8YWkzbHZNFXs+VJXt5dMtBWPQxPrZDF554LM
 pEZyZVZL9qXiD0Kv5UFI04BVPurKfFIn/i5ejdmk5b/BdB218RalBfDCbAyjdojh32K3
 WfDwW73k4yujCv72DTbo5wjnbD71PF+zIo86bYgvhEJ32RkHmzwWpbpKYELhpMq1Aj2E
 QzUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Romv1D+zktCkcEST9gebFxylmhe5IpXDTsSqcqclVGy/JRGF6Zuk0Cefq0QOeT5mxzwd5I=@lists.linux.it
X-Gm-Message-State: AFuF++l0LwOYMTvcFf1t7VN8gg9tlWVEiUTl62W0EECNYxtDCVVaSiJX
 BfCas86kjUPLzt9AISnzYDJrZAUwowpo/BP02KJDOzpxQSxWKn1HRWZpKCKzUy+mONA=
X-Gm-Gg: AR+sD10Hcxw3o5/HV7QhvX7zu90w427AiuhvPADIoiQdXRw2REsfthCeXjJnCoHW6Zc
 sc1tk00ivL684h4Yb4Cg8yuPE+wh1oV0gzI+JQr2ONMGbQ7G6xUyaPBWFNfHOxHBODSXxgQCHm9
 csIeCM1ykiVWTCx2qbU4igVMd5XJKHbsaqXdI7HMzszX+LgWGTNIpq9kJ1j3NCZ0xRwKnQE1vok
 viDtPN4KstpRP2Hvc6iICSeM4jZKqqJcL9saVvlGChguCxBsnzFUCxx+h7du3u3ekyeF6OW/XMc
 kCPhA//BjrFRNSXPiUmH8wK8vgD9GztxXgpq+pzKazFaSM3MlE97zdpuYuyyT2LdGnQeV+BcmMZ
 ozPYK4uhq88beKGuLX0zUQ/9SSYzgSmYllwzzkq+s+RF85vuI2GPb2zt/RxIwBeOZr/JeyeK7qA
 TSTLuJKPLqfKur3zAFkpTUCCto8+YhphloUAYeKuiqJyU5+u6Ip8aDeHrp8k3GDcXkioc2AF5Ix
 u3at0vPhBZdp4VCmuo46PXUV+8pGZ3GV+wZD2bK7ZL+9Oo=
X-Received: by 2002:a05:600c:1f8d:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49b91c17c41mr86141805e9.3.1787916807484; 
 Fri, 28 Aug 2026 04:33:27 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c5a903eebsm11226035e9.4.2026.08.28.04.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:33:27 -0700 (PDT)
Message-ID: <6a917207.e53d905a.2edf82.82b8@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260828113033.8995-1-linuxtestproject.agent@gmail.com>
Date: Fri, 28 Aug 2026 11:33:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] setsockopt08: Handle EPERM from disabled compat xtables
 in userns
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

Hi Avinesh,

> > +	if (TST_RET == -1 && TST_ERR == EPERM  && tst_is_compat_mode()) {
> 
> Minor: Could the extra space before the second && be removed to follow
> the surrounding kernel style?

this can be fixed before merge.

> 
> > +		tst_res(TINFO, "32bit compat xtables interface is disabled in user namespaces since commit ec1806a730a1");
> 
> Minor: Could this 108-column line be wrapped to stay within the kernel
> style's 100-column limit?

this is not needed. I will add a rule for this.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
