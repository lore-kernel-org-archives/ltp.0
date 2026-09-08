Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E550EC79F9E
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 05:41:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C66C03E2FB2
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 07:41:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03BC93C8148
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 07:41:13 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF173100099E
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 07:41:12 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-399213ef56cso2034676a91.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 22:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788846071; x=1789450871; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+9GKjX5IdOhM6RJADER83RAYwXAB551whM3ObIbV1Mc=;
 b=Qz2F5HaJCCS88vbiWJNL+zX1DKWJmgu6H1nlBDdX+pIHZvZk4medx6isjpctnxa+Vg
 +FLQkFJag9E81rxCeN0KdSA3EyLscBDiqBWV07o0z7AXuYfxwTydzzLnOlu9RcphEfeO
 jrD/lXbpWeJxgNIqszWohPThIq6iGCB+rAbYrozKNdrUS/YhDruOD5A4zHilE3eIcFFD
 /3cqSx0pdw1Z5pHWwhUNPfenWzSJkfvZKUffGeNiqrjkDpDOAD28BBido+zIM/qmJObp
 Zcw54JTlZRKVat/b1PCZqAJX5WzmISD7wD6/1ZP+sTfpi0TDvtVq8whpdqUcTlyddgX2
 GIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788846071; x=1789450871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+9GKjX5IdOhM6RJADER83RAYwXAB551whM3ObIbV1Mc=;
 b=ZLHWPU8+VkwkP+L/0BJtSVBmkhffPFvwMBC4xppisxMQ26HqdwIjCtydOYdzchpFHR
 buJhL82HxwqtWXxJpE5zV8VIKSm4oaccnaA41mMlIpDupbzKFUAXKn9n4zPpZOEnMYSf
 /Jysh92+o1asD/NnfGrCWCEj7bbEC2HRxPovbFMrDITkm4yM41N0CgW/plJ1lE6tHbxr
 FAVxXYa635nOqUjPKp8dV2TkJesbm3WVzQcteL71wIXP019SnN6tbt7NM+MZNaOPokp9
 aHEKS7xmKsGDwvuN/WQveNvNhn16LZw3rjTVavRV1QWePzihdDVD4CwsWTWNxGKm/tqj
 t5cg==
X-Gm-Message-State: AFuF++mk6QWPKyZC1rtnowYzjNVQVmVk8xdmq32sbv3kcLap2iwDZIAM
 mfuJw8uZpSp6Sfee1BetKltL2ep75xbJvU27wp3aYLBQHRtAdU0qH3vJ
X-Gm-Gg: AYBFou2ddpjVtJ18JWWLYA88rDafAtx/+RWzTuz+YBOnTHxJHuTSetr3YqQGB8objjo
 zH+yk2rjCJyTGRdBfmnzq/ocZsvlfi/l3+14jFvXN9ey7h//wE4WDP/lqd3NnfVUkyRnHBAalB3
 kjEN9WOHhpn8k3BFtQxviUxSEmMDyYeJZ9mLOnatF3c3BwsRT1XdqP4nWaoDTpXQjCQmT9M4rXX
 QXzWBPt5Gbcx5DQcl3wejz9SlEkvdMoNNdX2lOeFLw+SqiLRHc0xzekeOnbv6mstXlFcUyz36jz
 I7rw6qKJd0i47yr8vhCcB2gEBBijhraNSlwTIj7iYDEhzTHnq3ZpZx1KHn28K6W/BIon6LUjI28
 Xlx7AlkH72TzUahdt9IBO/sgHcp1tfdWMZSqCvN/SiG/EyEHmG+0leLyDBApcIlbLOx+j8IeabJ
 uvTJZxw5zfB6pdk4J9rpACmJTiLKGnegkzcC+MIO55s5kSKVFXo0BwkZtwrDBEtH2TgZW85BMHY
 mn0csjp2BwR0aF0iNqJsMMam8yo1aCcFDuhBwRKDyHKKiRHG9OHsaCfECp1QOFgKE44nCBrheM=
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39b26272d69mr41159435a91.16.1788846070750; 
 Mon, 07 Sep 2026 22:41:10 -0700 (PDT)
Received: from
 runnervmejwal.5xxpbm4yekxu3cyamwn05ghzxd.dx.internal.cloudapp.net
 ([52.225.97.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432423f99fsm30179357c88.1.2026.09.07.22.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 22:41:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Tue,  8 Sep 2026 05:41:08 +0000
Message-ID: <20260908054108.9076-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908023121.1895897-1-cyyang772@andestech.com>
References: <20260908023121.1895897-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmap21: Check for free space before mapping the file
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

On Tue, 8 Sep 2026, Victor Cheng-Yen Yang wrote:
> mmap21: Check for free space before mapping the file

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
