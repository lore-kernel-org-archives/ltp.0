Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05648C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784114998; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=kW0k2heJa5ygo/kEX4Lxxs61O2k7lk2eJsfoxAr3hYzdxP3mJF/dWKKBtKIS53nQL8885
 Je+WDbsnumQGv4CVK8zlErSzdkdczXggen29HkyYDFES4VBA9v8DtjshALpXEjJ5AyaU+n4
 e7MDAS9Gap1GkXGlCGdH3NBWBKgOz+Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BBE23E5692
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:29:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 034023C8515
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:29:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9283B1000530
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:29:36 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso3294620f8f.2
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784114976; x=1784719776; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=exVGlOlbGIBvCFCa/MvJN4IWq7fpxVgn31g78rdJqN9rj74OVQvCrbyZASoCxMVUM8
 9LEEfD6cCL9IxR8BWrc290+ikcinX1qxVu1FFjs5LTczt7hp9b54dz9iYwNEYBp/kKTQ
 dK0431jhRlRgkiu0fShw12ZW17gMkd5PDJeAh0DLdmGfrrcdYz+Qq9qrNV2YHA2kudUL
 /PKLF2CZ7KZnmMObzDNyzZwGrBSs4EBzkRNrVAc3iEtDLICW03moN2YbEeO3CV5Eq/ls
 i5oifGngEkdveg8RBo2ub6jMZCU/DJPKUDI4CVUR8wQ+Wgaj9mqD0fCO9WUb22Uol1J7
 4ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784114976; x=1784719776;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=cZ8vrjFZOeTU33IpL7+HiOtNKuxVvYtj4/PbVyalANampCJ5eQeucF27LmK3iaegli
 EkIS/HuV+JhGE6kO96u5j42PJ3dFf8Pl1rQgNI6vd3wzSLYbacw5dSHr1WIvaw+5wgVF
 uasLmS6GtDP0QpQgC+dEXuSBlgSoZcPazzS/aJGmLyWQY89LfKGYTwI4aiLG1UiHtW3D
 REf2qhKwfD7Pehtr4UO8TrznPetLYVugYLFrsMOEWZbeMRnkZ0MAGAgFXLcyn4F//Fpe
 xUJExps1r9dNj4mmeG8lwUeZKBnZaJ5lxbV2titb8aVxJDQbW9y42deP7CZBbuP3o5aE
 oz6w==
X-Gm-Message-State: AOJu0YyE+3kfNyZAG4L//owrCz6msLKms7GuTtrMT1qHe6v4jO6KNUhF
 yMSNNy0h9EdMroXu5ep0dCxhNgnTSMDHAvRn2JTjQ3z/FAr0h7OoIDfyKVydw020yVo=
X-Gm-Gg: AfdE7cmuFEf7zOJqUh2BiJ6UWNSqJml/Ltr6yNj00pQ6uKsl/5KgAuSg6trmx+DwtgA
 VZCrZ6XVmzvyJGno5KJU02UvIYaHJlV4zQDU6q9h+dI5Qrf2gYytq8kFs8XWrshxQsNyewQaG8b
 tSViuVgtjBR2oAHuwMRoeApVYDH1Z4URe13mQsbLrCP+rOFwG+vVn1Ub8FvUe85dLoo55MSVCK4
 B2Fz9OERoNuGwvn0VnWMTx0AbejFuwxz4euinT963NjJ3hB5ENbcyy164tYSrFXU95gwPu0WwD2
 nftqDs/E1EwGaK2gmN7VK60NhTpKeUL9cZMqfaU7FsGk/1Sx74bFSadl99gA7J7eCQtTA8htloZ
 6bCjcI16+WZJ0rURd1IzQj1wPlv6BJ5Ps1V/2uXxJi4PPpPtcP+fftgRlwx/9Uf7HQyXdi3dYB6
 /FO3/mHexWvANP08w0jgy+okaXLqESO47n
X-Received: by 2002:a5d:5f49:0:b0:462:6aa1:4393 with SMTP id
 ffacd0b85a97d-47f4886edc6mr7115159f8f.4.1784114975826; 
 Wed, 15 Jul 2026 04:29:35 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm16681467f8f.22.2026.07.15.04.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 04:29:35 -0700 (PDT)
Message-ID: <6a576f1f.9099b29d.2b1b7f.6a5c@mx.google.com>
To: "Gang Yan" <gang.yan@linux.dev>
In-Reply-To: <20260715075850.66118-1-gang.yan@linux.dev>
Date: Wed, 15 Jul 2026 11:29:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] loongarch64.in: add memfd_secret syscall
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
Cc: Gang Yan <yangang@kylinos.cn>, ltp@lists.linux.it
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
