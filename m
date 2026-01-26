Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4042BC88E77
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769417067; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nweBy9W4iiDoqsEqrdG8vzQhBDmXSgz1Go42huAArbM=;
 b=o7DUyj3jzx+KuAi3IdauYW87xWwOGoMMn15M7YbsR2vU2Y7hFDr+843C+hqDA4D1WqzN5
 O7LQalXOykSr0yBbudODGiD2v0WArIZ6Sb7pUqlrnizBCVFAGpo8tCU7DeZoH0ijMBRJfg9
 esN0EsEgAXN2YFkrEHhEOwX6/kUhnIM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C597C3C310E
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 09:44:27 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C4753C01E9
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 09:44:04 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E119B10001A3
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 09:44:03 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so6182075e9.0
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769417043; x=1770021843; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pr/UzKPMTz7RnqI8vE+hq+47ZEqbZG3zB8xfkesbVg0=;
 b=BjMHMhf4moXMjkvRh1VrvVvmJI5ZYqp3dIbeWB7L1fSWUf7YQoyOj8jt1AxhB1k3C7
 8ZMTIS5H2PTyY7tqs4JZOFD8BiNsPdrakfKsIXGJyQlPoOWPH/l/CV9ekFz2yPH4nvHd
 W0bhjVux3pLPBnKZno16KoV0q9KZPrOObShmwtwAnni9wvVWG/BGSMQF1BiN8XOEQ/AO
 9UqUlJPyNxWYgANT6TW3IuwrY5ii2ZuWbN5d9FhIXoCyE4iMLn5v7icOXU2zn5Rz5W4j
 fwfq0g119sn6uBzC7uxnaO4YyykkSXDxHWNy+RPdVjC/eHQPj+xn5xoWZy+9Y3PKazr0
 9RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769417043; x=1770021843;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pr/UzKPMTz7RnqI8vE+hq+47ZEqbZG3zB8xfkesbVg0=;
 b=I2UGUFGH01QOcUy9bfILtvtYy8vZ58TVxVHF4ZGHdzqM/LT7TqHTh1EYH5UmHmERlX
 WdwMrb9/lAFeWoSgyQYdUVC6dR+be/eR/SHM7J2SBcVFSmgAT8gtGQLPWnXjNzK9sJk7
 Ij81ELyWuO6Ttt8uMuEsW1eZeTAeMr2tuoPUNL4WsQipNrFUMYP9XT2Hrfq3JdWT2vJr
 h8wXSAKFSYVku96SYcd5Hb0sO9J6KY5WaHgbkZOudOcrGGKCmpYptWTnN3laip2Q0Qe0
 4p2tIQ3Yis3yu9xqeKkgk85idYdwjatr8E2AMbgBpV472jLOY0MWc30GXyM1jLIyBEGI
 cS+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdW0OPUFC6HKazyTjxXxIrJxqYC1MWtYTuWNJbGmJuInu50cxXp2waOQ52e9ttENZFMyw=@lists.linux.it
X-Gm-Message-State: AOJu0Yy23lF+pYFTS3Z+1UOgtGhdW8d+j08u+dJN1bmAXhU+MW597ycC
 qiM3dwgLI/3wqNnlPErkKHYfxF3K2WE6hiiayIkpIqDPjRuVi4MareZzy3OVtrFIUnq30ml/DdR
 GnIQR
X-Gm-Gg: AZuq6aK+8qwE/IAg0cFOa+tr9o3JxNVJYveIIVDg1P4Plgm2Wckw1LmCLcj1D/NGlZg
 WBycBLlgvyKxJNLTpQSXAG0OYD9fqqZI3UwbaMixLxnoj6vgF1Tp6eG3XbkoIMI+NZv57C5CHLU
 x9GzNiiHydBnZ+T4O9fWSVwrE3vrPiP0lJTHQnhxTmjiHQPdv+pGgwgS2EoivD/YUWTK4MQ+Qj2
 Zlp+uYCPxko6OgrA6AtGcSBGyNGfrJQ98aSj7/8Yvzyj6+igW6+gKSwou5t1X92NH0rhp/hKcUr
 hT5bEoNPPaOU45PTcvuYFug4a7DmGWi5sDrXpNL6iRwSXUhawAqGkcq1pjcy0eUpha5Qv5+YeGY
 4ri6uG+s1wTlubCt6B7D0Q8PuHkIHQzijTutaz42SzGkO5Ahz/ilYunmRjUcArBvSMyBeDDcIWm
 gsbkE1OYaKwbIctB14EzDz5C6eEltzmdH+ulOxbRjNymAz4UiJe1DR5kqO3eceSA+kssgw4t7fh
 /C+J3g=
X-Received: by 2002:a05:600c:3b1c:b0:480:52fd:d2e4 with SMTP id
 5b1f17b1804b1-4805ccd0fecmr59782415e9.0.1769417043187; 
 Mon, 26 Jan 2026 00:44:03 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm344309715e9.14.2026.01.26.00.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 00:44:02 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 26 Jan 2026 09:44:02 +0100
Message-Id: <DFYDZRN8FNDO.2GK22N63DK233@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <aWjZX0fsrTJMqq49@yuki.lan>
In-Reply-To: <aWjZX0fsrTJMqq49@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

Hi!

It would be nice to merge this one as well:

https://patchwork.ozlabs.org/project/ltp/list/?series=474077

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
