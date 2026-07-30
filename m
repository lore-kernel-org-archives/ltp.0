Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D97C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785419772; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=i/n7eJ3RT/YWfoOn+5Ud7a+Ybry9Owx2a2xTGjIZXZQsTxwpaKSNKRBombmZ8hC4AByCy
 10w4niFVHU7/D+M18iy9sIMdk2dlmcAbPlYYqb9FKjLQjFthJiHszCOmV7vIXUPe49wrG+O
 bVVDqz8Z5VNL/ubQR6RR0OLYSd6v8Co=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 820D03E723E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:56:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC8FF3E1C9D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:55:51 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58262600492
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:55:51 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49557167508so18289165e9.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785419751; x=1786024551; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ESPCyss+PCUzEQq0yE9Gp9LpqEnCTwBYXlHFFzYCG/OkFLt9yvv6N/EMoSDrYiMfIX
 MKXZmnc2lkaHfH3w8x+JAWm9DRuuQ/4ZiZO4vBEdLLIh+lOwDuw8Kfl7WFu0o23JulPB
 nG111VIB209RQtz520diJGtmOOuwhbmwiqh9AAZJaVezWUKmaHzckorftHPXn2vO4fZv
 f48NVJWVjAfdqlAd0mHS94w+wPdyY0/Q+x+kuaomRQo02tFka0LM3gP9/ODqvQKY0HtW
 u/OSRCvUu+1j5ha2OpPzcnoJQHTBwV5pfrYRqQ1TwcBrKNoYy/vVSzmlEDgENZRZ92Z4
 bLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419751; x=1786024551;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BXT3OAh9oqbDWMglNDS9eofcMkzsFgVSrzLRs7tpBg6/KYFovqbx6nvR0FmrGfsz/x
 SWjffRyFWZ1Xad2RW55MwsMiKZdT4G9dgTRwz6L427RJXZmGOT5QpAS6TnaokIWnZtSg
 D6S6w9GJ2UwYe6qYxH1AegxkZ2tVUtYnCEJHbSSMuGwhJ8+OHeg1JLBSVTeBIkpAZNiS
 uu+3c/XRzt2DGj8chpDvNGnAgb3IufakhJfc2NKXnO4nne+nIoV18Z0tpjexgmfJH7Pg
 l4dI0yYqSrHKQZphlX2kwJDW3yL46yTKbSxgNO8hCe2nOvD9RjHXF/65d3B6C+4vXhcQ
 dulQ==
X-Gm-Message-State: AOJu0YxwOhZnrKz3iokye5YjnUBEeulQXfIvzuAk3ozW6VUHLGO4cyDx
 QlegsbB5K9wYf4OAZKUUZRlSsUF8RKlghJNbvnyXvSnXOAVc0hti/wh/egDGZOO6j7WvyaYWtbM
 7xe0lIGI=
X-Gm-Gg: AR+sD13kIWDvWy9kmk+eB3NDXQpm11uwVl+ZC10Vl9zHZEaAyqCvxDno0qQqn8Dm5RP
 DEK9O7c0iCG6IWSMTioYg/osoN2QnUUgqjIg2+7MuFHtcRdWXF/x+JfAW8UP1/cR+79J1mIiSgY
 I+y1FnNbhXjI7HziJWur2WoFk/fG8oPmZVzBhQxRtS5Zpykw7rg/epn+sl01wfHjW6/kI8q2YnK
 PA4NKGUu8i+6StzOFTJ8a3ZKJCWkpRT8mD3f5+toC1jN18ptJ9OnJVZOMIJ8FYHDkf/nrn3CrAk
 3eJ4oKdK1gIrFCbzu7zvFUgFJl7ZXHIbOuqem395Blr8ZxY0/bwa1vaRmjjk743x3esfw5yPIs+
 IAPooKytKBHwf5UUCWo4qL9tWkwnKHZl/S7xICPwbuyKto8I/zUN/s9IZjpxwBk2jRgqfXATfR7
 nK+fsoXYI9shlyzK58H5BVVEkBUEdTAZxieiW+9dB1tPpS1x544InQ32yF4pwD/UR8OJKhVfN12
 Pll14m7PmOpAgJknn6+pE6+OIjWF0c9TraH6WqKRS+SvcWhbg==
X-Received: by 2002:a05:600c:1c27:b0:495:5045:39e6 with SMTP id
 5b1f17b1804b1-49800e9d3abmr43052475e9.17.1785419750587; 
 Thu, 30 Jul 2026 06:55:50 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f25df9sm54841965e9.8.2026.07.30.06.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:55:50 -0700 (PDT)
Message-ID: <6a6b57e6.e11288f4.22d520.740f@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260730134102.132477-1-avinesh.kumar@suse.com>
Date: Thu, 30 Jul 2026 13:55:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] inode01: increase dev_min_size to fit the peak
 usage in parallel scenario
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
