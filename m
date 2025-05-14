Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38762C3ABD8
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747225201; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uf3I+Kx3QqcGvMlGTR9c9E338+TyfFnSXceq0AuTQ/I=;
 b=a1isZAWooBGUPi5TBD0+dVcnXZrKpYALb+8e+2BQPNmOLPHxkyPd69qZQUL4HBJgFSkkK
 KTuh3G985uoJFFg2U4z40JrI7VUW998QJGdl2SQlsJcgReVj8d8zOSoFLaKng18DW9yEqIa
 xCCSUrbQoK12+sui23VTVEbxsaD+q5s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A35933CC3BE
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 14:20:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81FDA3CB86F
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:19:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ACB3F1400967
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747225177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uy+fdx73eZd8cL1ldr2oz599xOcpCSF9ltSzb4bG6zE=;
 b=TMBVKY6zMGu9WRyIQfMJgXDNW6az4KtpXuhVSS7il4EiTgQzl+dCrycXgA6gZ+XMkaeJD3
 K1u7glrTRG6vcBI/wboNsnee/LyPJvF4oTmE/Mc3Mmo/1FFl/86WxkNIwIAsIIHVqAqbMl
 v6yZIv/Mfgm7PMXjBKyCT/otqgtFzQE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-D10XYgJkM1SDP3h_a-pZyQ-1; Wed, 14 May 2025 08:19:36 -0400
X-MC-Unique: D10XYgJkM1SDP3h_a-pZyQ-1
X-Mimecast-MFC-AGG-ID: D10XYgJkM1SDP3h_a-pZyQ_1747225175
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b115383fcecso4026871a12.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 05:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747225174; x=1747829974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uy+fdx73eZd8cL1ldr2oz599xOcpCSF9ltSzb4bG6zE=;
 b=ErU+nw9jPcpvb507acni0EH6SorVtCAyewijLnirPWQ/iSI+JVki2a1pK1E74GzFnL
 09ONsV2yDWhpKSiVqOhGcLTjL7rh/XRQlpUJZaboCIzOHRNcCD2zv8WB+agSe+4FQLvv
 JlE4iUxuNcV1nwtxQr80S3lO9Zo4KuJJiKFfZyN+yXIDNRnABgfZSrnfE77DHpJfcJqZ
 ZmjgKAYiIxaQRyY5vKw+TDjiOFRkHbgKBC6qc/EwLJADxt0i0J2kJz7tMQA4XqP+dC9K
 6a4KJi5LAJn7ZVabjCpoHxUwoO++KCg/k7kYLm0O0JDDE5a11ZenSspl5ekmu21IERFn
 tBiQ==
X-Gm-Message-State: AOJu0YwxWVTdE6GFcha6cufGyOk9bEX1L9R07R/jbTfxTjiljc3/5fNV
 Ea6OxsxNyuQh6BfcUdz/Cf04lRXlCWTZEze7m1cSIxasFAnvwkKw7sVVFmko+DZEk7AoHfeXqQz
 Gb/c87lOUMXpebBp+br9ja3ImbGJkiImejF+9J1r9LFaULNYC9SjD8J07ihgXWmiiWSBhLi+1fB
 DqGzGJMcEPxKx6IxqobepT7ha0+xiZhpY=
X-Gm-Gg: ASbGncsCwBalS/tCYivnYo/865twElX9ttLqjzI8qA3GXcr47syvLS3ByJ5jzCF2Ocb
 MjuOd3o5koYfIw8Na18oo0WqjNg9B0h6jkfLJpsPGQq0eajuX9fugHF3x+bTn6wagLpSgoA==
X-Received: by 2002:a17:902:e741:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-231981402e3mr50690695ad.21.1747225174478; 
 Wed, 14 May 2025 05:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9xBj16BlvtFjUVcFI/x3Pt2oi4QbvwuBrH4mYEpDxi8BzRmDQ1AFJXuGBA8y0MaXismv8k3fOgc1bv4cT4q8=
X-Received: by 2002:a17:902:e741:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-231981402e3mr50690435ad.21.1747225174166; Wed, 14 May 2025
 05:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250514042811.58339-2-liwang@redhat.com>
 <20250514083403.61348-1-liwang@redhat.com>
 <aCRo_e9iTDiNuOmN@yuki.lan>
In-Reply-To: <aCRo_e9iTDiNuOmN@yuki.lan>
Date: Wed, 14 May 2025 20:19:21 +0800
X-Gm-Features: AX0GCFvdu5hawZh39Y8Radyk1kKonG7Bhbt1H7XA_tyPJV4pW8x1wiBOw9tUJd8
Message-ID: <CAEemH2c_U-GaRjR9anjmKG9uqjkF-X097fZqQYruLatkRp-wMw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SjFMSYp1ByWgF9Svk4oFdzz2GzBw38ZiUli63X46BN4_1747225175
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: set results->lib_pid in the setup_ipc
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

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, patchset fix pushed.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
