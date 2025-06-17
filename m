Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27CC7114A
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 03:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750131965; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mOmMGwo+MswbJhn0E4G0e0sdy4TYR8uN3R+dDWXl1Ao=;
 b=QP/Ey6E+66uwmdmLugMAjgUWzv9t0l/+0qpSjcTNJEAJUpB7RxytrXsh4FQUnJBqIB0jF
 RyZ/efPWIn7jBUI9VR0sPYeaANsiSR4G49dSRtszDsRuK3qyX7H0IF3u5WycNeQikUiTEfN
 udAT5VnzOAgZPayVLXaEU0EFBV+28QI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D64813CC1F0
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 05:46:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B343CA36B
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 05:45:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E7E3D1400E78
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 05:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750131943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qIIyApqXP88hv/7z4dFHsMfOmQ5p7e/HD7YkodFafGs=;
 b=M87jXyuBZeD23zw6rS/RMR1A2ycB+zqyGUuI34WRY26jxNuDLhhMYnlyA+sxQD38i8xzmf
 Wbrt720UntifQyRWVnc+Jtn1mDx+ANlD9WYR0MVSKvYCp+4zv3sYHcpmRiMW6L3/G2TFnW
 pfPVuQm1sxWDkF6IxvkwcGBfFGi/NKk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-pb5v8g-nNp6AWTUmyqoTuQ-1; Mon, 16 Jun 2025 23:45:40 -0400
X-MC-Unique: pb5v8g-nNp6AWTUmyqoTuQ-1
X-Mimecast-MFC-AGG-ID: pb5v8g-nNp6AWTUmyqoTuQ_1750131939
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3141f9ce4e2so1447141a91.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 20:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750131938; x=1750736738;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qIIyApqXP88hv/7z4dFHsMfOmQ5p7e/HD7YkodFafGs=;
 b=KQ6qgb9VtA/wWknhj1/GEX7Qz3FCVwvny/sp1B+3fBSTcoA+mqsmwHtg2Ok7YEF052
 SH2vzJ2HSkYfL15gWCrWym81PbAr0BwiQs634pSKbD634W7QhGe865cY7CTYorfiCqbe
 tO0iT+9yqvqB1bKMA1yf9TiqNhSpJFHA81RDBnCbvYtXM6ayohZpv5Twx637JFuGsPwX
 bolIc8NRw9zZhd9LOXu1kd8oNC77VQz6+hNdFYq4NMQw0FRHEXkUCo4e8S6sljA4Qtcf
 8BQzFbLYOLM3kMAMQWsMZt30eCKOAcq57RPKMX1JaygWXXTgtka+XWATpReEwuaVnlUE
 gGqg==
X-Gm-Message-State: AOJu0YwPVgnHbvk1s2Q7Wn9OzI+aVTbHWxTZxX1Ou9FcBrneN9PL/Wml
 oqHMSRlRgbXMty+uTIMD2lUBd8kvFKtlnep8xZjr9YAw9KV2NVAOH9uoJ4qyTPrhMGC2KkKJFUe
 uoySbSKZPYJZMmfJbFy7/ApdTTobB3X7fA4yZolStadRQne+rp37NwHTE8y83j/9XLl1YgXKkF0
 mgkqV+V4tI8h9tmBFbTmhdCRzd9oBCSnJyB6E=
X-Gm-Gg: ASbGncs8BptX3CJBN28AB7wPNPWvN2zTZrIL/+ORqyhf0QQ4A41FGHyxOqoB11LeAjC
 I0JeU8MBPnVuxotKS7+Ui8fMmJdFst7IxZEb2mmhZk075hVbU2ViAah83HWHoRQSLH0yghLzdKC
 0YfZKe
X-Received: by 2002:a17:90b:4cd1:b0:311:f2f6:44ff with SMTP id
 98e67ed59e1d1-313f1db806fmr23426653a91.17.1750131938216; 
 Mon, 16 Jun 2025 20:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgL7g2P0K8HKdWNfyPkoKjKTswVLkXreEtYb4bUkMla3wmgnZKcIP8zN8HfHYjLeKt70PZoghTtPCI6S9E1rY=
X-Received: by 2002:a17:90b:4cd1:b0:311:f2f6:44ff with SMTP id
 98e67ed59e1d1-313f1db806fmr23426622a91.17.1750131937828; Mon, 16 Jun 2025
 20:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250612034229.310523-1-liwang@redhat.com>
 <20250616144234.336032-1-liwang@redhat.com>
In-Reply-To: <20250616144234.336032-1-liwang@redhat.com>
Date: Tue, 17 Jun 2025 11:45:26 +0800
X-Gm-Features: AX0GCFuzQX_RL5VBDDc9DPyOnWu8zM4MnGy_WKbf2Ia4r78jHXMOsHF-dexMkPQ
Message-ID: <CAEemH2fkysKbRpEGYgaOs-_bs9H8GtMsiD9ReYFv9H1SEKBHfQ@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OTN6gGTYCDbnA1sA9F-6ZVbKV_JEXbnH2KjwkZTNKLA_1750131939
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] lib: suppress early TDEBUG output before
 context initialization
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

Patch merged.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
