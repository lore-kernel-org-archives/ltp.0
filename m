Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3CCDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782299675; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=2ipAuDvpHZplv+hSGmzS/Xd3337OVsqsS3sh8ZR5SmY=;
 b=KqPkzT8/ZATm5jQibmbFMaYGi/rh+ZZEkBPe1Fx4rCDa58sq5olbPDuOexAy59TOwxM2+
 PS46ntHY8rseMEiOk8Ic12+uKmStc100XiOmyEYecXIcawq042LZuX1yCR3qBY2PljzJ1w0
 0/XJYiIcLHQiuX9yb3rA1F89KC1QMaU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B5E3E6207
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:14:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECB683C041D
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 13:14:16 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4A4281400C6C
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 13:14:16 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4645995069bso619369f8f.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782299656; x=1782904456; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Av93Ha1WleY8j47GT4k05NzETp3AbuTSxjsB4HD9wIU=;
 b=HGV+Pm4ixmCWeDlXhUa/f2/tRmW+DSVEpz0dCw5Xxshp+xyOfXFJcsHtalpgC9/vAU
 43mtXMMKLWAzTWBxE2w9etpNyW1nGwVkv/8KMi1n05V4LcNiDoGSxn4fY8Qncf5H+k1o
 15hb2oJgGR8jNjbbvLXAiuuDt7rop1p+yUtMvI+TR0dPEkwSWUCd/0Cgcyfu3yVjAOyI
 Dcpo98QLr2+8atIx9w2zXaAh2b14fvkfBw9FNiVzBFEIZ1E7yhu+dEEJA9Y3GZ+DRY2y
 /6I4GG2M6Kfdq0p/MVPH8aLnjMJbzs3ktPPQwXqF1MGPF4xUedhk7BRHTuQIBLocqgec
 bfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782299656; x=1782904456;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av93Ha1WleY8j47GT4k05NzETp3AbuTSxjsB4HD9wIU=;
 b=nU8Xd1nyybyvzhUJwPJVwqfhpppjIp2M5KObrc+7vrYcBSojjqQXaH+i6hRB3oCaJt
 Lu4LXZV1YKAexBblKuRnB6+tqs1nziU4ZzcZ5ezz9fc+trwSNSBNPjYJbhGB8TRDRlaU
 l7G28293btNrXe49RO20dP4znSzBi4uAUEKj9ib9ZkNPJYvTgPxJrO/sif0MddNQb6NI
 28sBGAgFRTTLw+/2HmkuM38OPtRed9mjqwdUD5gALq6BQSy7e6Ud0F8uLL762vYaHOyT
 F3qpwpGJVeB7+7ZIoPHqzN5rT35OOYSXWs5NPFsc0fhiDNlEwFF8J1AaBPcGRZfRMHD2
 0REw==
X-Gm-Message-State: AOJu0YxO6E4Qx1Zd6X28k15+YOctLlkxPxiTkvYfAH7yJvb4OAXFqTtO
 gqrFiQUdc2/8Q+04vgztjYdpC3Ybehs3XSu3PimRwmvJ4vtYM6T85ILQiWBG3g6+Ic0=
X-Gm-Gg: AfdE7cm9LnwR8ffjMUkJ3nPwTiW4mG1jkCH/Ue0hZxPwt1dIuk4g3CSHyuTzLUTruRH
 zm/50Eq3A4nwi38EBauEiOtCBNe1sU+RS+wWcNgb9UCDxwikSa7tklbs+K61oK4BaFEIDJ4x8yO
 3f7aKB4gcjszbiW33OFXdRCfsEJ8t5DLPnIvBYP715UvC5uRvQQ3x5RGOzs4mm172fFcV2y9paP
 IPSEBI0K2lee5nmc1Jba+dSs1JEzFM9s75v9aXu1MnmgDB8GuOHKajeQBzalfTwJyWjAiU5DQIY
 CRZEtTDyAYNviYXv/cuELc+tVOv+P4A0s3gOEx5Uk2ac0ZDPWhB1+ER+ErG8qgWOY63P0WSxVA5
 3TcAugHQArLOjj6U0AdCxwPMIRsIN2uii5Y49UklAjQd/uZeXiJFUHj6QEB+77ecy20fBuGSrCh
 ITdnQaojrRNtJXvEjrueM9dyIeKjOLoiZxSvRaLs6Z6uKhsm5dk8gU7ibLsUkQIZ6tQcXZNPmQl
 QaQwWgW4pKn1BSIAgah07TXQClnRNe6tZr2x+bQxHCigG+DGq3cnso9DLRf8fSTCvahYohMTpLd
 PA==
X-Received: by 2002:a05:600c:4ece:b0:492:40f4:9fab with SMTP id
 5b1f17b1804b1-49260875c0amr37918235e9.29.1782299655638; 
 Wed, 24 Jun 2026 04:14:15 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1fa34sm507544285e9.5.2026.06.24.04.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 04:14:15 -0700 (PDT)
Message-ID: <6a3bbc07.f844783c.da03b.06a9@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aju2jwCz8aky9FgR@yuki.lan>
Date: Wed, 24 Jun 2026 11:14:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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

> Hi!
> > as I already mentioned, I think we should do this in all tests,
> > instead of having it only for shell tests. I know manual groups
> > are error-prone, but they give us good control over what we are
> > setting up.
> > 
> > I'm not sure if adding groups based on folders as we decided to
> > do it for C API is a good idea. A tst_test->groups array feels
> > better suited, if shell tests can't automatically support the
> > same approach.
> 
> I fear that we will have a lot of typos and wrong data in there. We had
> quite a few wrong CVE tags already, because we weren't checking them for
> validity.
> 
> I'm okay with this as long as we have a checks in 'make check' that make
> sure that the manually assigned groups are correct. For that we would
> need the same heuristic we have for automatic groups to check that we
> didn't miss anything and a list of valid groups to check againts to
> guard againts typos.

Don't forget we also have the agent that works quite good on these
small tasks. We can add a rule and make sure they are always valid
groups.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
