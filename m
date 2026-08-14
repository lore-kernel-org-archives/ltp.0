Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A169C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:52:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB58E3C73EC
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 16:52:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20A2F3C7297
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 16:52:13 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A4FF4600865
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 16:52:12 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 d75a77b69052e-52838fe2172so2642001cf.1
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786719131; x=1787323931; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1ylSdHHDTKJXSPD5YF78ZtydNJvliM63es6tOh2+uU=;
 b=ruTApCYLFawmLd/euB/uaJZcS8rIjnLOcj5wE6tCou4UQvpUZou4T5AWTKIZ8jv/pC
 AZfX+9hEbPJuCH4U8YPX3QjfTDMQ5DpSV0j4vGQGbtMMpwG9h4g8uqt29LA4eP8LvNrv
 dzLcp5jsGrlZrTrk4Q7Hj2EQLurgXcU6e2sydlmxHWGblP5mtH2TClqv8ULrERkJigng
 qOPkIVYzmtrszv1hR3sY54fEY5EPK7QfbBmGSG1vMwPwc0sTo8xAByy4JERObinyweOp
 UvtBn8LOU/yfR22gADuXgh+ZQuZFNQRWQL1EimNiTzFr7aVjXNHTBtfwfcZ5PrNxTASv
 2Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719131; x=1787323931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1ylSdHHDTKJXSPD5YF78ZtydNJvliM63es6tOh2+uU=;
 b=MY0RGO2sUkddjs3wu4w6YBiceZENA3CiUJv1cM5QW5qanFy3LqLmivLKRDjnKGnk2V
 5j+csc7j13fuinaUowMns4atokcXzQu0u7prf4Egrsac7SPx2WDQgEQXktkz4m42DQV8
 1epqDtTdhRxcviYd5jPCjaJdYd4IYfHIOhUXFuiwGOKJSZrMwUoZvMoDz1r6Z6uIq4wR
 p+F9lHwMNkCyhVK8duxXedUKa6d4lJYF/xTLPVlFL1fSquEXu987zqIk2+bFDeBGQiVA
 WOcB2p1epzqUQe8Mm5GRFpCiqHvOUzg/xjbMJA1KPD123l3CeVxAF/D83HkoePecMtn8
 f6Og==
X-Gm-Message-State: AOJu0YyMQjYjSAgdPkesukNRnLe/QXqkhk/sMjGrmWpVeYhH4VXLkbMZ
 q3xxvV5mOXFd2LN2Tb0UTxxk3fdnpJPw6arhB4ilFNFbPC4BknXIS0kO
X-Gm-Gg: AR+sD11vED+GiIDhj3Xa63VqdY9/zcFXzJhOctamFGODoZ/a2PVpG7O8rsnbIWpo/fB
 Z2YMZ2PH/a8uheZQ2wHy/xk9eJ6U8kolGbaGtNUvCoAgp1SrfU0RHswjwLsECEqxy7BZbQ6xIKh
 i6+pVYbY+aUJGEjtXts09dDE5rd/TNvaFqUfEuE2JgXtMbVJxmMNdgdU9/ja6eRR5DaGYrJm4Dw
 rtYTTEr6YujGci5dRdLFiYbaU46E5DHOQj/8/ekMVE4mX3CJUZ0asl+fM3nFjeP9uwMq6XIIwG0
 Rb8yiqbW4eC8m1Bg0T+OiNrmIlvMryKG9bYQMUxmtGbpn+Zr7VGmoroo31GV2EbFmBHARDknVOM
 JiJ7OfpRgKM6pB3OcFwzXiAltAzGqHv0llvbrVL+VvxWXLFEPw3zllqCi8h0X+9ftLaFF3EY5Bd
 CJNb5H1CV3MPGQdJb8gzaXDziq6Cn9PAyNPgdUnQ0BQclm0MGEuqkl5wDTaiDR/hSsp5b2xPc/h
 YXBUMyQgWycSK3AL8A3r3gs1XhAsMO920MJftnfd7OWFd0TJyBp1QbB5voWdJKIu03H9jkGy8Yg
X-Received: by 2002:a05:622a:1e13:b0:51c:6e:ef23 with SMTP id
 d75a77b69052e-52d8551d1d8mr78583401cf.32.1786719131165; 
 Fri, 14 Aug 2026 07:52:11 -0700 (PDT)
Received: from
 runnervmzvulz.gj01ltki4gye5hz2yad2jjaq2g.bx.internal.cloudapp.net
 ([57.151.86.245]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a92201f06sm20767536d6.14.2026.08.14.07.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:52:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 14 Aug 2026 14:52:10 +0000
Message-ID: <20260814145210.3861-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814135704.1247403-1-zohar@linux.ibm.com>
References: <20260814135704.1247403-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_tpm.sh: update test2 to detect integrity violations
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

Hi Mimi,

On Fri, Aug 14, 2026, Mimi Zohar wrote:
> ima_tpm.sh: update test2 to detect integrity violations

> +	if [ "$num_violations" -eq 0 ]; then
> +		$cmd > hash.txt 2>&1
> +		ret=$?
> +	else
> +		tst_res TINFO "ignoring $num_violations violations"
> 		cmd="$cmd --ignore-violations"

Could the failure path of the unflagged invocation retain a retry with
--ignore-violations?

The counter read races with new IMA violations. If another task triggers a
ToMToU or open_writers violation after the counter is read as zero but before
evmctl reads the PCRs, the kernel appends a zero-digest record and extends the
PCR with 0xff. This invocation processes that record without
--ignore-violations, extends zeroes instead, and reports a spurious PCR
mismatch. The removed fallback covered this window.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
