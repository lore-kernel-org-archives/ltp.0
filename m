Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D960C44512
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 05:59:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B26A23E55A7
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:59:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7325A3C241C
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:59:06 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43CCF600AE6
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:59:06 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ee27aa897fso69665906d6.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784699945; x=1785304745; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMv5iqrCzDHNt66rJupwUvGUYR61g7RolTke/Gnd+L4=;
 b=eEOfkca15ODf3n0+67/50U/jAgHPr75/hBH7DpLE+kNmcb7M4g253t+L1ajAlEXwGI
 Z90rFx/kkuNkdt+vj8UhqIEuJ9bR4Vi8uL/oJm3aaXSgAxCQ/ASTBG1dQe038E9jzYcx
 USLqnwhxyni/mhHg3yDo8FrD63hoGDZLRRlu02tzJH7EukjmkwSXfbAXW64l6poCjKDR
 uj2R8WA2e+Vv1VPkfqScEDfZz9BmomBk6GEC/sIZj9CXthvaaqr0uHIFNiG4NZx0qxg5
 a3nb0A1ma3eovnPVHuuER6whrvc3gR0vz4hjBrqkAaR7/PPUXBVzzSDgY9a7hWa2DDu/
 LSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784699945; x=1785304745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xMv5iqrCzDHNt66rJupwUvGUYR61g7RolTke/Gnd+L4=;
 b=PjJZzsj+YkcjUG/MiNr5PZwTKvAYvnZWohXJg1WH0o8rlhdDrVuxc4LraFeWNF+1xu
 ekMVS7A+3ixUgmukPDz+AcKfGVwvupSHsttnAEDqZ/LWQ91ogCS++7VucDWorjCOq1uc
 gUnQfDA5rYe+1sPvbglEKu4+92JrwWZDnwy+X4dHWWKUC1N/43o9/IMYSwnrtdUb1luR
 KXvuS0WiUD1fiT8LQUarmDuCt6tuhRFZSDmdqDvBX0ectXsRwZ2YmW70GhrdvLKzGYBY
 MP1PKepGSlbA6h+VqTHPLI923RzuAP3D5Sm6Rfb6BEiyO0bRf+s9JogFko78Y6YZiTvc
 uzzg==
X-Gm-Message-State: AOJu0YylkyvWLY0ccj6DZpWeVrMGvy2bBQOKbMN+LBM4PxUsTRju++3V
 0SPkGnFsPUC/8OpQlMYBx+9iQm6NoknIJofxC0mDMv9betocODvrYs0q
X-Gm-Gg: AR+sD12N45EfFIuCFJ16iDUY90sBZucsInqiwK0mWEpXxTo6/jU9Il/ImzQpisED49u
 XH8vVW+WNBCE3y0OchFiV0jyAITkhxt0yZrGJdaVP8Ijz4Kp8kUZLUgQYs+SDVdAZ+SSjdZrYXy
 vRBD0oNdu084rV/IVWxvaa7iLQ+pXSYYaWC2BmtwENMcrzR5tcDfaCjjCnB40V7qvSK3Jeqjnm2
 rtM/IzhSL7ZUrgvOvi1MTgqezoM6bnLZ84RDrFTfteiclJxGEpB16UXs/m/wadI4InZcuBpH8b6
 lym6sNpSRyPMof1XYkbh1QE/dueMhf6dyGkx2dvX40/jb9NUCcVeYPCd12I4DMQmxja9nFhb8as
 v4rZkSb5FNJWcUln1jrPzZRYGAr/5bfNfCbxg5WczxCgRaSk5R6W3DCEEuMYo1WxxIXs1Jx9Jkj
 ToX8wArHmz4bygynWOq4Id0wi6Ho5Hq7vMr+1cbzcPfoxbb9TteYKlKHN3P+d6MbrHsZD5t1IxU
 0OFC8gr3kQqMWn3iw==
X-Received: by 2002:a05:620a:2552:b0:92e:72cd:32f4 with SMTP id
 af79cd13be357-930b43157ccmr2162042585a.64.1784699944925; 
 Tue, 21 Jul 2026 22:59:04 -0700 (PDT)
Received: from
 runnervm3jd5f.f3puv0spyjrexgmmrdyyiudxgb.bx.internal.cloudapp.net
 ([40.76.191.162]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f6872a59sm86258685a.3.2026.07.21.22.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 22:59:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 22 Jul 2026 05:59:04 +0000
Message-ID: <20260722055904.8701-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722044732.3547-2-wegao@suse.com>
References: <20260722044732.3547-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid
 success path
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

Hi Wei,

On Wed, 22 Jul 2026, Wei Gao wrote:
> lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path

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
