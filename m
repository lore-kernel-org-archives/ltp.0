Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA9FC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 06:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785998143; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HMHvivkiRr2yPj362wLykwFZ3CCd2MgzWJHDQHGYwco=;
 b=mpRBuTRY1AU26L2hL7ZVKhUMplwM2q5yFT1mMsUjzYDOttdzwvcsshh/uLgf82xw8i3qN
 a+tsYs8FEP3Y0pL+LtmB+hNIV0YncxKZyWh3TgoRoKMN7c2uHAyzCxphP7Dv6RG0L9sLYAv
 frCYiqWdk7Wpy6706phqUI2mbnGE8d4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B426D3D064D
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 08:35:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCFD23C73AF
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 08:35:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 129B960077F
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 08:35:24 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso12553025e9.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785998123; x=1786602923; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GuI/HC501tGgmTTLd0gZfZJVQmdKOa4QHt/elFGbpKI=;
 b=fKj4e+YNCZ4CvO6oxAJAgBaRjtgv8rOQHG03nDBrLVFzPQ1kRVT6AKXU6kBATdWDtJ
 AJGRvv5OqcLpqdznpmQ4E7RwDyxFXcu6oRKHw4wE6iZVEtvZmX1D7AARtr4cIL61k4Xc
 G+pkRd6vTcYngklrYe2lYc0xcPLK5FUutI7zjmy+4iVBXkXrH+8ugxT9PvcUzI1huq9B
 /V3Q/alGuZuDlNIHC14TsCVeEkizZZoNucP608pFpvSx84hb710H5U2GmadLcqy7Hyld
 TTN5srrtNE/4n+zOX1DTHbSFx9i7IfIyrxYtyXhiO6pWzW6SsKrmTJ85rpWAIDt3mJ8K
 yldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785998123; x=1786602923;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GuI/HC501tGgmTTLd0gZfZJVQmdKOa4QHt/elFGbpKI=;
 b=sHlk9NORO7A2MEf4KWw5Jmo145B06KN7lcn3mI04cCiWaW7e8kBOYFjquNBgOCZfUj
 LjgeLa/wDM3GG/ITbsL0N+2jI9litBoVa3nj1v0sAgrpO5w/w5yw3AKk3qBdDPFqn/qI
 xhtA10i+UJgqkSpaHytvFW/lLGphj57YzaVxis01hhhk/YO1JyZjo6uAURGL6n+lDVMc
 lyUFrRN5493HkjMa+MytUnwsSlDBH++KHJNDon9eOpI92hjkfutG8/7wlPwOGCRPlBc+
 gupj/WAJmwjfNOmEZLH1xW4sDN13xXFPs1Mpf4aoYYbPrmHTOoJI8KdzxM/IggbmmmAU
 4zOA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp3bfbh7Sj1+guP0iP6mgUNmU3Oi7hn6Nt8z98T7687nMWo7za+XMSqX/H4E754h3SHeU=@lists.linux.it
X-Gm-Message-State: AOJu0YzF3rGnt7xYj3IsBWS1DRd70z1Pu2GMiVyFz5kW4ZrJdiyQDCWh
 OloH8jE/YNgAjkl5CqVnoKPoXTNuO7h1lO6LafAMOy12DhwtWDFQg2xlGcLXQ/E6o6I=
X-Gm-Gg: AR+sD10XkVhiqsS5Wy1J6/gS390vNsrBYVBx4OZPIigReR9+Xk+PzpA1lnprONHhbjR
 3qKViIg2sW79QRVTUFeXuMKzUrE9LOGLj4cxKcSXKAZug7ImYuFLnRrAvL1K8Y5tlmBSyLK3J6E
 nmf3lNduZWJmkLEJqLH7cyq5CYIzepzzc0iD6MqzIgU8Ii+Bz4zFPO2kFYKXRlVnMxy6m45C6c7
 WymBgbzRAYFnHmcknJzzztadJsoUxewHffw8wT5WwrAPKHTcd5q2tqf1kx0qMBO5HaBxCCi8CZM
 fvWQaOdTZ3zse4P4/gjInhapC1tsBBdrb/QVT0oZ7wVOE6wrPnFAvpRD+5HaB/VBBhVzCsH8JwM
 s5gyf35Rbsz6BOTnlNXzysfkmr342n95xDRgwRZxDcHN2XMf29SL8F2PAbtQkVEHxaJDT2W8MC7
 O7KfGmRpSyu7v4NoxnbQpOIqAroVmYCDROqbrfZFu8ZknF+MlatmmUErR0OG1kquDLTu91jiXnJ
 cyVVKxb0DuywaeQkS6XPq2/wyBgv4vlCcaR2ypEVzgaETifa3x/UTog62jarU4fENMvDiE=
X-Received: by 2002:a05:600c:8b35:b0:499:4d4b:be2b with SMTP id
 5b1f17b1804b1-4994e7d2bb5mr147156595e9.16.1785998123368; 
 Wed, 05 Aug 2026 23:35:23 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff706f286sm3625626f8f.0.2026.08.05.23.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 23:35:22 -0700 (PDT)
Message-ID: <6a742b2a.a148a86f.390a0c.1a18@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <amsRGxrUfMnjDlFT@yuki.lan>
Date: Thu, 06 Aug 2026 06:35:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Hongtao Zhang <zhanghongtao35@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> And honestly the PCI test should be either rewritten and cleaned up to
> do something more sensible or just removed. As it is it's too fragile.

sent a new rewrite in here:
https://patchwork.kernel.org/project/ltp/list/?series=1140684

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
