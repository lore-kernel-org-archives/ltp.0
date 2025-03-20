Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897F3C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742482433; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=IWN+FwrfLtXhACJLofSRXeUBHA3f50X2UXzAH1Azhkw=;
 b=IMpLfesH2+MhIYUHoomu3HNPEQISAF9gpVj9XSriPs8eMAhVOeEDhNJmH3C5rbLst/lLy
 LR6BkTB+EcYj7Y+9MB8agXUBS+w1oOuSanuBNk5DVHR6d3lST8WP9qq+ms9axPQX3UBiiXY
 GzAZ9SH3Z28VCEPb/oiptDQfu771Ex8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895F43CAE41
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 15:53:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C803CADA5
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 15:53:32 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 27CE810009D8
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 15:53:31 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so6119465e9.3
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742482410; x=1743087210; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJdu+8n+lJbb9fXH60hZf7uy2D6y7+EwAZk+OqCdSjY=;
 b=S2svTTgJ4/YX9C3JLVZCZiJL0ffxOUzqMzSutTqFj8YY8EL183/WhNFMAoLhKPnS0W
 8o+HkBYDQh2yJBNgaH2Xn3p+e7b9OxrhLS7Pb9MIAbcSmrskXlrTGmNxmItYnmjPsn9W
 FGjwFjCbVELJ6KiwMEWOb0RElhFCVJ31DNGjnQ1wgTPp48AFps0c7WSQtO7ZX5HG9eE/
 D/ozQA3HB2GqNrQjuKg5/TKHJb/UL6oNM1CWh29bmKXqGZKtTF75TIIf03aeqzw+Belf
 QNQ1lEH1wVM1PrUDfRe/suBtkZQJBkWiWLe9BKqNZpauRQMg1lVY5T9TBwM5t1zThr2R
 VZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742482410; x=1743087210;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OJdu+8n+lJbb9fXH60hZf7uy2D6y7+EwAZk+OqCdSjY=;
 b=LD1dD1tNT50zktqv6nN2tgAPMMbicKdLPn0ogmLB7hi7w6ivw6sfidtHGvVW6KHdBh
 48od9dPWijB7qofIp/5SdvTQ456rjVz9qZmZVW4cue8UOmDjaSvYQNgyyYQ3YF13U5a6
 EVPBl8wA+zTnQbfx/8MPBRlqYk3+lgJu772rrfTCs628aSEiofqabAzBaY44r3FW+xDy
 +U7p+tZOhZC9XIX9XsY+zBXdYnYIbaH+en5cnsrGslPC3Tqet/EuPMuLIQcl1kvAvAny
 Aap6YyxZ/jmmm7cARYCtD0rYsskOtxCqpQQKoxiJ4SfClT1nWobx2sIm+SRYSh/vHPTa
 t1ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKaJSbMgVg7tHTxf1ePzZQbFqfetFLm5WoPDMDVcLPeFi/ikdnH69Y+SnqfDZygkLVTYE=@lists.linux.it
X-Gm-Message-State: AOJu0YxvJLhWV8oA4TMuPGBlyLnF2ryN7wIVtRY1MkHyoSfmxoP9u/Z7
 SUQW52XJlEMvlUmdQj2JvXZ9VBY/9F0Q6xC+KIBIhXy3KYRo33Eh36Dx9RY0PWY=
X-Gm-Gg: ASbGnct21D22Cmyo0SjWnZEy5nBvJwS9+H2oPYtOcnKRJfwnCORsR0op+4x/ntWlVAE
 fe7HnggWP9KMKEuuQ+rnulDMDRolu1381/l71jTjDOX2XMVhcFkKs8ssiQwxkG3e96BqDeZccsQ
 b4tQ2jSrftBCfLKJFiXa3tv3t1/+fGAAMuPwp5zcRf+CabFlP+m2ZruIYXGMwnHCqY8ph+i5I16
 RgBQgcw3yFD/LmSix4u+1NkXvjihpmXgVwrg9vI0+BHU50pn8V+Wli7qv/iMgr5YLIVQMgnDX4E
 YF1IrODTyOnIqmjvfLzcuT239L0MTEWT/QdgYjj/BrT1GuuwUs5cZ9Q=
X-Google-Smtp-Source: AGHT+IGDBmJ+SIMOLuciO3ecKiZ3pDBTxge9hFabGD/ERuWDGRIV7dDrglhuS6ZdJ5kL0TXbvROI4Q==
X-Received: by 2002:a05:600c:3504:b0:439:8c80:6af4 with SMTP id
 5b1f17b1804b1-43d437dcbebmr73404445e9.19.1742482410420; 
 Thu, 20 Mar 2025 07:53:30 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c82c249csm23551408f8f.21.2025.03.20.07.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 07:53:29 -0700 (PDT)
Message-ID: <1501d311-106b-4516-87d6-f9a86a11b957@suse.com>
Date: Thu, 20 Mar 2025 15:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241225114215.2973-1-wegao@suse.com>
 <20250319044750.19434-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250319044750.19434-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mount08.c: Restrict overmounting of ephemeral
 entities on /proc/<pid>/fd/<nr>
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

Hi Wei,

Commit message is a bit long. it should be 72 chars max. Maybe we can 
just use "mount08: Restrict overmounting of ephemeral entities".

On 3/19/25 05:47, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
Uhm Signed-off-by here is a weird thing :-)

Otherwise LGTM.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
