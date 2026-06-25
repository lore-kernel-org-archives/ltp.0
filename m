Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662A4CDB479
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782391812; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=AQ9wSdSz2q7DbxbSM912Q2GOXwdnBTy30qDTP/Vh9Cz1C6USQ+L2sq+Ovyv7wjcH1r/iA
 KnDWbBO/EBKL4Y+suyGq7EB2UGIRKNrct4hhcOnxi0wf41aKaHHRzHcrMS0hOQpMSk33SEm
 hwmvzgPYqQLBz/zn82R5PTcH5olbds0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C94F83C7154
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF9A3C7154
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:49:53 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E753E1A009BF
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:49:52 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so14127325e9.1
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782391792; x=1782996592; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cGqsKCPj1eUEe8oAd8GPIJ0hRkxDSNTdbRdziSjbseTBppLG60f8ijIDUOplAFk/77
 rw3MMlNJwjWXigTOWlEXf08ZvH+xi9aGrhDY3EuqdzeSSclRdjObsMu8GaQXWhmGodNs
 +jAFRdI8koircYNTI/lQTap4MzsC47Tb2BWWHqwBmm/1141peO1A721xYTBQkRee9WzB
 eI8zE+BV6yVRGv/9gFiwbMm1oANnbzuYlgyC58W1pTiBusrrxjK5WC2m4JQHx6PCltWi
 UQ5v5Sos3YpqHL17ELk2plWuQYg53I5G0nZK0IjL6nVYLVty6s1n6K3LTnhUPRrbJSRI
 9M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782391792; x=1782996592;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=eaiFElh5FeCPtEErAnRje19e042XHuDwL69ru42t8NfF+lQZJlkcmhs8Lg317kydPT
 KeDFoGnoqfWLmrDMI0suGNMAb0Q7nzXoYeSdcp2xm8QaUHHTc4CNEepJofiKsCMgb8tZ
 Qc5hrARsCw1CrPBm5dFcBgb+jBfK6gnYkX2119LmRh5ri8aBwut+/KzxTjpGYfTKlSN0
 Pzm7pDLxTXUNFilIWITPV/Ww3XOGfg0mUfLxeuyGKLjcMDXeGX4GXfprOgDPBWrkQ35h
 UzDKboalMQe9+eAu+6yRZbfoQQy+xvZaZyjsJC7oMFq/gXXLgXAi6gOXOL5TJeGWbGW9
 JMXw==
X-Gm-Message-State: AOJu0YxKc8PP5whMuXg5dMUFoR5omVYG+DTq0eY2UOYUTMFpNhg6SV/X
 cDb1Lt9d9W/Bz192++TYJpHfbe9pSxjb6CsscOp/t2FeEFM9FfjIn66/3IUpxpJVh2g=
X-Gm-Gg: AfdE7clkD5cOSJdVc1LBb7btn+b8PjjyjbhtOdQfxMZgTDNrgOQyvs4qFhxCmL1z3rq
 mqGGAMjSvU6l9TTuS1uYfa2yIpYTP1x7gz4+cjIMhc5rtD4gOnO9xS+oTjFRFWUKu6QMZJsQioE
 NAHDT9LGADAl47uB97YzdRVUYyCbjqx1WJNPP4w5MqNo3ztC5Jl/RVSgTrziG+68AqDhZfhoQWW
 t/fg4iJWPqIDcv09UjH4Nntd+18cmpzcufOyt/EHJNXrgPx3JEV9flXnp73DJM7XxnosSGBFgoC
 ZqfeXRD+lSWVTXWhmbU486rmUIHYChBUt3oonbRFJNspaw4r3jYf+exJwE5R3kpCi1yvWgi1nSj
 gbaP2n65CE+8cM44BU277QQl/rMIG/l74ZZDgWABI/TjOzkRuDvi8b9ERwJfZHLeucP5+wXLBvF
 wtfbpF9goXyg6EH2AviE2htKstoFn14FwMtT44+6zu6d2OTwAyvLKD+N1CnIdR0A==
X-Received: by 2002:a05:600c:638d:b0:492:3763:aeb9 with SMTP id
 5b1f17b1804b1-4926687e72cmr30425605e9.21.1782391792202; 
 Thu, 25 Jun 2026 05:49:52 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492640362bcsm88552035e9.8.2026.06.25.05.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:49:51 -0700 (PDT)
Message-ID: <6a3d23ef.f6661fbe.36e118.bfc3@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-8-chrubis@suse.cz>
Date: Thu, 25 Jun 2026 12:49:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 07/13]  mem/thp01: Add proper runtime support
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
