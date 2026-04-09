Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEA8EA3C4E
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775736678; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5XC7oOF+nPm7CHmDhFtNNWkOcMZLGUIYzOHJaP1IQ5w=;
 b=lmd8/WCeyKiH+fSg9kCESYwVtoA37AkU8+TS1YRO+6YcKWFGvYxUIMAA2meVZu1huzsRq
 MFQ79z04GqJJW+17+0sztR1ugHRIg9RZ3kRQvzdr0eDnu3wvbWweMn3P/1W7NkTy2hkeq5C
 FD9WhPWlLuDqWHUV3z46nigxW52FQ2o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58DCF3E4CFE
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 14:11:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD6243E26A8
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:10:52 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 77C8320117F
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 14:10:52 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso12768995e9.0
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775736652; x=1776341452; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=USP/k+Iz6UfZN64K9C3DXH/Vn36YE/0jdRnJ93Y0Q4o=;
 b=Psc8d8QUDiF+xYZ69mjhB9iMdByWRo/PJhaa0LIOKBOs82SYbFf+VY3ncG5H0fDhV5
 EUixaF5wz+/BOcyLwvRu1rL1SZ9SJP8Qa3HV8wUUsKE2qHN1asc3BYFG6pSAIDUt+9cX
 G2sfu6GMskVrSe5n6a4xyEbZpQxRi6yvOKpP+hLQz1IqL9d9+i1HN/vtYCW0WJpPaogW
 RypAg926GrQ0kL53+6IAoQZKW9Aa8H/xs2Ef2G8M3lQslAwHPuDCC/13WvQBDR+d5wZm
 29kfPFc9WQiyGp6V4cLyJq2jDZmp5h0m2XjWG+T6QqoObVyCFHFXO5lm9uxy7fFC5JUv
 510w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775736652; x=1776341452;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USP/k+Iz6UfZN64K9C3DXH/Vn36YE/0jdRnJ93Y0Q4o=;
 b=o3MmT5kE0ghazqOEY++Az8YqCl7+iOcwLE+VTJ9biE/vmYDk+hl9urhM0RhgvS/X55
 bBlECKlUTZMbFDSF6fgCBe2l6bA98VoL6pZ7Pam9mUAGWBKDhzla9luR2jA6W6/q52xL
 J0SrVgKwdeyIshQskLXaNsvdtacXmVYuyNYsrCGKuc8VsppYZFI2u63NMaFDRcqSxpEl
 gANx5QskzCoRJDRdpsr7S7Nn7PjKxKfQ/2qdG8+S44s/+WTTpPjPdoRWZc2vdZE/0csw
 Z7+mI/dLIF4uejQPc1d4je0kiV295L9w4kLnlxoDjRgaIrX8jJqxlblBwzFQvUfXy8lk
 XevQ==
X-Gm-Message-State: AOJu0Yy/O2uPbbGDwAD+Jk5OWM951uBx/WN1fVCvgTAfVwOi0uB0Etdj
 92tUIuqrsxp1i714fEVwWIrVZTsSphwmWNuXTytb7l3h2gtlnuJZ8YM5JzGgxjWm5HU=
X-Gm-Gg: AeBDieszopUqQkXIIB3sIcbsscpMP7aevg/gw+rzEozAJoPktzDkHPtDFBZU83RRl89
 CUpXF0GOVjSbua+PlVNwaAWbomgf6CDBCOOCLq1tBsSUKJkPTB0H2WXuIRNGOZKVziDoVsL97k8
 d7k0yltvsWItoJEoqmA96HuzGQkyBz0GBHQ7AUSTPUPLil/7iAv5nSWnXDgoc8Fd/mlZj3DK4BX
 vlzOcsq0TBA5/tUj8AAH8HA7Cq52Qi9S3UqfyUZdmLNvEq7bQU+/gWv87fKDIfwGBSbtE0WbUNv
 iyDHDEb3VkWqPqYLQKMHtDfP8SVLYd8a3uno5itqgDHy2YKJc1EUfAZtn0BZXQx73w6nlfk9YKR
 p9v8tqMBHoGr1Gi1YwMsP73a03yMaHNENsCNiFXIYXBjnIxHPf9dNp6XEREZFY11g+mYGBLUmiq
 mQXac+aT9i5yCXA3qbNIkzFx/Dw720v4ol3OQQxclqBWYsZm8AIeywJW4qnsi2MJuHJP0fOSAlN
 NofFodpiZabJ4dy+qEKvpK+1eBdUcXcgUHZxJr02kZ//SxHV5J+kJALAoO9nG6RdhJJzAWONZY=
X-Received: by 2002:a05:6000:2084:b0:43d:1e22:26c9 with SMTP id
 ffacd0b85a97d-43d292e24f4mr35868617f8f.42.1775736651573; 
 Thu, 09 Apr 2026 05:10:51 -0700 (PDT)
Received: from p200300ff0f08530195b5703e94aceed8.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e56fesm63626152f8f.27.2026.04.09.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 05:10:50 -0700 (PDT)
Message-ID: <69d7974a.5d0a0220.7b805.6e6e@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260329120425.213306-1-pavrampu@linux.ibm.com>
Date: Thu, 09 Apr 2026 12:10:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix memcontrol03 test failure.
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

As Martin already mentioned, this patch is not adding anything really useful
to fix the current issues. There is a long history about this test, which is
randomly failing now for years. We can't do anything with it, unless we want
to change the kernel itself, which is strongly asynchronous and certain
features are simply difficult to test. For this reason, we never found a good
approach for fixing this test and we need to accept it.

If you really want to read an in-depth review from LLM, you can find it
here: https://github.com/acerv/ltp-agent/actions/runs/24188892454

It doesn't add more than what we already said tho, so patch can be rejected.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
