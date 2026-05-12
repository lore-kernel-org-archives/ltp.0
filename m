Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE8CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 15:35:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C65283D7A74
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 17:35:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C67F93CF005
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:35:03 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C1D72001A0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 17:35:03 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-3684a6f3b0bso1113166a91.1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778600102; x=1779204902; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwi1v7lIrw+wA6EKDbAJrNNnBLBA+OcQobBBG2t8NWA=;
 b=A+hZiVNjB1jo3xJi1PyculWDh6dpkuUpBbfilyzeR74i8FYqWJXOmVITBBU+upSuMs
 l01bqx2Z3+f1kCSnZuKY5YVRUpbUlWtnkziTDrZolYQ61I3Mw/CkJul4mOqTM8mLpghs
 kyzKyjz/0MtiG7QLSGILjkf82wuf1waDXvBOX3Zosaei2Zllkbbx0psHplUQXLvmDK5u
 k5wdDPJAL6K10u49+norio2l2QLMM5c10lVGdONVqEpc8j9Bp24osfuhobDZPk4f9MFQ
 ljIXt5OTCPI2hP2oAIHVWfvr5um0KePFt2y8v/o2nJK2w4jNA65xi0nggLZ1N5PnhEVG
 URAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600102; x=1779204902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwi1v7lIrw+wA6EKDbAJrNNnBLBA+OcQobBBG2t8NWA=;
 b=arh6DnZYSDYxuhDAUdfHNkYSUMM0p3ur4ADDrQymPZ0J25cRzwQbq2j+LtR2XOCvy4
 o7y3w8EI+hN9AWtK2zXzH7p7621WBQbfaFiuQSe1LHHls4rrs+32wbEkF4BQ7Omt8Xcy
 UAXeSFh54JIW+qTQNFMtvRFu66yOl+fRSCJ/hOxoskU//ftzqYJASGNrYQOCjBK219GJ
 W1IVrbZ5UtnrT7jWxrfRE/IInC15hbJSVDw+spMyfP8q+mmTJaVJ93W1iRrgwn6g1hwS
 /M82Pa3CLEd1hCoafTQXpUJw+HE2vRWFUIeSgYp4v6xhf6ZQcDITXoGe8Xw/0MRpNkb0
 FNww==
X-Gm-Message-State: AOJu0Yw76jQuC1XehCxYJJvMnZQGg2AN174R4L/S/V/mSNyLGNP8FGsG
 czdUT22wwatZhR6GZ8fP9xQVXYvfG9rzri24knZfPXzLP7drtDoyi5o=
X-Gm-Gg: Acq92OE9ZTBztB3VtEmTCHa1c9r1Zmx4x40FOwaJSNF3CBPUrkZrbVfnFS/wEelaVsU
 GjmV+5P+hIy6BbGttFh+4vw9xz3TuukSo0HMyLyMs8JjdP3Dw5JacBoGoDlXFdV4AF6l5udYorg
 07dDipNHkgc3iq5o454cRnSULEk7+yATFa+ZR2oEQPlp0Fba2M/lyXpeVUL3kEkf0dw980em7E0
 YSCbfhYHPIy/DiiMQBtzLA4G5tIw6N4Q/CnhNGtwZo+J/DkseSw1miaV47LY/OYMjEuIQu97r51
 iCRx8k2gqwkI3Kwsk2EatUA79ntzRQeOS2RQJIPyQtr/23qkvKkVv2VTz4x68GRlYQk4dz9lAqu
 V7hYzZC2e6WcWPZ+SLCUCC5XiBvhuKMuAUlKooWB2szuWSv8M6+aKc9Yd+9Knf/Oz0w1nHQO5Xw
 V0NY6Q0cUyiOBoaBaIS69g+2s9CpZ/aSLvi/uaDPHcuQ==
X-Received: by 2002:a17:90b:4b08:b0:35f:c6bf:2bba with SMTP id
 98e67ed59e1d1-368abb24d2amr4423511a91.11.1778600101744; 
 Tue, 12 May 2026 08:35:01 -0700 (PDT)
Received: from localhost.localdomain ([1.232.225.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d27002sm144557215ad.8.2026.05.12.08.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:35:01 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com,
	chrubis@suse.cz
Date: Wed, 13 May 2026 00:34:35 +0900
Message-ID: <20260512153437.4360-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69baab3e.050a0220.20c44c.52e9@mx.google.com>
References: <69baab3e.050a0220.20c44c.52e9@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] inotify: replace strcpy() with snprintf()
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

Hi,

Gentle ping on this patch.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
