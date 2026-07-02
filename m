Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3296C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782981949; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PYuCzE5aI5yetbOfOeNaQJ6jbFpTIIBHTn8LgRy+FkbiO9VhPS395fx09Q8ZAA+zpioKX
 l16Uiosy7DJdJL9CE/XxRTH1hLFVL5LH0fhT4X3RrvSfEDnq3uYKwtJ8PLm1iIBTN5NHhzH
 VcheFruarEdaIe5p4nf9Ra5Fk9o8/4A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 468DC3E4A0F
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 10:45:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF5CC3E4A07
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:45:28 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4FFD210009AB
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:45:27 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so1247385e9.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782981927; x=1783586727; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UCyIzl6Tt1qBf491oxIFPVIC7/GdhTmQJaRhqJQjfH1J9Bc1BKlOe9pW4fop833qIV
 EG4mWTavaaqzmDuLWzGeuYl/Ceocj34dgRiYYIXqvpBrtMBaFbvjQYwDPLNQdv1rPQ0K
 HSHd/n/IFmtg3RYQtKb2eXxJ3zyFag3bThT8z9JUg//nqCmpFxd4/9gxl2SLg9Qd6r4A
 dMl9ZcTQrGSdf0TWhSc+CYhnp+b59F9kxjVAQXcKATkiJ0DaLWtajSwISVbHI7GjJI4U
 y9xYYUuCs/8ZlxwO2+JNtcnhxwz9i1Td2OaGg2v+pRRRrqBd2p3f1JKNwHvbPSnZu4QT
 aesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981927; x=1783586727;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=r13v0jlu0AOsa7XFDqab4cAVU3DQWWfSd3KOWtSV6KH7W3V+xsXw+pZDOJQ/nTxM+0
 a7L2MCwQ0iqAYDdiWBep9TWNEkCi5KmAo6xJplMIz6gb/bKUkvPHc2pWzZQpSsxP1kOC
 THHtubjtmUh5bA4mj9UknYmpv5oX74vkyEgxzChtiQuymwUSQWp2vIOM493tV5ZzZz+H
 HR57l/J01PkbzA99vNJVAqmyRJ3wWy8hUAH3xflBcrBFg8WLhJLkGxHu9Iw8ezsjPxnw
 hpPlRALLI4u64pWJuV+1rlViUVmw8MLEjJyGnBSzeF7n9x5UEhgPFHGZEbrTE4YRmKsO
 aW7g==
X-Gm-Message-State: AOJu0YxqNrkqzbZgdMYWS2T1RpBJvDPlwhmoEQW2UGQS4W7vT/lpdvu3
 prW5Zu+hLHonMwVq+TINfrCGvxjsiYwbEMrrMqppJF59ewg4Pl4Svr51X6BjCQbd7SM=
X-Gm-Gg: AfdE7clpaWUsVf420l0FIw194pFW7MB+mWKFLg8G2tFJUYwWAAVcMsq8sOHszRYb0O0
 fayYVEm2tOpxwk81BJYSZMLjMBtUHVPtoiWJe6WjA8rZgmOWGOIXeugwMBP+uJPThwvrXNP1JMN
 FETvKla4trm8AFKZ7SuZXKcb/lOxcDHjk/BW9THIpzaINMumdRs781o86iCT1Rocccu5qIf50DF
 z4DXHma7FzagV1w6T/RUenv3vWzKX/pcoYBR+B0yZs+PKwGtw1CYBOZez+X0jEj5s2sJH0QHj79
 cF/WXzvxXTbb03bAqD/7Ipxu+S3wb9jBdHsDaRTNqOzMLDUYNsZoZZzJXH9jFIHVzuxuHiyHECP
 6r1iVX3vgXqNnaXGuM3hAn1rVzvRrq4anOkub2vBpAErRaDYM+wLo9a2Na2nnE6KLhHUFKz7pAK
 1lHAls5bzVTc7plDmlqZWdX6PvDpHMjuJaUlusSnxQHcjMY9uNZVX/WVCRwUoywLVi8K40B9dyi
 IogTH/EYSWuUH9P8TxlKnOmAw7cCHbj/Twz93q0c4UklOHdeIK4IkbjoYkPtLeP3io=
X-Received: by 2002:a05:600d:8649:10b0:492:2f3c:d0ed with SMTP id
 5b1f17b1804b1-493c2b98387mr58500425e9.30.1782981926672; 
 Thu, 02 Jul 2026 01:45:26 -0700 (PDT)
Received: from p200300ef2f13eb00a65561a8bfe9e52d.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm26151235e9.1.2026.07.02.01.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:45:26 -0700 (PDT)
Message-ID: <6a462526.029fe3b5.288377.8cae@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260630170611.479639-1-pvorel@suse.cz>
Date: Thu, 02 Jul 2026 08:45:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] irqbalance01: TCONF on missing interrupts
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
