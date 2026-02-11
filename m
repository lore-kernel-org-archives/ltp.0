Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E96EA3F27
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770805653; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SJUyEqCh55tliUCFcqreln7RLij1YOUdZa600T34BZs=;
 b=gSX8dYLY5y7ZgmSBG0zi5J5GlGnykGxp009aSrluJ4Y80vft0dDv8qnpOvUDGJg3sD1P1
 nLyzp//c0BkEIwG+/m2pntEh87WOkQ4d4HKCdsO4BptNEXbK/wbiH2o2lNvFeeWHrF9spcq
 Lgetw8vbGL/Nb0H2Df/sGgia09z2uOM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51353CDCFD
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 11:27:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1646D3C4F59
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:27:09 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8DD06600BC0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:27:09 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so2599771f8f.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770805629; x=1771410429; darn=lists.linux.it;
 h=from:subject:to:message-id:date:content-transfer-encoding
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5pPjeglBYGQ9inCXkB9skZW0H72U9G3av86xEt8tT+I=;
 b=DDkSWUGN9oVK+t34Zd9KqK9AYYlseZEG8NWzPJDzYnvjnCcSgRdo/lZVMv+oPw1nTp
 tUWzdev+BCevkPfqzOjNt/tn2OI4swK3PBqDtDZegCLiSreuJZtWp2cnwbJkYqpLxnEQ
 CcND8yaogZ1h1DAINLVe/NztOL4ObnwhS99fz8ay4VLQ8xD04d+Pw+xdLhlCSaBuCQrO
 oh6F9ERQa8PTo33aaVsHNqhKa8HtVWP/0xfYNclU8VU1zruUv3K2GbomDwzjYIa2Ib0F
 sZDzDpZaPmm9URr4CICRqwjyHClaW7hQfA7RI5jrO6gZbaid3YR09bXJxDDQqRmlH4/q
 VQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770805629; x=1771410429;
 h=from:subject:to:message-id:date:content-transfer-encoding
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pPjeglBYGQ9inCXkB9skZW0H72U9G3av86xEt8tT+I=;
 b=eUW7Fp6jMtSKKNOAVNDLgi7eUs7c02zw4u5ANhddQiqmr/3kVZDtU/maGPSSf5yiFX
 j3eU0pstsoBEsCtMVgn4uR47i8brmR0Yp2EJQj/RlWi3d48ldaFmC1MSfbTkYgi6pfq0
 DdwOrLe0BNHcf1VxFVCZ2IPdURnhYgbnjkCix20WDRhUgAJADgFdrcXMTdJ0/EmYmRLA
 W/AJzpxSNqRSXWcyfuWCi9o1dW2Ir995xqHckv6jk5OdkJgqKGdzznd5McdUMec2jA7f
 StQyzN5EyyNesidGwP73LjTVjCbmwI+S7kHnfEyl1/2d2Wfc40cTYn89TU3bvF4B0dVI
 ZHPg==
X-Gm-Message-State: AOJu0Yyz4AY5vL7IGGxFqUrEENDi0Z/mWvMjxzspbrqdxq6nXvipoYSf
 OpF3aQ4MhhvPYMRXFFkfLp4GDMkWe4YzB1xrMTltq94/Y0Y4ywSiHfZN/xu6W/B70pVnN/PeGxJ
 nIHEtX4s=
X-Gm-Gg: AZuq6aJMbKwYmiwk6pjwnVBEY3yc9f7hKtrfAjYmWY2DB2WzGT8HaSEmDf20ypNo8yc
 WRis/T+se38Ne+7mYFt7FST3nIbROffKdQ+H7tQsmyyBkP5zMrJh/S3HHiQZaUFKxZdmTfBI+MT
 /i+N1OcLK/quRpZW6tsPOh4PGlhCbjnw2tmG5dP9Tn8XYFxeVVqOowWsZN4av5IqMLL68sPbSuD
 KKY7Pw94ttRDV1ZYJ1AkKQB9oLYLU2mYc6CtPymV7m0CIE81IrEc5/4nf7FO4OVrRIjjkeWYV0s
 VRD5arx0wDPFea0D70EEXJM/sxnjq0LRLVdn7g+ydqfGRleKycWrmexbRqnYzn+rvAVct6wuR+I
 QTUGpi8dLdjXcJSLUVBea6xucoDGXcTT41/MQf3s3ev8hYIyi9JyRW2NPWPjSA6C9wXuiTk1h+f
 jbLng1Ay7tkhPd0b8g33oX+TScHsy8mq87IdlgMh+//iw7fu3tFQjyWK9+fFfFAQb4qljZaO+NU
 +clOp+EW7/Zy+htpGo=
X-Received: by 2002:a05:6000:2907:b0:437:8164:e958 with SMTP id
 ffacd0b85a97d-43784521a2amr1978725f8f.1.1770805628599; 
 Wed, 11 Feb 2026 02:27:08 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5be13sm3668612f8f.35.2026.02.11.02.27.08
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 02:27:08 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 11:27:07 +0100
Message-Id: <DGC27F1BK4VU.1MC5BNP80A236@suse.com>
To: <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] After release meeting
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

Hello everyone,

what about scheduling a new LTP meeting after the release?
When's your first available date?

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
