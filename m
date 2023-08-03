Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AC8C04A94
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 12:32:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E25D3CD72F
	for <ltp@archiver.kernel.org>; Thu,  3 Aug 2023 14:32:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ABE73CB495
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 14:32:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 366851400E50
 for <ltp@lists.linux.it>; Thu,  3 Aug 2023 14:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691065939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MO+G1cNcyajfaXF05ak7RvL7lBG9/2ShpkFRjbS3mV0=;
 b=fx9HcTZSDrtXjXOROR50OSfq1WaIsNIkPMTVyVvOPQNcNySWn6Z3KMBboF9qs4lMS1Wg5T
 Zquh9MgaNSSoBl3eXxThiloNxAUNXOGzNs7XQ03EJAawurXjtW3xyIj9C4PtymOoAHofUR
 vyeq+Jld3+Yy8cmdsXH1MZ+P1nat7QY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-UuxPlaX1ORiDFQqSwJkO1g-1; Thu, 03 Aug 2023 08:32:18 -0400
X-MC-Unique: UuxPlaX1ORiDFQqSwJkO1g-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1bbf8cb6143so8761235ad.1
 for <ltp@lists.linux.it>; Thu, 03 Aug 2023 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691065936; x=1691670736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO+G1cNcyajfaXF05ak7RvL7lBG9/2ShpkFRjbS3mV0=;
 b=a+bfFvH1TYszsszPnHlUK00NShJ2xQ5GR1Sp2lTHFwoctixE6TM8UzqlL4ct4IAzSN
 zj2u5vc7VeJ9GojkfMKhiWhr+uyWEJfaoChe0kndfqBI2lixe74BgCuMSpbtlQTVr9Kf
 V5PVgENyEej4JGIX6IZRsPfRuhWt23yGS3N5b5Ai9xKm3wFHUJrIu9c9uKmF6U4XbkNN
 e06hOurVVAVRnCB7FR+t953vA++IF9KzoDAIrTyy3MnqbISQ2hdSHZuN6WH3Hrt4TpJT
 AV4ZqWD/5eTb//sqeBAryaV0y5ZBistTkKiHT+/JiIeDACafTcZI7aJ3cKnyC3HevUbA
 pxrA==
X-Gm-Message-State: ABy/qLbP6nxb3UN+HosO5Te6B/6M4tUb2/cMawUN3fuHupVEbs71sRHc
 BTHUAmc3k1YhCR7vjBb8DCYTffX2TjFzZuqHVj429GePNJy+D2GTOPs8MNjFMrurj8g9WhagoGb
 +YA5a7tm8AvY=
X-Received: by 2002:a17:902:8216:b0:1b8:c6:ec8f with SMTP id
 x22-20020a170902821600b001b800c6ec8fmr14746373pln.46.1691065936318; 
 Thu, 03 Aug 2023 05:32:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZMLVOkSCmTbddpyOR9e+6w5Gu1Xk55v1hivIL2X9w/DWqNjkhwOpUIcstoO9wwB5vF+dsrg==
X-Received: by 2002:a17:902:8216:b0:1b8:c6:ec8f with SMTP id
 x22-20020a170902821600b001b800c6ec8fmr14746355pln.46.1691065935914; 
 Thu, 03 Aug 2023 05:32:15 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090301ce00b001a98f844e60sm14259044plh.263.2023.08.03.05.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 05:32:15 -0700 (PDT)
Date: Thu, 3 Aug 2023 22:32:11 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZMueSwKpatMoeWao@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <ZMuG5iOmeLH_OhxV@yuki>
 <66019516-fc86-9fe7-1cc2-76494fa2dd32@suse.cz>
MIME-Version: 1.0
In-Reply-To: <66019516-fc86-9fe7-1cc2-76494fa2dd32@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/device-drivers/zram/zram01.sh : add a sync
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

On Thu, Aug 03, 2023 at 12:59:25PM +0200, Martin Doucha wrote:
> > I guess that the files written by the dd above end up in page cache and
> > are not written out until much later. Does it fix the problem if you add
> > fdatasync to the dd commandline? That should be faster than using the
> > big hammer and sysncing the whole system.
> 
> This is actually a kernel bug reported upstream:
> https://lore.kernel.org/linux-block/20221107191136.18048-1-pvorel@suse.cz/
> 
> Not only the test files stay in page cache, but the whole VFAT superblock
> seems to disappear from the device as well until sync.

Interesting, thanks for the link!  Reading through that, it doesn't
seem resolved, and I guess new information is that I saw this on an
arm64 host rather than a ppc64le.

It doesn't seem like there was a firm conclusion reached in that
thread -- the machine I could repeat this on has been removed, but I
will try to recreate it with this new information in mind ...

-i


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
