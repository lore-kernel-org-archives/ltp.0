Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E639CC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789045283; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BTPUzjvJ2m/tHRScV2K7quL0jgORqasj//cJ2KKy3Do=;
 b=DmiZ0FbdTU3KGW2+zHh9egnsVYtngZJrQfjlUxtG/I41kA0zQSp6rY0nIRJOvqRAE4QGn
 8O0E6FCSy6XMCRrCjhLkHvfqOlErfxqArv1HhVvSM3xW65+PAEqI/PUWia7GqdKz9VV5VWT
 O0c0EgAZRa0dTzcRvXQOekimimVQbXY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6708F3E5967
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:01:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBCF73E30D4
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:00:55 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D87A160004B
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 15:00:53 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-486e39e007bso282193f8f.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789045253; x=1789650053; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HmOej1q1et0n9Lkioe6pLA1OewczQziPAkkscsv+EHE=;
 b=D76nHkF/MHt1wcdCgJxhP/pjkc+2NtLPZEduMdBf6wwMhem4WM//RA07SVWbjnUo1p
 vCLZ32vNQd2/M0nzzQWyPqYT/sFQ/4N4zLqLMgqYmPzsFqCEggRdXf0Ogp21UPjTLjDb
 R/N+WwYrUDvFYvQ9bQjzK43LoKYJro8vQFKm35qFoRME6ItMieUErp+hQCERvsedSWj+
 Ug6J1VPKAE0pFR/aVB2uGs2v1KORqD/e3k1vAmhgxE9NHDoSkij819MB5nun0c8VvV7b
 7VFxuvZ8s/WAxyweukAqfwo2D3/dwG2kJH3HYfdopE7qgRm1m46H7tXy5A8HyuuqXo6u
 QFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789045253; x=1789650053;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HmOej1q1et0n9Lkioe6pLA1OewczQziPAkkscsv+EHE=;
 b=qTnmL40uVoMX275CGZx7XlFpPe+Ug6VlZIwaXYTuNp97fVDkBv8wu4Z42LIt342UQa
 UzHJfbxAP6xGnGBj61PG14hz1s0fgO6CRMhsLwJ6LMEnWbufwki5w/Gi47jDZ/kYYxcy
 wagUpWLIivVZeN+DXKBIv9tas68GHutTLLVM4jNisYM8qbKiFiWPUvRdwuJw5h2lkz6h
 iv1yZI5+BriFcmexnrEjrFvW6Lu7q/5VU7oulwS3Oxd7ocqxKEbVGaFUuSUheGPjiBbK
 8O5mVTLuqBl8/Lt5Kwsu8asQj24lfofbUZn5bqJDt1Cgfi8F8qX1djYcpOYk8cVaAXGm
 F2ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiIWgKKdj9h52+GTBXFT00yn8+SQpVY3BrlVPEUnvFfE5N04b+40xxHxGgucn24d4j5j4=@lists.linux.it
X-Gm-Message-State: AFuF++moUIHJW55mVvYS/iSbSEJ/EqoqFRvYIKxfDovSTBgMvFqBfBP2
 Yr3Qdsz798dvKCgoLvjbvGKEWFRYZzxOofwXnZTf0BHB79euqNAzMd73X1WH5nl+MkK+xfKy7SU
 eXRDgWe61ZA==
X-Gm-Gg: AYBFou37KS5zDTOl9TS7EsgwdQhtinbnSCcJdP7f+Q3e+aHcjPZKTlwwrGq7KDyh30Y
 X8Ne52RU2r+GfEKSsoi8rr7wiHESiBnQEefeNUfviZ9p2W6VGv8wlYCqstwtmkGeTCNMVXm5Y9Z
 afpJJJgxWPYWMLmqY+38A+a0ciSYVyFBZ1sviNX9TckguJRxKCAO1Vibts7QgoCnKkOpeU4AFFV
 H4A8fIAHn6LDKlktjIqG8EhkFA0/RqMrDSGmRSHllGgF69j/KUAgQ7fvrq+voQr0urghvl4nI7q
 x4NQx+V1xHQhWX35wWAm1gn7Qot65Bb6M+9ZT38L8OnFzmt/MCssOz5JN6c3tKJKepmgm+61iE1
 33J28VszC6MoWD7efKhRVOga0vqtv6e1I02SJxOd72t334KWMLuptoSy4NqYrEpM3KIxBrMBpio
 qxX3a4yEe0KJ3Tzbv3F54ohcZ8XtLcF7shRdBZOwkXFoH3WHcfGWnnfeFTfWBNNCLwBqziO/630
 xx4WBzWK75skvrVT4MQC9HWkXbB5FPAFGvQCyzeqxtD+T8=
X-Received: by 2002:a5d:5d85:0:b0:485:8a46:705a with SMTP id
 ffacd0b85a97d-4858a467242mr39188677f8f.44.1789045253052; 
 Thu, 10 Sep 2026 06:00:53 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883a9b49sm42707526f8f.17.2026.09.10.06.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:00:52 -0700 (PDT)
Message-ID: <6aa2aa04.c9eda3e9.76660.270b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aqKmzG1kexhUuv1c@yuki.lan>
Date: Thu, 10 Sep 2026 13:00:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 3/3] coredump02: Verify ELF structure and notes
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

> AFAIK the 4 byte padding may happen on x86_64 only for a historical
> reasons and x86_64 is at the same time capable of handling unaligned
> access. AArch64 should have 8 byte padding.

yes, it happens only in x86_64, but I wouldn't rely too much on unaligned
access handling if it's just few bytes copy away. code is 100% stable like
this.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
