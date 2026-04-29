Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E57FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777446861; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vzpeiQyFckuKwAuxQpgfGVUb9h4Z3kJTVbLe37/P41E=;
 b=W+BeBUX73MS9/pKHci6gBGNC5eHyHL51k2JsyjwKG1kg7dIE/VOmJmFYx4h4iA9Wtk4p/
 jLoglM6lWunvnoxqlfpzdKrJ9OOHmoWm9cQDt8ITKLJlO4iGNUCx3nq8s1fm/+Z6UyUnNii
 CH0rwqWGexee5yDHATgMoR6zWUEZpD4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D303E252C
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:14:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B36F3E2114
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:13:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C07E210009F3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:13:56 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso106213665e9.2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777446836; x=1778051636; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nHK9LKFJLtK8dx7/dZav6K+vS5g2N4o/LxE4xaBBTyo=;
 b=J+/KvJ5OjCODZsBJd/PB0d4x/NfyiFqfax5L9/+bArwfCyf20tz0wAP4a1GdhdRO1/
 wxFzWGQMtGQxhoRrnylQRz3IYisGzhrpEOJkJiqXTugzOV8rPqFAmZYaRASy/CimGdgf
 W3aNrZm/ATYS0UJdZI2mz0GP8aekEkTN3gijhrDuJmQvbHyob609V0Mf1c0YTfkMqHFg
 H/xZmGrz5kjJJlasNqzYIzSkCmC7fQuoLeiTQPZzZkC0Ox3wq7xAYlOxyPYpq/aGPB7R
 oTG8Th21kHCDxfFKU4ilCV1yK8r+4gsb77rETlj1YiwDP6XYB/4IB58iwtsgqMbV94s5
 smfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777446836; x=1778051636;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHK9LKFJLtK8dx7/dZav6K+vS5g2N4o/LxE4xaBBTyo=;
 b=ne5BdaD0/3tp3W6cYR96og+KD+5Dh6j6IxxG5uYt6AG42f/McdPvASl5Nmql4E3voG
 hahh+vpkw9Wmz2lJ7vdu1wTVMXgC0tF4VBnHhv04fIxP+X7E0Ak445ZnriXWe2DyMfyi
 1jXTFpOiEMb04tC1AKcLoWgBOcKwT9XCIAghOVBn5/xJWiKoEyEBrci0vF2HK788Jmd7
 BuPzg/Xfi6d/jr2G4yUQJpWIjsuGVHIyYboJq/DPOfAVNf7G5HjfngpoWftbejnREAin
 hB/ZAxw7cWVM31WdT9M0I0t1xpjZJKBhGLvRNrLFyq4ZqLUwAcUH+d6anOYHeOnO+/EE
 wLAw==
X-Gm-Message-State: AOJu0YyuCL34gg4bIRhCSm/KzR5neU/a1UNjgdWzD9rqcWBi456b8G6W
 c1T1YK66OuWJBBoqngZT6Epmte9gHgrFuQeNBMKcibRdyMcOkntsVtj2I7VYoLK6qs1SfJ38L4u
 l0Q6FK55uHQ==
X-Gm-Gg: AeBDievGtcWR773rYWkbbWd7HeR96XqZT4VSFcY0F09gKSqE9kuFOG1nzxxXSFml0ep
 wByw3QmK8e8UG4lh3xC34MtBeZN6qZPhyar4xAzS3NX/ksWa4QcClQ3OiUeQCZXzLsn7v92M/nX
 /jYKHVzRvyeyleRB/XAf5SbcpYpgjudKgm5+PsjRTfyal+MUREqlYD9C1F8amHBOLw+I83sPMYU
 D2DtwyJTuzLvF/ut9kI4ShWMGjU9PjzPoJx6XbPZrO8juKElBYsUjGvyYhirYoZ5JHGoXkFz1Vu
 kgSUMFAGPqIHjgPgh2VLWwweFdSHh8e4wm5LBvBzzR8AVeN7CBQJPIBhfwFq9UjNSVSYPjirXiZ
 bQe7IhPvHyB/yHZQtzf+vM/JmOyWvsDILGmugz+VSsoVx0XQVA5ebsQNZQudHE+wwklOHNNGdcV
 MVWXNtvxf7s9FFL7THEhGe3QPAWFJ9qFgJ5TsUVG2+exjlcIu5Iyiq9MEf5px69KP+QU4vgDzt+
 42EcGj9L6rMHPcVTclCzZ2lhfYvA63qdYIjb9dkN71tssYP2sWil3VNT2T7tgsYcsEdqHk+kpjW
 wvhBz/nde4f/
X-Received: by 2002:a05:600c:138b:b0:48a:563c:c8c0 with SMTP id
 5b1f17b1804b1-48a77ae59c8mr101858405e9.7.1777446836021; 
 Wed, 29 Apr 2026 00:13:56 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c5be6a4sm32656365e9.11.2026.04.29.00.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:13:55 -0700 (PDT)
Message-ID: <69f1afb3.050a0220.2034a7.c43a@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260428133233.28050-1-mdoucha@suse.cz>
Date: Wed, 29 Apr 2026 07:13:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] aio_cancel: Fix incorrect strerror() usage
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

Hi Martin,

please update the patch as requested in the agent review, I will move
this to Change Requested waiting for v2.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
