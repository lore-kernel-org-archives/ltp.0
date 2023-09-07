Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8193EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 06:46:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 430DD3CB599
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 08:46:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA1073C8B41
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 08:46:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C17610006CE
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 08:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694069179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SMmDO8TOevVFwJo00qPEJmbcG8bAcEmgBS9qycTA74=;
 b=bx3mGUcVh7tz96GAlAfFL2ZsUafuuqRjYqsEyYWcQ/eulFSdN/hTIlx/HDLZEExv61i7Fy
 AXznEEPW8pcCVVO6ftH9VIeq2KQOu6kWplOLXo27L9jBeTU4HBtPznljVI4C5vsn0vw/uK
 A9EGZIrrXggG1p0n/UrFI/1jYooJqKI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-zsYJQoAuNACD__ekkm7Gbg-1; Thu, 07 Sep 2023 02:46:18 -0400
X-MC-Unique: zsYJQoAuNACD__ekkm7Gbg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5735a879147so631465eaf.3
 for <ltp@lists.linux.it>; Wed, 06 Sep 2023 23:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694069177; x=1694673977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SMmDO8TOevVFwJo00qPEJmbcG8bAcEmgBS9qycTA74=;
 b=HXDZHPBdI/UeoIq8G/5nsZ/LYEfXeum+PFX3j8OHcJIVhku6iJwRHHcubjZbt50szx
 H1cSxHCFP69lpeln54e8LvuJFJspsRFFSNg3LK3RysF8zSUWxb7AE91A/JxnoDjxMR4Z
 Rm3fkwkHqgh3KfvQ0N560mACYJCNkDAOtbCBIIa54b9jsgOA0r0Bhx1IwfRnTtdqZ+SB
 upjSR/H7hZqdoAfJe9y+Q9rbnrsxCyy6sILtstb+zUJIn/zPMPLW3cMfYMHcI73yDYt6
 ZU6JnRcrWuSlFAW2iVgY9QMYY/r1GvwKk7/xDbAyuC64BnDK6/BEPWcmSYhxunox4BQs
 QgfQ==
X-Gm-Message-State: AOJu0YzGzPkjOB6hCvEjHAus8HT2FYH6FdNaindbhO3WmZBDLzHc+qL6
 Quf4/7ox4nZCkc04b0r5jq/nWap1VHak3GxwQLQifkB3gRlJm6EjvexlwEiCupMudl5FevlBkGG
 V0ox0erdDKjI=
X-Received: by 2002:a05:6871:d96:b0:1d5:eb1:c587 with SMTP id
 vi22-20020a0568710d9600b001d50eb1c587mr6011779oab.19.1694069177387; 
 Wed, 06 Sep 2023 23:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+KeDQud0j6QysoKgpFxuLpSCJfFbnJ4fZ7IaNgTKa3J7pY4+gDQIfzaHecOrPba9mqPAhyw==
X-Received: by 2002:a05:6871:d96:b0:1d5:eb1:c587 with SMTP id
 vi22-20020a0568710d9600b001d50eb1c587mr6011766oab.19.1694069177087; 
 Wed, 06 Sep 2023 23:46:17 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a638f1a000000b0055b61cd99a1sm12047590pgd.81.2023.09.06.23.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 23:46:16 -0700 (PDT)
Date: Thu, 7 Sep 2023 16:46:12 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZPlxtKUwOta4GYh2@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de>
MIME-Version: 1.0
In-Reply-To: <87il8xhr05.fsf@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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

On Wed, Aug 30, 2023 at 09:20:44AM +0100, Richard Palethorpe wrote:
> > This is visible in the occasional divide-by-zero error, but in the
> > bigger picture means this test is not exercising the compression path
> > as desired.

> Do zram{02,03} already do something similar?

Let's go backwards and try to find a path forward...

In Jan 19 2011, ecd667ecb5118a6a2805caca30823f18a355bbe2 added
testcases/kernel/mem/zram/zram01.c to test r/w compressed block
devices.

In Apr 23 2015, 433445f6beeaa38f5ffbd723a8f392a6880b7e11 created two
more tests
  zram01.sh creates general purpose ram disks with different filesystems
  zram02.sh creates block device for swap

In Jun 2015, af0470f65abc62090ad22583b40c27923c48b038 moved the
original testcases/kernel/mem/zram/zram01.c ->
kernel/device-drivers/zram/zram03.c

zram02.sh creates and adds/removes swap devices; I think this is
sufficiently different to stand alone (I mean, maybe it could be given
some intrinsic documentation by being called something descriptive
like 'zram-swap-test.sh' but anyway).

zram03.c (the original zram test, renamed) makes a device and fills it
with the character 'a'.  It reads it back but doens't validate any
statistics from the stats.

zram01.sh is in concept fairly similar, but instead it makes various
file-systems on the device and (as-is) writes zeros.  It reads back
the stats and tries to infer correct operation from that.

zram01.sh has been suspect from the start, because since the original
upstream zram commit (8e19d540d107ee897eb9a874844060c94e2376c0)
zero-pages have been de-duplicated and not compressed.  I think the
reason it minimally works is because there's some non-zero file-system
metadata; but it's unreliable (hence it randomly failing, and this
email) and not really stressing what it wants to stress, which is the
actual compression paths.

zram03.c always filled with a non-zero value -- presumably to avoid
the zero-page deduplication -- but I think what this missed is that
when same-page detection was added in ~2017 (kernel
8e19d540d107ee897eb9a874844060c94e2376c0).  Since this time, it is
really not stressing any of the compression paths either, since every
page is the same.

> In any case I'd prefer to see a zram04 written in C if some coverage is
> missing.

I don't think adding another test really helps.

I think the best course here is to fix zram01.sh to write enough
random data to stress the compression paths and further sync to make
it reliable.  This is what the patch proposes.

If there's some agreement that the investigation above is valid, we
could probably remove zram03.c.  It's not really doing anything
zram01.sh doesn't do and it is not really stressing anything either.

-i


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
