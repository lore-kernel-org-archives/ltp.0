Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6636AEDE9A1
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 11:04:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 829A93CE737
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 13:04:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7830D3CB20B
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:04:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 62E7C1A0021D
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 13:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694689479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NnYTGcKElEEPIZqfh6VbciIZ8tz9Oqw/7eqbzwrZvb4=;
 b=BgoNZ4LgSb459xLSxyVIJN8Zk4NoYRscmy13iDo/okW+Dt8cZAFwGBhnzEuaVfuztapwEA
 FiPHNNIjLO7WDUzMTjWcIRVqbu++6CJD1yNPAhlkQyZAoytpaa77J3l/RH3UbIiGtEm2gP
 MMJ6uIGUfmVzYrDw646Lc7ktSU9Wcvc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-LZeDuft_Pmmiv1Rp6djttg-1; Thu, 14 Sep 2023 07:04:38 -0400
X-MC-Unique: LZeDuft_Pmmiv1Rp6djttg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9a1so807539b3a.1
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 04:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694689477; x=1695294277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnYTGcKElEEPIZqfh6VbciIZ8tz9Oqw/7eqbzwrZvb4=;
 b=VRTbo6AQnjdW2G5z1xxHCBguyf4o5W13VxYnqQm/vR6MloUlxbGXgECKJCoSeucOMh
 YraHxEmllhoQu+SW+OXHP51r0QFNUs2KmvDLGAnosrvyzXNnFHxBUvyIN0DVV4YC4uvA
 jj0Bwh7Jf+QRxb5Ma/yz/znFVsDG2p7VzucQRRb/UEMGRmNuSglk+m3szodKHCuWkBY6
 3EXTE86OhTS+Px5oHMQuoVMQHX6sKxiSMxe7Kc7aN5XbFN+zani++Zw4AFtKSI4TtorL
 NxGd3e/t3QhNMdhu1UVRGUw9OKPlbqK8UX3EbV+URsOfIAOK/a118hX1m6KYliA24s6x
 NDxQ==
X-Gm-Message-State: AOJu0YxOy9OvHYCebA+O7Pk7mjmmffmaNctV0R/UR6mll90YDWuoK5Nj
 RYQXnoavdu5iVbcyIbvTYLoFb6MFqWoYmU4t7+rtluaZcl9MkieeOhtaoe9AUn9tX2fUjmStC7K
 2Aqz0Oomzpw0=
X-Received: by 2002:a05:6a00:992:b0:68f:b015:ea99 with SMTP id
 u18-20020a056a00099200b0068fb015ea99mr2024112pfg.10.1694689477272; 
 Thu, 14 Sep 2023 04:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsoftahzHSWii3RDhAwf2ibAcKVEFCFDnU3v2P//wPl6jQRwlyrcQdEgAakyTrmjYYyUvUmQ==
X-Received: by 2002:a05:6a00:992:b0:68f:b015:ea99 with SMTP id
 u18-20020a056a00099200b0068fb015ea99mr2024094pfg.10.1694689476935; 
 Thu, 14 Sep 2023 04:04:36 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 x24-20020aa793b8000000b0068fadc9226dsm1113611pff.33.2023.09.14.04.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 04:04:36 -0700 (PDT)
Date: Thu, 14 Sep 2023 21:04:32 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZQLowDHRBq8QhQwu@fedora19.localdomain>
References: <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
 <ZQI14xCNkc4wjpC2@fedora19.localdomain> <87msxpgmf4.fsf@suse.de>
MIME-Version: 1.0
In-Reply-To: <87msxpgmf4.fsf@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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

On Thu, Sep 14, 2023 at 08:37:46AM +0100, Richard Palethorpe wrote:
> We don't want to remove coverage of ZRAM_SAME! A bug in ZRAM_SAME is a
> potential expoit or data-corruption.
>
> If you want to change the test you have to show where ZRAM_SAME is being
> covered instead.

The patch v2 has always had the comment and intent

+	# To make sure we are actually testing both the same-page and
+	# compression paths, we first pad with zeros but then fill
+	# with a compressible series of alternatiting 0x00 and 0xFF.
+	# This should assure we stress the compression path and can
+	# calculate the compression level reliabily.

I believe this tests both paths, and in a more rigorous manner than the
extant test.

-i


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
