Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB239C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713450617; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=WhYAiAfrgJzJRtjy5PpzMq40KxokDcNMMWSPk7E7JwY=;
 b=g3sN8I3P99P4FvfvH936vBnsbGOkexgqcmTrNSJby/L04nkFN4qDU77cXt+bKlodjE2ZN
 BcECd0NMq59dqHPlTwH8FVHHBvWDXDa31dsYe1mwJdMQHy2RfKRWeWPUp5w/mE7Vge+Xob8
 Uu63XBYESvCCA5OMucWPV4fi27jmOPE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F4293CFC40
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:30:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2759A3CFBF6
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:29:56 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3CB24603EBC
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:29:55 +0200 (CEST)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-418e4cd1fecso5365175e9.1
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713450594; x=1714055394; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkGn/jMAYn0t8cgC5xeqi5f14rxClQ21wgEQzPUiFUA=;
 b=RWfn5889xKFqf8httZ7i8VOhzkxp8u5uVcaAPc5DALOF5xDlZdYxM3p1nkzqTRfubQ
 p3XjwF+acNSt0xZfjGaDWe3lqPlyba9Acymnqpb58pyqRsMC65H2w7DyCMZ6IciL0hJW
 3dmOz56d+bWyeXMZL8hpeLQNW9SYf2rsVetPGC76k4vfiEm77Em3q+42IlL+muqripWc
 EqDy7nWMdRiromgn1wqhSVWjlj2ZrYLBmtKco3YtXHFcGyl9lrJvCcSmwd5yeKKrNZZU
 pWpjhpgT7cAQMYWYHYJhr0TneMws6WeMHFNn/hEZ7HNVvSTpT8JmNTqeP/2pClwkg18K
 scxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713450594; x=1714055394;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HkGn/jMAYn0t8cgC5xeqi5f14rxClQ21wgEQzPUiFUA=;
 b=nY9RB8wg7EZLJbKNRqXJRNLBXsPsCIWVGRje9NYeo9JpAd9NQGWFgU00nRht+ImX51
 B2/oIkGeRRCnUxJxFL72xFWrNQynMdWcGh4VSEWNDzHBUt98U6U9I9LkugdKu7nC1gn3
 s7PJ9mVa6A0uZ/XmtWmG1G223ov5nY4GWrugWAoQsIqec7HH73CwjZsaUw3/BB4FJTJ5
 h/ZtPLzKE0yjDh+4vhJnF0mO6n7t/e4XwX48pkuX80SppKHMnOraiYB5BQz5CZTAaPZW
 /2yabI8XiVVRCV/IimiafGORa9jjHAY8Gdrah3CEfasNGHJqSbaJomQvsIxGxd9guXJ4
 kpvg==
X-Gm-Message-State: AOJu0Yy29LSLURbBu1EINsDvU0TtymTH0sWZrE35OD5JY875SmHwgmrB
 IVQPpZuAQj6kvSrkw35UuM8eggrGZUG7/YclWHERKrkMqdqs02sBLyGjeNY0+hhrwvgPWl7UQNJ
 oUot0aciy
X-Google-Smtp-Source: AGHT+IH5c4H2WD80Yfqs1poMQwhYpWQ2tmlrsHudyIoGyejyjmXIpryBA/ZfmpjJPlytjWdgUqs5Jw==
X-Received: by 2002:a05:600c:3b27:b0:418:32f7:e87 with SMTP id
 m39-20020a05600c3b2700b0041832f70e87mr1948812wms.32.1713450593795; 
 Thu, 18 Apr 2024 07:29:53 -0700 (PDT)
Received: from [192.168.178.40] ([178.20.92.8])
 by smtp.gmail.com with ESMTPSA id
 o28-20020a05600c511c00b0041898fc168bsm6693721wms.36.2024.04.18.07.29.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 07:29:53 -0700 (PDT)
Message-ID: <070bb7fb-6938-43f9-b533-30a39f628031@suse.com>
Date: Thu, 18 Apr 2024 16:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open monthly meeting 5th of June 09:00 UTC
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

Hello everyone,

this is a friendly reminder for the LTP mailing list about monthly meeting.
As previously discussed, we won't have a monthly meeting in May due to 
public holidays in Europe.

Next meeting will be on the 5th of June 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
