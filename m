Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C5EC875F
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 22:29:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEAD93CE9CA
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 00:29:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418C73C9274
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 00:29:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 60A29601577
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 00:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694125759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIwaZcO7GJ6pSB2T1x/kgBOyfcdLhsFsoMJWQAWz+S0=;
 b=Gb+TilNMDTrMroGVMk/bx8zU/ifnjlTJ0wvrSKUzDLWvqVgWijHqWv3uCGhwHjBOeondoh
 a/rKj0TuuTkEyZ0G+ByxObC5CaJRnnY8Kc+t0dyNDvK8aKyjWyhRgD6V4idbaQBsnGPIDI
 4CkKs9eC0aItgR+gQcNumhJzA9G30Mw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-IcpbnlO3PgajxrRXv3dKHQ-1; Thu, 07 Sep 2023 18:29:18 -0400
X-MC-Unique: IcpbnlO3PgajxrRXv3dKHQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-574155a12d9so129410a12.2
 for <ltp@lists.linux.it>; Thu, 07 Sep 2023 15:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694125757; x=1694730557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIwaZcO7GJ6pSB2T1x/kgBOyfcdLhsFsoMJWQAWz+S0=;
 b=D0xLa8hcsYw21huNJQAIUXSDVmOQZDZFsY/nErF0pITnuXMiCh82AHczoj1dxSOKiN
 VqbH5tsRJ8Q1KeVmmK4+uSB3GDz4ZIFQGIH+rwFUGIvHs6WpIObOafXvEwgPoUG3HuYA
 bK+WEYACcDeUEEKP18k6qm0cwBScu6cKp6qdTIZAdo1uOzcwsO/Oiybj1Lr0xKv3Gbto
 He/qpGS/3P0Jz05GUzUjQ3kyi0B5UAQiJF9ll1OAfe1OLXz5GaJqzewaozeNr8/ew6zy
 0aGkSUlqhaSY5ZGKIWGV+DQVwIbydgP+pDzKezsb8Jd6kYf5g1F31hjAF3IVQ3FOGa9B
 Sxjw==
X-Gm-Message-State: AOJu0YyMZga1CZ0TgGlCiUNYfEbGIiOQPjx7aJJjzvp/8YR5pZLRs3nE
 mdfbY5ZqdvdQT3Z59oNWBiSOXAr2Evm/CMKyqlOCFdBkmEknTq+JXMjwpoWycJ7rNxPgXtITv66
 iMDjHnOilapQ=
X-Received: by 2002:a05:6a20:9144:b0:154:4246:d63b with SMTP id
 x4-20020a056a20914400b001544246d63bmr930158pzc.25.1694125756974; 
 Thu, 07 Sep 2023 15:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERnJSBm97KI+q+YqcqFPp5SAHmVhsq2rxdgyPij9wmOUC/hNWQLujz9qWs5YPyBJArfxyebg==
X-Received: by 2002:a05:6a20:9144:b0:154:4246:d63b with SMTP id
 x4-20020a056a20914400b001544246d63bmr930141pzc.25.1694125756606; 
 Thu, 07 Sep 2023 15:29:16 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 o25-20020a637e59000000b005649cee408fsm115171pgn.0.2023.09.07.15.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 15:29:16 -0700 (PDT)
Date: Fri, 8 Sep 2023 08:29:12 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
MIME-Version: 1.0
In-Reply-To: <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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

On Thu, Sep 07, 2023 at 12:18:38PM +0200, Martin Doucha wrote:
> On 07. 09. 23 8:46, Ian Wienand wrote:
> > I don't think adding another test really helps.
> > 
> > I think the best course here is to fix zram01.sh to write enough
> > random data to stress the compression paths and further sync to make
> > it reliable.  This is what the patch proposes.
> > 
> > If there's some agreement that the investigation above is valid, we
> > could probably remove zram03.c.  It's not really doing anything
> > zram01.sh doesn't do and it is not really stressing anything either.
> 
> Please do not completely rewrite test scenarios to hide one failure due to
> filesystem specifics. If this is not a kernel bug, the correct way to deal
> with this is to disable testing on vfat in initialize_vars():
> 
> for fs in $(tst_supported_fs -s tmpfs,vfat); do

I don't think this is the correct way to deal with it.  I think that
you're probably referring to earlier mail where there was a suggestion
that this was a ppc64/vfat specific issue [1].  I was seeing this in a
different context, and I believe the zeros are explained by no data
actually being in the compressed buffers, as explained at [2].  Hence
I think we need to come to some conclusion on actually writing data
during testing.

-i

[1] https://lore.kernel.org/lkml/3ac740c0-954b-5e68-b413-0adc7bc5a2b5@suse.cz/#t
[2] https://lore.kernel.org/lkml/ZNB2kORYiKdl3vSq@fedora19.localdomain/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
