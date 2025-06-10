Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E85C5B552
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 02:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749520986; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MXT9I61fxLfgV7iow68nGRDBd7xe5kyp+GIHe8M3CFw=;
 b=LZTxbuQeekhRIkkN3lHZfzBHQP9DJ4cGrWKKAeYbLLLtk7LLUVl4lMd1E57CBBTgpjJFn
 pcRjo8t0uvxUvuHVAWGlttqpxJdAAbndgWuEQw88uCM87CmlgT0VfV8uhcQKTB0bDzMfrID
 A9WB5lBPs7tZOG6H6Oe+LOHTVT6NSbo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D5843CAE0F
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 04:03:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510CD3C2869
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 04:02:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70029200C0D
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 04:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749520963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c82npwLxiop2hPhibZL7GJvTy2ehxXtZCagP67K0TEc=;
 b=R7KdCgdBILl78ACh8hh04/R7kX6xgOQtf3ng7CqDNO9f2/lE8ck+XmjNwVJ/aqQovOj/GZ
 Z/FFj4qpasDJPCI00NiBKhXtYJQ074X5nA1vTbS9uYseRk1M/vINCw72ocemipvTUvNcym
 Xve/O0t8PZPnoGKqjn9FHlQPVkvd3Qs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-sW-3RB2fOPeCLIGypC_FHw-1; Mon, 09 Jun 2025 22:02:42 -0400
X-MC-Unique: sW-3RB2fOPeCLIGypC_FHw-1
X-Mimecast-MFC-AGG-ID: sW-3RB2fOPeCLIGypC_FHw_1749520961
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e3f93687so76906225ad.2
 for <ltp@lists.linux.it>; Mon, 09 Jun 2025 19:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749520959; x=1750125759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c82npwLxiop2hPhibZL7GJvTy2ehxXtZCagP67K0TEc=;
 b=XCZG7C3A2QR2pwDh9FnJDxuPcKm4VUKv4dQUvGbx/qpgFT5dNjeV+TvoW+xmXkz88V
 1meK37tveGL+caA10mee8MeUVxDbZkURKummvzAm7kqHq3+RFtnOCoA0Hqo3c15NbhdG
 +lPvdyIxjR3y/HkQjJ2ViUs5dU9LFX3e42pgzpkkkHBpJvacsB5Jz/uCypqVT3ZJMPHa
 9qfl6Sfu7Ne+UmmskwXA4GyPgELLUBvoOPnFEte1gbLVDQAzQq9vEV/13Or2T1U447nT
 uNCg1GhFh94lZ3ud2vQXQlTZW22+7wg/p867Bpzssb+l5QKtoj0gCEJKBzI+DcpA07B1
 Ja5g==
X-Gm-Message-State: AOJu0YynJylTnahdBRNSijx+tbisokNkYK09Uwm8U+erCuz3M84Hqex/
 lueKG+yIQpNRGaHif4pSXBwqYVw/elxWEXcyZyVj/L/jjQD2A7UxrEp7L3xUhAnH1oAyTiIqihy
 s0cILnBcbJvyXrt/xRT/uuiTADGQ0Yzsl6ebPqFekAaJVr1k3y3w8IC+6Azc2+PAyAjMuAwdmoX
 4dfO+gvgcisRkyV5Qq4lwofmu8ZSS99xUkBMI=
X-Gm-Gg: ASbGncsNWBt34tnWiOGBDtMQ0BX5rePd7OaYcBqeyhrowpj22rV4FR8BwuF/bgC0mHk
 civciJtK0JjlNQHj7m/dYRm+HRqprarpJ3FRT/OOX8vXSSTH7O02q92kxK+um3XbZOg0r2owxbF
 7jZol/
X-Received: by 2002:a17:902:cecc:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23601cfa32dmr199532635ad.20.1749520959625; 
 Mon, 09 Jun 2025 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFShUOEe7tAmcuYYFC/Houandx4cgaBmpXC6lmho+k7kLIqWWuzxPz/ude8MRItiCo+BpnU/sJXdr4zx9ociv4=
X-Received: by 2002:a17:902:cecc:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23601cfa32dmr199532385ad.20.1749520959289; Mon, 09 Jun 2025
 19:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250606110541.220472-1-liwang@redhat.com>
 <20250606110541.220472-3-liwang@redhat.com>
 <aEbVV0A3jG1Knv51@yuki.lan>
In-Reply-To: <aEbVV0A3jG1Knv51@yuki.lan>
Date: Tue, 10 Jun 2025 10:02:26 +0800
X-Gm-Features: AX0GCFuv2_M3ncYlFFVkDLV6uoDzmceSZwnX9CDw1ArZwKmmNkqS_96AxJ2Z9yA
Message-ID: <CAEemH2e3=LpGHR1+BOoqOhFOH8XHRo2Tdd8zpJT0dgC1jgU7bQ@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sdZ9g3ngiaXqawSFE_EZDmFdUSl1cPLq5971t6HKdAI_1749520961
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 3/3] lib: moves test infrastructure states into
 a shared context structure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Patchset merged with minor improvements, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
