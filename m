Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9106DD0C84D
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768301301; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kW05Izk76VH9PRHpme+Z2BQ/HNMtKz/nbO8VhmGBLqY=;
 b=AzDtrkkHEwi4l1bbYJWUpysFlFfAwVq5ct7Eea4Rw0b6WleDvfps30X74HYpbEx9sRfyt
 WtKKjaPht7zzScgfdUOIZ1PTTE8u8oCp1pTS8DUtHPeKkxhAoRJlkS9cbdW68yRLiGrOVi5
 1ms79XGbvsHbwDwdG6hPG3m4+tZm/UY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DBA23C59F9
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 11:48:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20B8A3C1428
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 11:47:56 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C01D1400987
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 11:47:55 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so51021665e9.3
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 02:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768301275; x=1768906075; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmiHuZjV0nrgyPjA6+mnFwihUZC56qwTN5OeFp3YyWs=;
 b=Tn42D22OOBsWKzc/kc2erssev42f2oAIjKjXIlpFH43XccVnpkPrSpKJaI6cV0oYWp
 Eda96bOcnwmgAnRgpU+ka+SjHXMTB/oe1wkSwDHobG0gbKfMVWgqaS79C792i3D3ZuG/
 qZaXzJcy072cJIeITHlei2ax6KvY9vfZotIGN81vN4H5cXuiysOnsweumt2le2HHA6Xn
 /GSN9OOQtmMIqFIPMcVcP/Gnhod+GY8glDSHRadwaMVa5AayIafF30DnGN3Oh96aAdVw
 CfYocWmsiEXZUO9ytAII4cnI6MqyIQc1VvnzGlT2+moPwdb9UdvaIL8tTWjC42klTrYB
 TBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768301275; x=1768906075;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GmiHuZjV0nrgyPjA6+mnFwihUZC56qwTN5OeFp3YyWs=;
 b=EXbnl7ewXzKZu7VUxozkTTwXi83JGftxMT6yGkKItUfPcrXWB6X92VREQIbz9ivZab
 mzSUHHH+84Egi+ZDonmvb2CRBeLPLzAp9pFDLFqEUg5m3q0P2e7E1iaGhap1Eyw2MN0V
 HyBYgOXhPz65vax4P++16eSMuuexXEQvPRp5K4haIXcn4J+tdN+O+aAy0sHTp972aqDq
 mO65sJrYGV0C1mgmczxybU+tSvxDGClKENmhHaa8pooPGiJ4BD9KwowRSPeVCaO4Bb+p
 e5p9k2LN3uMQgbrQt4XSpa5M6dj7hQgOrsFMqyMakk37DD1Da+MkhMEEr2Jv3qvztzc1
 Etjg==
X-Gm-Message-State: AOJu0YxcGxcOiHX/zq9ZXzvxWwSAmaNPTam04vLfWKGxm90eqR9ctllZ
 ITHz07XKOl3jqXAJ5N/hwt4j1y+zbKrWth4i8jQTfIA6I+RqRQ3r2KrYcc3JwHcE+1pA0+dVVGz
 e21sHfUM=
X-Gm-Gg: AY/fxX5/qE8NTb7eDYUt+pzM95XILHjVfU2frDBvdiZN1vLYzsW9XjZiqZopQ7dyMm6
 mfqg9KpScflVCrae9yT/tVUyTu+SkcSxISSqCIG787p2Ni29GBSqFYb8VeNI9NvJnKwnOT1JoAs
 SLrntBnxFEbEnWByQyp94pkHM3Yd05gfbZh97SZFSe+fiy+KfwupiJyrIh9EiKGh7OxpWd3kyks
 SPkw3t0zUs0gU2V3sGNgaNeDMqM0uk3XcvfN/MpgFMTprGMkGr8b9oU7lE0PyyHFwd+LsxxyL9N
 KzwxmuoTXoXKYMs5eBzTa/1xpOTKwfch0o6VA9BnVUuQP2ifGclgw4MtHNqZDGbVrEfTrOyr3WJ
 CA6NV8QSRl2E1CmUPuYRpGM6K8x+pe/tcQXjOMK8sugddB9NoJy2d3avnI0r0LYWf4qXtPPYY8a
 Lgj3kSPJkiGXfk
X-Google-Smtp-Source: AGHT+IFTojWqrKSL4x7k6HkqHcaMVJsO91A0HInw6kOGhdX3f/ku7fOQbnGaHd4oGzUtAdFRcO/SaQ==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-47d84b4a815mr257430595e9.32.1768301275281; 
 Tue, 13 Jan 2026 02:47:55 -0800 (PST)
Received: from localhost ([88.128.90.24]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8384646fsm365512245e9.15.2026.01.13.02.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 02:47:54 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 13 Jan 2026 11:47:54 +0100
Message-Id: <DFNEHIUBYEMV.2WKG1TQ0KDATC@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20251218-ci_enable_sphinx_doc-v3-1-9923a2de1b4e@suse.com>
 <20260113104323.GA308851@pevik>
In-Reply-To: <20260113104323.GA308851@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ci: enable doc testing for new patchwork
 patches
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks, pushed


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
