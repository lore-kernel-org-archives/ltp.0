Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8722DC61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787678524; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=mZnnvXOWgQkXmwjalQvSNlpekALSXaQWxREdKakDCvwVcNLYaeNpQfsscoEiNIpWSrMf3
 nl53FPSr3A+7mxS+PIcyCf8eTYMYrBeVzctDkLsBr80/9CJ4/sAY6gI+DjFXZGYKY0RLuUh
 +ac4w11bjOPuM4rJ780EGuJXTXtxG+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93C663C8148
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:22:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A84723C210D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:21:45 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26AA81400B8F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:21:45 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so6306866b.1
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787678504; x=1788283304; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=WQo6sezfqmKzvdz1YskQnr/7/Lf890TUWWz02xHwiLe9v4ZbH+mm7YP0E++33eeCSD
 9vT8xqGvtTd9nRCXDH04OJdTGiJeCrqlPR7BqKZrMs94YT/Z7+PcR66qBDdDjldtCVnm
 zY4JMk5aDt2Vi4q9PsSTuJ0IhwA7a3lnt/18gO5vuO1Bdy499l8Ms8FG/FexC6xITbgR
 QQzH2Qr+TDzjQySGTfJ4ZzQrDFoBA40PEZ/52in4W3eRpeT4iFa6327IKiM89R3pwa9b
 F5Ek0lBL9zsByGa1W0+yLLLPwCyaMhS/QUk3G3VT99LapEDvzFmX4tNPtzq/65UaBV+M
 r8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787678504; x=1788283304;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=V9T6aCZjC9i9lBB3PaTkRNpRvTOQCEk4kz3Kl+A282gSBPfj49OkmYe6v5HE/lNBOP
 t2yzG3nXXZ2H/NV9VGGyLyt0c/1MqO8Nkr0gjJxkQjnq7tH2cs8BVmQoLS2wG4MIt1Du
 3BM9S3ZNAw2hdFUIK2tKwzQI4I0r1N2fVGBiYwputZMXYJs7jPuALHG5PXPsFO/ppVaz
 E5hvyIzNPluTs7rGucfG5BqQS2LWuKSf4FGkWo7V6yg8fYZGpPmqJC2NDx0cdnHm+jO/
 RCDv37kK4yJueT8+DNiDk1YpJVpmw+9Bgh5A1N/CYAvyA4k9XtFB7fEB+V//kxfeiUIa
 +Cbg==
X-Gm-Message-State: AFuF++lh9WzClNcDd4MTEumRZkSDo9+wqaSZJpFMR5fXO56NFO/Y5wXC
 tKMEYxzxBHnm+B1djECl5v/jfrYQqpU3ET8ORddVADJJz5bRpD15Kpe16bW8n4e5pAY=
X-Gm-Gg: AR+sD11+0j3hz0/rW4AU0nPRBdJ7veeyoBc2PMQsWVFCIBGTjhEhDJTK32Czg11/9ta
 Jb/7OZSJY9kXs+1d5s3PF5npFksTvszmQNVAcYL1LKVo+9GawWfjiuebXJRJ+kRkyIGv1SPPbfe
 x15V6GRqn/4R32Y76JiEll3I8pBAijj4uJZ1bH9FsDGP+wq148PVamSwnqaQLKwaqLvT+Ca1r45
 hPeILd7xXaP4X9Pac7+Lqni6A4+wU26CzOHOhF/wg0JLZA1vOoucsS8I2wvf+++AmtY1MsdWYgO
 W4htyjYFEmuvYZTZDyS7ubS8XXqab5AvX9GvWrgAqgtcalbn4grJCOp5BOddGm5vzO/VId4acf/
 1Ebkn387A/xZ9z9wxXsFC1G1Hf08MNWlB6NHhTe3QfmknheXTLDSxEMMFdktYukH8FGMc2Fiprb
 yS7zGXq7oaMaX9/6eOXhsOY36VBL8zkhIlJEuASXQ8HzJZ2601CCeXzyGnaU0+dy3R+55t0bDpl
 GAKG5/jMtrB76cN08XDE0rvAC16PsVjGjn4jh4WWkV59IepfoN4sBqjHbxO5Dsh0Mu/Yi8=
X-Received: by 2002:a17:907:3ccc:b0:c21:42af:4cb with SMTP id
 a640c23a62f3a-c24e2b3a618mr956721666b.6.1787678504386; 
 Tue, 25 Aug 2026 10:21:44 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68f9sm49241866b.1.2026.08.25.10.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:21:44 -0700 (PDT)
Message-ID: <6a8dcf28.4849ad19.1ffd0.9655@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260825-sctphantom_fix-v1-1-6504f91fd7f5@suse.com>
Date: Tue, 25 Aug 2026 17:21:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve/sctphantom: fix EINVAL on pre-v4.19 kernels
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
