Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA9C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 07:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749020699; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MgISGDJ9oLG7LMGb8UA4M4ojZCFMgm/F5SGDFxYMhDM=;
 b=K9vHhchtHef4eHSD8MT294Mf2ZxWzaUg0ZMBpFpbT4iNpJU255y5e3Ukt97i4gskPQZhZ
 LiC1fCWhbR+vGh4W9FCTsDiM6EMfSQzTCW+oKVkXTB4sJSlkpVVnmKVj/sNSeah1zuLiU0K
 gxBxMB1k3OCwkwL/pZ1kifkqwnJrPZU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A913CA108
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 09:04:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C5FB3C5788
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:04:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 72BBD1000434
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 09:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749020673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5v7aCKCm5h3ogrHi2IsdSYoli03ynlLm/RKP1o3Xoa8=;
 b=gCVXV/9Tcnq8bf77IixgkvgKbBe8LLgC7zhlr0VgsDpRw7GLiASOPMYDl7YyVuKhg9Dp3s
 Pa+Fjw4nJGjgtR3n0p3Dlr9HaDuLgbsTg0L0G21WHt31jRzFT4eism+VUW5gBlt6xAUbBK
 jjsFXmQLtNP6kZOidytJauz9YVkWQx4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-2HeTfi38OAm354o7Fer0zA-1; Wed, 04 Jun 2025 03:04:31 -0400
X-MC-Unique: 2HeTfi38OAm354o7Fer0zA-1
X-Mimecast-MFC-AGG-ID: 2HeTfi38OAm354o7Fer0zA_1749020671
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-312eaf676b3so2230188a91.3
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 00:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749020671; x=1749625471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5v7aCKCm5h3ogrHi2IsdSYoli03ynlLm/RKP1o3Xoa8=;
 b=RrwKIrR7wZaZdldeKutzU1Tlg2suHvgw6jHuZK6zQuYaxxESPGa1Y7rQHGH6FU1axO
 aWBj4QroyV3tY9j9QL7qV1PtHsl4ZPgFnz0WBCXBgIXTOIJbCJptImspRxQuV3OMvNe5
 lHQr7tWbgURzpkedLAExmS6cqgz7zVo5ktUZvnk0xjdhf8CtZxk9KBpiHLL5lldnnUCP
 YxkoqkSonSzNbDndTTS9mpeBE4qMuDz9gxWRCwSMQqmnMZ6Ce1ghSeXD7nmi7jzlZjXH
 6ciYdone5+8ZiWmU6NAy2TQxZoIRvSljP/adtzlLBEajlgC/qFGpKVnSAXEKCsE18mC3
 q1gQ==
X-Gm-Message-State: AOJu0YzlWHex/5AT+p6kT/HVTaFC7UZvxFTLvc1aRkkrmQ7V6th4gkqP
 /uZxS90asPJP8ud9esAFoNZSh+CzcG28U6+g8uAnqtufw/b7hzP4wHmy2/6IfNWpOo03JGinV9j
 t+zxSOrL1uvoexH5Oag8CDlnMkrg6ZTYi4+bCyrrvPVSjXHcI1rgb/0yRzRDGkzn0ADuzVu7WLL
 ZJSAeT1BN81e+NuGddPa2JDSUftt8=
X-Gm-Gg: ASbGncssNAktmGfTL77jPz4YqVsc7G3f9FaCKm1SPj3enHKiKVc389yVfE6RoVCtwXq
 R/lqZNNqgbPg7aLQE+R5yB8X6UIlezJR4LuHOf5vc+WNMZ5DdYoVnz34LMJ7XtiQYatBd7g==
X-Received: by 2002:a17:90b:254c:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-3130cd862ddmr3318232a91.33.1749020670642; 
 Wed, 04 Jun 2025 00:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGapat45y4rbn3HTESQzDfPrtNSltYgNwZqLy2xYX/aFAC0xfkz2J3RdhpMqnVWlCU4O9yLyRQAoJbCiYWroI=
X-Received: by 2002:a17:90b:254c:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-3130cd862ddmr3318194a91.33.1749020670261; Wed, 04 Jun 2025
 00:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
 <20250515131634.GA493261@pevik>
In-Reply-To: <20250515131634.GA493261@pevik>
Date: Wed, 4 Jun 2025 15:04:18 +0800
X-Gm-Features: AX0GCFvrhnZjDt3Md-4_5gjHwQmKV0xqZtEYllSSTT4LUD2Wig6DwRKu87SKAAk
Message-ID: <CAEemH2cv9r0FOokEeyD-vDuCFTcPr6=1AaYsLXnzGkeo6dQ3EQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -LQip8LMmDX5qaB4B6_LL6uzK6OPirrk4D2lIsjK48M_1749020671
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril and All,

Can I merge this patchset? Any other comments?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
