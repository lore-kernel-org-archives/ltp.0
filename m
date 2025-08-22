Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4751CA0EFA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 01:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755824432; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=R4KDRVwm4If1fZutjM+66w3ydmkpax87gTRcIMChCOM=;
 b=iJRQIwJ4t7mRw4sgz9YSfhnrLDJNryZHfiNXTkt6qPh/cUMf0g3Z4qbd2ByiUdNRnnbHF
 Jx9IJ1/7TqBL0mYSXCQioZu3Pb42MLCVkHePU3M7PTpI2EBq/Cl1n/KdugXA2e12myOghKa
 WUYSlOPzQ5BB+64U3lw2KvAjLcK8P8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EDC3CCB9D
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:00:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4885A3CC997
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:00:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEFD46002BD
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755824406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0VmO9vFs01fsBO+bkRGfwJTxaN5mrpyKIUtyIXgh0k=;
 b=ZL3E0mK8ebYezh9iynWPON2Se+XIkjTUrjwQkXrBsUroE78yXfKiBcLigt4ScKk1Pt5x9z
 6mDTVVsSRVa9BdptZ4nZlusX78rBPmKBSSvEyGr9nVB0RISTSWbSwytNPY2gJkgpz7cp/p
 zdtgncpaBtbUplDWQu+/XH2WWt/aKuY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-zJgq84Z1M9icMz7o0S6Gtw-1; Thu, 21 Aug 2025 21:00:04 -0400
X-MC-Unique: zJgq84Z1M9icMz7o0S6Gtw-1
X-Mimecast-MFC-AGG-ID: zJgq84Z1M9icMz7o0S6Gtw_1755824403
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b471737e673so2766806a12.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 18:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755824403; x=1756429203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z0VmO9vFs01fsBO+bkRGfwJTxaN5mrpyKIUtyIXgh0k=;
 b=lSeO55AYXNFR+6FSx4B2Fl+0LHpf3fwRp1NKm6t8h8HuckXaaorGv92e40iYZ4/GAr
 ixdTIuignAW6n7VA/TE9tKwi+PwvBRXuurDJtxTOgrAagJJsLeZRKL1ul9hqt+YIik3S
 kkfpr89lW3ANsHHtOb3lA56fsS5Jc2oRPn3Oy7IpLz+nCIYU+brxKD60uJlUS7PxGWI/
 dnvgzkvb/oSHE9n+O8CBkQhokPssfcb62LaCNaFB2wrezIT/G0Up8ONMB/KunZKzv6Mf
 f4dyXfOEhz86Q+b5ldt322JtjSd84xDLYgronX92CI38GhFA+kP1+z/KlXwSP1jmoa61
 xqNg==
X-Gm-Message-State: AOJu0YyA7/6/pmoPjs9xgOatFBqGMBtB1VA2oubuY1Dpz3XtEQeZrHje
 bfV9ofSjRJf8P9p2RYYFdJ0yawWzDcxsOlJPbmKzZI5wBBnnhAY8TBcuGF8gdZnESHC9SgskcQo
 nZeW0PmEUtyFI59vXTNjEhCItrVYmPT8h/sSUMLY61ih6APpDwNPeUCm31qdYkD459WS9vmbLGL
 hbGOl4fa9xWgZ9E7hER8KwZU0n+zA=
X-Gm-Gg: ASbGncuC+TobjQt4ntPKV/HcZjhm9FAOHnGvtB7Rp1SDEk8iHqMLS39JctstxNigxHc
 NesBIF/2ZFXBg3ywe4U582sP/xIfHggnGVOkhUV5HOKR24aeWyKxlmDXXdhbcaqa8PCD52DOMEk
 x2MZvEzPek476YPcKtdqECdQ==
X-Received: by 2002:a17:902:ec87:b0:246:255a:1913 with SMTP id
 d9443c01a7336-2462eeb7630mr16126345ad.39.1755824403533; 
 Thu, 21 Aug 2025 18:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXTTSb1O8y6Sxc0hQZF+X8YoB0xeAAkN/GgnOzpXbPE6NWe5U7IRTHa06A6OWe9xTLKnumfbhstZRUYwb+vIY=
X-Received: by 2002:a17:902:ec87:b0:246:255a:1913 with SMTP id
 d9443c01a7336-2462eeb7630mr16126165ad.39.1755824403177; Thu, 21 Aug 2025
 18:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250815035415.23499-1-wegao@suse.com>
In-Reply-To: <20250815035415.23499-1-wegao@suse.com>
Date: Fri, 22 Aug 2025 08:59:51 +0800
X-Gm-Features: Ac12FXzeqlhazm7PDutJKycM-ERdz97E-Dv2V2z__v68uSqh-quk2pN-zbz_kfY
Message-ID: <CAEemH2esU8U7RuD9svydnLWzqwomerDkd-kcm0eh1tvCoGE_fw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lpKJ0oDd85mhFF-EIcvXdT3_FFuB2sZfEtW21iEBYnE_1755824403
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] openat02: Convert to new API
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
