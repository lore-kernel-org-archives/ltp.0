Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F40C79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 22:01:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E283E9521
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 00:01:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2DF43C708E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 00:01:21 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4AA7C1A0060D
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 00:01:21 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8eeebcdbfa1so12248396d6.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788818480; x=1789423280; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dGB8VXXuTeZYYj6pmtJE8cGjRrh1/noOmGEkVt5RcKQ=;
 b=sxYr+3oowD2iHEZbTYAD3iKDpjwGzGFFLB9EkNMVcZGIeq8/aDvMtOCHlmEuV05PPB
 AOdYRIGwKvPCUjghS2gBhHPHj0J/GSzDa5MupO5pA3Ttxuf4Jt1mUobxJhow/iTzajRn
 l833zpkDupw/TvW7XXO3e97ulARRF7ZsZsyAI6/+TWOwEbBRgN2d6rvK6Q4Nljq84lck
 b44KMtnMwO16C/+lGYbmMchdz8hFVxvnAHpf0cLCN3bba3NZruGXdGXAtiiu40R6bUwa
 m8ZHAvVDMYvHKj+agg3ZwLuF12AY7CaR5UvORui5JZqcm+Bk+3mJVXnMa9J5GzASx3W9
 zaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788818480; x=1789423280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dGB8VXXuTeZYYj6pmtJE8cGjRrh1/noOmGEkVt5RcKQ=;
 b=BTV9sllaT9bybefXV1VPh9wMJC68Nr11augRFstNxoBfF7UDMCZ7hiwObMwc5Mc5kU
 aPcTN7gHeFXrLuzE998tSkZr1sqdC/SyIML9BxBUIWSuhkcD68zQ1BKMxlTyRG2bRXTx
 +wYJ3lsrSdpFtsAHfNsaaKvmECII4Zb7nb04SX+s5tVk7une/H6hpNWQmCkKL4ivW6ek
 JDqsDMnW+qybGqSdl4mRTjyNsEQPCDf2+A7GPUxcNgMaD2mNcRD8nOyQHFU4rU/g/GNp
 X86pjE1JxofnTgpc9rac2v/qslrFnyE/Z+hJvScm7aJnjVJnROhkUAtHFg1OHQaP8u/i
 psEg==
X-Gm-Message-State: AFuF++krMHTIiqyh8Y73mrn2cTokBgc+QgTEpp6c9RRoDPScvOpPE1QB
 iasACYdLYoKrSFMrVz7orPYRHQ2T+cSkLoBCiTjyM+aT9SL+bgLDHbGmzIvEUsXrw5g=
X-Gm-Gg: AYBFou3FLPeVefc4AmDpMYPyEW6dBafPiQHHxjr28YNPGA1Mo2EQdbG+WM7XEROi8w2
 wY+Ur3QQL+PPQwrh18h45X92XySEMUHRczsUgRhf2Dfq4DAabXrjtnoo3ra1ZoYi0wqnFwmw5TG
 WseMYR1hFVeRfpfkLNWUoX7Nu9DUh6yXmYAIPAPR9cuNWHxow21Q+wNF3Td5ynTGeNJCsjhDzhZ
 Gie1LNlQBuAPlqJgH2UkpzC585BtIVCj6v8rrCkquy1GdNOnnh1aKhLW/XEwtN/z9F3G4MBN3q1
 HcS/+LjhB9Zc60bS5uN2dXFS+VWwt11HqAaiLpJ9moHlct3hjavOInY4B87YviqWc1Vy1NoDr4V
 l3G0P2yw8yugn6vOodnqyqreOq4wpvsemYS0z5McfHVaUdcdancr9IRiqmtS+lIDVfeeg9dO77w
 6SxZog7RWvXhF8w2gonGSoowRVTxD4pRAXGveuK9WpQdBd2zO9i2RgKC1ucMnYPwRON3ScbLmcZ
 Woli0fAtLvxVLAg6qdR5tPAwA/hncZriADNUXp7NPokb5LAEotH/+WD2w/md4lIM581tNS/vFyT
X-Received: by 2002:a05:6214:21c8:b0:910:3270:51cd with SMTP id
 6a1803df08f44-9103ef9568amr321616396d6.19.1788818474959; 
 Mon, 07 Sep 2026 15:01:14 -0700 (PDT)
Received: from
 runnervmejwal.h0l24wjbi32ehma3ntfoutcuxb.cx.internal.cloudapp.net
 ([145.132.99.99]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040595c57sm102788796d6.5.2026.09.07.15.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 15:01:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon,  7 Sep 2026 22:01:13 +0000
Message-ID: <20260907220113.8971-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907194422.414746-1-avinesh.kumar@suse.com>
References: <20260907194422.414746-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] uevent02: Make wait_for_uevents() order-independent
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On September 7, 2026, Avinesh Kumar wrote:
> uevent02: Make wait_for_uevents() order-independent

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
