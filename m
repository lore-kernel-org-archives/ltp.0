Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CD7C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783617182; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=PalgMRWdD7nz2KoAtPVcfAR32llNu2t7mSWQRJ2p6Tl0RQkLBPFaqGzZ2Pg/tB/GY7oas
 cjkSq3IpStBduedd01KJFKQOP1jZNBvTP0sYYNndkoBOLfKv4g4P+75dppmOvqNvsXujolM
 yzZLmwiGE7Xn8WmMSyvl+Y3xQILgNvo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E0A13E2153
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 19:13:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568793C036C
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:12:42 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B42C3600A44
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:12:41 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f0ae9572so116975e9.3
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783617161; x=1784221961; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=AotlnfS+kyEGGJh+dTKVhFiqyndVeu2LHqWOeX2xrBg8HX5WItszCVd1+KlbBdllWz
 7ktKPFHDEvar8z4GP04zqFXn8KSlNZGdD9jfztg66d2eK5wx7v4jNFK8yNKkXPmw/JxD
 NJqsweff8AuQ9bM5pDVpqYX/IQjAWPY1IN5mXHHEVvFAGgng0mMqtht6BGu1oZ1q4XuR
 +SJ53mf4PttCgXGaIAmvtaUYgGyEWJ/8uAvT2eFDc5RJyuW2e2z4NZ8rpJf2U3GYLb9E
 //7SMhBBNS+LaI9AZHyhIif29arJq2GwACIMOFDOSlTCPa+k+B1CxekKJKIPana6O6YV
 0Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783617161; x=1784221961;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=LexBvYj89E6VHIRWhBhkkX6dknRdcNy/L35Zhd/IMmf1y+VPBSZDEk5KWyOQwTfusF
 JqwOPZDgMtnfMdJprm8AsoAXHHNvwEgESFs2vN22mRmqXMp9h/hIPEO7WpB+Jk+outZh
 6LhF8GtACIVJebCW1TkWwaA2QZLvGBWqr7ZvtOXijgzjUAspykOCGiq95SnycuVxFhKq
 XsqKcTQddcVoo5z2brMHcbz2Uy1aRWMqm1jNpkKUji99tGWvq0AmVLcwwcMrvaXLyBHT
 jcA4L3u9Y2WjESX/BFUOf9vafz7MqOem7wgDP/cxLSTGklbsgCenWWcFTUMaqOOw24Hz
 NxZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPV3R2FI+NVe58FzGxy6LCOZt2W9OUWNEGX5nqDeYa4FXMxB8ayDCKWAJ6WfatEouZVOw=@lists.linux.it
X-Gm-Message-State: AOJu0Yy/dy70ehiQBmC/ZqMWPx1zxU82rvfHX9eFU53Apn+Y2J2Lt+VL
 vWC5u5/lUSspJL4HFArC39A3AbdtyGutDt7QWVQ7QbM6vusLEbAhDya8mGDU3Hip26W7bIJH2Oh
 l73aR/QA=
X-Gm-Gg: AfdE7ck/ysV3NDLPDcGle+w/8h5pZ8mgJVmy5lmQmV0Lg8Cxi+7w0ZLaF+Mpro2PRxe
 FNdqpZyMmoXiVWJAidXb5709iUeGqf3OnFaBdyZmQHvXDLO36h/NEXgGEiIMnHGTn4iSodQICSq
 MjG3Dae3Scrpwi9CNMXgqj3u1vRaP6NRSfF70N+pyChybaGi4BhKVb1K892tLkYNWlsqxkaaHSs
 QGGxKcXuQLcrGZTsmoNRCBvlDbWodgZaKu+szmahvqjMVKYG4YJ4rAGIpx2d1ro27zZDYHGYqUh
 cj+RBdXHjV5Wnm6XlQxzCsyUPF1k96L0xqRZrkBrEaaQzQJfoaffgzsPRkrrfNnPyp5uUwVdkjQ
 AF42VXKbNgwZN+w0pxdydF0niz26/dX9EbrYxnaMNAI/VgduSg13mNJ4zNLKJPZVb1xv3LKpR3w
 n5HkjhNCAQkSpzftwzWRSAycNkUXem+fNN
X-Received: by 2002:a05:600c:8119:b0:493:bed6:85e6 with SMTP id
 5b1f17b1804b1-493e686ad9bmr81063745e9.15.1783617161033; 
 Thu, 09 Jul 2026 10:12:41 -0700 (PDT)
Received: from localhost.localdomain ([37.162.206.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm51588007f8f.6.2026.07.09.10.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:12:40 -0700 (PDT)
Message-ID: <6a4fd688.cc089686.163bc6.77c0@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <0603be3a-0bc9-426a-99c4-2b9d5df97ba9@suse.com>
Date: Thu, 09 Jul 2026 17:12:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] statx/statx04: Skip vfat and exfat filesystems
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
