Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BA0C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785486062; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=02ZrE+xrV7m6YjVaWVJ89gR0pUKRLz9r/MKPuhZzsTo=;
 b=q5qRDQ6aRg9/rLqI5qoHrBI/zD6gfEVxO9wB8k1sEdw3yy0pVs+sFe9P4D5bHiOD0kJ7E
 w1wCJjS/WQWGgpKDoaVVLSSfmWIvYlgwu8qI/5rlPHLFI5S5ejuUx09ODqI/glfKcCHmAj0
 yVaY51rKOBgbkOLIHxAyp3DCbFlB7H8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B3863E2D18
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:21:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72B383E2448
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 10:20:41 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18CB2600B01
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 10:20:41 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so401962f8f.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785486040; x=1786090840; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=afQfzzwbY2trC1NXyoxp5js3LRYMr57xWt2SrBT+LR0=;
 b=Xfvw4iwSSC1sebrUBzl6FwNsBfTMYmmW6FCQCEUoi8jU5TKUjVDvEoZOqf3eCBcg4M
 0NXRNzWg6n9ab5fUHO4S/5LgaTyYQiQIVdnlrhIJW0eOdirlLaLVn9hce/LVJhlsCsW3
 XYuTpxReXrvBIwZi6Rlmrgb0vPPaDbOluELZmE1NswFgfmVj18eQcGbYjkvWVF9ODcnz
 IhcJq59pZpj3V4Dsy/kuyzueWcUsNoIpSWPsBj5Sa9Q7n04mquWpl/d+b/pfy5+UkYgi
 UbId6Un843iZebC09NSkYDYQjL5tCy5PcjSuutLbmWblMIRMzoCX9t836Vc4Kp2RKxwi
 fbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486040; x=1786090840;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=afQfzzwbY2trC1NXyoxp5js3LRYMr57xWt2SrBT+LR0=;
 b=F5RpnjVHOJp+1Cw5tffG8hBGqnHbaa1xvRh42gACARzWLa43BAmbUoEy1xeNAruZ+i
 fbp8d6G9SVoFTGXIkkaLESS46vkbLET+W8HgXcofetBnS094v6yoq6b3qsv0kiGffl/f
 UwxvQ9ZJDMODeBUdcEOCfmHrVRni0eagEpSwo2r4ADNExPfZKm12FgMj1rVcn1rWBdcb
 miVzk41MjWsmL1REquGdVpRmOKeHOcPEVWt/9eYCqFDTEG6vumPnYsqWxhxcdeg8qDlY
 xJauvkaPDoDc3Wtba2OHTJdGspT6GfHVsN99l0qzIEGuASwC/pPR/n2H7Vu6o0YLQQoC
 KrbA==
X-Gm-Message-State: AOJu0YxANdHTN1EEO8nw9k52ch5sniZp1KPaS66CrInWoU5g/t4NRc/s
 XSvUUPxV0G3jHywyrtzZ4xUfNODP51mcY5jiWkisUzdYxmaJFydsfmUNf5CKpLX4ujEcov7OKqG
 dw4+Tt0d8FA==
X-Gm-Gg: AR+sD12e9/VFp7CTZYAZi0nKTnvhTFHEFG1JhqYBEqZTDU6GtHZ0yYhvPDVXfaYmK2U
 2YdvuiWYrpMU/QzDXHQ5vBaOlZJ4x5bP2DJC4JQUAzA157yCvEObRoqfinFNFpH00q4fOnubmmS
 uMV/o6HefYuSjrA3vsFO75YPzquqIG/6QOP+vQ/PZV44x9dSRh1JwO+thNgoY2v5cX/jfxhd3+8
 BPnRgDWX9TU9lBAaExwQIeSXU4hFYcLnIlU819vpYXuUcrnP1vQahibYUu3Hr/bovrPp75CnxZE
 f7dssZSYPWkTISXavU755f+aeqE7e0V/H2zwCyhKTOHBPoTJfvcypIGcsKfAFdGnIREKFwNzryr
 s9KOYoL3Cbmi8HP9H+ufjPOwQRAv3WLlnDwNtihqtxX4+fM6RmYwzpWu1SHJT62kgSRXGcXOK+u
 t/cDj7yDpMhYNHNpR1+N6V2FKNZzZJJBv4H3zNdj9rneSrFvSQVRTKfiaclUN2ElAoBPf4Aej5p
 CtC7YBFS+FKFaIvQQBO915kRzAB6a2+EdI+paEF9KiI0/+3VjjIIIUKv/aVIn6cMfoChaw=
X-Received: by 2002:a05:6000:25ef:b0:47f:73ea:37c0 with SMTP id
 ffacd0b85a97d-47fd2b5a375mr2596928f8f.52.1785486040417; 
 Fri, 31 Jul 2026 01:20:40 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2961sm2609424f8f.13.2026.07.31.01.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:20:39 -0700 (PDT)
Message-ID: <6a6c5ad7.d9578069.1a429d.2ed8@mx.google.com>
To: "Shaojie Sun" <sunshaojie@kylinos.cn>
In-Reply-To: <20260731031343.1298712-1-sunshaojie@kylinos.cn>
Date: Fri, 31 Jul 2026 08:20:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/3] Add CPU cgroup v2 tests ported from
 kselftest
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

Hi Shaojie,

we didn't receive any answer about the reason of introducing this
into LTP. kselftests are not working? are they unmaintained?

But more importantly: once we introduce these rewrite into LTP, 
who's gonna maintain them?

We already had an example of kselftests tests rewritten in
memcontrol02/03 and (as you can see from the history of this ML)
these are causing lots of issues and false positives. Mostly,
unfixable.

What I personally see, it's a duplication of code between projects
and even if LTP core library has a "better" cgroup support than
ksefltests, still, there's a risk we are going to maintain something
that is breaking and someone has to figure our why/what needs a fix.

kselftests almost come "for free" and many people are already using
them all around the world to test cgroups.

For this reason, I'm against adding these tests into LTP, unless
there's a valid maintenance plan for the future.


Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
