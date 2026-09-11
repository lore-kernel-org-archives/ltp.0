Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F995C88E42
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789108516; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=msQ9tWljxwsyUEy9NmqBrKpIQBMVqzVX2HzFPPlRtAScTIfq9pJL4T+SbA//79GRaguC9
 YA5RrM/oezsSADkbr+Ugd6naWZ95eP67F5awgXgfEPMics43L/7sSZfezbdXAmlFy0zr9uY
 aQApQVnlFDcw5lFJirkEA/HYBn+/Aag=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB4453C99FC
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:35:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 277463C99FC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:34:56 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6769B1400244
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:34:56 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2420395e9.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 23:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789108496; x=1789713296; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=GmGgB2f17F43qYBYOFIUSIOociliT6PwdV+10shv7eMhmGgg83ZpCPjyuRngVz5IbM
 0yn0mV+j6qolzHID7co38H6mq3P2ow5ORwpbFxY9pxy2M9nbfFkuVLGMc3+KY4WPVUrc
 KWs5/fyHQPHjmEXorKtEWP7F9nJfvpfkxx56nLDDVrT37K/65s3zIKHbfk/jdpPuduGx
 yV+YQpVyLgxMvu9NIWmoTZC8VRC2Er2WbRxjQZGN7eWqGbP9KJtxm8YxZ1pxCPsVD4NR
 gKjx47dJi+o58MoiapwJvRbShud/TUO1Lm2rELkRSWFxDXV7loeydETfYUNzYgcjsIhl
 zh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789108496; x=1789713296;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Ovei3P1am8uKFKYdYScHRrYoYW38FOhh7QhW/2C6/giQUiYyj5SSgb+hG1eijpnn4L
 4W/xkJiFDCLks5XdHYeol/Khoe2epXba8+UfejGdcnH2Wcbxvz0w6Y1DEae5NWQxjlhX
 Fa0ff/Rh/1U+q7n0rqeoh8DHJLI7s5BjjHwGvCTPij6Nh/c7GOSWJNrE40dHHkl2F8NH
 7FQVOOwHl60mvH251aVYWZiLQL9myIAHR1R/xgIxPl5CyfG8z7AojMqCt935Aj7SMyv0
 /ONz/xREGw7N/84TyzdvM9gSY5BQc6Aje61zLhDz/i6XHJPM1+3ib3VZvzy5EJ5qv9gy
 S5DA==
X-Gm-Message-State: AFuF++lUY+sG8tfNeE4ABGLqn0/vKVs01U23kuu1INfZ1Ip8jQpt2EDb
 uopBFg/JSYoBJ8cnloey2HOPH8cg0/JAYHrrA6X71CeWN2J5RhKErVwtI0B4lrmRbes=
X-Gm-Gg: AYBFou2fcHN3EM3FBZLMP3rh4LhUaWtojJFUNeDvG6QxMQ+HMLHrV62JE0lLDqimtZQ
 YMoJDeWvO8bYXaOrcV9IRxlPkfQuObSu572XIpEExj0bdWjEk08n61vJoYniWegqy3AG2qkbQua
 7KzPfk9PzzSgf6XDOK5mYHHMXlaGqLi2R+Spn31vw0zyvj4GlHb/+osDjwpfHH2dztEISCjob48
 YKbh86E37Xi21VAWJ8U4di6UA+7rsR9aODeDsvLuLiYd6UuBlW80Gm9FAe4/RyHj5CighpJ/zk0
 ilvGcCpAmmZZUBthCDcoFOYDpbVGCQ0rxWIr6xi4he8V6t1l+juAmdE0iKwk3mnIMJDnxYeCKUc
 eeArH3pTQg6KPKUZwVGmfvM45DCiWv7RvQlZd+c6XgaND/ssApcbTJoFXGjoR2x/ynXK37/QEwq
 Zk4zRpkdtqnDKj1YKQ3T/tCgw+C3DyZpNfvCerOhsBOtb7CMsGF61CFmzIP2vFp7qIdvJW8fJ9n
 1lIZRrSBdl4BW16YqzwMlE0Z4JpFiceul1g0yJ9VlEfehLWQDhcPFmNnIHdi2Wnhh25Ts15yNiO
 /EUsLza/cnbEF2xP
X-Received: by 2002:a05:600c:c4aa:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49e619c051amr26851335e9.18.1789108495830; 
 Thu, 10 Sep 2026 23:34:55 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c494basm117439465e9.12.2026.09.10.23.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 23:34:55 -0700 (PDT)
Message-ID: <6aa3a10f.8e817291.10e1a6.ad9b@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260910-coredump-v11-0-e87e2100dbe3@suse.com>
Date: Fri, 11 Sep 2026 06:34:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 0/3] coredump testing suite
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
