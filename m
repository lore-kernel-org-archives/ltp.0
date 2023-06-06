Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B7C7EE2A
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 07:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49B9E3CB6F3
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 09:35:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34D303CB124
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:35:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63EA420009A
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686036945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmQebgeuQyA/flpWa7oL90x9AemJ8SVzj2eLaJn8zSQ=;
 b=WkV7LjNfVqVeBPCMk6S15vWLg99hJN8f3YkduNIlMp+rzd0bKOCBifun1SM7Xwj5Ujym0Z
 vXcwfDoELpgKZZDhYLf/PvqYcV6EEkzFt29qryRynsRb1vZs41ZRc+PUim3kvwbSCkg6/T
 qXXCL0I1rqG0XZD6wFBT8H8CKFb9FSc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-2kNWukmoNTqeqvM3_Ll_oQ-1; Tue, 06 Jun 2023 03:35:44 -0400
X-MC-Unique: 2kNWukmoNTqeqvM3_Ll_oQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f618172ed6so2099155e87.3
 for <ltp@lists.linux.it>; Tue, 06 Jun 2023 00:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686036942; x=1688628942;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmQebgeuQyA/flpWa7oL90x9AemJ8SVzj2eLaJn8zSQ=;
 b=dNlF5hFxAz/phvcaSYKO1tYtdqFcpLtd/J8oLjLHoigBHojbgMHSHaJa9kQvzYADQY
 v3rNGGkAjYX2cmwJzBgTGlDrfcVih8LAMV+VleWqtg/0eLpk4Ia9RWEc2kReMoDBmGiD
 BrxKxbnor/GDQmoDBF5mqkorTWr/3G3R12tdh92JW8w23iyx06SYU9ANFofZVD5TKK29
 pb3jW5PfqvyDfXFCDoogtoT6eM1tT3hFmJE/0Eivnk6r0HfnP8rwDvCERG8lW0ir0C4E
 0jPvcZZ18vvWsvb7KG1pdyJKmiDSLOwAxeFUxfDnfNLTKSQjRpVXrdrSUdjG4rA5oz0j
 y0Uw==
X-Gm-Message-State: AC+VfDz1ff+YnRMDMEeEd6jo3k/tpTMNXjluHaiEtsWTgni3hXrzhGpl
 aBvXPtvH2a8xGN36JDENtq/wKdybdgCEryI8QvugySGK2cwgbVykxUk8EAKm6lVyv7kOzvvuNve
 WFxeHre1iWO3L94X9314t46hfsrY=
X-Received: by 2002:ac2:5390:0:b0:4ea:f632:4738 with SMTP id
 g16-20020ac25390000000b004eaf6324738mr633308lfh.6.1686036942695; 
 Tue, 06 Jun 2023 00:35:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GubIWJIIgbCr27gUV6lDUrQTImHz2o1X4fXotxM8bRXa+2k4xqfYVDF5V+iYO+65wL8ekm0qgsQ4DQ6fp6mI=
X-Received: by 2002:ac2:5390:0:b0:4ea:f632:4738 with SMTP id
 g16-20020ac25390000000b004eaf6324738mr633301lfh.6.1686036942338; Tue, 06 Jun
 2023 00:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230606065100.3873610-1-jencce.kernel@gmail.com>
In-Reply-To: <20230606065100.3873610-1-jencce.kernel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Jun 2023 15:35:30 +0800
Message-ID: <CAEemH2dE6tGeMWvGVsfQpu5kLi+3cDhzzDYWpXDU1=2T3bpyLg@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] fcntl: fix lock type interpretation
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

Thanks for fixing this, pushed.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
