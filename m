Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F617CA0EC3
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 01:03:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A9CE3CF4CB
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 03:03:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFDF83CB3D1
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 03:03:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6DD8140006F
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 03:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694480590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bc2YenTOJOZRjGRRsM4v62EpVBictdDoriEaOqx/VFM=;
 b=ET0Ft37b7qWwF7Cq7fKgXsWtyp12uSOJeXIHPh9D78WgkjYjinP09/W938JDO5sGs0bGDj
 qsC1UavcdGEX6qiBLrlJduliA4AXATtCEoC2kXd3Kote5HXAoRbaCW4nBEHNgxOJ3zLAfI
 NheCKqjr/Ug2Et7SBu7pOwSkjP8UixA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Qij4ZCQhNiyaW3rSKnSbtw-1; Mon, 11 Sep 2023 21:03:08 -0400
X-MC-Unique: Qij4ZCQhNiyaW3rSKnSbtw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c3a8af2209so23735965ad.2
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 18:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694480587; x=1695085387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc2YenTOJOZRjGRRsM4v62EpVBictdDoriEaOqx/VFM=;
 b=Wkh8gZvBnRye+Q50mSzqxG07XVKU/Gbe/C8fvZGhkll+J5K1MC+mednTCphaZRUtHR
 5RXe8KoyNPgjUwaIGHtt4G9rVz+ylUh6t8JlBAmSe3nopfi9lIYlWdpsnLNwrtgM0KcL
 qnu11u0x3/g28LNfFvZa9SUY9YJ3nBWp/5wYn68ZZpo57yTzLy4rWH1WNGkLONjUCqu9
 HHTP/1/bBs9TOyroePZgZPM580otEoZW+euchQRtC8oYtab+qSZWtlsHD6hep59sSrQP
 ltjhQgI02CzUqZsnMO6++0hWEtrQhyw2ffETiQKuoiwk1rv9/Gx2o2XtY64r90H5ZQ4e
 1LGg==
X-Gm-Message-State: AOJu0Yx9VMP2P+YS1+PTK5i8uFx3pe0WlPp+B6qM+UzkO562rixpQ/bJ
 0MINiAny3RKY9IPNhJwlMVWRxpQV7p6egzz+2hMTU2X3i7SfGFUMso1Bmy6I6xUt/r5KwAv474f
 BmokYyUR8uXQ=
X-Received: by 2002:a17:902:8c8e:b0:1bf:34fb:3085 with SMTP id
 t14-20020a1709028c8e00b001bf34fb3085mr8652524plo.14.1694480587359; 
 Mon, 11 Sep 2023 18:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWvd84niwCdngfvvL0tAvpi07ZOryZyG2m+5S0MzJh8LnS4HpBZA/qwOUfuZMapYarXuzoNw==
X-Received: by 2002:a17:902:8c8e:b0:1bf:34fb:3085 with SMTP id
 t14-20020a1709028c8e00b001bf34fb3085mr8652508plo.14.1694480587000; 
 Mon, 11 Sep 2023 18:03:07 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902748400b001bbb8d5166bsm7075808pll.123.2023.09.11.18.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 18:03:06 -0700 (PDT)
Date: Tue, 12 Sep 2023 11:03:01 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZP+4xTgAuTBepQge@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
MIME-Version: 1.0
In-Reply-To: <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

On Fri, Sep 08, 2023 at 11:21:47AM +0200, Martin Doucha wrote:
> On 08. 09. 23 0:29, Ian Wienand wrote:
> > I don't think this is the correct way to deal with it.  I think that
> > you're probably referring to earlier mail where there was a suggestion
> > that this was a ppc64/vfat specific issue [1].  I was seeing this in a
> > different context, and I believe the zeros are explained by no data
> > actually being in the compressed buffers, as explained at [2].  Hence
> > I think we need to come to some conclusion on actually writing data
> > during testing.
> 
> Well then, did you see the failure on any other filesystem than vfat? I've
> read this whole e-mail thread again but there is no mention of which
> filesystems trigger this issue.
> 

I see this on vfat; the test stops after the failure.  But I think
focusing on the file-system is a red-herring in this case.  As
explained at [1] I think the problem is more that there's insufficient
data written due to the de-deuplication.  This probably exhibits most
easily on vfat if it's not doing something like writing superblocks in
other areas of the disk, etc.

> Alternatively, if kernel developers say that the caching behavior in zram is
> correct, then your v1 patch (adding sync) is the right solution.

I think this explains why it is the test, not the kernel behaviour,
that is causing the failure.

-i

[1] https://lore.kernel.org/linux-block/ZNB2kORYiKdl3vSq@fedora19.localdomain/#t


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
