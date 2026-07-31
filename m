Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD6C5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785496728; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=N3V0J7t5GWdKfUeO6xH8UuEQxeX1uUrT3Jqg5477z4M=;
 b=SDYXH3WUcU9g/88vxUwwWS/fQKkkSyH8Z3g1WdjYCOBSoi6FN6twPfZQSsEpVuPHOzLMF
 vPO8YRrHjKoNc71WltoT/IzEIDNs2ItjEzM3wBO6jR5oxZTI3+NFmKbyU5aJnAus2n/1Grv
 iulFSRv5CfCg+Slwdxx0PXL21KZk4CE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5996D3E71D6
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:18:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EB6D3E2D15
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:18:26 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ABDFB60070D
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:18:25 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso104104466b.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785496705; x=1786101505; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mRPCz/47SPMOrHMeSetrKnYq05phlnLAzwv/VgMS9jw=;
 b=diYVPz7COas2ccN3cS7fv/E5Fu1qg8MFBUyIwVsNKPoypdlwlyw1dLTDEKQlY2kfM5
 Wy1YFRzCDslqMqmxl0bWYNSmX75eqqW3v0Rjeo4cJPz6UKcA7xGfgIkhfTP5d6QXdXIC
 +wR8zZ+bEP3pnkorBSHgAx7+earl3Wodqi17/rAjmI2qMXXhrI4cW66EiyUI4jmG1oKR
 BM5mQZpsZ4f2ME1CGrltcknOGWjmTRE0cXvxQy/o7ZJcSGR20yje+UgPFMccMx+Bemst
 E+v8DiyxJ/V0MuGyn6miAQ6wSxA51ctRXNF2KmL+CKC06Qx4E0kf3b6WBivJzP+XpqdA
 I0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785496705; x=1786101505;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mRPCz/47SPMOrHMeSetrKnYq05phlnLAzwv/VgMS9jw=;
 b=Q5BFUiNNFfIZPSpPcus2Ej74SB2LSKNXmjuHx0rOoRbEAjr6OXff8Xb5AgnjPlms6g
 HBb0iIe/odplR0X0+x7KCPDytg8h/SiboTTgLTQmzo52TRiUHRIjXns1y6oVizCcjcFt
 QxeBBIKl+7ach7ill71XKKYiSk0Il2nk8YH+43Y1L3uVMz0lyBLEjj5GEg0z3Cu9LDfY
 Whxoaqsk0sJtXYKt6/3Z/m1nyWl/LY8BoBfslDkkEQglf3ljepyKxYuWMNke9cTfO1K1
 Ti7uf38oBq8l5Qfxr5Mh5MJtih8BrzEtNNnHfQQV8IP4iTIyoie54g032idcIt2LDGim
 bHkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKz+OnstpPoAf8aQ/+l4A+fuKaalMZT5OVg82HGZXgUDf6tvAerSJr54gywg0aZkfgLPQ=@lists.linux.it
X-Gm-Message-State: AOJu0YyvwThMBv8PWwcbedUiR6roWMrBakKRZoX+mapwBXy4lDaC/uj+
 rdKby0CgxJvQW44/rxk5T84rn2TfN9XpE3oDzxFYMRO+4jJ1tr9wUZ8xBiwXsBeekaSz4nYC2tY
 nOB7Nq0DBow==
X-Gm-Gg: AR+sD133vbdRXYFLy2x9N91S5FW58A8bdye0lG8/2wTS+dJdv16avuu3On0uCohzAX2
 W3qTZksqGoPLuW4Sp//2ox8SStkWWPvYdzuy5TfLyhYwMMSQwF35doGRbHryCDQFOooQgZkoBal
 BNUF0mOBEOCybB6NFjBu/Esz4FYdKw3flCgnWtqRVMpOJZznI1lwBqcUqVOT6Z0FtflKZsX677T
 4j2hZcunD+vNrVUL3cjGvez2lRL7AKmsKcj5Z0rMakEaAUJfyRRG1KmqO+iN4JMwOW0vLpnr6dH
 uEKxriWoCI3cXEGnkyMWw0CmCCy+udcL3Eg8HjXX8fniGAVequLSu9mIvvkBVI7g7VYDFgzvS5t
 TQSi9ZWo74OTSVaJApGe9r6N2Zwm2t5iosxxmZf0SPcpyt/T//9MXd57VLulRxeH9U3RIrtH5FB
 lgMcQD0B4msNF2Ww3Yhh14CxpMBaQdDM5lAE5WncHjnOdlav9Le0dI/V8MnLxf8zap61tb9hXya
 f3+/+LTsHJfa0f5XcSMp//u+aIPprlM0B6VfA==
X-Received: by 2002:a17:907:ea8c:b0:c16:5f28:4575 with SMTP id
 a640c23a62f3a-c1fd253c76fmr106291966b.31.1785496704973; 
 Fri, 31 Jul 2026 04:18:24 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0ae0sm3565119f8f.33.2026.07.31.04.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:18:24 -0700 (PDT)
Message-ID: <6a6c8480.359f6b3d.45242.e5dd@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260731111255.GA192663@pevik>
Date: Fri, 31 Jul 2026 11:18:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: reproducer for cve-2026-64600
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

Hi Petr,

> > literal 864544
> > zcmeEvd0bW1`u+yxMr9o;E1IdO%$o%^X-RPuZim7`kuog-5yA-x4yN5o6zF;)ie|IP
> > ztb4PW#>=rfVh(5{*<_<+(?%MoZf1Im-}Ag{uYDH7?%wa;zkB>__kP~J*1O*KUGG}!
> ...
> 
> I dared to remove this unrelated binary file separately, please repost rebased new version.

yes this is ridiculous :) will remove it before merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
