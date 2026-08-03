Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AAEC55184
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785749053; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kzvcNSGDvMIQl4l47wwVW/BYUEtfqwKzX0SxRBZ+XHA=;
 b=LE8LBKRDJWeMdrBINEb6AbWPFCL6NAH0A7pSHB8fsDEMY8rZC3v+Nvftu81xTZn8zrUGc
 nDrmnMHZ8Az3HZ/ebBwLPdS0LXHSUJuTmO3AFyL5MFeHVCj5sHCK5YqAGQrGkEJTXVupvu3
 uX2aRdMSQNGUgExyoUgFVuA6+yZekd8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D804B3E62BB
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:24:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9FB3E16F8
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:23:55 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A8326002B4
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:23:54 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1885505f8f.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785749034; x=1786353834; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RN6nw/Xblww7DpkR81cZw7VnRVYvLOJiHa3Pv2sgSN0=;
 b=I3qGAuLo3KwekZXwn/bLY4JJsCbDYFN1PAieCCagDUUx71OafteXXaWRNdGZphjvwR
 RQnjLk1wpFv38xsZYSwAzucZdagiaxZUgOLKu5t4zfJ65uCnWXDSSTKq4tS9SmCV0nF5
 8d7gxC9mCzXeBKiwjlFFdd+rXJbKSqXFi1MHxFNZimiKahacrIToVa1Kv57CCPwgqVjw
 VTYOB53JfUEEJNfNH9BpXnc+99RhkZms9jzyHlQp35ILEz1QvLeodPH2HdwP1aFsToqK
 e3p4A8xJDC2crhEpwkMd09nVtOiM50Q1rdQ6jz0Cw0IS7hDOn+95jw7+UGiaH4EfRJHK
 CRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785749034; x=1786353834;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RN6nw/Xblww7DpkR81cZw7VnRVYvLOJiHa3Pv2sgSN0=;
 b=IEj6MIOl7NYmMfFaw/bIQvP2JAx8v+qQhfvUN39OaasA9pnqy/n81Pw02NmaKdqm+u
 4AUgC9K1FOM10v4jCVCH2earTvwwLxyVVAOc/rl1Y5odl+Mk2c8txaxCbHymhtY+y45T
 0zuu0qAPgCkV18JqaSAwGDFW5JN5WXfDzqW85zLzDaXj65Bz10+Vxx5EVKP4SnvZ5Wkc
 KWTXZrPHx6SCnd2DUYh14CL9VGW6W3XX4F1mv++hu6YwC912fGL5M/2TwIFJrx69QkSq
 8ZixhmRRKJM3Od/3riMZZcQkp8O40VnN5sXt+1X7av2XcqBBdOP+hrCGvKZeD4tYL2ia
 kFhQ==
X-Gm-Message-State: AOJu0YycRWFMvg3+s/95JKqjuKql4IjS7enr7gZGpTzRQbUlIeC8U3A9
 cXwpuzSsEpbmYolwH1sNshGSVxaRQH1iqcrw1YBn0JwDnrKqUxSIIDWg9lMO98lZkiJw5lumSVd
 oLttj+EfuiQ==
X-Gm-Gg: AR+sD13+7s9uSnonrBhbMlGoejajweh4GIDdIDeT8cQnxCoTq/OeMzSzZJOVTwkEvMZ
 nO5yTvgH2eY6kDf9bqoXuTVL5aQKtqS6tutMrtZ6GhsXJyU71yV1ozgu/8Jii3L+N5TjTQzPCFF
 CxbesRl7TlA2mW+JUgHX3PgU4YD0G36ZO6JoWNGV2nkL7jQW395fszSwQg1pyzA0tB9s2EKFJQ1
 +mdq1azg7MZU80VJ9oKWfXIllrB9mrFBbFwbqz+WOK1ZqAJHP03CTT0/WWwhZccTryiCayjjb7u
 xpbxuW60PxuS0K2vIIprXal6KelNE+tziLOv/d+riXgnO/b/4bX+v3ES/6QKCarHDk5YMAA7Ww0
 TvCXI72u2H14Wc30d16pYMmvb5+GIkvL2pA1fFYIfavXC9GmBd/Y3yb5ncy8sG+BLiSTQrxch2K
 A7YghpHjtWj4PEnbsXYgH7muDpwBEQZdGAIPSL8FhBzRQkC6NKHZg8uK9A4axR+y5oooGUd3M7x
 DhGZUF5z7EPNdEEueKI377XST8jkZk6aNkNHiRYfKi56zqYDHy7iSkma8cp7v7wFOOXslc=
X-Received: by 2002:a05:6000:230d:b0:47f:6dcb:3737 with SMTP id
 ffacd0b85a97d-47fd72fa279mr26035503f8f.29.1785749033944; 
 Mon, 03 Aug 2026 02:23:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fe742936csm155506f8f.31.2026.08.03.02.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 02:23:53 -0700 (PDT)
Message-ID: <6a705e29.c69142e7.53fee.4a71@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803091348.GA216243@pevik>
Date: Mon, 03 Aug 2026 09:23:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

> to patchwork.kernel.org. FYI we already have 18 patches on it, AI review is
> there as well.

Unfortunately AI review doesn't work there at the moment, I'm waiting for
the LTP CI user set inside the new patchwork instance. But for now, we can
backup this with my personal token, if needed.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
