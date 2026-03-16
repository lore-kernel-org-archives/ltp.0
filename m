Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C5F46445
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773657214; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VDxUhJSzWFD/8J8R1R2S6AshTpuJN3wv7BwnOBa9po4=;
 b=bHTd9Ni+aKBxQfea7xwHna9ELly9YQsoFt6GV2dKUa0KZFXFSr5nlHaXEFmT5EnD3A0qU
 2zTDKFarV7Cp+q7sCewsImKCkFFlNFjGcL9cyth2q2iuSegLn8gV08GpAvlEYoDpCqfUH5x
 27DTI847qS1alhPALKaLLK4F0pJ8SAs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69CAE3E2B80
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 11:33:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9B493E1CCE
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 11:33:11 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F37281400B89
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 11:33:10 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso38718325e9.3
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773657190; x=1774261990; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CKdpTnoHrhExjeKI0J9t+sog97JYQKMnvroe4+hVHMg=;
 b=PrIGlhvZbD25xKN7MP/bzV6jbRdDvcjYR8pC6j91hqgt10T/29lTc+zq1yVYmPsqjT
 UTziE4QJXTbAR0Jyb8ZCZFHeoSprRJibsm5i7/Jz0rOhmVpoS6pErTAM/gobS0Cld4uK
 NEgdrnY0W6aBvBIKiUtMgxLOtTGSywPyGmAhTCoLQwCc6yeewI75BQkRY9+2xZAz8Tir
 YySeN56oFkgf4omMU4X7FOdIroUR73XekFUTgwpfcZ/HRGztpe4aFtGV6rRcq4R/qLUs
 e6/rBR8ZQ+TNLnZY9D9arbjd8fw+hDijMPF2O+zo3pq6UqdEJIk/f015JcJSEqyumaR1
 Vfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657190; x=1774261990;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKdpTnoHrhExjeKI0J9t+sog97JYQKMnvroe4+hVHMg=;
 b=TkV40FGaDZMvHu7YIFEs05CEcn3SkvXNrBbXtrS9Y2Ya/elUe/1L9Lh6cU9mN6ltfR
 W5eoegdZH9TM7zlgBNS+wbBQRtwkVk8kG8YFwYAfj5ehDS8P73XDl+QDLbNPWtJ3bxvo
 TYUCbBH5utcbHn3WuN8/9zaXrcvOcrps4cIJ3I3V4mFi0l+XkI2mizwO3+f4y0l26Rg2
 VVYdt+tPN2XbcZXx2/hy60TFhV+A2d1WzE/PkoYaUXPsLBSWQVvcrPbZuOhWbZtSRG/f
 2DTmQ/wTL/7hmSZuGGc1PY1iOYImCax9mbIFVXohhXxXyAyumG1sr/aWBSRqVWjiA6y+
 qDpQ==
X-Gm-Message-State: AOJu0Yxj+7CGq0BnMgc13BOxSKp5hRePnuRQBsv2LR1mmlJDY8RbpvzR
 MRSfx4rgxfoEiMd06VjdsA40MeIEwg60OHuUuEb2oXWTU/UiGRKy0I7MfWGIs5AQM+M=
X-Gm-Gg: ATEYQzyWFpmV17PgO1cDx8x/fHdDcroqHLKB6BWeEJ9nLmBY/2H/2TM0je2/BKjMaTn
 j6fetxvnDdFRd6Cdv3MdhYu9PY7xT3FXa8Kq29YzwidLQCA+8oFVBYeXSR8m1ysxk66Yz7uCtNg
 H6HGQtHO0MO43cmoNlLL+ooeV0PG2tDlLbWnbwXAeoRUffNxc7bbc7ogc1o68EH+Qlb96fsWzaI
 jDsv8MUeaM9aqRTGFis7T1cKDE3IlZT1AKQ6+wWwLC3xVaNzLHua+aut64/1UNbWIhdE8o1pz5x
 MCMbuQ5j4IpDNYCpzGFM88PONyn60GnmFPQgaDJZwlFIaSSwRUVCETD+YJphtHF4utDEIyOfojU
 /kUo9o2857wlwL8osqb3nWvRkO9T9VliuFUPdfJ/o5V//pUhkQJuUaAjtbxigAcvDvt6DH53ShS
 Sjf175YNr/mzgXyQxHTUREuT5VNtktAj6YZ0bEvMEnRfP6wUdK4r0p8ppI/+/4zXQYi73m/BgH9
 AeSFBUuJuMAOMQaEZINFX1uMGUJZdnNIJ9jZp3snXDqaA0weFiWjqoJx4i1n0AqdOJxRZJt5mr+
 hg==
X-Received: by 2002:a05:600c:3b04:b0:485:3c7f:527e with SMTP id
 5b1f17b1804b1-485566dd02emr188647705e9.15.1773657190100; 
 Mon, 16 Mar 2026 03:33:10 -0700 (PDT)
Received: from p200300ef2f4fc90053e282780f88a5bb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6b95sm442754775e9.6.2026.03.16.03.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:33:09 -0700 (PDT)
Message-ID: <69b7dc65.050a0220.29be94.e264@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260224162726.28933-1-mdoucha@suse.cz>
Date: Mon, 16 Mar 2026 10:33:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio_cancel_3-1: Rewrite test
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

LGTM
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
