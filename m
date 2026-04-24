Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43851FDEE56
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 01:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0AE93E53C2
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 03:59:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693303E2729
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:59:11 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A46C21000A3A
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:59:10 +0200 (CEST)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506251815a3so61972081cf.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 18:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776995949; cv=none;
 d=google.com; s=arc-20240605;
 b=AUqlBUB8xC9zBWi/R1fJ97dZ0rvh118sdC9eNBZp6VlNv1a0kSV08ZCJ69nkt/Ui4t
 9mCYEelerEv8Gf7kJwSEH9q+5xVNOhTr9ehUaqtiyFCT6f8Jhjsqzm6nEX1GNLikgHzR
 jgspwavwHojnPZwgqkfv+Ro/2rHTNnJtf++RTMgUwaBmGUKUOhNXZUKFkjn4Ia5EXgNT
 w6Ydl+VIwQreOLup/G4FeoZmOeK3fhqNFj+yXqUDYbB3nAOSuz0WGWrq4BL2ryUXlKyx
 W7Gg2VCXOkQW9c5JvcywfoKMXCIAaMdkdqftCsmFdVoWoDo3UgA5G7dPr/Yq8/2NQPD9
 452g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jm+A1SABNtaBRT9exIhSARpd3Uq6QXoyOvzCPaQPfhM=;
 fh=CuExz54ljsO/o995PG49UG+i4lYrQxd0nQjicfLDGOA=;
 b=dmxFFfD5Z/tLmH10t4xyyU/bpiTBvBnKzKGVfkw8Uy+I6sJSb9Gr1i+e099uRIqA3i
 md5RvDB1opHVxScwlIPTLUf6eoteDA5mAZYpYly83/TcTVYFzbW5Tp0WPC/GvV6IRnbC
 T9GGc/kdHhQQSuJrpAHDdEndy7IjYcdrXm+wlPnnI5stKL1RXOuYKh3TsO/BUKGwOqu2
 XjRAoMPRzGUaTq8iHxN5uMi8lhqzZ0Sm5u05Gk9E4r5zEl9Vc/fB4a5Rfu51Y4wBhe/a
 J7z62UTLfF7HDPWpZem1F5Be2j2HS3D8lHkuZfSh7w4vEEgO1u3TfkjQevcyEJUxeMoU
 YmwA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776995949; x=1777600749; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jm+A1SABNtaBRT9exIhSARpd3Uq6QXoyOvzCPaQPfhM=;
 b=OJBr+HzdVu69r/G9bghK8GoPWra5nDQxOf/wukiq8GeapbfO9BH4zmJPF5JKTs43G3
 oyOGWZ0sQ0y55/9lKoeAT8YitD3JO8ZOSP3HZkCMrfK+RGuvqTzzs0ekCSe5E/IQUfqY
 xLxOls84t0978O/6rdDgFoK0bwEnmDka21bTgmI7gbxxHuOqJKTTO5unPuVcO2Woisct
 F4TSFNPc9iVPaEbPG7V+iiuCI12+G1kB6My6Sj905XvZqQPqsQ677AQPML8qQDDPkDx+
 c7r5waIRXbCWfjQjiOfHTqdVUQSj1g6YyGElbI0dVebXxuQnMi8iv5nCrTedtv0eayqO
 5q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776995949; x=1777600749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jm+A1SABNtaBRT9exIhSARpd3Uq6QXoyOvzCPaQPfhM=;
 b=VPktkyQNNplvQyjwH3QNMNHSFTZqO5KYwZtUzRfI6Pr6HD8/kEL3Tj4CFuUrVoq62/
 dA9edISa1jw1wXnOYc3ScbPi0mvra6PMMIGvB2MTxc44QtBW4yndYDLsKFM//aAo5Zrv
 SlZpeZkMmtldEa6mffE1bjDS5LttRiUFWmLfw7vC/xNsSM+liwNVeMB3wxvsww/yifi+
 rfPy+QhYps430/JY+uwnau2K4xp+KF4EysXjteBkhbeEHxVFVUW+tPatssXA2dvrSIwo
 evVXASJ+q4/bNQ3BVQYmqfEVO2GcLzX3wvu6sP6EVBUBVzYejjuF4DusbEvFPnC0Z/BI
 oQiA==
X-Gm-Message-State: AOJu0Yx54gxMhjq31OkdL5Vr+vNmGRqgaVPk/GMYeRbsyR2sy5/KlqeU
 1x5fRp4GFf7L70AGy44rpuU1BbK3I/0Hn80ryGlK8Jvvli+nUhQ5ygF16YmqV8rAEx3R4BChbk1
 Fn3jyf1GgsURAx/OLh770jCERse0COQ==
X-Gm-Gg: AeBDieuUI4Yak8MniTHsEF0Qf1FImhwgFRN65QpTYq3Iht1toZuATkj7kDw5qzpdArC
 qPj/NplHjGmfIqIPSJ3hGcNc+n4u1HfyVsvzkzNzs3MAooDpW0BxyAMglmPfwvFqSeLTN1EWmif
 xh8bP2aKFfcgrUEoyJVWfoQQ2z8tVnyV3SqM2Vymfspg30kiLdH+/KAEpoaG1lRBquEiKjRoj2W
 Oq3k5UX0derf8lKsYzz/80SuimpGcddDZ5U4YVMFE/eBcfOdKxxeNXH3x7TMmkHy7MBqSAuqcUY
 ShfaKuNE1AUjwxhwsPrvZJD3R3RQ
X-Received: by 2002:ac8:7f4c:0:b0:50f:c2ba:e919 with SMTP id
 d75a77b69052e-50fc2bb14a7mr135102381cf.16.1776995949331; Thu, 23 Apr 2026
 18:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260423084123.657690-1-pvorel@suse.cz>
 <20260423084123.657690-7-pvorel@suse.cz>
In-Reply-To: <20260423084123.657690-7-pvorel@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 24 Apr 2026 09:58:58 +0800
X-Gm-Features: AQROBzAWNmbybj-OPyreEglfgSHnj6q1wLTXTHU9CYTpIPyUba8xDZM-_VBiM_Q
Message-ID: <CANgNiRyjs=tCkVquFGqz9=pC6BBOtapiGwLEhfvuM6R9on_nMw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 6/6] lib: Print TCONF on
 LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: ltp@lists.linux.it, Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

> It'll be better for Valgrind developers to know, that test is skipped.
> TCONF is not printed that often and because output of the message is
> trimmed, it will not be that disruptive.

Fine with that:

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
