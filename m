Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FE8CD6E60
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780307881; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=OrUPyNSQ3fbG2vIbjRzJwDaCMV+tjsGitWISVfzOY3qkGbs07uzEZtsNheB2YLkZIX2fv
 SM30MWjVB4wyRoZM7omGxeU2PBSeULCJ+oweB5c0g3O18OlsM3FPfu7rhJ4ragjj4+UbBo3
 nU0vC690RUJWdHbUkgrcqbWD06R1nCY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F16073E48C9
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:58:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28A023E1DAD
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:57:38 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD4A01000366
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:57:37 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso78851595e9.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780307857; x=1780912657; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=OR6C5K6FLI1bmR5KVNRszTfvQ7eLN498Z5OiVDX9CzrIktjPK2B40dHLqvdLAXOMsH
 Ow3dMBzpsP9TWu4M+DpSPqxvGaqezfUF3heewWwGymsZp+Brd/iLrvidk0elmlIj74T1
 GqanhIrf/iboZTfTKJWjgYBvaaT8Ui1axK4Pi3KWmYVmtpCzvFJgUab3W4dGldVgCPVf
 vSIQKzaRQ32kdN5CYvCRFeBxjGwLX3Nff51sPKMLx9XFtFIoPonCzS11lGHqy37TomXi
 NLPWHBxLPx+HKSt2myzuaImDuueyVDiJjJprxOljR8A+ZKXE717yv6r1LsX+dsY/XoVg
 2Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780307857; x=1780912657;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=lR+oYcSMK+C4Fuqszm9xa+yyUSl9Dv1kBC9JXE3hBm2BqdubWMgMec3/6PsThZ97NW
 yP7ge440vGRY/MikT9DCTzL/LhHhuLA7lnWOkdNCUHIAAto8ztGIt+PpE2kFv4w+NZUe
 /6X00vKmYlHVAMheLusadenDkl7f85ivLZoHQT4egdvbn7uLj7QHZnGqISmxdqlP6CN4
 jsXBK87OM77yv9B6QBIdqRglg0k3D1rtQz2GO830o0cfFPSnZ1nneHhPHwEn9Of82DKh
 q7Kcgu0Gci0D/CYL/FKe//YO5RBPwVVvNhsu2x26rj+L52VIeXzp7auVMbcYrf0dpe3j
 z6dA==
X-Gm-Message-State: AOJu0YxEaPjzVKIK54qaRsXAFfopN25qAgl5voE/0bEOeD26RAlHzKnD
 zmN6uusGO9kCbB6HbnlJpuZcQPESEcB72mbVyLUeQ5rhVd/86MSPCBadtBB0NVL14uFQU9gO8kX
 X9ahYN8s=
X-Gm-Gg: Acq92OFO8jZiowTxeXrC6QjZ5NWzJATV8fb0RwUQXoIRVcJ07P6sVJCkLRRUHPFu5nx
 qpP1KDs5MC4P1kE3L1xvsuVWEipbIyTsIMYMVEGyd8j5OpwvsjlJV4xNbE6Iv4cc7LcslqArKPi
 v0/QPurUPzX+MjSZwxJj89JR6LbOyWDCekNcA7qeYcgr5b3Og/hrmiQ2gCDib5/pqzwIhnusP3D
 ySINm2zDUw5QgWJIjOR01avRQxrxokxg5wziN7/F8McNTO4p0G6kvqT4QOQZT/9FbyYPgd1R881
 +qRjtEiKQ6bYhv30myEvn5XArWnIz4Nz1A1zVyS3m2V9UBcNvA6VTHbsZvThO2Abb5ymsSXpuEw
 eqTe4SB/UQroPJfp4hKjG8Ak2wf/9m8Nc4hb0JWmYSu4WG8xUd50LkVMOZ5De2GmRzyuBzPcfBb
 yf7BDrI8ChlIuLKspfH3bBxD/QF8zp0jHsWIaqkBgGDI6gDmYbVrHUs3IcL91WbCSTa91pOowhT
 cbE+LxTYy5zh9s0QGpxSoSAK5TCg0zxnB2ED+LeEUWSeA==
X-Received: by 2002:a05:600c:450b:b0:490:6e11:c303 with SMTP id
 5b1f17b1804b1-490a29213bamr203150895e9.13.1780307857139; 
 Mon, 01 Jun 2026 02:57:37 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4a8800d2346cb1fd1859e6.dip0.t-ipconnect.de.
 [2003:ef:2f4a:8800:d234:6cb1:fd18:59e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c50f6sm26871588f8f.16.2026.06.01.02.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:57:36 -0700 (PDT)
Message-ID: <6a1d5790.1d29a1e2.17a769.df70@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260601-gitignore_ltp_agent-v3-1-b39af1578972@suse.com>
Date: Mon, 01 Jun 2026 09:57:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gitignore: ignore ltp-agent setup files
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
