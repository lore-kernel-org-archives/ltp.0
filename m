Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE778EA3C59
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775737872; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tB2NU+SZnQMJ9q3OZMaO6iAraBZIlO9IrANF3x7gwWo=;
 b=DBIvPOx06FxH1O4N4EmclWZqUKil3vqcvgAVjbApZYpX/aKFSUdkd7cdtVDstQJ7eV/6b
 ISMn9BzOAj0TQ1QU8k62Ats2Gz4Vd+CFY3dJqCQbFaejdEaFA1sMPEbfR8cZj4wJCBpOY8T
 E578dM1Et1TLJWyzsVcZddoZMDMxGb0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EF1E3E4D07
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 14:31:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7E83E298F
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:30:48 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B4421402F8B
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:30:48 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso9026155e9.3
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775737848; x=1776342648; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=o6oD+2ixsLIVHpbe168K7cVXaLqUIYhThfqwLIZjv6U=;
 b=Apz5tLAgfOrryGiM20Qi1zdt1mGY9bSfSimog0RrzRMafjosl3zrWCO38Y2kIO5MSI
 x0tSAk0xLvjJc1JWPp2g7EO9XS3JrPWCzX+CghwsjrPHkSnPYt+wrYBmb5t8z+2zELMY
 KJ1VSOcU4IaHtPrHlEj5Mv3SDEdGFWm4oszFfmpsOWxU9vlHEoXWE57OJ50ddOTclM3g
 I84J5HVwTd6ks4NjorhicQnbaiv3c6kmSlRw6tcMo6GR1HvMC786Rs/tDmkbTtgt33cE
 CqLpbbPA6Qn6CBZnAoyUEVVW2Z5+NmFkc9OV+2p/eX2m7S25kbmVuFjnmoWJO4I06ebw
 e3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775737848; x=1776342648;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6oD+2ixsLIVHpbe168K7cVXaLqUIYhThfqwLIZjv6U=;
 b=VH1ufiJ5BIcER6seGhJeZzFX/jgp4bKgXLOnGoe02ekzJRp7vUX+sgUJH8ApmnfS3X
 plIeBOXbO/nIeCqDaJQ+GezETvWH9qwsyC1gw5XoAWKUhjEY20DIL7xVpQFz4BS87lKJ
 9bvumX4ENOI3iTRGMow9I0VXIlPrTq6pDnRPFEThote85jt/LtnPfR9+fyPFJgHjIva3
 lcmYB4AHcWTJPn+ZA4qkhFDOdL1S48A39/cXyzyg5FI8ThtWoAcKaalLzNcBndVda4MC
 243qfxyDOixa4kEV1246ozVKHKvsPJeoe96OOA1KicbKpDuBkmD8hiOhBmflcRRlPi+7
 zvGA==
X-Gm-Message-State: AOJu0YwoaiFxwd+h14Cr8mOhxtOcoCXJBSmoHTZcxG2pm0+w4AXvLFp6
 VBvKgz/zAoNX/0bydmn4Oo4uOEjhIbQRbctfrFqL34hfha6+kkj7KXLin5HdkCCwx/HZnzNP1NQ
 3rhK586eXzQ==
X-Gm-Gg: AeBDiesDp91v+9oa7BcmPHsKTxj7TWqNiyKuArMNEZIW35DbBXnAIUdGSon9qK/4JBp
 iMUxJVFvj7yF6sX3huw9kho7vUzO3pQ0PHsEj+RICCvlcxB/nl8fgavCg2+oBTiAongEMdwoE5g
 CFFh5w90WjDJdArmwLoEl9D3BkH6YYMxDn0XusAY9VDglMSpG3ri0c4Y7MKvD80ZQfgVu/FQNlF
 JgRxAklUngDR2zdHGaFhgcqWDn2DHYm7YmB5tXCf9j3PensRofv7ZPIz32qEwjFDIWOCKPfcn5t
 j0i0dWHEPwv0se9JSmylFCL57Ityrzcaip+bUnkkB3VJAY1f0Pc9R1ooe9gzh0cLszV94mkQpMR
 pLP9QLtVpb5wHVHWMDdthuEAYqvubPtX+CJ9oVCJR09GWpmZSu2EKGoSha/dz97w9XDHNWqBt+G
 AktqJpYFnerzvWjZueqCfPC/4TVPmiK4QRjZ4ayouGsiSq2ak3rfMnWBgtG+HV50QsT26rkTOjD
 IyopQSqivdmBr9MCcuHsyysdmAKxtX8mJEdh+KvrvKTWwi96F1a7hN2TE4QfqyFgZSaS+UBEDOv
 TUIys8xI2A==
X-Received: by 2002:a05:600c:c11b:b0:488:be58:bb5b with SMTP id
 5b1f17b1804b1-488be58c8fbmr112035285e9.24.1775737847522; 
 Thu, 09 Apr 2026 05:30:47 -0700 (PDT)
Received: from p200300ff0f085301c60b3f6236adb066.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd19a69esm24693325e9.32.2026.04.09.05.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 05:30:46 -0700 (PDT)
Message-ID: <69d79bf6.050a0220.192241.3a91@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260409-fix_ci_checks-v1-1-bd1c9a25d3f2@suse.com>
Date: Thu, 09 Apr 2026 12:30:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] patchwork: Filter checks by CI prefix to avoid
 skipping untested series
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
