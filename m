Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFEDD185CC
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767871123; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0PUkcZmiATp82mj863foJLlX7SOQYnDAtRWyOqyOJSc=;
 b=JEYA69xM4/toTV58SiMqtmVNlhcsmLhxJZtMV0whwHw9VR6HJBu2ob+xEBsJW7UE59uVc
 ZaIaSpC09DYduP0AbYIGF3u/Ja3d+SYK4M96YmmD5jobIOPQezLkEQow/2PnQ6uQiRJ2OI6
 IuxI/oCQmOxxANOXSVuUY9to76A6z4I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 885E63C5ACA
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 12:18:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56F3B3C2265
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 12:18:17 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E010F6000F6
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 12:18:16 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso12280395e9.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 03:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767871096; x=1768475896; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=dKYthfgHl+1vSuG72vFR696EvXnsp8MnwTR3YMf/9grV6DINBoMT0IWEyxs3gn0MVI
 hOJEzaufgiqG4SBWykO03GcGancrpsPshkwkdlvzgDYydXAXoXzINOWK0GmZeQ7YKLIC
 kmk8zsxCOx8pmuz6hM8drEnNjE5ZZ1qUGvwLnehbOVz+QLujT1L8xTCpxM/FOcS8smA9
 KnEEtFFf3jypBtv/0FIi8flXNeqJMU7y6Ai8V405PJd8MmjoZOn+XQFBby55Tnb4uqH3
 VYTEsk8fdHbkJPblI69pZKlx7mB7JDNcTSNGtUk8sVIWn5uMO41fQaiTzXjNqGPhRHDj
 VLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767871096; x=1768475896;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=TYrgmnaXY9i9SGuBT5SyFy00gUzaGeHAJxQPjlc8lvSbyXKxsA7lwVgfLFtjbz/rIu
 8BPu2PnnVJKHMt/BqAar/cF38ETN3BJ/fv1TF/YoXMuYyPc8/5BWn0oYlkFz9dWfzmDf
 O/Uv3Sc5mr8PzCOW9//3ou/v5E5BiMDeEcgGL2PQRvVoxwYiAz/CHlnDQgHyQtZx5na8
 s8dPgBe7E6VBEPO0jqfAv9/ykffHIcy4QH6Hmafe6JhJ83Ts6r9PICn68jBLHte8BQFc
 rnhu6pEtZppRevOSouzUkEF/mSV1CNT+pQFSeVp0ePGv8o78eSlwM33tVte3wzNjhnJ4
 et+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwsuUY4ox6aRtbkPZEwojbxWdVhTA/5yzghe49GbFgM53XbafXXWLiMvxl/l2wVDzv7T4=@lists.linux.it
X-Gm-Message-State: AOJu0YxXSXhB59Ja+DXRgcL64J93xsJM9sww2jqDxyYbqTvQXQG6uTYZ
 RM8f2aWvLr+n+kYe/nqvPtfNycaIwH2LITdnn9ElzIKMd4tgD38HmNAZvhKHWFx56qPo8NYMg+w
 BYn06bQM=
X-Gm-Gg: AY/fxX4GgY9j6yRPdikWE4Q4AoGwa/E2yZUYy8bqQ3rlghBRE5CCBD2JZSLe+FOwd0k
 hJrUI99MweMygD1CcIX/p2bBlhQp7BGrVjrjllssKW0UzOGXPiU6E4LqrWoi5UAkUQgHmP3W9V5
 DhdEwadJf4aK9CKBfwl4/fPK8JWTwoZcHTAd/F3SxCHZDeDyF5i+ipELZLKfUk4N0nx67T0tlgf
 9FcWcZ1YsowUZE/osn8H7ohTbZEyt1GzBrcZ7Tt6tqAuvRiQtFv02QBRa02i9aIXE+Fm19xk7T2
 Ob1iPgPn2x7lRB7Y860lMenXtTtZXjy49fY3pkZI1DxIMcdslXco4yFYvSwYfholTULJpaqWVDY
 pW9bh5fvwD55H9DLRxnO/m51YEc+qaN/L/oZj/iV2LRdhEsIlW+EY7cE3ilVCdQosgStCeGlmLN
 RMt/YseCsfLjUX
X-Google-Smtp-Source: AGHT+IGQYUcuAp9h+A48dnKL+PBEctRfTh42gA56ipQg6zkrFWA7Kwr8VxAa9ebKepC3dVN2bSWffw==
X-Received: by 2002:a05:600c:8b33:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-47d84b19f5emr65343265e9.9.1767871096291; 
 Thu, 08 Jan 2026 03:18:16 -0800 (PST)
Received: from localhost ([88.128.90.73]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm149632225e9.1.2026.01.08.03.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:18:15 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 08 Jan 2026 12:18:15 +0100
Message-Id: <DFJ601CMFZAR.A3TJMEMXOJTQ@suse.com>
To: "Po-Hsu Lin" <po-hsu.lin@canonical.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260108103606.35227-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260108103606.35227-1-po-hsu.lin@canonical.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv2] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17.9
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
