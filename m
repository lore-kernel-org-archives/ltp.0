Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F47FC97E2
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774860818; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AHAbbBHL2EDiGvNJFQvpf8plOjLUExjIUbIPEvZXCL0=;
 b=rwDpmVyol9+fiOjPFdcEEGw5MvMNsCtfzyOzkyH+8DfjvTLMtYKhYDHg/cQpK98MiXN4/
 SDUf7s1kPm4tYWUMj+hStqQ03yICOdSDkG6O0Ou0+G+8tvbBUhC3zd2BIg9/ZWDuP6cu7EV
 JDwtgkTwGvWVfGzYn1LeS98W6uGGCAk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77ACE3E2A58
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:53:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8FB03CB8BA
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:53:15 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 06DD61A00148
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:53:14 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b8982c2f4so2083338f8f.2
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774860794; x=1775465594; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6eVx2tiytA/MmiUT9jRnH2YZWB97qpe7aJS4T/T6MHg=;
 b=XMVqkBZnT3XgFeI9X5Bc26YM+6BXBp7gkpwZqC6Ikz9Z/H0E2WkIrA/aVRNiQUPmLr
 bpDUwrvCNhdaMVqK6SyxGANe/5A7XeJM1/tfzdJHzzcE8+0QyIPifYYbpf61Lc9YREoG
 sk2XtlMsXNt2EH5lLe19g8z4ulwQHT4cAU7/Wt8qQQ4sHjjTHKYDNwq4BLrXWXjIJvNL
 WBz0QeqB38BDj8kFFdWh83NYEklRos4adyxFCNAOBzAXcj8AiVeY/kHFvADio7Nhkvd2
 yyNPfl9mZf82aHivq7HZ755I7zRjiuG9D+Y4x7yMsgzpViaMU50+/Nh/yBKV5K6Ea2Td
 3A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774860794; x=1775465594;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eVx2tiytA/MmiUT9jRnH2YZWB97qpe7aJS4T/T6MHg=;
 b=VhOwNLrcg6T5qPksOzbuJv/i9aG9xNfHDquTE9K2Si82ySeC7QjUGKffwXcwtfqYV5
 rCuJoYpuArm+1g8FW4E3qlVjb+i//4ik8XbnvC8gvKh1PJYzvh6gufjp/8M/R5gKVciK
 /F6i3NLjdcJgueaProBOX3O1YJp/Fz5dsaWCPmvUDdssvhv0zq5F5YGv/6JC7+9Gedga
 28sLVRlN3Rn/5yHwZztQGxmAbWy03/ptqqj5tYTFbBk/vyeBglEuaoEt7CzRPj6AQ8dO
 Ao7Vv2et0crEgecxL3ZTOdXiXLhkYjFDWpLs0QN2Qs+G71kjUYJ4lBWgV/tkR+mX6zgc
 Sz7w==
X-Gm-Message-State: AOJu0YwO9gwd7tfakWwMqqvLQ9WkupC+Fv93WCK9DjjtftPoqVGVzLSC
 TNBMZqrn783OcjGgcW9CnSeLdy1Va2X22IO5SQ15WATJh4JNH/zleb0rBxlVCt1azD8=
X-Gm-Gg: ATEYQzzU9k4G4xDjXc4TNGMqkA3RzVpySqhlrQHwEhFYwtP56SZtrsdO/+15RAQmj8z
 mB6CQIvAlvgEdddZzT5/Jzs6KFDIeqhDC72F2r+tyjGpOsPmVnmch4W6SpZZUzyCOc2n5BjsX1U
 fEoRcPMtZYgeVWlZLVKJtBTyUx2CSn5nJAlTmCV/hGflwuyXV1pYaIqk+MjDbOJ+xhEQsKdTf4l
 4A25GcSREokDxpCr7U4kTRU7tkO3PpC6wb1gNI4Su1/oyWj3z9b4BJlTdpTQDVDhDVkDwTnZMAs
 57kogKlDPNMUD2WWkwV9kGrhY9FLRkrrG4jwggsN6tDmnLTxsf1dGzWdXkEqav8PzkKpQqC9DL6
 zBPNSRmySvS2Nz3IkabFJyJn4IFDqFgmS5m5vqNAQhM4Onl/syVEUSHoxtHKicuw6yz7XRCjXos
 OEhfn+k5kRj6VepDctio4Pe+E+jTTCpdICel3Iks0To0sPjwmsJl5h0paIHbL5CM8G8UQLUk5tj
 vOTgcErcUMqgVJsMOqsO8XW1+o0Dj8ByQE=
X-Received: by 2002:a05:6000:1445:b0:43b:514a:ec78 with SMTP id
 ffacd0b85a97d-43b9e9d5a20mr20592619f8f.1.1774860794343; 
 Mon, 30 Mar 2026 01:53:14 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf1db08e6sm26541298f8f.0.2026.03.30.01.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:53:14 -0700 (PDT)
Message-ID: <69ca39fa.050a0220.1f284.bea9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260327173252.1112192-4-pvorel@suse.cz>
Date: Mon, 30 Mar 2026 08:53:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] lib: Prefer LTP_DEBUG over -D
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

Hi Petr,

> +	{"D::", "-D[1,2]  Prints debug information (can be overwriten by LTP_DEBUG"},

Issue is still here.
Typo: "overwriten" -> "overwritten". Also missing closing ')'.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
