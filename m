Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE4BC41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 11:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 069C03CE613
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 12:00:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D875E3CF2D7
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:00:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDB821B60EF6
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702983603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SBftBgzJEsXCH8+PLk8Gigeha2SwkA+7vAoUxc7IFE=;
 b=JE1vy4YpSprtAXi5+fAgBw4qHg1Qi6RtMMUPW//lZLxhjtPjuoiTul+UnxD3p27P+nf6Wl
 xIbZKdf2ubp8ZU9F81agbJ+gkPZGCB1LNahpRnaaiIEBtlq9tEau2y05ExaH1CxNwHdKnV
 nKjdkCIfFTeE8swNLfz8pGSQCgEcDUk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ks88jOp6MsWDDGJ-RivSSg-1; Tue, 19 Dec 2023 05:58:16 -0500
X-MC-Unique: ks88jOp6MsWDDGJ-RivSSg-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6d9feae8dfdso5990434a34.2
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 02:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702983495; x=1703588295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4SBftBgzJEsXCH8+PLk8Gigeha2SwkA+7vAoUxc7IFE=;
 b=aOKCBjFbFQuGxamU6mvJReSnKNpL+Aw74vXDgSUfkvk3dvNcDLQe+GJhgaeZY4Ni9+
 QpTsPykJO5+DEJ9Ff6+sUtlPP9/rdEoiKNWouA51YRMwMj1F34YtanMule6HR1aIeUFU
 VpM2uwaxXeHBsl26sFGX71w4SM3OgblCtNvRHsJLEmk8iqjORnpmR9FkoCS3CQl19hb8
 aWqo9E2X22VH1NX9rqvmVLRq96SajFQpMZZrdAMwrwgOYixQRsC1xFatiWTAPbTVV2nc
 1C5IMnFhNIXCXQ7ApaNgshwyfB+46S8vn5AuyqzIu28hMbI5v4pQb6WwhsiYYdDNoWPi
 Za5w==
X-Gm-Message-State: AOJu0YypbYCdGL4VtIcsPjKxOWFEcAYDoGv3jS9jkdVncLASE3mMUxpk
 jX7AivBt2KNsVoqxmWwC/QCAvnoAGuFzkB3GXVXJlbLwvsLAybJyQzOu1gI39EQgIM+OioTEviX
 r9PNaLAXrgNUFshFX2wMXLsne9d4=
X-Received: by 2002:a05:6830:32ac:b0:6d9:f544:8098 with SMTP id
 m44-20020a05683032ac00b006d9f5448098mr17590271ott.28.1702983495813; 
 Tue, 19 Dec 2023 02:58:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPPWXjGx1UTIV5B0vQSC8nxiawmw6MSo0TIfvgrGazyb+E4EKulqs3b4LbsxRq3nul11KI+p0R/wY1mkMrPio=
X-Received: by 2002:a05:6830:32ac:b0:6d9:f544:8098 with SMTP id
 m44-20020a05683032ac00b006d9f5448098mr17590260ott.28.1702983495441; Tue, 19
 Dec 2023 02:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20231214151954.840244-1-pvorel@suse.cz>
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Dec 2023 18:58:02 +0800
Message-ID: <CAEemH2dH5tgNUxZHbai6NABN8Ffw=KuoSW6j2rzy2xaeRv9V3A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 00/10] Add TDEBUG tst_res() flag
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Nice work, thanks!!

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
