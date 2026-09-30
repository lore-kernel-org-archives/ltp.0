Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB426CA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790754349; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VjnDSlNyQ/DWpVpNIZoDzGG2eBt2TPRhWLjn3grL1N0=;
 b=QDzrBbYGUTFFkyMyytIAWddWuKQHc3294y7fUw7KMtMKFZ3lIhoCyRRmlaqzJLnJR8l7W
 zd8gH5nThjcdj+Q4RCEq0X1svp1qp60NL8BrXOumvywmCyjdiOzXS10Ew9y/ihHENHQS6oc
 +VSD03Tny01Ghqj08rHYpN/ROs/QQjQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A56D3E55CF
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:45:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C948D3C4E64
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:45:29 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9E0D6012A0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:45:28 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so24553485e9.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790754328; x=1791359128; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1Cib0ENHvpiSyuMUoE5Nr13iUyMUe64YPx6sMp83f/k=;
 b=gEnd6N4XBvp+US88faLP5qDWR8f6nBqHI6m1dt/+y4OZPtOpOu0RPy1j5EJJHx8z8O
 3kt2c3ToEu/KbGzzF39gFvLb7lNFyJpbAcX7PLr6Ri+6L3Asx32zLTgPq3TeURKKHLyG
 AlsXL7+aqqMCxG7Gsz/rzDi6TJSfls013vOE8peSIaoNsir1P44G8jlirdijo8MkAwxy
 1LstZW5buliet2hk0K0Tbv9fzbiqXkB+KWFpVpJJO7ftafyJV3lRmLxXMNSNvcAtWlyN
 dKzWKTl21yp0cCavhryf5/gec/FQpF7q2tPY1mEbE9SwlvIZJihR32cCb6yABgoKxF4u
 5utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754328; x=1791359128;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Cib0ENHvpiSyuMUoE5Nr13iUyMUe64YPx6sMp83f/k=;
 b=BTJB1v8yrpkRvwFvaAgapJilegigb5z7YjqaCH1VnKZyKcDgbdW4MWQLTzjLjp/E85
 Sop3BX8BzUcjeDai+2m+1+2ELwaGQqXMdAvua0JFlkdp+NVQEaGxyVBKm6reCZSm+I61
 VfMr55ciHTlN76pY5gzp2MgjKEjiG/uC4keNc6qKKqmURPFp5dJNVuYcikLSouoVPnvf
 lQ5YRYOwn2D9jdVFEkI5V/X+CDCk0lMVSBib+Koo/DJm9OJ4Q1NVvEVSogxEAIHn8TQf
 iDNH4zTTXiDFv8Krr7/NEgMYxA0LtfrIQ0VLp4ledvpDe8g2XEBaiKAWzfe0IY9It8Jn
 ou8Q==
X-Gm-Message-State: AFuF++kRd+htif8FPw6CzdwvzMllBYJy22M9JVz2gko8yaBfD3NBvLV5
 McSjh07npSI2LIfEGubZkjhOlVY77Q2LoYywBSvFojxkY9m9WBtVHxwv7y2g4At3n/DYyEPtTaE
 1aVxWvBxKqQ==
X-Gm-Gg: AYBFou20Cim3VSovPOe+wiAxejFbryg5ui3YjdGzbdD5DKlbaDz9l7Qh78VEmySUt9X
 0iC3NVqQKPDr6pqXvvcTuey/wAwuVvum+C2X0W8vwA4te8Y0sDfm0wdi4B3vqNFn690wenlAnME
 q3fHqhIjGYZNRB9YV/00A6HN37jub4fOL+1SINqLSzq50vmUBZtO6sVQdfteIJvRXhVurLCEpQi
 lK9g0x/swgczrhF/ifMeNxpM2+k9n270umttrmItZoknuFNJgvdU+x3mm00+ju8TKhqvFvbpfdS
 gPzg6EWqg185hcfEhwclHEHAmW8KIQxkJX2ouMHKj3qCSTdG0O/8tMPUiShKNpp9wIpBYwdhexx
 AgFKIZQOpVduJBYV4Es0DDXj3fU9xzfi5l52hBjW6TrlQiHHcdn/SXzKA5GlL/XWIND6ti564cg
 3k+g+bf2YmTFCki8t2KFrIDURhbku4e26DW9oJyXKwkAW059N+zaGECyLCotMcJZQIoYqHdwBcr
 V2EVDRxxM0PqofVeOaD9op5UhmYFlllBK8rOGQ/jmP+emcNJUlT+R8Ci1vCwNZy2P5bf5pbzn1B
 PAkXo1z/idmU
X-Received: by 2002:a05:600c:3ba3:b0:49c:fc6c:be03 with SMTP id
 5b1f17b1804b1-4a01b017583mr9354355e9.26.1790754328332; 
 Wed, 30 Sep 2026 00:45:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771b0e8sm37634875e9.12.2026.09.30.00.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:45:28 -0700 (PDT)
Message-ID: <6abcbe18.b899f0d1.1fa384.c90a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260929155935.GB2614679@pevik>
Date: Wed, 30 Sep 2026 07:45:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi: Update syscalls numbers to v7.3-rc5
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

Hi Petr,

> Hm, this removes s390 31 bit support, which was removed in v6.19-rc1
> 8e0b986c59c67 ("s390: Remove compat support")
> 
> Quoting the commit message, it gives me confidence, that nobody will miss these
> syscall numbers. But I should note that into the commit message.

did you use the script to update syscalls numbers?
If so, we need to update it then, because this is an issue

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
