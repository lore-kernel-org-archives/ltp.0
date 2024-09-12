Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D054BEE57F6
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 00:49:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2A173C231D
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 02:48:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5439C3C1D41
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 02:48:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10D69200A17
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 02:48:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726102120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEXgrWPeXJUsB2Ao6sqmxV9HB1KdTtVGKl5SZIwmqu8=;
 b=H8NEBs0FbCdLxnf1vGT3ZIrXadpqJHrTUmJcKAW/PkrZ9BQNjvOK0rPLR+v58HKhjZmvuM
 vi+bjnIahIPa4gtNpn+Qt9xVT7B/sIQdKnRbZWa0STbH7D5yIyGwkhtWsGcxDE8sQeZijF
 o7bba3yYPNhMjOeoYjlZjqGW9Zz/La4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-BPq_3n3OM-iroVajou9dwg-1; Wed, 11 Sep 2024 20:48:39 -0400
X-MC-Unique: BPq_3n3OM-iroVajou9dwg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71790b5626cso431710b3a.2
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 17:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102118; x=1726706918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEXgrWPeXJUsB2Ao6sqmxV9HB1KdTtVGKl5SZIwmqu8=;
 b=L5emz48tk7kDTytpZ4kjr4oLAeFIBnfzKCxpFNjX2JuYclnmr0IMwprTsm197pYAmO
 JYO7dLhThP0xmIxn0uyCyOcJQ3n+t4oAWdRkFrfC0Jfz9FDiCSe5GFRGSTJhISQc+aFQ
 0s0ybIMBhm/zB6RGBDEf1F0msJPUqkEZ/QEcIC9ffnKctX6p9ZFyJ0Qa+shESiTZkOal
 jlJTkp6jTDYmAG3kMsez+t7UDGPZJ5V/QqxsO+m2h+fppXcq8m5borSxYqiW46vfHfdk
 pvAuTx1UvlPGds6hwcDcVumV2UhAj0GrgKOdZKpTkJo5IDF8R3nWPmzI2v7dHMyL61XI
 /jqQ==
X-Gm-Message-State: AOJu0YztdD7Q1Zf5zz3NshgB7YbVNno+qpufqlGFkzj64QP/lGUIvQj5
 yLgXlj7GXtj71FvebT9fu+UEczXZwmXGEicI288gVu9o3UDTSheiJIbsqxIoF+fNSzdEMgUp6ch
 +tAJBNGCq3vTZ+E2larVXtcCSwLfADiORJxShOyaaApw+sIXmC8FCkFAU+o6jlR5Jo5uErOh96J
 96daThKGLL6Wt/SWfAG5Hfa4o=
X-Received: by 2002:a05:6a21:6e41:b0:1c3:fc87:374e with SMTP id
 adf61e73a8af0-1cf764c255bmr1187831637.41.1726102118036; 
 Wed, 11 Sep 2024 17:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH970gL4TNlddb7y6AJz8tQ6rrGe8hg9kWMZ3QUDChx4xe6kuwMwCEksTxjm1vp7ESk58dUE9wmBxNqcij5VB0=
X-Received: by 2002:a05:6a21:6e41:b0:1c3:fc87:374e with SMTP id
 adf61e73a8af0-1cf764c255bmr1187810637.41.1726102117606; Wed, 11 Sep 2024
 17:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240911133019.11059-1-andrea.cervesato@suse.de>
In-Reply-To: <20240911133019.11059-1-andrea.cervesato@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2024 08:48:25 +0800
Message-ID: <CAEemH2ehvQxCpufKNFoDVPmXdsrJoL0B2fB2hL_txfJxjacFXA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add rename15 test
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

Andrea Cervesato <andrea.cervesato@suse.de> wrote:


> +       oldname = tst_tmpdir_mkpath(OLDNAME);
> +       newname = tst_tmpdir_mkpath(NEWNAME);
> +       objname = tst_tmpdir_mkpath(OBJNAME);
>

Nit: the function has been renamed to tst_tmpdir_genpath, somebody
who applies
this patch can help adjust it.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
