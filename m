Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B376C624D6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788440984; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=ARz4AC6WpfgFIHGBP0fLiILkVaJYDsPAxqKeQMwq1OhdCBfZ1BWdR2GMO/sTGHrl5O7ev
 mE7ClnagqkI7akq7z+wd1LiPMFrmileMX28xVqiyTLiCfe4V1bNvM4Z8jVz1TBrqXatSdNg
 z3Vtjm0G5sYzPSV+IBSb09CDNCnAxSQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC7D13EB095
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:09:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D722B3E71B6
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:09:24 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10186200B00
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:09:24 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-495590dde14so26543845e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788440963; x=1789045763; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=C4JFOdyxrYiTKjwFJMCVp3K1p8sPRVC5LFwBbhKxD7qqQTUbQg3hBOyxUEoDEzcBPM
 f6msZSmRxlNn6v5dZQwPduXKYmbb8Qt3WjVresXzRZgc+nxJmLxqMsNBBq/ePHygZdga
 tIZO0gRr7suKWoHax5254gNnwdNgVBn3SGEFczw+D505nJpeX6RnWh+2qflqJITgS/1b
 u//DDy2a47OSDK27BAQsdI85iu8vEg0KOhFk1g6KtQdAcRuBlfE8xHv7/+zE5ciTpT42
 T00Xvk0Im0sboF9zQcJ6VjzlygnAiCAwM9Spwu6KRBv4vlerDemFIQgso8QbhJs0Dt5j
 vR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440963; x=1789045763;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=HRz1VvfkP/hBBmFm72KMcB5Cj5dsIb3z6DuNsbcByNFkLi+EAqZhkbViWp6GYw9fBa
 x8RtuShGqJFJbE5eb5SpMRK4jU4zmsY5lKJz/vozBTijcpXcffw6q0u4vDKU/7WfjTlY
 ZUKf9abh3SYDHHpdpI9Pmz1/1+AZIe7+ZYzNZBc+wxhcY/IUsfioDes0xrQUQeiGmVQ5
 +7ftzU5VZJORhcBP3BdY0bIGuaHmqGIJrPFQpjN+9+3djAuF/r9cAV5tNEc6AkxNMNMK
 mhlOIbjLaveWQ+9pM/xbnEkB1jym5vzQ3NNi0kspy5q2RCtM+KJWgnYNICZQHC15fXON
 jEWQ==
X-Gm-Message-State: AFuF++mbgeBMfHLa67PyGKsmjakAeL9L08uQaanhPPJjAmumtsitHjpq
 8EUIvive8SrIVAvfJQ5FBePbTKZ7Vecr6Fcx5fMo1CQ406cuwA6u/qo61TqHIj8xNHVVhi8Rjft
 jxvoKz+MK4w==
X-Gm-Gg: AYBFou3QTqpEo1Ur2hLmee9/u2DTPuXe4xxeS0ppToE25RCUZUCIsBT3+OpyotIpX11
 IsfmrlDId4KTUTUEpBILlV63bkkz971uAuommjLI4Vb7LZGbh97i7LCK51ta8jX7DnzNh9pvB0d
 ZM7pVf374QKgf8iSM2Tx45edawwpHDwUtU7trIYL+jQXlfJg6o7flKIaqZIzaDtE+/WBH8+EPLh
 eq4/WXL7nZ1Dec/3TSeVT/2a7xFmaAKqlV6NMbfeSanGThCCbP6DtEoz86Oa8M66c1ixHDXdDgj
 QllrGos1hf+0UEjEUJsiU0RyzswvQ9iUNrdjkFOT7ubPYlJjXw/kOITvFQjDTWlEVrLCfs47xjx
 am5E+9SIEAXyZGd38noPbInETXf2ncNEx5Ljz4bHEr2LvOlxK7pBGMkrKA+Hf8Ap59hLT1xED2L
 jwQfDGbTJmrW4IDuA+ZQQOtPg0/hIYJYqQTqr5pdix6Q3vxIkelXHBrt4Mt4tdi5rVNKar9R7Vr
 9/oFbfyaR5+
X-Received: by 2002:a05:600c:4eca:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49ce5816892mr184326075e9.4.1788440962989; 
 Thu, 03 Sep 2026 06:09:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5563c6csm100617715e9.4.2026.09.03.06.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:09:22 -0700 (PDT)
Message-ID: <6a997182.807ad8d8.1b0b9c.aa68@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828095724.194900-1-avinesh.kumar@suse.com>
Date: Thu, 03 Sep 2026 13:09:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: Handle EPERM from disabled compat
 xtables in userns
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
