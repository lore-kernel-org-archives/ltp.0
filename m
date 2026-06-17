Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4CCD98EE
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781687764; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=FvSPs+m5gSnzdg3HdDY5s6TOceOQoIZ/I8XA5pH0V1M=;
 b=Ng4O4r1HxUok0mlGdgu//2uz1+hOr5WgS6xYchUofTR6NpQnVPjrYXU26LeaoPZfHSJdc
 hRbX0PbEfjifC6MePVwX1XvQDzuqNw97PKOQlJF/7grNPOPwnMd4oSsiOzY2cAXPmKbTC/C
 2gq6dPtAZ+nW7Rj4R8q4sbBkauS/U40=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF1543E592D
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 11:16:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC0CF3E1FBB
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:15:44 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1361F1000D93
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:15:44 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so35800535e9.0
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781687743; x=1782292543; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FdDAdclFznWTm8iDmX7Y8z8j3zAbO1s1TJZy2YEZDEE=;
 b=JYOlx62fkjJPT+kA5MLnGuQCGelBZnhJF7Kee3Ay980jqofliOwz9qzBYCMX/kAZOC
 YA9tiedeQ4YqMkXQMr7mUNkanf7AkXTHD0Lcu5Ycn0mUtyk6GYbRgYWS9LMZvi1jMGjH
 ZjYLcASn2roN4Js4RZUnW4uHom2tJYOH5SxFPR17yf2vTi+GrF9UuYfyK/r8GkUo/dbV
 V52EidZ54Vx0Gu59XG0EHWz6ffFSFm1JFjfc3ev68OR7i9sI2CROazeyK+n9RMDqizOd
 AQUJRFt9wanHuB77wR3ev6BBveej3vwpDO2uBxOjfyUU+spk6fAwyBbJGwkT4aTtHnvd
 zOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781687743; x=1782292543;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdDAdclFznWTm8iDmX7Y8z8j3zAbO1s1TJZy2YEZDEE=;
 b=VoQGW0beZHoSI0YQo1/QGP3jxhUuq8/C2ObPyZEFD5tfQ5Gr3i+HNOs3aotDXkVr2n
 f8Ufw0A+BRns1FkA3Yg7coLK1gFHUhTE74qsWD3qZX2r3AGXjAv71J9GsmoVk1T8bU0V
 /F5Lf6GaMdWnBGVmVHPcNVqvgFKmgA3hQQtJGoB2Bp6N9B7LymP/hyUenFKK2i95FrXM
 uufPN+IXB4LcY9Hh6Dg16UcAZKFcJLCkvO65c6Ed19psScoQZ+dHt0PKeTINj2wEjhzW
 9+0K0YhGmUEVfZqaLXJ4X40jrbda6YnspXBLBXZNeHU23/ff/qbbfZHR0sRlb8ylVHLV
 x0Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ81z5cOLq3p2m3qGW6Zzzm0AtSH3Wic0R88fiXxaOvKFxWCwGL9nyBWjAnPZgQRXgiKgrs=@lists.linux.it
X-Gm-Message-State: AOJu0Yz2y6p2SKhKl0abiF88p1RsMMOx/78ZXv/Y0wpEHKvcFRZx3h1K
 HzRv9EeFL7oycgOGM0s4vfIUB10k+rW+YYnIYvUFe/ZKJNDQgjtzKnLXcHZDCN9YOr1uekToqBm
 thlVM3q0=
X-Gm-Gg: Acq92OFi9ACn3EW8FOsDFOGOl+u3hAlAlD7+Dg+AJoEFNuCCyjrSnRG4zQGpsG5KW59
 I5/vNezRKrhUCgQ+Q+y6wChuiJ17AxPgut6WMC84bvGYxdy50BKt67C16umhtHH3W2zojL+v5NX
 5LPNxw82T8nhzmi+/hkDeOQJ+PqKLNCIogMInFAbEv+md7UN2uhdPZFHoDRH+aPlDzxL3KHPcjO
 HNrQJNKww84OrAQ7DVlpFKxIkfpQ3FVHXpbSO/gMlK5sAc2B+UIJeA/eRduBPptaGoxURaQPs+G
 H30m3SbH2WzS3tLn24Sk1XIg81GkeOruDHKZyAVboIP1BXyS+IMYu6YCDs2GrgLFqnx1IDd2XvF
 QWhj8DEer5QLn0qrji+euGYrkR4iJDeQxw9Xjpg0BU5YoykuXAqTN0DbhaJ7EV2GV8PSOOZlaeq
 wJrSeS7W/jJ8dfIpBrV1MDORmTCb8OwgtMb2lPnXNd/6uv9PYyV4Irlib+faHZLSO2G/o3cpofP
 HUFMaDQ/+ebqkiq2mstgyu2y5NDnUCgQQ19vo9psxfYc2BD6zN3WYH19LwPrmz5W9U=
X-Received: by 2002:a05:600c:a307:b0:490:b06a:649e with SMTP id
 5b1f17b1804b1-492333ffd33mr46204255e9.25.1781687743404; 
 Wed, 17 Jun 2026 02:15:43 -0700 (PDT)
Received: from p200300ef2f13eb00c15f82d9757402d3.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a0e9e4sm130659175e9.0.2026.06.17.02.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 02:15:43 -0700 (PDT)
Message-ID: <6a3265bf.5dfca4bd.e0bdc.3ce6@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajJjWSYh9Q31uWRb@yuki.lan>
Date: Wed, 17 Jun 2026 09:15:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in
 cgroup_drain()
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Maybe we can print tst_res(TINFO, "Pid %s died during drain", tok);
> here as well, so that when this happens we will have the information in
> the test log.

What about TDEBUG ?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
