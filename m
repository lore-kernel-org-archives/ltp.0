Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD23C561E6
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786008766; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=eN66sq/57GZdN5mBp//w4giLqv72ftmQavHIdQR87Ek=;
 b=Ke0w0BzDRoiSnbZYtfalptRa8y0h86mP5oz5QPBoCDRDbZ+dCkIiLBkK9fi0XhuRcWB/G
 fp3um7dzr+6ejGzqK7MqtIOuz3815RUtzvmcDg1dptp6VhmIn9Ljy7Ch+Il0crurQm3M+HV
 LjEkkWilDb+pCdwF6HwQU8GytRm3qp0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C43C3E28F2
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 11:32:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFFF93CC4B6
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 11:32:26 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F708600621
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 11:32:26 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso5392275e9.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786008745; x=1786613545; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eO66Ek2Bctg036RLjIdXqvvx8QdbWXUTG6gO0sSgm3w=;
 b=cDQ+x4EhdEO5iSdamJSGB7LBjlnoijOzKApq3OJeNRHtAO+mGOzRGlrSPwuQ6MuKF+
 tESQjcxCa4I2lUgfthw2M5V3wHk7HMOLB+b0cK9J7/MefHyTxHFR14Qyy+mLnVBM7fcP
 Tk+7hYDH8b/YzHrhBzMOeeNhqkuKeVdc9lJwcOlRs+hNvPGgA8zqLhgTkpYR0qVWZ4cA
 QzgNsr5YH52FPU8vkU+9ohSmeX9igtBm0jNfkuamRW6xBBLR4vNhoRJQPdfxAZ531D4L
 WRPjqlb86C3PqKvxVcRi4/4/6hFRvHO4CNXBHmEIuGw1r+gSAD0rKpmuYf9hDC/GvOnO
 vH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008745; x=1786613545;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eO66Ek2Bctg036RLjIdXqvvx8QdbWXUTG6gO0sSgm3w=;
 b=IZtfULXwQDoAnbtXnibsWNxIzfKTohYIuiYtYeiMVkQtsSerIq+2ZlyIqKJ/0749h2
 5IaecyMMYqHAumukLSK4NqmFc5vQAFP/zRChdqkhMYA1YzRnvAeCLZ0qKMail13JIQgp
 5SNVd0gzINRHtPWl8V7mN6Ki0aT1UNzj/QEpgqtgDItJ2nHQIPwUncGmV5aDPCJSclb5
 D9aa13uZ88bapFMBAmuf8YUvlNoAH5fikIUQbvFVf+Uns19oF3j9/PwuR6UZlc4LHKph
 Xez7Ix/iwGmK4AOTzby026y8oU28LX6+4a4OELiq5r9Dr3m5aIDfcU1mX0M4qBf22KcS
 2bTA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7H1Mbw3Gw4xPCWPNR6bpK+MGBExLD0VY2kXYU7L464gH/wnGL3QuUaJmAdzd8UAi9xmI=@lists.linux.it
X-Gm-Message-State: AOJu0Yy0B2s5Y89G/T4q8lg6rj7JR/RMvkrZGSWJzA76VX6VHVY+JNxA
 e5pF6sruC6ALu94+7a/n2nimjO6y8jkETBkBl9yOnxCJ4qyORWEv7Jh75zRIEnNjQYGxpXXZw8y
 9JRJgorgdaw==
X-Gm-Gg: AR+sD116kzjunTod36W0coaXv25hftiJjWAy+G6/hWMdZdynOXe1HrB3qBg7Stk+8c9
 m+yxP/3LIhfvhsZc1e51R/zfX9rcrOrXv1Y45xZ01j3XNiz40nD8VPVdn31eqSSqfpipfVRcZB7
 YQG9yKve6bmKhgk5uBbnF5Eq+nbY0K26mWx9FPatSeFVhKa2NSWyDSJXFGm9TCL3G4pGSBEZFaG
 0Xez2uAHIow8HK2G+Gdq1xwwZYd66lcW7FyXwF30J6vzcEB0KeGsizadHRYrOFKxem4csOFlhtj
 PH3utm4Wz+yvK5Lnthe6SpWE/CtKSy2olnY7XR/CO2YIo4a3UmmRoFV+2OAXeGXPpsilaOOJkQW
 9mtBjNOTnYm29cQkZ4sekrqwtUOckNp7l91ScotBOxvBLBhx1eamRj8ze9nm0+Nr3p0WpQmy3hh
 OVvVfVXWroC02xGTGsXFxdOpzlgK7dLs80nz4VkgiEVl1ubCxI07J2QiJ8JtJLS26kdl29JGRXC
 2+sDLeuOAB1fnU/MA77aGX9Ge7u8fpStlkiMRxhJ9+2QqwsIMW2I7dHFdRtbCtKWD7FpdheL60S
 sshJ7dCCYQzdO03aoehX/yQDRri4EuZOBQ9efg==
X-Received: by 2002:a05:600c:5392:b0:493:e543:1dd9 with SMTP id
 5b1f17b1804b1-49952f3436dmr89010965e9.9.1786008745400; 
 Thu, 06 Aug 2026 02:32:25 -0700 (PDT)
Received: from p200300ef2f1109002813f5f2a1fe61f5.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e9ad922sm79305925e9.4.2026.08.06.02.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:32:24 -0700 (PDT)
Message-ID: <6a7454a8.9b80fa5d.1fd0d2.3b4b@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260806085049.22237-1-linuxtestproject.agent@gmail.com>
Date: Thu, 06 Aug 2026 09:32:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

> On August 1, 2026, Andrea Cervesato wrote:
> > cve: reproducer for cve-2026-64600
> 
> > 	struct stat sb;
> >
> > 	SAFE_STAT(".", &sb);
> > 	blksize = sb.st_blksize;
> 
> Could the I/O size and alignment be derived from MNTPOINT or TARGET instead?
> The framework mounts XFS at MNTPOINT but leaves "." on the surrounding
> temporary filesystem, whose block size can differ from that of XFS.

This is actually accurate and I need to fix it before merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
