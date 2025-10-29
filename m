Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC77CCF9E9
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761723070; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BinOBCL1L9W/CBUoyCOfNpufMx/38EVH4/XoLTv/Gb8=;
 b=GybVaPslK+TJcFT66YMPJO2Z1GbiYZCnbVogsrXPoxAdyKQggmsWhCe3Wq10O8yoaxVcE
 9RCL7zknzTI5b5FGtNwJ4S4kyzoIm/T0Fj6pvIxudPNyjgBXoB1y5WLwSDO9gh3KRMdOZts
 ZgbonoKgNT1DbNHMqrPtTJuC5dhq2OE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08673CA72C
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 08:31:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D0023CA2B3
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 08:30:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B0E4100014B
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 08:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761723046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQ1YVV+pJEnjnJLmBiANS+8i0O+K8QR7tkvC4KhYa+g=;
 b=P6g4FtocYz85u0OoosPqLCAfYrqJLqcX2epm1tSsZChJfdZr8dkNQT5DX7fyjbqjZ7MXF+
 oR3lqBdCH8e7CLwawHgOOSAUjwoHqKmWkvfXkISiMZvXyOSp4GCVruo3EjdFKVCAnhr1iz
 e7iIoIB4TdQk8JavBtKzXcx0xkDJ/QY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-nvT1y6Q4OFmnEuxlmmO7JQ-1; Wed, 29 Oct 2025 03:30:44 -0400
X-MC-Unique: nvT1y6Q4OFmnEuxlmmO7JQ-1
X-Mimecast-MFC-AGG-ID: nvT1y6Q4OFmnEuxlmmO7JQ_1761723043
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6cf1b799dcso4947839a12.2
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 00:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761723043; x=1762327843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ1YVV+pJEnjnJLmBiANS+8i0O+K8QR7tkvC4KhYa+g=;
 b=YT4pfr4h6jKzJpO1e2MjNd9FqqDSM5ARqRYDzCViRK6lQgx9q/taXpiwio5/Z3q4ji
 LgaiX8Bpw20W61MejD3rFMHd3ZZqZWLP3NrkgZpTzJsV+pWVFigaT1eBgs73tDHRo1tZ
 oNSqiFhyEkRNRYtMjH5/3XXQujD2GRBYqft2flFBcrYq7aeDOOYsk08ZPUPGOm9lAZcs
 JzFofkzRyfdsI2rNYT2Ms0N8K0jNrj44R88TYw9Dkvkcv4AoNhdE2/kgeyl5xKCskauI
 Vcx57GlEspWG1zSh997Pmpgj9qPHSr9FFL/kN3OuNhIU3olYhsIHDxe+NwgeCXMmzccO
 w0EA==
X-Gm-Message-State: AOJu0YxmftCcD0jOO/eMqy6zqcACpuUXiuLLc2co61Ytvcnigx0rrwRq
 sQM2dB6a7zxgkUoWoAbOVMEa5vpMcII21uHLlzMt2P1JOhalSPAFNmzvBc/T6eQx5I8BCf8fwtG
 sMGQYTSAj/H8sWl2Fpvf0XTWtpq+3SXoWZvjWJ+LCtmY+TigXBYhR5i4P+2lEzJHTgvdv/70Jk3
 LQUHM0BF2d30hBNA9WL3uFFxTNWyI=
X-Gm-Gg: ASbGncu8oBK+IPGx7HMpckEB61MAfJHfLVKxCgWkBbPctKvWgY9Cur06i+U7FTtCYjS
 irkhBHa3zUyV5+OMhZOS9K731+86IhtDLsp+5B8NNE5L/rotzyhsqma94MUjQcL7SU46J4OHf8F
 B6J25EgASRT5/OGAhpGhRZpsJEQtt4tOWJUysGnR4XViQBGGVmiP5jjF0c
X-Received: by 2002:a17:902:e5cc:b0:290:ab61:6a5e with SMTP id
 d9443c01a7336-294deeaae66mr31609115ad.27.1761723042917; 
 Wed, 29 Oct 2025 00:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF50LTftwU9Rumyx24gA46sFzp5vsXmPTdnRWjKBTjiKWhfiGtP0ttomr64y+OB1YYDUT2gDLr2etTL1Yoxbho=
X-Received: by 2002:a17:902:e5cc:b0:290:ab61:6a5e with SMTP id
 d9443c01a7336-294deeaae66mr31608825ad.27.1761723042481; Wed, 29 Oct 2025
 00:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251029061129.3307836-1-chwen@redhat.com>
In-Reply-To: <20251029061129.3307836-1-chwen@redhat.com>
Date: Wed, 29 Oct 2025 15:30:29 +0800
X-Gm-Features: AWmQ_bm97ftz6FdwIhF5F68TykPTZ1q9qDUzql-jwM0Qse6Pn7mobs-jrZ0gc5s
Message-ID: <CAEemH2e=R6r9QPKQH5RUSfisH9p1COtegW4zGqmVjHgQpZoqqA@mail.gmail.com>
To: chunfuwen <chwen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0I3g8IZExaUbSEB5POnE_CZKTTxXkXxLRHRmmnzlkLM_1761723043
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v17] Add tls parameter and flag:CLONE_SETTLS cover
 for clone syscall
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chunfu,

I rewrote the description and adjusted some code indentation, then
committed.
Additionally, the clone10 test passed on all architectures of RHEL-9.7 and
10.1.

Afterwards, you can refine the clone304 and send it separately.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
