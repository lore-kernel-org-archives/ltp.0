Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2CCC48BC4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 04:11:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B2073D0B11
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 05:11:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A893CB8A4
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 05:11:25 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6370C601351
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 05:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708661482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2CyIPjpVwWnXt7J1JHbNw4bU5FfrXftZbYTkX+81vc=;
 b=c9aVox0XO4sQSVowxWccSp7mpIEqcTgmMuTPwIJXe4EpZFtMTOgP+kwWkAB6y6mde4OQJj
 tAK6BNhtdocIVSSNeYvO/BcMlBjNzp09fomv0s3nrc7C1tqS8Cg940BVSbMs6gNRh5RxFc
 IzQJ/lunlzT1ECV9489Zfu3HBicmZpY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-7sn2ghWlPSKlB6M5nJ24MA-1; Thu, 22 Feb 2024 23:11:19 -0500
X-MC-Unique: 7sn2ghWlPSKlB6M5nJ24MA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5dcab65d604so334181a12.3
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 20:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708661479; x=1709266279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c2CyIPjpVwWnXt7J1JHbNw4bU5FfrXftZbYTkX+81vc=;
 b=uN0K69qA03smtgNMeG9z+hT8/AH2cJeJAQc3kupMP0Nc5NdsU/L5xMX522XAgcaccx
 JVg7vXtItZAC5OVgfftRsAzG76BXzCKiA3g2e0nN+Y+ei/v6/epPiAsNGnM/N7IRgRjw
 SSvE5MBTKOwv+yqHobPAICNjKodfYGhggpGorAtFxKXswiPU6nt+Y4aAzOM/SYyov16q
 feReAzAQhLOUaBIKxoa5eMu8a7zmoJWOtpbUXbj+HRPk28v1/Z01zmMdbly98jkozjtm
 S0X86ji8myL1IMszaMkjdDeKgcPSqSHpScbKgdYw71jHcOLaD4lKaqpp+qQgksy+iwFY
 ZxZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV7DHgj43F6oFqppZJJofSdfrl8kV85pvIxR0QGmQzylZHXFkhYbGlp3W667AqF2qnn9YUT/2XWnGBoOAfg/QMK+c=
X-Gm-Message-State: AOJu0YwAclcHwbBOfBfwRV/vm1EwPwzFglQkSR/nsEoFe2oZ3b8ubeAS
 cmkVZ9Swfsxyhx5UvF+5GK8Rk52jIOwQT2+EQ1xR+YIeUlJDKbY8oPoQydO8x5ArzUJrQS8nyx+
 BW0Qp6uX9B6hLMlmKv25uPBjhFKq/njPQ8hpTjRLHzx1hStowBFHX3QoZKQjYTuNl3a6wSa12/I
 Dsl/2X88qTGWW777+mZbtIOmM=
X-Received: by 2002:a05:6a20:c706:b0:19e:ca3a:612b with SMTP id
 hi6-20020a056a20c70600b0019eca3a612bmr886588pzb.54.1708661478799; 
 Thu, 22 Feb 2024 20:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAso3oczaqw2mBQ0bqMOKm+/zzp1++zJeW+6dH17jOYGLZnP2T/lcnNwEiQkJGS4Qh3n7Sn04vTaSchNWn8rk=
X-Received: by 2002:a05:6a20:c706:b0:19e:ca3a:612b with SMTP id
 hi6-20020a056a20c70600b0019eca3a612bmr886578pzb.54.1708661478529; Thu, 22 Feb
 2024 20:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20240222044119.28500-1-wegao@suse.com> <ZdcIT1WiEfV7MCQ-@rei>
 <ZddOKzhl1semChgB@wegao.166.144.58>
In-Reply-To: <ZddOKzhl1semChgB@wegao.166.144.58>
From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Feb 2024 12:11:06 +0800
Message-ID: <CAEemH2dtarpDtPuzHgG6eeoB3Bhbfa1u9fjsb6dBFX-rPg-3dw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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

Hi Wei, Cyril,


> > I do not think that this is a right solution though. Is there any reason
> > why we pass number of blocks to the make_swapfile instead of megabytes?
> >
> @Li Wang, could you give some clue for above question(for why pass number
> of blocks instead of megabytes)?
>

I just keep the function interface like the original
(it wasn't designed by me:), but I guess the only
advantage is to test 1 block for different FS types.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
