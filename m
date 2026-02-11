Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AEFEA8125
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 10:14:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B67B3CDD51
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 11:14:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F19EC3CCB7F
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:13:55 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74F1F600BBE
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:13:54 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2a79998d35aso47332385ad.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770804833; x=1771409633; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CeUYLHcI/Cd40MGCSmqpuIqdzybioxDWF20b7XT1dQ=;
 b=h1EELW1nHKGiiVFzmYXXMcuN+5xj3Y0yG6Sr7DKIGSAJa5YQc/jkEx1FqWZovBH7of
 pmuSOQ+D3dlRP6iy+wsy9SwWyb1P/IfmuHNnSiMYM20BJXuczIpgGJFN8QwnLuhOYNF5
 Ze9milOIiZRDVCIzCPHdLD4LbfsKUIs11v8+wA4q5BgkZbLE+i/w/IDoSG9sWmMwpUbp
 RuSTVDLAuA2vJVkQG78ksfMZaqLgPYLVmSz0f5az7PjtWCnhxtvdQGNh5m+hLYa4nzT6
 5wWbDEQgFixeBzpFnrmE7YbfrZoBPg3J+Qo3+/ijYZFIDrUx4/6CVx/UQe6okKbuXJHx
 0mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770804833; x=1771409633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CeUYLHcI/Cd40MGCSmqpuIqdzybioxDWF20b7XT1dQ=;
 b=SlJfFqmSWLKMsrMinTJ4wlGetmOPNWC6S9iUoOqJYjxgjtRbYWmo6o/d03VNWCT/Nf
 eGolNXp/WGN6+n6I1olyjnMAfcO1sMnr2LUd/EvHOpbXJOc107FjiSYDOXeQWjwiWXYZ
 uFD3xS8Iriu9zMUN+3ZOZUgtrS+p4Rmec88fJi76asyWbR0GpVr8Ull0MNi/4/M90IE3
 ff6B+0EOaWHHwVLqxtmKVkv8We4TgrSlLM+vp1KASTuQcZhJw7fU6DUlxtyLzmOX+65m
 GTH2Faj7lGvDjKNoqQQN/AGfItbnWCNcL6xYFtQW/IJP18Rno6owHkH4TZ3fNmXo6Tz/
 zT7w==
X-Gm-Message-State: AOJu0YyprkM2TQIIrrm21Vcp2Dx7GftsCba1GHmK8EVvxN/cI1DqRVvT
 OS1uIZAyzFTAyaFEfEusBfSVqruWAbwyNeKAWibiktlLyg8FGASBzZtiV9NdS7ZFLdrE
X-Gm-Gg: AZuq6aJEFDViV4b41yxIQ2iP1v00Hb7TF5AJOoAcfQGMnjoAM2hVaXpDjnxA5zxAmC1
 sTPeYMkSXFNiclVa/EJHyseLO1aDeZ6Tw1qYVzHi3xBiMMLMn16yq2INfqpx1m941wXmStSeDpT
 QNMCUD4XsYwWIJbkTnjVEI3dZoSbqMn1FqTh+z3NxglnWXxcP7E+83cSJlKghxiH5SUrQ+VnVYn
 DbR1T0kbBYLMUN8tgztJDk4lfPTOdOmQNCNncaDxBWoZqns7LeShpLBFMtQPUnRAeurl6WIBIzc
 eB2FZZfuNzPKB2+72y4DhqH3MJf8zks5RhsR/CW4E7Gp+nejVMsJG8ZugFlUkxaceFwD9nKStrQ
 MsovJTE8iwV91KBOwElFRgRoUJ7FFffSwt8uGj5AKrhOyOK57AOYLb3oBNicJ0MpGHFIEq69aDT
 WAFDzLzR9Qf2+RGycQ9oRyqMf77VKhwsXxcIRnJqFF/Q==
X-Received: by 2002:a17:903:41cd:b0:2a9:63f4:117 with SMTP id
 d9443c01a7336-2ab29f8ea62mr18683125ad.41.1770804832528; 
 Wed, 11 Feb 2026 02:13:52 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2986dc11sm17609805ad.23.2026.02.11.02.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 02:13:52 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 11 Feb 2026 19:12:50 +0900
Message-ID: <20260211101328.1180-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGC0LPS5JBO5.DEZE7CY4YTHU@suse.com>
References: <DGC0LPS5JBO5.DEZE7CY4YTHU@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify: modernize with SAFE_ wrappers and fix minor
 style issues
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Thanks for the review!

I set len_strict=0 intentionally.

With len_strict=1, SAFE_READ would trigger TBROK on partial reads (e.g.
240 bytes when EVENT_BUF_LEN=32768), which are normal and expected for
an inotify fd.

len_strict=0 still catches real read errors (ret=-1), while allowing
partial reads so the test can continue processing the events.

Thanks,
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
