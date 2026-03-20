Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99C41098781
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774011317; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KWbXW/MrRcchBVVtfH85lWIjjb8X7nZmsJ2hs8JjT7g=;
 b=hBa0+5OM/cL39cGECdTogqoV/NnQhIWvk2b+jU67tpa4L9tGI3YDxnoULJm+isoKaJRf8
 PdYx71NQ6P5RRSrABgzde1oNUnDGh3Z60vWh8j4L9p5INBVZ/LFbst3QNnA7wb3n16yPyQw
 69UqiZf8Hs3nPWz0Pm/4JZ10lqJWclc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8064A3E30A4
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:55:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935093D06E0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:54:53 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E31C71401254
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 13:54:52 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso4717485e9.2
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774011292; x=1774616092; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g01w3s17rXVfThYeDQK0nkbVMWjmfUT7YTK+l+Jo8Ys=;
 b=Zg77m2aU22hJx6NzGbWECtmEWlYX9peGsTwsIN8VVjB2dNcK4qc0Bq5LoGFHni4Wk8
 KOkADzpMO/ioSnsJP7WNe334AEC9AHmpFgjRgvkouYBOaqAyQRD/2wWfLhmyjewGo9Vd
 H5aQD05ie85XH94NCPfUab4SMlo9mt1s/+geimE0Sk3xvLWXEoWGty/4FpyTl/G3bh5N
 xc+lnB1LyRYYWQpL6W5b/669HYSX8Jf9HxL4PQ5k0+o8o9BLIXdK2AS9Q0Ef5GUJaWdF
 CIZuRfta9db9j3CFU70jj6T5s5BWzTLzIUtyVSVCOBn7zxrVgWX8IJ1bVnoIjbURFPFj
 Sskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011292; x=1774616092;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g01w3s17rXVfThYeDQK0nkbVMWjmfUT7YTK+l+Jo8Ys=;
 b=UFZstrITjgX1jphp6yYGg/2sjluQE/PiDqcXN6P9hKlkYVETziFOsmgdCl+g1bD17F
 n5g7Xs6dI+idWCCeOHMqRX7ysMG46NKRtezabEDH5h4MNqlAsSxnun9zxxjHL53WThbz
 b94MQGIk3RCy35j67dj6XCFiwRwnPRlDe3tgfLrGmi8ceSM22+PDKH7w4gWLPCFOrjX2
 MZsnYBSbggnwOwJ5Sr6pUT5agSjvxc8lQogCHBoGVPfJiUzXfQnWiqY+iEyWYZa9T9T1
 ZmxXjyESiyVt/UeVYtA7dvtLtLkCBEIqm6ew+n0nrdSGUaTPmnxLCMWM1dF8OMK9/vZR
 2BMw==
X-Gm-Message-State: AOJu0YzYCAbId/BEPZgYxXhtum3k5EO6Y/0vb7OF6p8N2KtPhkAqr5dS
 tfOnhKRbvRcOZxRvg8FhdeAHNyulcYQh0f8RuvPMWu9Uf+H6DEyHWsBsMqeHTqZylFw=
X-Gm-Gg: ATEYQzyJ6JD7LQM5byccf9EqHDxSq0qlY5AiH6AtJBnlG4iqGVRIhi4FRXahq9vA9YJ
 eBn7G67lMqxEixEmWtWE3OEH/eaPCuEKQVZ7kYvGwXlFmO8i9SFlKRzPYnF5grTtRd10D9BTuCi
 uPtfRwkJdkttv4KgzD9jDz0zNUOx4UVA55lN8QaFezw90reuTi0mWlHQT8d26slDRwwkTM0j3xo
 oGjppHe5duvPFAy7X9Zun3WkbqG/JSGQy8g3cHlqPoGcyKFALK/F/dEwXSiftzrZ1/X1e0obOEm
 lYDiV09lXXGPi5WhVJNq4/cd9uRd0dzCvZQ1/Z61hl9xAp8ODadxWYRGGWVrDa29wBwt0FcPVYI
 icL8GDO6lXB/HOgbAATMBDXK1Uov21pwsmAupgmQSZpfSZxkxC/DspFNFAMZNr69vZ5Od+PzaFA
 GF3nqcw4/0v1riGyRn3wQRe68r+aKMnlqDT0swQX/Moa8FNcw=
X-Received: by 2002:a05:600c:8b18:b0:485:17a7:ba0d with SMTP id
 5b1f17b1804b1-486ff01ca39mr39364525e9.32.1774011292145; 
 Fri, 20 Mar 2026 05:54:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe89b781sm16251555e9.12.2026.03.20.05.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 05:54:51 -0700 (PDT)
Message-ID: <69bd439b.050a0220.6a7c8.8a94@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260317114635.944-1-wegao@suse.com>
Date: Fri, 20 Mar 2026 12:54:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] io_submit04: Add test case for RWF_NOWAIT flag
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

Hi!

> v5-v6:
> - Changed fd checks to != -1 in cleanup function
> - Replaced errno with TST_ERR for LTP macro consistency
> - cleanup format issue for aio_abi.h

This can't be the body of the commit. It should be after --- as a patch comment.
We can fix the commit message once patch merged.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
