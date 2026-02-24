Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4492E9B258
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771940106; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xYdWttO9+MbtO8W6Mo1uustAVK5k1VhK0MZLIdd4CqY=;
 b=qoPFIyWM5GH+1kRtjtRruwt3/Nm48fT6SJ4RHTxY1srZ255htpqivvhqVdcIEIXTAC4Tn
 eHMfsDOVtSELnOmht6I3Hn33Z4Vtdvl100cntH3M6wkWe0Vy0x+/QM5KDU0iafvH0aa4fzr
 mhMy5/oR9IWfCLTPc5yjQoIF7+qTr0Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974163D0F96
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 14:35:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CA053C015D
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:34:41 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E0231400054
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 14:34:41 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso39045805e9.0
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771940080; x=1772544880; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AvAzSwxwtXLInU6GhQMHcGkrKXOPZo9a8vcO2Tiqy8=;
 b=cYEt4pt6LuAaXiJlHfIj5sDd724KmWvsh+ouSYxDI/WGmoQTkVOVK4snQcjyOI6V99
 SiobeFr1OlMMnDQDj47aaCOrQMkqdJ0XLf4J6ubFh5RGZaMrA7UTzz2StLkT8cx6epHi
 GBG7ARIvzWjW+7mMRV3FzraXnG44pDCS5r5PhMpTUVeITrMyZq0f/g0CLmkdGrpHmJot
 +jG3Z/S5EZ6VqZ6FAnPzBy8u/7pl67Lc8Wo3Z5vFzFrHg1E3wAbXjmU2jhm5qSFFsxFu
 5G3H0OJ6ZAXqh7gvCVafL7hT27Brd2RvdQ/a3MZVArKxkvgIRt0JoWS1VG14CQ8B+OoK
 UZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771940080; x=1772544880;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1AvAzSwxwtXLInU6GhQMHcGkrKXOPZo9a8vcO2Tiqy8=;
 b=uvUt7ik1q0UjmOJT3zS+v4nmdppPDQu8x4KH1B/c/tAW6lYPlGxVWOQ5WHkOUmG0OO
 mr3FbJMxFdbFrG4N7ijd9eeYfBCJUIoBHeRl0fRx8IDwYJQqVolNJfkxifNB+7FeXdAJ
 7+munybMHxGZq8Yyiug9piXKfKX/MH6Ss+0/7p8Rc18EKw4goVtmLGUzF/r4Qchj7mEe
 TkpipQEdZNV6a7rphdX+xOCqVQZiAafQygH5zOSDgKWzTlipVyKu1MWuzdlj7Z5JGIS3
 neOSnf4BzlFIax9wmTJo+DDwmZ3v3/9+5nRKG6012Crebg4YlP4vce20ax/PzSW7mXoh
 9jxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9iXbRL3hhrMZmiJAzmJRKcn2jxihVVKSECPup8S649nNX4dX3LPkhZ3fnUTDzultABBw=@lists.linux.it
X-Gm-Message-State: AOJu0YycE/C0SO3De6ktG2ihM03HNh+tlT51E3sLW+FGOEKtOnloSXHI
 zajkCXyvKcBLqtrM89RRaic0Kaky19SgbnQW1DyRzXQN5QdKESZsuUQLjJIneG4ARUcqrZZYRIQ
 fOhjzu0c=
X-Gm-Gg: AZuq6aJQGS6NHVJPNONyZuHyGMLJx2Bk5kBU7AA3IVERwKy3d+7vaEW2uZNsgWstAqg
 rQzV3SvYC8CMz83jSciGJr+VtR59Xe/MIMPA8pQY3DM5xfWJB7kRZiH5yjEn/5O0/6q7zwXsmx7
 ERzsxDPiNb7MfTUbiOkCjowuEQFbjFaJfDsGy3T5Jc0wGjv/Y+jAjM+PfQtY9rM7sQRulk8aaBL
 Ndkul8C10sRhxy0yBM3lI5liMEDZr92d8VCsJ3of37fT7WScxtGV3wUmisVQQG3hFqMRExTPN9l
 xpOVIzV1oYGqSv+WFFd3gdr9PmW6TLXy4S9yhjPJ0H/04wanu33NFQherzh+mrZ9KkTvTREoh/O
 zljSiifFE9si1qhLxFExzjR52nRbPqkyHxtp00in1PH1cpL2kK3pavG+s9HAXi/i5moUs93ejD7
 z6iDLE3CF+ADTDq7DkuISbCAHK
X-Received: by 2002:a05:600c:4fc6:b0:480:4a90:1afe with SMTP id
 5b1f17b1804b1-483a963de54mr206100065e9.34.1771940080499; 
 Tue, 24 Feb 2026 05:34:40 -0800 (PST)
Received: from localhost ([88.128.90.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6854c7sm1172005e9.0.2026.02.24.05.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 05:34:40 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 14:34:39 +0100
Message-Id: <DGN8C2WWTN5A.3KWMOWRBN1QEF@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <chrubis@suse.cz>,
 <ltp@lists.linux.it>
References: <aZh4Tsd1V2rlgoAn@yuki.lan>
 <20260221082139.1709-1-always.starving0@gmail.com>
In-Reply-To: <20260221082139.1709-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify: modernize with SAFE_ wrappers
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

Merged, thanks!


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
