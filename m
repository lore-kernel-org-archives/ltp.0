Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC09D5E144
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765888887; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6uiJz9VYQkGKPC2xgMHRt9scX91piZUlrsC/3U5UvV4=;
 b=ktIpiD6YUIs+9AUZBnuzbdP+z1Y/qyaLf4t4X0j0KscvthgJse/r4mo60j5vuRAgNua6e
 fnpHdU3Q8EwOcBfmM6mNsVY8TgY94ovBH/fd8ItP0SMrU6UYlQ1BTe9QvuFb1qx3y34rx1q
 BJXAmorqCFr0Gi9f418F0z173wpKgKc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F47A3D0382
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 13:41:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA313D0345
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:41:02 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 50A346001F2
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 13:40:58 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso36983595e9.3
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765888858; x=1766493658; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w85V+PozN457GL8bboLYiwl2wlUGqSU52BRmopObnQA=;
 b=dQq2eTiva+QWlCtkLi+DP/GPotAUdVBINPThAoX5lnKZZmu1tLDBeRE2yfSuvSLzBw
 SxB5wACLFAUp7E6HDciHSG/MBevIawl1Nk9xqiB+ajWhZm0qVKirXfMH+bqSPl/l1E4N
 eNMewkJ58S77i74Ph4spXCueoN4BZx4V8HpuiGiyBWfGNNsR7B7ZE3G+0Xh6Yft2DH7E
 8NUDh8sWm4wMuzsEic755da5UIcoRmJ+HRvb8hr/vwNwjGBchH+S8FhzzpW7yt2LxBwc
 c30U1Uc3HO6GZtN8dqap4bXt/g2Foh4yIBY9Z/h4ZVcty3pCVu2XFxfV0LSCv3DUIfrF
 UPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765888858; x=1766493658;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w85V+PozN457GL8bboLYiwl2wlUGqSU52BRmopObnQA=;
 b=nSGLsyYgs4KDP02+kzKyzNj1VpMfPdQ1epC0nyM2VfgtW/tsIM9HzlAqAkQlm+mXlz
 59XMI8tuRhdH4Kl+7XVnmDSWEHiJiqYGYLdBZIJyZaYtb2FwjSqDGMHiJ6eICy/BTpqT
 txcXNYbNSxlkShDi4jgKJbeZYif9LkZ8F1cXFTVS3vxeTfXJd7vywtUOjw/MzrWhsAKY
 zDYS94lZ0P/fjQxTGOnaFlnyszbsFnT1aYBLWKj0i8zoue2vnGnoIdwlMIrnEbhGooj9
 7q+1ntnmTtjVb4ccyiyRrLeizba4tPkoEcQqHpkZOla4Gpq4Kbo+7J1uSZApquIy7Mql
 8KHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKR7mCKuoVvvta/SZdcBl0X6x6cMt9hZW4ujpa0mkQwlZp2cIomdDAqLel+fs5ky5S+ek=@lists.linux.it
X-Gm-Message-State: AOJu0YwE+LrfistUZ4zdM9BNhdD5YTHiTbz0yCpTuQaElciD6Swxi9yR
 ZPMm9pb5VwY4LtCahw/N0qqfSHBXUbMYXwdR/e0UdzkcYb8iKNN3YxwGp7hfJrYgXOhCj3KvbDf
 rNADdYNs=
X-Gm-Gg: AY/fxX5izZhmTpSFnIA+NNGqKEqQbBl3Yz1QphNXng4Dk5amBqCxfvc5m4LRjlSWo0G
 hGEy2zUCvQe+NhVPziyVjTaB2Ququm1OobLwIyKvvKuchUdagG1XqiYXpVM+2gfA0yNvLGnfPV5
 Nh2d7/dBwHKlfPelMU/neysUwJHNJ5fYTBMOHAJxprIBWtS71mLBafDlxH1yxldAelHiViQqCje
 o+s4F861ZM7p+ZaNxRxg8GeGpH+T1rlgi6DozTkBWLjDgg+CuMYlPTH/DZMBm38PrhsKmFdmUvs
 jcMtp3kKlrfXl5dfi95piII7XngSukN82YqYBQW0ycM4c2/SPd8cSdg07zAbP9Hw5RhUZNGDYlP
 td0u5xlIIVKOrYKQ00/WntXTRIDrsIQVnI1ykMxkmjb2KIE+mSR5Rej6sidtNLQ1vhmPVB5Cowg
 DeMjjlgqLpM7/P1Z3ZXX6infSij2b11g==
X-Google-Smtp-Source: AGHT+IH/+PdseVRBCjpyrR/uYpczpAGw9+qsQ5pY0JaCqqcjtAYCJxdH8PRbApWzsTcK4IDRF7nswA==
X-Received: by 2002:a05:600c:3492:b0:477:9392:8557 with SMTP id
 5b1f17b1804b1-47a8f905983mr140007755e9.18.1765888857597; 
 Tue, 16 Dec 2025 04:40:57 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6f26ebsm247047655e9.14.2025.12.16.04.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 04:40:57 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 13:40:56 +0100
Message-Id: <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
To: "Chris Wailes" <chriswailes@google.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
In-Reply-To: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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

Hi Chris,

First of all, sorry for the late reply. Unfortunately, I couldn't
find any C lib code reference that is justifying the clone3() wrapper
inside this patch.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
