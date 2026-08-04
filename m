Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF5C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785842848; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4R6csYi3ET1Rz3qz7cu40Ev2+Mrzy10PthRgj/tNzNI=;
 b=olIwXcmXEkD4/VrDj1W/KlFvotwxZXjrve/NFP8LkX1rUy79vDbs3QOW7XTUvdjkLAg8d
 ADfNb6b6vMS0PZ/tQM46RoVw5yjnJcb/jO4gXdv7+N8uk8m1gXuX/JOWTbYg4UANgyW4KE3
 OSGnS5J4tmZk0d8lHQu8nRYs8r423mc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DA5E3E7185
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:27:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DDAD3E17EC
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:27:07 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D3E7600723
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 13:27:07 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso3949301f8f.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785842827; x=1786447627; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dbDnWGGW2HsrNhIlvkFHDAnnoVz8msOyPyf5B4Oknqc=;
 b=IivgqowqsPCXFJ6at9lz/kz+HxZfkB9Rkci/9Dt8/3IrSxNd40P//lGOFEZmIqzInX
 bMHqRq5JLybJfl76KOBNJBYG/2TrC0i2EuZJiFW0U6+o+xVgUIsFU44O7PFn7eauRUjn
 izfawJM7H2oRTztemjVnf+FGdxI6y7axK5UNbXtnTkbZX8G93FFSBbrP9G7uOJJFFyeG
 5vlDyWsZ1s9kqabAwdR/mpKpOBUnSai84ft7rtjdSv1dc/ENw4aVVk93MaH+5m83IJh7
 cuaqtJzafk7rMovcKiR76S9uIBY6rhkKJjIIMFDsHTTotJPxJYU+Nqdq+ZjEILeEE6iQ
 /L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785842827; x=1786447627;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dbDnWGGW2HsrNhIlvkFHDAnnoVz8msOyPyf5B4Oknqc=;
 b=smAF9LUwZIVFp5KJaNFlGp+eU/KBUvUvAXaxZU4J6Mt4EtmEHg4t8xi/zepSCOt4S5
 fh4qXdKznlDOeckOQFT8FE7tMgfNz+/sopWns/3VXuupciqYql58cie6HNjwyVFp0KWK
 1oomjkf/W1FdZ5r9XVE/m2PpMOdfhVasP3vRVKY22hgnmuDdkQL4SyJ33BMpB8feou6m
 DiwDav6pP5o7rK6gFTwhWMGouqv9BbBth46jvW/nwZEhsncfFFQDsS1RUlRQ5NpIHGsD
 3VyYmqYziapKJz/huABMdV5eztUr2CxXne5tsBps+9cVZ5SnkwELx/ztKFY41aMzVBi6
 F5yg==
X-Gm-Message-State: AOJu0YzLhw1PxVG4Fp1WhKGnHr022pgziRXARYCsPeCzojIyg2DYwS0a
 m9k9gVrDvChguqTICN5/HXnqxsW0Cf8PliFmSR3uWnWOYVRY9Qx4GVmU7zKC/2xzox/2Y2bVLW6
 5W8bF/js=
X-Gm-Gg: AR+sD12eUPa1j7YrfB24DLf2GNf/8RvQzTHaH0r58MvxjaGzz8a178dk8zkpxytxYaX
 G6p8Ba9C9tbN0RaRWt9YWOs2aX8R2+nueWastHb1J5BlXNmbppqgC5Y7YSLkMKkrUMlvtNiRUto
 NC3/mx54XK6pjKsbFR7v1lwUD1hDBfj6MIJYW4bx+qGs1OaC56gtCesreoU6jrMgkc25gg6zCgS
 +6ZCTeYp7YG7xQVuExw0phuHAyWvLeHfKnoiNTZMzRWmpaY3cuSGtEBhF0no5ll8+4aDcJA6kZF
 xqyf2j8HaF4FK8LVTt7m4x03szAs9l3UV/KUpZ0VmhKY3TYjWKwEDJ6oxfzHBhw86oGDHDHuT1p
 axGlamDoAUT/lWEfgqUVPyMkIf2uQKJuKqiEoa0nYAgc7ft1mMd0DmZSo8XY/2oXOrJSzg4DRbL
 g4eGBSc6FfRJnDbJXoYuDbRNB4VM7oKNOHUKmJiu3VSwK2ozcKz5Az0ADazGTifZbOsd2tnW9mS
 bb5V78Wv2UcD/BrYxlzkLf1oo2EqfRjx6+SktXKQfqOLpu3N9Ml5DffZAJSVcx8JPIfPtwCp532
 oOH+Qhzc6SNE4DyzWxQRzejExlA+5DZH1nlOPQ==
X-Received: by 2002:a05:600c:e548:10b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-4980c649c63mr253668925e9.6.1785842826619; 
 Tue, 04 Aug 2026 04:27:06 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fd08dfsm95238055e9.4.2026.08.04.04.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 04:27:06 -0700 (PDT)
Message-ID: <6a71cc8a.c5b9c171.110ad2.4b49@mx.google.com>
To: "Yeswanth Krishna Tellakula" <yeswanth@linux.ibm.com>
In-Reply-To: <20260731041949.26465-1-yeswanth@linux.ibm.com>
Date: Tue, 04 Aug 2026 11:27:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup/cgroup_core03: convert to new LTP API with
 parameterised subtests
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
Cc: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yeswanth,

this patch is purely AI slop that is seriouly difficult to review.
If you _really_ want to use AI, please use
https://github.com/linux-test-project/ltp-agent that *at least*
configure your agent to use the right rules when generating code in
LTP.

The patch is rejected.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
