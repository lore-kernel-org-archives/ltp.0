Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DDAC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788419687; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3G5ym6qNVGPcPqo1h1xQrL47p2WPZ0LAcAIKbz77M6A=;
 b=ogo2CGCr1M1cTU7R6ZkiXjfI9iCD4836DdkqIPlhk1wn4X+r9Ni2cd3t18AGGX2mDf7b5
 e4XS6TadYzs5SSLIL1bYlivD+HsmKiN0Ew9PIRzIIT9FuLtpvz9gFE3zUDwtJCwjy28f0fs
 Sx5OHihYxIWTdMTsh0ux7zcn4AsbMxc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF9A33E939B
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:14:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99A253E48AB
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:14:27 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F5052009D7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:14:27 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so1087127f8f.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788419667; x=1789024467; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pQ0qseqe2BCc98wDBdkxYtJLMpEu5occR+A3nr7VjRc=;
 b=UYqr65iggv7tN1F3kHnj65dQU0mtN2+YmF/o+3/Q8Ey78diL3A9C3PLdEMwmPUVT+v
 zhYZziAhNMJGrgdw4x/EMo+xbBjQ7/PhfFSMXkoFJvCLHbSk9A1LoxiUMwZ6CbOiYtkY
 TvihgM8+2dbzsqtEwNhtZkIK38PC1ZNH4PxX/J1AcWs/hQa75y8qU4iM0vjva27SaUSF
 XeuAwioRsektAXTw+dVlY3i33EBJvwl/HBAhyFXS5RK84P4sJHdhDMEAcyRavEXLL6cC
 63wBqlrRp2QhhJjy1Y4oV2x4k/1IS3COGjDmwCFt/mRhg6ttSB1ZL3JPznIevbCR1+/z
 Xqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788419667; x=1789024467;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQ0qseqe2BCc98wDBdkxYtJLMpEu5occR+A3nr7VjRc=;
 b=qabXYscJ29xa2UHZx5mpEIIKEg9fLSCDhkhmV4NZMRlyLgqTjZ0ANV6f5XLYtCaAGX
 Evx9fNopFyD7Z0dH8gL/rHfGOeKIjG2e9XJwXHp06zNuPC3elbE1RRBrhi9NowLDwVXZ
 AhAgpfVTRci4n39FuXoYzFg1/49yY0AzJkXxGF7t4SwziyaCEPYBaLeb88DeM7BY5A4Y
 F2BuYShNLbjjmApiLzYvdmCf51R8QrC+3CtzgYxuchL8R5HZ1PIVp6QBLG/GOThNw1YL
 2lxQo5wbuuw7a8OK4gsP90hAzuSfw5+40IYf4J7vXBpuyZEJKZ/w7jvDxsh+3BaZhG6/
 jW2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5q4aNUl5v/sACjiCdd0QOxgCj+jpM4I3K+b/YdkYV+3AVuyGJL3ytfCXNFPaAMmRLosE=@lists.linux.it
X-Gm-Message-State: AFuF++kDSID0QyPG2i+G/snlM2/+XpGXZ/Hc/U6GrCdJIRQhudCGJKfm
 +fKJeWcyDENTrwk/A4BUe5AqVqHNhzcCt0d3gWHh/NA5byarxitZUWdqYZWbLx4Pt0U=
X-Gm-Gg: AYBFou2HqRxWg3d8c+lLBpMeRddVXMbn6d6J//6Q8/DboWnThNWcedCoPl+qt3L4wbw
 SyutblvsmyNJ5tgy1tH16mVwdldSFUyzT8zt33g2CpTumc67eK4jo7wLkBdyfibkCVSma4aCMTN
 VdbXa+NtORu/HcE+kmub6pAbRNsO3D70vEZRc2Foyi8hKy4y0bwCQZdkx4cll1dfxiaJJwXSyNJ
 0SxT2yB4q1gAQktyx/5K9pTRNKsm7yZDCQtO5MNF3YkjuBqhDoPuMC96ljLsPzUF5R3VB1lpXjy
 l6mzuLhYKmfBuOqJpr9OJoEWXqtr/xSH1iaCRuh47RBk9y3zJbF1kSfxWAani7lTDDdEr4l0l+X
 29fx0adZBiYnMdKqRnZAyKmllGgLOQw3LhCx69KPjCHvS1pdjeHrNtKt8ycvJMKpZsLVbelN2HL
 X92mVsT5aZ9hvR/7AUTszFd30qrbqAJOGWQh43b3B2KdbnMhgsadgn5vK6FFJ1KchEAIhnSEl/V
 YTtcbM4A+KG
X-Received: by 2002:a05:6000:4918:b0:481:4697:8808 with SMTP id
 ffacd0b85a97d-48488f1b264mr21767422f8f.22.1788419666499; 
 Thu, 03 Sep 2026 00:14:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm11809418f8f.18.2026.09.03.00.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:14:26 -0700 (PDT)
Message-ID: <6a991e52.aefdde3a.b18c5.ddb2@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260902230741.17215-1-linuxtestproject.agent@gmail.com>
Date: Thu, 03 Sep 2026 07:14:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/sched: add SAFE_SCHED_SETATTR()
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

> PR_SET_MM_MAP was added in Linux 3.18. Add .min_kver = "3.18"; otherwise
> 3.3--3.17 kernels with both requested configs reach setup and report TBROK
> for the unsupported operation.

This can be ignored, the rest is valid. I will send a new version

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
