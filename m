Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73328CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791206188; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=l1t8mpG1WR6cUs/vo+nr+hPwTvdD2vO/uxNGIrTreJOOJRwNZ8SvmRTzgteNttFVZBBtW
 JAFqgmhF7Z/4cw5cj2jFPId6tRDDoglO4fJARuq7Tqpz++laE3WewGFxiQaKLTBHbwbQGJq
 HNaWZfLv0kaQbCp4VK/jgHDlGwqy2M8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 410F93E4D68
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:16:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483683E4B3E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:16:07 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 754D310007C1
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:16:07 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso14578225e9.0
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791206167; x=1791810967; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WO4rzTcBz/hrA/Jm6aLMVSJt1JkzAV5qDDg8iKcdN2RqcNATMR0Nzie6L1l+S5kkge
 l71JeYfruLAFeR+aSuWFSzXVTDn/ix3UX/7yzBSPM/qvMOHTJbdoE+qaNr8+PFZ2SoDf
 voiXvZFgELvjNDdNoHMIWEh1WBQ2CosT/6zq2sDpzWoDC8wOCRhaAp3p5xnoqCTf7f28
 OSPZFhfMYlAK94TFK+rXOlSOr9jxVcb5kaAB9VSVwYd2ICUUZvTnC8tOnrLSJkFfcT3t
 Pewbi7fp8QzvAAUgSMmUxYVH/sAni8Xb8GOZCk9kOu2TTBj0So/weR7e/blPnmA74QqI
 L01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206167; x=1791810967;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=VvxVxQaZBGZgbLxW+s9s3mBBJgQ8Lssy8jdVmElZ/LVg3ADdbbd46TBj3s92rjmKR9
 xm0D5wQIGkMsnN63BurU6IN/z0pscdo+bWr9FyNMpQZTTopNpvkl+Q4JGyQ3XFpXDfbM
 qgNvKzs7g/1+39TD4Xmai1tIe893u4jVieW4K7512C4uCSH7QZP2vTDimYoRjm+u8Gju
 UOzh8mRrKEMrS5Je7Q2R8Dqvz3jDHYWc9S1n/2ur+8GilbCjcpvHieACaEVSUip3NZOn
 1ln5YAgcXS3yy/oG35ja+zz4BsLsS2DvTCUu0jwzJg+h9suqajFjKQghZxYpcDECN4f8
 YmbQ==
X-Gm-Message-State: AFuF++kgKq0fEoQRCnyzdpG6a6wQKQ/9G8r49hK+XlCKz8UjmR1sv1Qt
 SFXvmmMKNOR7nQKgRcEA2fyiFu0hBXcX3Nk8x58XeU2OWC0i56gSmJ41sdTgukvVQlw=
X-Gm-Gg: AYBFou0IwOyU5DGr26SQy34TubC4ptZPx+e5twmFEvqrpUFfR3lZhXxnEUQYChWJnGs
 elhgPxgJSKK7HcZ5QDin/aFvFTGHks2b7tVrHn0SQnRQ+F/ce37ncmCiqAsv/22srXSdGWd2LYA
 d3Spfde57kzMjmB7J5ehkmeXD/OCM/6/f5JGQoatuRMyvyBXPSUimO5HmyCVXq0QOS/zwyH0mRD
 EgQHTkpH4lCLXR+X9FsOunlUGkniXgeLHyBBE0Ivk8zaSfm8m7hTG/BmFBZg+4TRQYfIckJZcS2
 Q3JGEVSSLIVdv0YAW6ranbZLxSdGoBSx1DHUf5pXwqq5b2BQucC4CFwLBC2oA6qwDHCYYprii7B
 U/lL1E5iZQJxYXpelBEPSIezI1kAz1cOgjipJ+qp5KIzBD0Sqrx9QqtySY+pzPbYUkzlGrJ3D+N
 tX2wYNX7+usnnW4jXXW3Akr/yEvjFOHBGZpBXONzU/vZ2Pb8O7TCRPz8BSKItz9g+hpuOHpsunC
 KyKoknijJAs6c8fQBikWo4OraTg54CFRnwxl5RjmEjAtDE=
X-Received: by 2002:a05:600c:6995:b0:4a0:159b:d283 with SMTP id
 5b1f17b1804b1-4a0275857a7mr182824165e9.30.1791206166520; 
 Mon, 05 Oct 2026 06:16:06 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm364796365e9.8.2026.10.05.06.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:16:06 -0700 (PDT)
Message-ID: <6ac3a316.b21dee25.a0c98.ebce@mx.google.com>
To: "Florian Schmaus" <florian.schmaus@codasip.com>
In-Reply-To: <20260928153059.1624905-1-florian.schmaus@codasip.com>
Date: Mon, 05 Oct 2026 13:16:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_wait04: Use tst_multiply_timeout()
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
