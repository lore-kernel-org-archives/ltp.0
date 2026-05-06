Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4670CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778070456; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=D6cdai5cHQnF683WXKgLf4c6DeTZP4onqB3USYaW4nU=;
 b=RCHKwpRtjCFfClW82B1ptJ4acBNRKE4hJK3+gCZulPWvzOcSmpJEh0JvHf+cZE7j82pJA
 QKogsAjXczwVQTVInSqP3+yX8brre2H0moWl4XyPqr+aIDylqP+XyEwN5GYCniACAow7MoX
 Ye9eaL75/lTCLj4m7j0bfQddn+zkreo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EDBD3E615F
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:27:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E81E3E229C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:27:14 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 23CD81A007F0
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:27:14 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3881965f8f.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778070433; x=1778675233; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=s2BgbTK0NR/l7nuDNtbRxBVawmeJbVWYq/tvaHfpIlY=;
 b=ULfzj18XwPMMngxWY0BL9N0HrMdEj61YZXXK7XPJDh5wA9XkT86nMYRhF41mQ1wSU8
 27iOtXI+4qxd79dY1lQUwcaOso4aInWneqKSDPrNjm4GbXWmtBkw9nbWtcSHaG1+l1tI
 Sa5vGjGa26Ze3OXwX6ZsPm1WuK80LmKOIqATT6LvtKkg/oMKoa95ahT3AoRJhRSn4qSN
 t9gOXZb8r2t++jImPfH/dVLrVK3J4AFnCUH74AhCa8WOt4rE34dSwVySAOy5C+EHvxNE
 s6XAG5Mg72kns8k4HKEetDAGCTdXsoqnsVTT7+DoUTWX/AV5HL/8XDkieOCBGeAz90h5
 c8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778070433; x=1778675233;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2BgbTK0NR/l7nuDNtbRxBVawmeJbVWYq/tvaHfpIlY=;
 b=auP5/aWgb52pDsMNKQxU0xRddFAs84wCyGhA9qY6z3GrkvYcBxb3Do9Xkw84uxujyC
 QpL6YbbkBUkdu1JIvOg6aj0uSVmCCscnupO3Dn9CgrCxhJY0x4IHZrYx92WyoqVOn27E
 lMBqs4L5IKkx9j9nIxnjCviUauOkwQICfRxbnzPu4+0Dhw8sdOpRMjYRO1MbumFi6arm
 ebtOA/1v95qO7oLbbnOJ/dzF/e8TIMKPaRwQDi5hhc79g+lGDt1qNSve77wn3XhaF8nF
 R99YCsxPzOorid45m2lZpvXTIgyk5Ny/xKejwZP5OEKaYlCE4dECFKrlncrfGnzom0mO
 /UPA==
X-Gm-Message-State: AOJu0Yz/OZ2zB6fZG6NxMxKAFz9GLsFgiqQbGFzYwSAOQVJvIUeaNCq7
 34WxK9uNstFxy52mZBDEHRJpKOI5wYopyc1mOjP3mVxq1k6JX2mOb3DY/1JcANnfJLMgUqnK1c5
 MgSR5Avm8Qg==
X-Gm-Gg: AeBDies3l/mJTsebCXKDwX9S+BZipnwm7pBAhcPCSBy/UpigRytRILWcufuRunBVsfT
 FlljC5Wyc8b9LTh7Q1sAk0aetPGaT5jA2uQDFps4TNyaYEeEjB5nHS8udZYqsXW6YM6BbjE+fRG
 PsUduZYy0uiBGTBK7+IC8t1ieZBdbsjnbA/y8D3p5zFjRSggQlytWG0w5xmL4LUJt1lpjW5XQvM
 yal053Ll0OQlnwlzQPXtFD7qbBOpNvXF8nyKmY3ejgX5w4h5LzTJgaOQ+JUNRF5HaW8tHPH/qc7
 0K4AOP5125rHH3OkR6wc7Gilv9NgPqhxy0lx2YXGLA4JaVkSYLIduvm3xZW722IRrWULaWoK9M3
 Zi5N4c/INrxAmznCKM1zbx+C41fqsTq+8r6Y2WikZH9SOTbh+l2SuAkJ8CLQo8LyWN1/HbLc/zT
 wvJTdYFfiaKAXXno8dAC4sUtkJe3QTHCNp8ewl0P2+efoqJH9OeJHkPiBHOfJC8Uw8DdXRoQuLV
 +zIWU9S3eTfJbXM+eykW9cn/I0djEVm54XPj/lkbHQvPccru5MBzz9ne46jjFlLon0izZ9N2pB6
 0BQhgKGEXHoc
X-Received: by 2002:a05:6000:24ca:b0:449:a07a:967f with SMTP id
 ffacd0b85a97d-4515cf127cemr5673066f8f.28.1778070433381; 
 Wed, 06 May 2026 05:27:13 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960902sm13619026f8f.28.2026.05.06.05.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:27:13 -0700 (PDT)
Message-ID: <69fb33a1.5d0a0220.337e29.6038@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <27137773-c7b1-4e69-abda-7a5f422ca837@linux.ibm.com>
Date: Wed, 06 May 2026 12:27:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] io_uring: Add test for READV and WRITEV
 operations
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 06/05/26 5:15 pm, Andrea Cervesato wrote:
> > Hi Sachin,
> >
> > is it possible to separate the test into multiple ones?
> Sure, can be done. Do you have any specific inputs on how to
> split the test.
> 
> Split it into three tests, one for each of the following:
> 
> test_writev_readv();
> test_partial_vectors();
> test_varying_sizes();
> 

They can be split yes.

> 
> > Having multiple tests scenarios inside a single binary means
> > that (often) if one scenario fails, the others can't be tested.
> Got it. Just curious, did you run into any test failure.

No, mine was a general rule just in case we face it.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
