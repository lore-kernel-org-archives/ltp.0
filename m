Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105AE674AA
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766408328; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=BLyCzdaX1hJ+99Wmd2mbPuK/M+SfuH/0zC0MuSXQeskQRv83jyqLrc1fE8GkxLGVtB6Zl
 VZ5TF31X0Db/J4LOuMAL+dD8GyJpRYa+9PRSxkMgrAXwYkTIyJUyE8iahenyfR2x20yB9LF
 VVrn+tRO9/kafSkzK/jzCuBlhWmNGLc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6293B3D06EB
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 13:58:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109C73CF6C2
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 13:58:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BCBA600713
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 13:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766408303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=RlRBiUvHSKMmmMOAd50Z5+RbCp0ADW95OuRXxnZ063FUWPMZrbFp8+7BRuMxY21gTGaGAe
 jGkNRqOSVs9Gpl2N5rMWJDq/TKVxMKbKNfLPikbbPlQd9ecgSrLYioQM8VF1ikLQfaSsT9
 ZVSeaaPTUKANkZ2kmTyrDK4kx+jjbPA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_yBXmWyaOzen_Kaz1lkROg-1; Mon, 22 Dec 2025 07:58:21 -0500
X-MC-Unique: _yBXmWyaOzen_Kaz1lkROg-1
X-Mimecast-MFC-AGG-ID: _yBXmWyaOzen_Kaz1lkROg_1766408301
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bf06c3426b7so7836006a12.3
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 04:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766408301; x=1767013101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=eUte2S9PIHxiixc/8mvfnLZ573aI16j69dybLRdliQtoWXgrNDfUtUNGRoGIBKMgUK
 Ja6gDqQq6ZoyJ83Xc9j+gdj7trrjBm0KGW76wQomMrcsPg2X4LLPuajVJJU/qYEkwNXT
 jbSAec2aZt1po0yYJ25slcW/FRCzJuatvYZSzzIQvq7aBSoDf2JtKuuPPKrDL5U1n54G
 NtpdluHUaH4MABhMutdDrtKyF0HTKEIK3wjg65uFs7diiIShkEITW5hvtbRiO+IUGqFB
 T60uufz2nf0qxzt1wjpxd47WRPqU4bHWpioyGcF35Nab1cYuxjWSpJHiD6qMNmtvSQf2
 RJsw==
X-Gm-Message-State: AOJu0YxNfqn6WZgiGtefXT6DHebsdbORMVm66F5g9kNensozMHKRTBo6
 sKyES9uUUMBSQEFFGtEwN22D+WPOoIy72GqVQ8dGPR6+F6f+TmzsKBSNffhi/PWfU0Hd1K+Fs5r
 0N7H9JpEUdZHfqoAcuWqGoRbGG6Yy/tHu/NrJUzmEf+ZOp0XdMlA19VJ1JSLfcsLgQZkjmE0h+k
 LTAxJCynPhHT9ZAGGVuZu9aIfADqM=
X-Gm-Gg: AY/fxX6xSQgzq9JJbd9soCiXGIFgRHYNEFIAmqTZk34AIZASKIY0Y5mF/iZ4dH88CYu
 qdxPTrjMUgtBDPIA/96IEwQbSWzDq9kQio7O/6UAchdJiZwmp8gW15Nd6+M6rr8Pbruoo262Xo/
 MiaahB7ugr8et7+DF8tIGBAHjZDBSlWyN4Wi34Mmycn1XOZu+H/siy0T3FqFGnOYoujxM=
X-Received: by 2002:a05:7301:805:b0:2b0:4c8f:947e with SMTP id
 5a478bee46e88-2b05ea0b5dcmr9465210eec.0.1766408300842; 
 Mon, 22 Dec 2025 04:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFju4YH82k6szBwwtxvLO9BVa2lJ8j7dPmnrXpZ0QYLKEHw0uYskHiPEs8fsTPHWR8AWEzGAzH78r/VuwFvPNs=
X-Received: by 2002:a05:7301:805:b0:2b0:4c8f:947e with SMTP id
 5a478bee46e88-2b05ea0b5dcmr9465195eec.0.1766408300426; Mon, 22 Dec 2025
 04:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20251222094428.87910-1-pvorel@suse.cz>
In-Reply-To: <20251222094428.87910-1-pvorel@suse.cz>
Date: Mon, 22 Dec 2025 20:58:07 +0800
X-Gm-Features: AQt7F2pjkHl7qUAYWrQMdARka-Fg0u96AhdK6rw6tUdC0jX-_-105kspNv3pER8
Message-ID: <CAEemH2dNPVh1pONN6GLY__YPnTiuj4-V60thZNJzEic2jL7YsQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6VCGz5XC7TFnSRLmMGKx2zo2cz6T9OvXgVy0ELUrblc_1766408301
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] swapon03: Try to swapon() as many files until
 it fails
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
