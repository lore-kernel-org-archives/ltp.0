Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DFFFF886C
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777366559; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DCaKIGN3fLR9HsefANvYpDN8psC11scvi2CkCVelKMQ=;
 b=fxZciWrejHMuVRGnXGBsDdbmauT04IZ4OU5zymrkWTBHIztEtHbQgKkHTDyzh/ps213EQ
 TUSd1BsegfV4D2tnNSY0i6Ytzml5jh5MLMQdUpBrpkU+YZvuX5WYkUK7nYK2P0QZng50ZV7
 T+Cw7YsowMt1kPbK4A7MVpCp36gstnU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38983E2D57
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 10:55:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCA0B3C682F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:55:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C19D2009BC
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 10:55:36 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so146970485e9.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777366536; x=1777971336; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ByXhE2witxwU9vRJsdUaQ/67NchhSD1rxvKf5OL1GOY=;
 b=cn0A5im999ZxRZ5VWKEghAlS7FnYce/LgAtP3r3Jr00kap7IlDImIpiluSIPrjDEuZ
 bbKcM1SSpETh+TIKWN2nfydeNvjdrRMcCDT5XrwOKBdJxxzQ//BKg4/wvt9tJ2eDQz3s
 qKMke1asojy349F+lyXWpJzi+KMIp7JYN6tngLpx8GlfSBdxG9UdioEeUC+1X5LOVfud
 ihlS4fSSAibADv07pzAj8g1ardSPx2jb09M1WUwjSjlSPeg4qiCkhXbODUc5bl3xLAS7
 tOevR6G4Nej+SXhp6SY+374EEtne/nn3ck/3tijlKfPdzT6GjtDXN68tYjDHcwE78tmT
 vtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777366536; x=1777971336;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByXhE2witxwU9vRJsdUaQ/67NchhSD1rxvKf5OL1GOY=;
 b=fpThDEf9nvhacPBh/jhpSOFxakDuXqsqWi/jSUqa9KMwWJYEgj0gBNWqwurIQpzf2T
 NOosN9AGCqlzTzB6QSLVvlp6o+z21vnxKXaFS4sjmmRG6ENBi3FEljgjp3jri5UWoZj3
 FsuZG0xxJeN0qOJ5TwMUcJPB//NiZSvHItMEeRQK7C1w/uNKiFGbWth5Bo9xfddPdDW7
 pLQKveWwH7robOZ1YCZER83QjJ0/hBwRxRovog3b1dhJ1A+BAB53Nl2sVY+lciwaA21h
 L/Lt+5lc65eVWbxaqTsT4wFHQNATxQJ/13cY1/b/s5oh0RlT1L9Lui94IHTCfI10Va8M
 JGGg==
X-Gm-Message-State: AOJu0YzjQjaeEdV8FEdUWgGFVdkSCa0/Nc/ZNrOsmiRvrkSoNoIv1doY
 QA09c+fvcWIj84Mm11YWvWKpqoejyyzccVA4TdXuzXxFRrvN6/mZFAtC4bKUpXX8R88RoOfuQrz
 qDCiTIvg=
X-Gm-Gg: AeBDieunDTqGVmuSm3rpbUjIyyKurWPr9KMGqfzmxkPRQuxNuYtq1mL2PL9a53FKpU/
 +ZR+k3xudaDhpM2Ixqfg/EDVd66W1MaSUxoYiBnkWaSk0vQjaQolXfjAdpwFMMkzNMHd0DZnvsd
 ImJ0TjXuytTdI3k8dIvJ0muLEPYu1JY7R/9Ef4K3706WwlPNAFfJ9RLTY1vzBaI+jKoSUyrGKZ3
 MW7sX7JnFjdsefYe/wo3CbGuKMxD/je252Fkm+B8eHC+u0nfPSUT/ynZjNRsV/IWA9yFUZ2KD5s
 DNWq1AFFlYP9H2UKyWrBfeORHILkwXIzzAHZCC5Ts/1vxUPXDjQ0RqkTXhxG1lHu6ccIFdC429T
 YBiB703UkaF+g4wWYO61yu4AZIL3Liqdoeq7x83KpYJ9HS+4dkpqeQrawJF/p8eyq0UxcTCji8d
 MGJk2Ckc02UlN1fL/TFxeUAYKNmYrmsqLc5ZHxuuupY0HNlDlTlYr4
X-Received: by 2002:a05:600c:3b0f:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48a77b0a507mr31687215e9.15.1777366535623; 
 Tue, 28 Apr 2026 01:55:35 -0700 (PDT)
Received: from localhost.localdomain ([37.162.207.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773f8b2fsm41216325e9.15.2026.04.28.01.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:55:35 -0700 (PDT)
Message-ID: <69f07607.050a0220.38134b.31b1@mx.google.com>
To: "Martin Cermak" <mcermak@redhat.com>
In-Reply-To: <20260428085121.qeeka7axie3rervl@lida.tpb.lab.eng.brq.redhat.com>
Date: Tue, 28 Apr 2026 08:55:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers]   [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
Cc: valgrind-developers@lists.sourceforge.net,
 Martin Cermak via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> the patch is below.  It adds 6 new tests.  New tests are easy to
> text-diff against their originals.  The only difference is that
> new tests use fork() or clone() instead of threads to handle the
> page fault.  Please review:

I seen it, but when we receive patches as comments to the original
patches (without versioning), we get out of the loop of CI + automatic
review, which is our bare minimum request in order to accept patches
from LTP ML.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
