Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59C9108B8E1
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773999547; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KBN5/HQleQ0zKpl0SBLMPySnp4FgpzRG9L1tP09+1BM=;
 b=DhvQnXT6/FDHm6Pj39x152tidqrU2Y+4iM2Y8LAWQUCNV/Rzm96JZZ6b0z2+ybRtupq5Z
 pygMbg6LJbKHFFwEtR9Z2Qj+AmjpSFYxgD15Us0BD1DYcXTVTJpZuhvWwcaIh1DhsUGt7tm
 2gjyP8Lj3czm1CuWSJR64nRx5eaPYfU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 393BA3C72BE
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:39:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82EC73E180B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:38:43 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F16466008DC
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:38:42 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fb439299so12702035e9.0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773999522; x=1774604322; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sjcXOGW0J0OogKIHkNFJPDSDeACeKekNHjDEU0S3Ux4=;
 b=g8y//lZ7eW4pgaTMJ995KP3800Ix5PvBZrjsuuSK55RhmOynzY5WMwVjc3WwJR7R22
 1STfipuc0n4pPFdC0Fg9yBMmSOtXjU5mMTTYI19MjUU7IAx2sogB0P1ux+fISkqdzBDc
 WNPN/+Kd7cLXMyNkzsN95TcCk9jNxmba1yIm2OwRZjGEGM2wfF5VfzYdlLz2yoM6x3U2
 gT3yO6KWWIc5l9UjrYenE/WcEp9Ezh1QEbYmNa7VM1T1HmmvOgvJTwJ3ZIxcLCMYOnSJ
 XjtZjmBkXiiQ6SIdf93z0rTlA7vvn3Y29/L0qWjOO9rsepqtgfck7nXLd26G44B4UUMM
 KWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773999522; x=1774604322;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjcXOGW0J0OogKIHkNFJPDSDeACeKekNHjDEU0S3Ux4=;
 b=m75fW1XG+FFa0BkuzvOY94//ZLbLiE9fW8DE3UAZMeWHi4qeT1cBDp6NCS2tnGAVOK
 TyGtautfk0jt9FSXOeIKj/XsL6JFeHIsYmrmy8kJnqGEtRI/IAeMCgRb/AY+1qsrhxRm
 vwvCi6w3CrHIJpcFB6JSVfRa31+x5eKQBwu4rXQHZQTREzVR9+t+XNoDXHHXTy2YNNhp
 Ct26972Jx1fBV5yySUJ1oCrPYb8VY0QNr1CGP8b23e1wAbtd50LheZUvFlLZbJ3VZVaj
 FqSsjMlErySc20ne8jOGtRWjo0ZukOeVGKbfCj+meQGgA5ROlW7ebRDNnK1GqP+aU0HM
 yRvA==
X-Gm-Message-State: AOJu0YwMfM07LjCYX/qeA9QZaLDsWXg8lN7r1ShDxFYJzDej4eZq1Lxd
 wNUxgb53LwCVd+h7hWlkbVqRirNMellsH0yvZMcj15nWVcNtojtMupSBy5/LTxVSgRw=
X-Gm-Gg: ATEYQzzFZJky8eZFSrQsP20hlnjIujFep6jSO2uxhofV7PC5l94NcNmN6WkkGj3XMuw
 bZ175yWEQen2n/TCE5nSGjXissSiIeJtHGFeForsqJAXxjvcn4YVz9fpxOCXgFp3uuqy/MetmZU
 H+D9xVsaxoRqw8nYf/C+A07eMHlOiFseZB/i/a8S/kSXC1a/X+TJ5mlzZb7eR/sfNzsePZe2onz
 HEpL1OphLTXWbnKZkxTlWZFa3RNQqGvoJCmeopZkN7+fB1Q3rz4WGn+GJfw/u/dP0/gCyrbTtkd
 KdDC2QMq8lu2wBpCcUPqF7+SEpqGVAKMHlhnwvarGf/y9Gxp+mLsQ4Bb+SwyYktv+RRig0HoXFn
 RnE23KfGg1vPuTBEBoariHRw/tfWLIwiA5dqYbjdBB968Kuwyp6Yz3xbIFoxITJdELHoif5Y+ew
 Sn6J5J79kddWH6m2Sa/rzZS+HslUwNtkaj9lzT2w/LtNOfmT4=
X-Received: by 2002:a05:600c:1d15:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-486febb7648mr32462695e9.3.1773999521944; 
 Fri, 20 Mar 2026 02:38:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7e2665sm55934265e9.6.2026.03.20.02.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 02:38:41 -0700 (PDT)
Message-ID: <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260318144113.30981-1-pvorel@suse.cz>
Date: Fri, 20 Mar 2026 09:38:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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

Hi Petr,

the idea is ok, but there are a few issues in the implementation.

> +static unsigned int tcnt;

`tcnt` is misleading because we are already using the same name inside
`struct tst_test`. Better to use `tcase_idx` or something like this.

>  
>  struct context {
>  	int32_t lib_pid;
> @@ -344,7 +345,7 @@ static void print_result(const char *file, const int lineno, int ttype,

print_result() is used everywhere, by any tst_brk, tst_res, tst_vbrk_, tst_cvres
etc. Which means you will have a `tcnt` printed everywhere. It looks better if
we select only the starting message.

>  
>  		if (results_equal(&saved_results, results))
> -			tst_brk(TBROK, "Test %i haven't reported results!", i);
> +			tst_brk(TBROK, "Test %i haven't reported results!", tcnt);

The new prefix printed by print_result() is 1-indexed (tcnt+1), but this
message body still passes the 0-indexed value. A test skipping its first
case would produce:

  tst_test.c:1738: 1 TBROK: Test 0 haven't reported results!

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
