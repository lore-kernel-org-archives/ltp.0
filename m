Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A66C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784130913; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=1Kg0iwbpwL+SYA886oVNPGdhO/sSSgJ2knVP0PcElXc=;
 b=OMg3cxFgc/dv7oW2DT/Mt/J56HPMnyTAr1yEIOa5vA65XWwH5vjMcwfkiMSLXEIVQjXdz
 xyBfYDQGV0AnAaH7xe4Pa+Gh7JDfh/q1LMOz7V4bmVx6Ck7dAj59bK0T6JW8lDg47rSMI5X
 3pdc1PffxSpx7IBX1gy/pmuSOiX2Sjw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 565973E7A01
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 17:55:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB46C3E1DE7
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 17:54:51 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F838600467
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 17:54:51 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so5543985e9.2
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784130890; x=1784735690; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J7uLf+dUXJUfoT31fECVKXOP0O6NOUCPZZ1xVR2zRE8=;
 b=aaBeyOyElvFIwZ32Rm2ZZqhDr34ZIrmpuDi4j0mJM4gpa+ssb8gM7lAtji6f4EBpEz
 qULL41YbV7w08uQeQKeaKEl/HqzHPvP/QGMJVS4ly072s+nia1A7f/4AwPMuKUawKBtS
 MKeG02Am2olBruwoL3Hn26BqqOZ80uxZ2NsOJGt7Gh2AEIg3aix8BJ3ScW7w5bvPE0JL
 kVZ+FFi5Vab2eoGGhHrHKb9BKNnksvOKwEZIqDZls+WFvZxu3mHQ+R7sWC94t4TBisWh
 zJ/aokcPnsYg3vj3TNWqNv8mh64v6WUZ9wCRMRPKv+mced4tyoh6NNpZvhWEw7IyWv/A
 M1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130890; x=1784735690;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J7uLf+dUXJUfoT31fECVKXOP0O6NOUCPZZ1xVR2zRE8=;
 b=gFyLscxeFRkCRmNgwc4MNf5EYcfh2KOk8oRnrKjUbKjelDi4oSXg6Y8vLsnjzz5oIY
 jR8J1J0hHbv2+x5zn6G14B8jmKLxP+oFepZoDFRyNWWmCl5VRgMQIeW296JPTgRJscUe
 qxtOg4SGuf4YSzDPL8WHaHWfevzW9J7KVe0/XBQWSc6zUc05rLiKMb1oIDB/GGm/Qflz
 w5jo5j4TET+MjYCJDGAMwjVutLJcQarMLUZ5Mhs0VgnFpoZark7aRUxReKkRTv/qEokn
 p0fl7xI0hfIXhY5RKvDWWw+6zrMkd9OKypmAbZjvnCt3OkPwT73908dPdGoKfObG0xPt
 qrbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonrQLanNJmcZ7hMtYSEsjcH8bEsErs5R52d1uTg0+m5uH6IXCiSvmBxQ5T5JghDGip+1E=@lists.linux.it
X-Gm-Message-State: AOJu0YxrsgfL+bo0Xa0HwfgImZiTm2LTcTtRtHw4hGRoIGc/5bPw8k2d
 zUqxnJnAizPqZkZIVgRNcAssMarsUnME5QRY0RHIIVPHzwIdtOaqk/oBW1pB7+g9QIg=
X-Gm-Gg: AfdE7cmFjm/EAGyAVdCbsqm6QAlbDCSRnzsxCd/Bz9S/jfc2JVx9B83OzjoNHAU4FJ/
 f+au3e9QWTuPG7/BSutp5suCLZCLXmgQA7IOzentzXXYsZYeaf3oi//OPGR2to65g+exw1k9SZs
 fJSf+OH+Uj8fBnlYFLWrZjR2OqgOvF95zfmUcrxw7MDlRDN03NvQ6Xz948dD+USxEP8MuonpqwC
 o3zL9muZAswc+Voo1ZGkG3aGWDeodFBJAfwE9/TmGPjVS0KbA+6PPmbelVUc0Cskol0+whMPKqR
 A7wRsh9Bt85QNemHkghSMR24sAV2hxMVmoGRL+FS9wq2PU3RjwxduEilcCbvfcqzBVh2JUHWIED
 /eO/G4bh3PAVf7daE7bwFM+7NyEnGUOLDUr6I14onicYrpOZ4EomFMlQ3m+ypQcPMihrrGsWdI8
 WgADXLDoueVxIvvku25kKwsYTRMVJjk83T1Do013F0c7M=
X-Received: by 2002:a05:600c:198d:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-4953bd5c51amr40599905e9.5.1784130890498; 
 Wed, 15 Jul 2026 08:54:50 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f09sm17452362f8f.26.2026.07.15.08.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:54:50 -0700 (PDT)
Message-ID: <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com>
To: "Yizhou Tang" <tangyeechou@gmail.com>
In-Reply-To: <CAOB9oOZaAan2bKWzu2XLeGkZVV1RO39YWuucmQK0tvvgVE4rUA@mail.gmail.com>
Date: Wed, 15 Jul 2026 15:54:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: Hongtao Zhang <zhanghongtao35@huawei.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yizhou,

> Hi,
> 
> We recently confirmed this commit does cause a flood of I/O errors on
> the root filesystem in our testing, leaving the machine unusable until
> reboot.
> 
> Given that, we'd appreciate the community helping to decide soon
> whether the revert is warranted.

Are you 100% sure that is caused by the patch you want to revert?
Because the patch looked ok to me when I reviewed. We need to have
more context and info around the issue which has been generated in
order to avoid any workaround for a system/kernel bug.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
