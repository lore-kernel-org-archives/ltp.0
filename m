Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B9ECD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778139365; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=k5rxoHT127UC0NuDijSLeNWi367ppqRbQrQJuH8vlFXCCDtj4J9ooVBDnyBd8E1qtJa7A
 Ys+NkcRZ2uAxR2MWXXpcl2Orcsyt5klXwCnAZJymTngzNQIB9eLg4kuAy4N263PH6B1xeWg
 /d5stSAYtA55U93lW8yRMxIPBI0C1ZE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AF823E2C32
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:36:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9ECC3E2C3A
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:45 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C7681A006B0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:34:45 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ad135063so4431105e9.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778139285; x=1778744085; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=CpszGDxl8pSPVm8BiWmvkY+j5G4Y0OujNGLKfjh6bEkjqB8lC0/IalR1+yR3n5n36F
 KXyUsUo2h4IcIQT8JWVu0Qd6ggtTCbXnfpsR9ozU/e94OfSXqHfHXiFrxXSB3Kdev6lM
 rztPZz3Orjx/kzERXujll6Vh+AGTf6hwjknobSGNqFX6r956ci7za5oOABBakjxmQ7Y6
 fBWcWVty+lZ+iFKHkMGQ7ODd++xA5xwRWiI4kH+k1MZFPgEqlh6NT3jdPNrEaD4pWJBv
 38vu21TqWSsCnjZHjAnSgd5m3aTqfL7a5/Mrt3dkX9DGhAfem/eu9j1w2CYMGEVJOn+J
 2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139285; x=1778744085;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Hy/syXBuUNWoxiQsl3eacW7W9HBKTH3qqq2E7TRkf88zIyY957laEfbZnOG/X8/2ha
 cT8yTb8ShsetyaVAl8WtEDHThZwd6tbpmzr3vKsRjFtWMeGdMDPbVNvsmm5dNMSb6V0C
 B8glzoiyeJeVqFhbU6cRMUB9FPMWQOKA1DjRGq9/ImEls4mSgBJugyabkVuTwHDZlM3D
 lQGe8B7iTxBFTo77y5w0sZs1lPA1ZisphPwXMAzMO+gMeiX7oIbXv0UECrg1ZTpqgTZT
 IXaWgL3iF04AOuFzTatnD77+KnlI3aOR+uFMuC9pkGYOj97xqanmf0Meyuml9aLY2fa1
 58Mg==
X-Gm-Message-State: AOJu0Yw5Z1GLoAgWEE7olxhAKep8fG44qlyL2DrasseM07Uem/Q4TmcV
 2Lxw3XpMT4gEviHAJTKjaAiAJDn5FB79kfdseLQTlGJOP3LC9CCdOx0hUROozeUSKLw=
X-Gm-Gg: AeBDievziTlwIxVCbaEqoDGQfixIqz3X5sCRAtQ0+UdaSVdlAu8yA2RSpVbbwRQxz33
 rB0RdxbpD8H2KEH7Jof9fffXKgHSn3+d+SN+yu/pZVkmkXWXrnAagCxcfqp3GdAri4utu0ZK9W4
 lIr3/2qw6nCV5RuRANWg0yD2sWFkRDzfBhXp88/s+bgTeXABhy/m5J2cJ6SiDmuywQrx1dP006x
 MFkaZBa33420T7mXHl85RJIZ1n/QXN3vMoN2pegD+Jzt0uwzox7hp1hHsx1TkIlZptHXU/VoiRj
 R1BbQRGo13HiR0HaSjzilY0h63njL0hQtYZAjO5sYldy0IsQDT1mQOvlAXDjquF8XPovre2EM3e
 kTpDDIygVBrFJRViXOv5f+HZc5KLyi3+V2nQ/2AfBzTFQ2f7R/OwNTCeG5j9yjhIDEwCU+Fevhd
 +CB/WuGoz40TPD8MDTbBw2QCkRh1BIlIYFjz1lleaP7r236jrdTXFJYnFmUjjLhjEPfD9/Zt5Bm
 Z2l5fWO/SjRL7oA3fNzf+PyFDfr8XqRT1/Qc9dxcqAmztdCbtoP1ia3
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id
 5b1f17b1804b1-48e51f32ac3mr112820675e9.14.1778139284865; 
 Thu, 07 May 2026 00:34:44 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03d4csm18641027f8f.22.2026.05.07.00.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 00:34:44 -0700 (PDT)
Message-ID: <69fc4094.df0a0220.168a21.d423@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260429145314.79256-1-mdoucha@suse.cz>
Date: Thu, 07 May 2026 07:34:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] aio_cancel: Fix incorrect strerror() usage
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
