Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF99CD1284
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712232923; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=iabrzSCmCE4s9bdATmQOAWMarCt2oZB7RoKiv+uiT7c=;
 b=DF6za8O8DpU67TFofKAHF1g0csVmVk/PFZVNpSkf3HXBfKa1ca8D5aNSGqWa+k6KPMmJb
 9oDZWf0PaP/g20hm/lG6rrtTLSUEeFdZck0iWLT69c1yN/MjlUOnQOfqkIMCvPKqMsC57cN
 MKUO7GvL5BC7njip7RdYPp6BWuNfFxQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061133C13BE
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 14:15:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F109B3CE0AD
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:15:00 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E536200CEF
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 14:14:59 +0200 (CEST)
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-56e2119cffeso511870a12.3
 for <ltp@lists.linux.it>; Thu, 04 Apr 2024 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712232898; x=1712837698; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9Hj15i4b4zTNySH/FRCXj3xKqayL6XhGFkwBfc5G5s=;
 b=fzAt8UfzWMDyP3Sb9PFZjdCDfedLjtjbuIA4sbO6rgmyuoOBf8z6jJ8pzQjy8/JVsm
 Ro9eEZMnCmEQX8xywnOsthVjMBsQhZgmGBa9mtNao/If7uSVEPngg+krZiMKcuVtzOWh
 aqvPlL9ZkBeepFZHBGUxVwnmpGUfV6BDj3AE2+/N13hyFo+nsDKb1uxY33Xui7QndBpa
 Am8Q7DABT8bdkLWjcU6on6h6QPX5fNvzUVQpqxm6GOM18cg3JninDEAE9aKUSY+U6dvP
 fc+pSEUP8MI22YiFIW81d6BNMPQK5yYqCp8jANXGa9e24S9npcJpoH3o9ERVtzJzoKsa
 77Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712232898; x=1712837698;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D9Hj15i4b4zTNySH/FRCXj3xKqayL6XhGFkwBfc5G5s=;
 b=TRylbGOZiTixw7d90ol3p9tPfkCiDlH79y0C+y3NdYvO12VDPnm4pss/I1nzvksRg+
 0ViEtK2n9muMgDBxO3gAX6LJO3/pmhnjsM4Z5NDIxTz+nltHISCXhm/qY7koJyS1OD7O
 QRpPDtrjiH/2Eb6eIzJOl1pru0KLL4jIq3iW3ixooIkwtEiWh0EdtZLS28d3L5515PWc
 H9zW9BW81BQysVTr1Uf37g+wcQAO5pO2JvKsA+B7daMw5vPb8aEHbwJ1DWxV8Eu3i+p0
 46r9iXnh2KCUJP+0KM+XiDnflH78QT0wP/TlsA0AXZ6CzrQ2KL38IcyhxPE50lyWxsyw
 5sVw==
X-Gm-Message-State: AOJu0YxgNcALMfF4DRcJFTOUByVvISSanGvjbFOxBuIpWpBWxGXonlTA
 bxpqIo+bbkYzu23Ym1ZedjyjXotNK5YUBOTdy473Y9pHvoBA9F7rE/wgP/oeS4UM9H7WkXSiCSN
 s7Hy7BjnB
X-Google-Smtp-Source: AGHT+IEKoMAZutFCHpqZ1I6K72ZmvUHoUc7PmsqOtjyIGkQxltj0YG7lYh/wiT1/h/GRu0+6xEdldw==
X-Received: by 2002:a50:f611:0:b0:56e:5d4:92bb with SMTP id
 c17-20020a50f611000000b0056e05d492bbmr1826184edn.9.1712232898342; 
 Thu, 04 Apr 2024 05:14:58 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 dn20-20020a05640222f400b0056dfda8eef3sm2247048edb.54.2024.04.04.05.14.57
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 05:14:58 -0700 (PDT)
Message-ID: <c4fef6d0-8460-498c-8f67-8c3d16e25b1c@suse.com>
Date: Thu, 4 Apr 2024 14:14:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] April meeting summary
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks to all participants of our monthly LTP meeting. A short summary 
on what we talked about:

- we have a new LTP documentation that will be merged soon. Its 
development will be incremental, starting from a sphinx generated 
documentation and introducing API usage step by step

- we will ask to enable 2FA for all LTP developers. If you are part of 
the development team and you are not using 2FA, you will receive an 
e-mail asking to enable it

- there's a discussion going on about disabling GitHub PR. There are 
some pros while using it, such as its popularity and easy small patches 
merge, but at the same time it duplicates review workflow. Perhaps, new 
documentation will explain how to properly use mailing list, which will 
make ML easier to use for everybody

- nowadays some filesystems require a minimal size, introducing the risk 
of receiving bug reports if we don't handle these cases: 
https://lore.kernel.org/ltp/20240403142431.GA452858@pevik/


Thanks for all the suggestions and improvements.
Have a good day and see you the next month!

Best regards,
Andrea Cervesato



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
