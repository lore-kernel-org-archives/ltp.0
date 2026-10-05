Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C6CA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 08:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CF463E4AD8
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 10:27:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572463E2D84
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 10:27:45 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0FCE100052D
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 10:27:44 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 af79cd13be357-93cc1b028bcso110992985a.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791188863; x=1791793663; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiMFS1CqmxIvnj3GIjHRZci1DzmzXkOrlCvlZxDKSu0=;
 b=ilInrF1ww3Og0cFlih5SnnieY0mySm1YR5l5kRrfJ0kc19BzjL+LTDFzaWnd5VnXo8
 vq/SdHQIZl+8pLVb9+Z/WDlUBeMomX7NY9QdjU6vBqLmg4Vfualj1qq0/V0HpIwkm2z+
 X7MQjov2HzcmQls7zq94p9Qpi6iU2AEYN14aiIz3zST3bw8v6QP38XExEPApsFz92MJg
 hY4p4nlM2s1JHGymxW/GvCCV0A62tYrsJin+K6Ge3F6133+L7PmTNyHAidnojXNGvrhK
 3gRE0biPe3WfAS0HPKmjsQj35PxVrCrt8PEW6Z2mPQ1sXzCp4SfKJiwuqNbpy/V5OyM0
 G+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791188863; x=1791793663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EiMFS1CqmxIvnj3GIjHRZci1DzmzXkOrlCvlZxDKSu0=;
 b=PHHfuYHWzys6Qg2OmJN1zwfdQFlsc/QouUqZ5ohmbt4WuRMCXC1ZGaeOsSFdhXXg9E
 Z/yWWOYANPSUDt5lUXZKC6wdMmJkMn3sr/awxACaG45qytzxv5ikVYMQIqOXmp6qGVsy
 SoPLqN9WDYvHY1l5pzCUqX7J420UIdbFir2cIo17DR5x/041GzB33Whft5rmfOyKvm3Y
 5h2DgFnIC8Zh3xTpmQBl9AK1C8Kf8lET9ehY3jlGMm0ENBAeLrEWqU51T1lp3VMoTCGw
 0YWiLJPpakgxCPWvsqPDH9VE1+GpxqMKkWWF4ji2ImQgOj76zY2q5lMsvi/jb7gJLF5K
 0kNA==
X-Gm-Message-State: AFuF++mR+MIxSxi0EVeQa1vSBlXutJAQgJKjm5wJC1MtBWZPzw8K2gm0
 8+XaXYxIcXp8w6sFJf5WYqOx1yxF/+w6wJ4TpZiFL7m+0XDuy1ZfdjDPB8DpgH3y
X-Gm-Gg: AYBFou2F9OI88sislwqJshsxrUqPK4Anum+fZL2sc2PRi9IO0V4XHQ7tubQX75Qqgl6
 7d108/Ammtha47p/cICWlqfujVhQo0CbVdYxDwyUNbGaszxopesPs8R19qak+qUlmp3Izx8lErC
 4IgSDMoX+wSf2rV33d9k0oP727Fih64htSkXewqjQrJOU8z2IYD5ZbAh13NyscJPHQnvY9fljzH
 SlwIkqAfHM+dnP2NizqIKt9bUSVoRpgo7dG9fBjUGxqgLrD3mE6DN+arIeA5sZYXPrB4T111bmf
 BatQFumY95UCRoju33J5R3fKpXjbDaJ5SXoIznGqHv72Y2nj3bJK+l3b7xHpGBEl9UZbwj/aivV
 SVVjC23iQ9JeW6oP7NFaePT4l8f235UfTKlztIXQ3Syu8FUXMDMF1pcb74urq1BXE8M4Sy88vWs
 1HiQdnAIHQD3s8wRXLXjBX07x9uhIyvmJOYxyDrBEpqni+IsyODwN98cvIHKqp6vSF8S3+lZcEa
 L/9VXkTtwjS7Mi23P/IXabKQ1i0U8DYhX8ma5kroefZ5MdpUP8tbKOmicmRYHqmguQN4Q9WiDSJ
 vX81te5Unls/
X-Received: by 2002:a05:620a:f0e:b0:93c:c4da:f46c with SMTP id
 af79cd13be357-93cf1a3103bmr1769147685a.56.1791188863288; 
 Mon, 05 Oct 2026 01:27:43 -0700 (PDT)
Received: from
 runnervm8df0l.dy0dcyvzke5e5dxxzu5nqqj3qb.cx.internal.cloudapp.net
 ([172.172.119.99]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca2d361bsm831211385a.45.2026.10.05.01.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 01:27:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Mon,  5 Oct 2026 08:27:42 +0000
Message-ID: <20261005082742.4234-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005060345.1019330-1-cyyang772@andestech.com>
References: <20261005060345.1019330-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Fix typo
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

Hi Victor,

On 5 Oct 2026, Victor Cheng-Yen Yang wrote:
> [PATCH] Fix typo

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
