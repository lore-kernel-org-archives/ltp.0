Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FEDC54E41
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 10:30:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBBB63CE9E0
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 11:29:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6EA53CD58F
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:29:43 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3D9051A04334
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 11:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709720981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dBJL+73Tc5MyppT1DoGtgcY+hCeimCH0FphgXFWNT5E=;
 b=ddXQeRsaDwPH7fUe5+xjD5pCnt2p+63nRBS/GaIiwwTsmxenbQnQ/1pnH7LFDKEvtAv9U/
 HdsEIw3CMBdLuWSsSyQ+QTYM1fdYUjz1/THj7/Zi2qJAMXyfIi15lF3XQ3ABJW8LzOfbxk
 fsfC8E6qjdSHU/eSDYpu0xBue6ZkNNc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-SksmAPgXNP2quw94NIs-pg-1; Wed, 06 Mar 2024 05:29:39 -0500
X-MC-Unique: SksmAPgXNP2quw94NIs-pg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5d8df7c5500so1318547a12.2
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 02:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709720979; x=1710325779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dBJL+73Tc5MyppT1DoGtgcY+hCeimCH0FphgXFWNT5E=;
 b=uzcPXe0E8uxBt3fFk++JAWeMF3x8GYPSRxr6o4OolJqVTQMvNbDELOSroaHiE6Q75T
 QgSeUfTb70Xq03fRrtj1BCdSwsGzg7KBV0zTxYe4XxA0S6Gd8Uq0JnJ0Pk2s2tYML89J
 6APklrX8Kaykmo4S5kxXTkZ4ep1cG5Crw2PgjEWE22iLXG/9JcO52Mq27JZYN0fmaJSy
 A0WOZ5fB5bn/5S1Amp22Os3FIgkEFf9kgDzp+BgUyR1lMtxvFcropl4lQS3OoA/gtwvV
 Z0aeiL9HDt/MchGiTO1BwD60sOiRCa/OYndQKLgUDzDD4hFCKeFxbqy/1wnGEQuu64HY
 YGNg==
X-Gm-Message-State: AOJu0YwAIKJ00Y8wIeX8vH6XmbYqfQUQk8BQZvaS5c4u2l/3B1ls4jrC
 5FNaxN1zpoqBfHJjrSMWPPGMEb83nGONqpy2jvsFIEPH2/JUYTvuwg6WaJ3eEQ1L4g9gJHfXCmq
 Yndu9P991Izk3OSifoMwJ95Uoyz4l5VzMajsBD8/5XjCQwdAzyQWfi7HqRz/+qnz3vHkJ5ot5Nj
 vXcYbHLd2uElu+3spVxGkbcbg=
X-Received: by 2002:a05:6a20:7f99:b0:1a1:4e3d:e323 with SMTP id
 d25-20020a056a207f9900b001a14e3de323mr4475904pzj.31.1709720978960; 
 Wed, 06 Mar 2024 02:29:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVkQvDXlg5cGXptjX2V7jaW+cfwilFd/MX6UJ52fbBXskPBpQHAhYNEUZhkzgMNGbZ0dqlfhnpAY4u5QgsKL4=
X-Received: by 2002:a05:6a20:7f99:b0:1a1:4e3d:e323 with SMTP id
 d25-20020a056a207f9900b001a14e3de323mr4475896pzj.31.1709720978673; Wed, 06
 Mar 2024 02:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20240306085254.534940-1-dbrendel@redhat.com>
In-Reply-To: <20240306085254.534940-1-dbrendel@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Mar 2024 18:29:26 +0800
Message-ID: <CAEemH2fi7pQUX2WVWqz1-px5reA3mcGjAHm=A3j3xnOVqF9vDg@mail.gmail.com>
To: Dennis Brendel <dbrendel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] munlockall: add test case that verifies memory
 has been unlocked
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

Hi Dennis,

Good to see your patch soon, nice work!

Next time remember to commit the patch with Signed-off-by.
  `git commit -sm  xxxx`

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
