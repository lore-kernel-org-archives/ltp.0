Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69939C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 21:09:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663153E9A7C
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 23:09:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37C7E3E18A9
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:09:19 +0200 (CEST)
Received: from mail-qv2-x0b.google.com (mail-qv2-x0b.google.com
 [IPv6:2607:f8b0:4864:33::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0E496005DC
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:09:18 +0200 (CEST)
Received: by mail-qv2-x0b.google.com with SMTP id
 6a1803df08f44-90cdfc57039so3938166d6.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787951357; x=1788556157; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPKy4X6L2eAzisgSOM5bOt4q6L4CkNRfT3xPRwqK2YM=;
 b=NxTzOQdIgPm6kvUS9r1l0JZkYZjvOQJN0/eD0gJkCtWZ/LqS0cPCeEZBLMv2NAmS2w
 CkbC9Iz+scVEbbjgJdaa5Zd10HDvAanoyrKLXahhATSPtgEdMBvA95Qe932GhGojNE9i
 id50IUIMLNWYq9ndSWkjj1MwF1yAzqcRAJaj+6kt9gUYlNhBlNd3tM0l7txyb6g3atbt
 yq0tcSY2UZez3rV3kanORzAu+0z/X9AbP/NgTe1hnesbQRDL8idLUnq7R19VyP4WueyY
 /zg/RQx50OQ8+UbUNgXkAcPb8bAie1zL422t96KOT7B5K96he6qkICFb27DZjKXvHWsm
 M43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787951357; x=1788556157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LPKy4X6L2eAzisgSOM5bOt4q6L4CkNRfT3xPRwqK2YM=;
 b=HSCiYC4sztbMRsJIQwLQ7blBi4MuNF4rL/DLaWJQqJ0EnmjRy4cn2nOdssSy2CX4dJ
 jYus+xjdD/Dk7J1G7ZJHcJ1TSOGZEmECQ1ni8qNYLn3gegktfXYBA1ydZ2hkaxgldey5
 MMGIyq+LkzsROS6GlGDFXonct0dSeBYb2cYBqdqG1fIkDINsgNjedUHbTYWf4HVP16uv
 kORDni5k8kBVXZDFH6BlMe0N2ZRgdj04E0f1UWvHZOGovFeUJ7A5CtGiIwDOIouCqE6D
 ZPGI4dakAFBBG5iURZZFr9kQJPwbtEBETf1C2Or7dHqAQ5xiiP61Si7DdiLmz5nIGCPp
 IzBA==
X-Gm-Message-State: AFuF++n/8rV6y/wUSBKh9B9fD/OysFLDU9I+We3gzUqO5Id1csvdcpht
 XhErP6/l1ftU4UncW0Qbxkq2eGnh23k3iAEH1imVRVxRvkez+l1PQcnK
X-Gm-Gg: AR+sD12PXUusfkPQk/bVQvGBZSgzzHQGxH/dy7UEPytIXtc3AOE/YoOQqltlqRNiE4u
 ygHD2R/tcaHxd5j5eY0aFUZS5sFss82fncljMA5/aFz5G+3n+LfdMMtFRAE+zEVpSoAheJtXmG7
 zRUd1jfPlXDmDt45CM2M+QCHtz+ID4VVowCGQYmoN8Ny98szqMT70Z1v4MyJz1EFTCmeqToQNak
 uZX51rY+z6b6hPbNr2iMocrrp17XhkH0ds5vrO8eXR9SAPRY6R0N7ZB7j2snC7N/3EXXNd7g/pi
 5vX8nI2VPpAuRKVyayw6O0iLZHYOLcv5CzRl5Cl680XmYCg69jvayTARxfByVuDll2QgS32hxv2
 C/bc09LYZO39rf66/duHO/NWdAVg5Met23r5hJ9fSOrJpcbjx3gmtb8/d0wzeCYaVS8QWMU/4Ir
 B91fjHWfHXMqgVtcZOhl7N510eYTnzzRr7U01JJQLAX00AhmE+hjvmAZ/MrqNuZglrCH2yy19Ip
 eaQ6sJQb9Q3LSqK67ByiVAlqXQBety+LDMRuFN6SOlYNF0YcZGLk7xm/WByGqGTQmSDypyMQ6k=
X-Received: by 2002:a05:620a:284f:b0:915:f96b:8f5a with SMTP id
 af79cd13be357-9391391ab8dmr1271682085a.36.1787951357184; 
 Fri, 28 Aug 2026 14:09:17 -0700 (PDT)
Received: from
 runnervmgx7h7.antyuueavygupldq0djacz51hg.cx.internal.cloudapp.net
 ([20.161.60.97]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9391723e87dsm231912285a.15.2026.08.28.14.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:09:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 21:09:15 +0000
Message-ID: <20260828210915.9031-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828152631.254653-1-avinesh.kumar@suse.com>
References: <20260828152631.254653-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] uevent02: Make wait_for_uevents() order-independent
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

On Fri, 28 Aug 2026, Avinesh Kumar wrote:
> uevent02: Make wait_for_uevents() order-independent

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
