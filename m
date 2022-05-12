Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5D2C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 19:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE4573CA9D3
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 21:30:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8FAE3CA8CA
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:30:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9EFC1000489
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652383823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peTLt77iCcMOXFi17DqDjqCPh6WC85vXuXPGeWiNqiI=;
 b=LGY00w2f2P6rEjFDWpzWOjEhSX59/0ohCsav+bLjq5zu+CoG4Ud0FmJ9t94rBVus2HoKEk
 vAoDGj1UuTsU66E3m/K9BXIExG4Jx2uG5TVXZKrbA3Xw/AJDyLyhQ75palQmkyQAgK6ZBL
 wMrJpRcL5ZPHdhsNHdqBLV8eliGsn8M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-wZiPsgDXNdm38SNL1oMUEg-1; Thu, 12 May 2022 15:30:22 -0400
X-MC-Unique: wZiPsgDXNdm38SNL1oMUEg-1
Received: by mail-lf1-f69.google.com with SMTP id
 d16-20020a0565123d1000b004758e4b991dso808027lfv.12
 for <ltp@lists.linux.it>; Thu, 12 May 2022 12:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=peTLt77iCcMOXFi17DqDjqCPh6WC85vXuXPGeWiNqiI=;
 b=ysu9GOInikdF4VXVFfdI/uV7Y01OhENNmONFT98vYoenmiYhHyE9IOr2uHnO4USlWs
 8biZaBzon8xCmu7QrB1fSSxdcdNbkw+cLkgNGB1lAWL+VUzsvX7XQ8eRUIj2SzdT0iML
 0Y1PS9EnGxYqbFGLxrxlrzxOXwzdWyP9VsCaizfUzPncOV81O3pS05NeWegdU53nsS9p
 ZhzgHHzPfh7mLQJQM10lODkhVEO4ELvfYUy/FqD5+Bksyrz37qighN6b/QQYLtTAv58C
 EDUMjf6dz/VWaw+UDspr6ZvjH3yhBXDk45VWgr8AbnuCKy5dpvdvToo9R2Y76Rptndb7
 FjiQ==
X-Gm-Message-State: AOAM533o+2YZbhS/Ba+8SdzHV4Kvql+shhU8BhOJZ2Y0I45EI2Kf8e9L
 G/Lfg1wTyCEv75ymiLWPME4r3jArij06oBf0nTfxJHEcM9KtXYti/SH/tLgKiCKVk2vCrmYmMrY
 Lruw67tMQlmfqXOGiJHchK5M3ufc=
X-Received: by 2002:a19:c512:0:b0:472:1c9b:546a with SMTP id
 w18-20020a19c512000000b004721c9b546amr939970lfe.110.1652383820724; 
 Thu, 12 May 2022 12:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWM1QcWEqqXwMaBwytUdoqEO241nPs8/kwntePHgwQQVtbnx4LsU8s+/BHVhlbr1oI88ZvFiobH9hmLvC07mc=
X-Received: by 2002:a19:c512:0:b0:472:1c9b:546a with SMTP id
 w18-20020a19c512000000b004721c9b546amr939961lfe.110.1652383820559; Thu, 12
 May 2022 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220512131002.26093-1-chrubis@suse.cz>
In-Reply-To: <20220512131002.26093-1-chrubis@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 May 2022 21:30:01 +0200
Message-ID: <CAASaF6wSrroB1gcXgztHmntaRaW=bQTA2abua+O4qsO5UJ2ZHw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: raise SIGFPE directly
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 12, 2022 at 3:08 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> The SIGFPE for division by zero is actually not send for quite a few
> architectures (ARM for instance) and even on x86 and x86_64 we need to
> work around compiler to make it generate code that actually triggers the
> condition.
>
> So this patch fixes the test in the simplest way possible. the child
> just directly raises SIGFPE instead.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
