Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D419BC5DF6D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 08:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787126892; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fTOICXQ+a0uQNeAmXULJ1FS1guA+q3/c852fdsJR4Fw=;
 b=aVxDm77OHwtntqFR4WEnD+Mh9fvOGwx0O43E3nBT/BUdmvdXnpxJ2neoOUS8yLgzYmPs8
 Tycahtc4c4Fk4x1zlu6gw28DeKQGSeySTXNBBSJ9dvODi7HKgltJBniIshTym/xDHij4Vp/
 DqOMkHNIAt6BTZ7/bneos+bYqSHYEio=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDA853CD581
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 10:08:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F3923CD2C7
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:07:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6138600431
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:07:50 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so5442735e9.2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787126870; x=1787731670; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V0MLCl8CoxrLD+V6esQRwH79YgHcyISlZXYNtg5qRB4=;
 b=gY3Y3UjnvpM9gpkTpnf74iH6gAlRz69u56PwLpY0UkteRgObjaq1KaRrTCpt31v7PG
 hK6+NYQ34Bq6Px2fHT1uGPUJEp73C436GyuItPkaOQKs9S5TuahUEMuOmnaJmsWSP3Us
 1Yd9wwn7jsIHmqVkoY68Ryg4jFXNLM3OS5oLJlO/v8IkztonsNZuxAQ/nUd6ttgeLZl8
 kKOXbqf4Qv6hOkSca3RATOcDrjo+e7r9zT0nFlxV6vMd7q/jUIBKbFLjeBJZ0H1OvatP
 xmDWvjwc1Ovi9SNPl1KxAngW2vfrGI3q2VKtWRpE1OVYo7iZKOsoxszPGkB9HPEUnmUB
 SBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787126870; x=1787731670;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V0MLCl8CoxrLD+V6esQRwH79YgHcyISlZXYNtg5qRB4=;
 b=rPKaGgPsqSmNaLwdWHBvPK7ZGbu2KWFYeB/GmtnD6oPH9XUey64OT7HruJtkmMu4CK
 /1IvbjMy3gz+jZKzrxXS3bjp/7eGUd9bclepZfVLpwBJryCoG0BNlorKiDtyC+LshjHJ
 DqlzITQmq9lhU38doZI+3ynAQeUjeQOiDuU3zwQbZhsk0I3bFcLFXPrsY8FB6l0in3Q0
 ZkCOxPm0br3BDJkIWfz211CjiOTnKZDJInLtqZFT/SKyeAirKCL5yxFBigyAApDE38D+
 bO5FejcV7NwtEeECUxetRSEtx7fVERnz1MIUGhEIFDlHollqRv0usLv6kBR6NJ8aoWc0
 o46A==
X-Gm-Message-State: AOJu0Yz6kEdqGtD8eeozCPRVETCkFW9FYOg38yFO+Lz2vyeOs1IU5JuN
 zOep8OWFkalpoTSXEcF4kTIj+c8OVSf0OFJ+UWph64263ystzHnE0lEJ7EyV7OREjQg=
X-Gm-Gg: AR+sD12GgHD9+dQnBwC9eaaV2ZLsQypmNAtASwbPZuvk77LlQmtfkHVsz2VLxy3QigD
 HrmdI/ogD++Hj/BG0YLxM/qUSb3G4l5yCz/Wkb1qDIEM6ZgBPdLP+XwPhuKRhFbhbivaeapd0Ce
 ylf3JBWZPAqhn3TfDLPL1PENKIJmrzjrlzFFu9KylSKtnM3XEpDK0tBrQlzz27CnGrQrUT6kQk8
 tgyaijQkCZnhmPiJUrvr1F5ZvoD2ghHKgOusxqOHB8w1fpaCDPvyF41u8LVgEPKbne6Mp88pW0Z
 mffmV7eEfPrkNq/vlVQkeFGNZwQxjluCczBA2H3RDHU+oTtS5ECaDVYvZjDYl0YUfNftEMltT3j
 rNzYl7U34FCLGdWch1ucOd9aJFKNUStdbJUXZXQR+aZLptiNKWDkgejr/QfGAIzXn7/mld2+tQ6
 o6k5EKUu3RfFjzUN2I0U5X8YFdkfgkArKe0FXpD3FXw61RC4QnKAvYHrN1dRokfmpgnyDxAlA=
X-Received: by 2002:a05:600c:4e01:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-499aa1d0747mr50195385e9.11.1787126869957; 
 Wed, 19 Aug 2026 01:07:49 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b144173csm4135100f8f.6.2026.08.19.01.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:07:49 -0700 (PDT)
Message-ID: <6a856455.35b91a9e.11438f.2fa3@mx.google.com>
To: kinshu@google.com
In-Reply-To: <CAGJyJpsBXuD0p7Cb9W3oE-cOi8Vzew9y2RhvmDE0y79YH_oWkA@mail.gmail.com>
Date: Wed, 19 Aug 2026 08:07:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Configure 4KB cluster size on exfat to
 prevent ENOSPC
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

Hi Kinshu,

this patch doesn't apply, please send a v2.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
