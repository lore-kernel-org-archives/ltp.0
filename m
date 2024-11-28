Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2738CD690E3
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 07:34:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C3603DBAB1
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 08:34:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA81D3DBA9B
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:34:05 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFF696331AF
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 08:34:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732779242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQOBY+NQNhB04HRQaYeoHp93un0PH4obpor4uj+sXSk=;
 b=Ym+4BhTbd/ozz7xGfkG/5qHNRl+XLFy/E5TLyNJ1qMl5zWT8wtu74ESm4NmH3RHHVsaQ8j
 m5co+HkDWACfQ/Fp4rJqlDnqsewot7BncQS09frfz+Xge3p0Fv6lX/ZKNk9X2+xPNWnq8+
 kA65f5HKrdB71JL5OyVXiipzNrp+i5Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-QHRCBoY0NQK-fzIJeyuQQQ-1; Thu, 28 Nov 2024 02:34:00 -0500
X-MC-Unique: QHRCBoY0NQK-fzIJeyuQQQ-1
X-Mimecast-MFC-AGG-ID: QHRCBoY0NQK-fzIJeyuQQQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ea396ba511so684555a91.3
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 23:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732779239; x=1733384039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dQOBY+NQNhB04HRQaYeoHp93un0PH4obpor4uj+sXSk=;
 b=DrBq7JIs9XByFndzy1MTu5G9iL6/m6ddPHKP5KBIX+1wO0FaV5uTTUOan460I8bhzu
 yyNPrBsnNSXVskQvwovK0xoIGQ+mMjbGyNjXWunbDLHBd5vgntZ07DGfPRDcuT1yGzdS
 O/AlMYqLofPOqPmxUoSxpMbJ5qTdMb6AyJcI2WlgZ45IvC9NRaeVEJ9uO2Is6KdrHH7h
 mgb6j5OaUPWyk33UPsGsembPi83zMdz67fhrobV8nkYaykn0RxrDJPbq9zrbcOpB/zSq
 J/Jr/eLxl3jeTIbgqFpQP+U3bU+fTpgQNypxejLzMCZX+VanhgsydIXMvlQIks03bFRG
 7j6w==
X-Gm-Message-State: AOJu0Yx90i4sBH/7FFw6LRFsS+D7zYh7W7GWnrpGy/k3SbeWc8i2cZs3
 ZfxDVu76yE08Yj05M4AembUzhR7bEHLcol9t9GL0eRkWUDpZvjSJqSzPz1QC4oMOV3JVBF4S3lc
 vFavaEov5qNmK6nAYjxgm8B2XPjo8l3OlVo9PA3AgQvz0vOnuh1x1zFJxfs7h1i8+paLs6bxx0y
 OhB1pGGoe7kwXOyZQyirf4KKM=
X-Gm-Gg: ASbGncvFEZ/38pWm6s77utLhLNTwGCJBcFlp1SME01ELp7urgKcDtd3jQEbsuOyIUzC
 I30aRtX6VUlRyZJae/qeFxc8pvR30nlqg
X-Received: by 2002:a17:90b:4b8e:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2ee094caf27mr7740473a91.29.1732779239584; 
 Wed, 27 Nov 2024 23:33:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY+DhJMNej4p7zjflB8DY1fajPKEC2g2YoJqn5F1HBQaOMk85hjsBmVXDnfI7fOAmgWqHW6RgU+1JU5QHnOxE=
X-Received: by 2002:a17:90b:4b8e:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2ee094caf27mr7740462a91.29.1732779239233; Wed, 27 Nov 2024
 23:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
 <20241125-input_refactoring-v1-1-b622b3aa698d@suse.com>
In-Reply-To: <20241125-input_refactoring-v1-1-b622b3aa698d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Nov 2024 15:33:46 +0800
Message-ID: <CAEemH2fGdzmy1Ja1E+fyTqFhN+fg4aDzBnDayZYPjkUb_yh4-A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HY1DjCVW3Vjk8KyKRGgAhtsKE70TbiIPY9TnvIFpPiQ_1732779239
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/7] Refactor input01 test
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
