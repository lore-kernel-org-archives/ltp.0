Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF2EE020F
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 22:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC4FC3CE76F
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 00:21:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7603CB2B3
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 00:21:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A67BF608A6F
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 00:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694643691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84Xkv1JyregwU+YYnyN6BkaXMmjydT3Wm0LTZovmwFI=;
 b=LDX1JbDmXlpxL4VqDWRQFItrb4jJz9FEvbJaeq63a3BCOYZAk2NPlxeRGjcRLBz5q7NYU/
 P8Bl9Ej4Jt3R17+lnlz4driZE8WTrk7WuioKyTX8DjBvMKzpV3WUFzEelVxYpRvYGHr8lw
 e0F0O5PvGbQBjGBTSEgHuyygwZ7hZes=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-5dZE5PK-Nkaz_YtY0sk4DA-1; Wed, 13 Sep 2023 18:21:30 -0400
X-MC-Unique: 5dZE5PK-Nkaz_YtY0sk4DA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1c3f46487fbso2770875ad.0
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 15:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694643689; x=1695248489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84Xkv1JyregwU+YYnyN6BkaXMmjydT3Wm0LTZovmwFI=;
 b=Q8JeEIWx/jiFF7PCz73VYTwyWYmcEF18sE2vDfA8sP4vTlHoKerOIm1s/iMfEjgalE
 Fi11YJwilLU8jjqDH62xk4YWWkk17sgI8MjRW3zZHcYBqz1vRos7GESl+4+lYfXzX0A6
 42y+0u6x8PceujBxBshl217Gu0dRug2jjpLcBPLuTT0N2ilORm93+Ou1hL4nhwxH6W58
 JuWKboNBIa5smYE3xU5bKr6Y8+RN4T2uuQ3JMLUzuw5pGOlj5WNEnwp7v12cZuajVvPt
 ie7ivxsA5ncWby3GqHND1qK09SndIqZjbJeqaGl4Z7aefO72sbZYyWYQQIJAs+N7ROqU
 7KPA==
X-Gm-Message-State: AOJu0Yyyh5kZRORDN7a6w8LoRvXJNkEwT7XhBj2mQgt0UBDlmQWVMl5Y
 Zr5Nv8h0+WdW9W3WII3gv0nuHWjClIUP1LG29GvGMOE/eXwzaBwEN5gvj0aqANpsmydhB4HcXEY
 Vct/Rwn6X70s=
X-Received: by 2002:a17:902:ce92:b0:1c3:f764:8428 with SMTP id
 f18-20020a170902ce9200b001c3f7648428mr2073170plg.0.1694643688843; 
 Wed, 13 Sep 2023 15:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB+cjnNc9iwViSGkrsI+8ho2P3JG5u5Wh2wQIh57bOwcJhxK1Ut5wORaB2KXGmtj5PDX/5Mg==
X-Received: by 2002:a17:902:ce92:b0:1c3:f764:8428 with SMTP id
 f18-20020a170902ce9200b001c3f7648428mr2073148plg.0.1694643688466; 
 Wed, 13 Sep 2023 15:21:28 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902ed0500b001a6f7744a27sm117413pld.87.2023.09.13.15.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:21:28 -0700 (PDT)
Date: Thu, 14 Sep 2023 08:21:23 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZQI14xCNkc4wjpC2@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
MIME-Version: 1.0
In-Reply-To: <87r0n2gip5.fsf@suse.de>
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

On Wed, Sep 13, 2023 at 03:35:18PM +0100, Richard Palethorpe wrote:
> I would suggest just using sync, but Petr originally suggested using a
> wait loop. Then reported that the bug was still reproducible with the
> loop:
> 
> https://lore.kernel.org/linux-block/Y3s+Czg8sBsGYO+1@pevik/
> 
> Then said it wasn't reproducible. The problem is that if using a loop
> doesn't solve it then possibly the VFAT meta-data doesn't get written to
> disk in the absence of any pressure.
> 
> So instead I'd suggest resurrecting Petr's original patch or at least
> his approach. If we merge that and still see failures then maybe it's
> worth investigating more with tracing/debugging.

I do not think the original patch [1] is the correct solution in light
of the further investigation that has happened after it was proposed.

[2] is about the clearest explaination I can come up with, other than
the patch description and comments added in the v2 patch [3].  I am of
the opinion that to be useful these tests need to explicitly make sure
they are not just writing data that can be de-duplicated.  I do not
believe the the intent of these tests was to have the only data
managed by the disk a very small amount of file-system metadata.

Sorry to sound like a broken record, but I spent some time
investigating the paths taken with [2] and confirming the stats that
were coming out were not due to some kernel issue, but it really was
that the backing area had no pages allocated to it at all.

Looping on a sync might make the test pass in more cases, but I hope
we can agree the idea is to make the test better, not just pass so we
can continue to ignore it.

-i

[1] https://lore.kernel.org/linux-block/20221107191136.18048-2-pvorel@suse.cz/
[2] https://lore.kernel.org/linux-block/ZNB2kORYiKdl3vSq@fedora19.localdomain/
[3] https://lore.kernel.org/ltp/ZPpOuK9lyWr2wZWI@fedora19.localdomain/T/#m1e037003252012ac115e57285a926db77380897f


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
