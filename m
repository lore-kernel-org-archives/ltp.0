Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67EAC43458
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 09:28:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 248D03E60B7
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 11:27:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 808FC3E2F83
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 11:27:41 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D19C10002B2
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 11:27:40 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-92e55b62640so60470285a.0
 for <ltp@lists.linux.it>; Sat, 04 Jul 2026 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157259; x=1783762059; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0j7+ng4zheFfksWZo5WHBMDv8HQqUs+OcyUOCUSdfY8=;
 b=jZyIk9F09kpwiRQT/bw+B6DGOdRK4pJQHpjSLmJV6B6rVyr/r8aDBLW1Mtjd71/K3Z
 FX6l9YkeQDhWWBOYSgQZ72/3vXKHvfutZSFy7Bfe/a+7VTaCaeWXKcUaJALevr29RBAC
 q2YuSiqRhfRhWMGSlfWUdKxRJW+q03+FaztIuJaiY13t/F5+ioYLOqYylIDRXtaamkyd
 IIzfEu1nWOL4M7ycbNuCuesYTsdyptaJ3KGTEmfOLGHzxY1+3dXR4ZWhPp0fu91LGOSx
 FXQ5qgYS5yNNgMerTFxKHddJzu/sw9iTUmohgFev5jiYktIMloc3uhjmY3N5MduADUdm
 yTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157259; x=1783762059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0j7+ng4zheFfksWZo5WHBMDv8HQqUs+OcyUOCUSdfY8=;
 b=iNmfNV6J6QTvW0qiZQqJeYEyezgyXFERTv/5cFWTtOy7byJTX9YlbO3dXjVA40WDUs
 CCzJvwAzp4r3rw2fTi0edd4J5LYOEsWAhmlWj4Xf3MfZZah0G8TPzvKmFED0lKrkz8E/
 UPHvSqtlO5SIb8DI9QN3UWTFFiscO5m0qgQVBckEgyRSV6XtQWlSHVZGhETwX13tnINL
 UdMzMaeVfBKkA9HecRLOw45M2bAt8z0rYlyvYv47lsbkskWV/5BU9BXQZoKifUYD7gjw
 UdRBY26faQFo0TpWHHdBSckCB8j1QzP4SbUAhQ1oYbe8MgD92C1n3gNQ3FENFGY5rGuz
 NX7w==
X-Gm-Message-State: AOJu0YyVkmi+16T+elQs/O2w0mRzpB3WmcD8uJZg1iSX9rMuEot/TmLK
 jAj+udznty8//c/YjCCK4UUtO8YcSi0uFhWc4MGMZ4SN+0m470+Z+KJF
X-Gm-Gg: AfdE7clMKwpofe2EOWtL5/tSBYamR+a1Z+KkucAwcdesWPLe3ip4qkLQFaBi8AXAg+4
 RO8IgRJjEUPJxkgOOtQMTOO74/zyRBkzRZHxYcjtEWvfj9fgnuJtTD8SCwTteOdTtW6755COjLC
 bBOqLF4y1Zv4w7e3lm1vHIp++MD65VE+XJGhKv//e28cXgofrTzp9D4ctQr3hpAnvF0R3aznSfq
 Fb9b/dtJCo9mAnqQ7gnM7lQTCgjBqtCo3kM75tIPA+C4ZQ1RvMD/wqu0sWwS/iublMCw/+Ej715
 J7nBF/Me079DF9udg5yNzGGYuJpYG9G0xLXRk8EJPlavVooGThRy7VJ1VHFeIKb2VMmhsfzTCcw
 kYAD8dX/5tfMMtXqrfQiRKwx6cLT+SvNh3pUYakPX2mN0BwHZEY7J4tlpCGZZpuJSHSYLAC/IUo
 grzUs8PEvbg7GwSbIqntX7BOJeulZu3VDT6nlhAa2kTBSuTnnUamIiWZGoN+afPHGZ8jPZcFBW4
 PEUdifhJKCVRIh24X7GyAeyex/Aygc=
X-Received: by 2002:a05:620a:1a1a:b0:92e:5ba4:b81b with SMTP id
 af79cd13be357-92e9a4811a6mr384167385a.44.1783157258823; 
 Sat, 04 Jul 2026 02:27:38 -0700 (PDT)
Received: from
 runnervmkkn4f.d25eko5qp01u1c5angi00huzxc.ex.internal.cloudapp.net
 ([135.232.208.145]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46aecc908sm79426106d6.0.2026.07.04.02.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:27:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Sat,  4 Jul 2026 09:27:37 +0000
Message-ID: <20260704092737.4044-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704085703.618290-1-avinesh.kumar@suse.com>
References: <20260704085703.618290-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_test.sh: TCONF on xfrm algorithms rejected via
 netlink extack
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

Hi Avinesh,

On Sat, 4 Jul 2026 10:57:02 +0200, Avinesh Kumar wrote:
> tst_test.sh: TCONF on xfrm algorithms rejected via netlink extack

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
