Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16601EC8747
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 01:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8099A3CE9B9
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 03:59:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB3103CC02F
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 03:59:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55D92600855
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 03:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694138346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g4+DpBXuWtfWVZT5bWXEc2SYagl4LgvUrKP/nrv+9/k=;
 b=ghvCwcerMNiFPuZaww0kcEHakj7cP5YoQgMrw8XQXQDklIX7OMBYx43djSUwNhl0V5hH6H
 Xe9nx7Q80WorCXH3nBBdLoXhszrvDCKSAqC0lWIueskMJbUnxkaZbjkxBLoi682GK5w/uk
 6LTXPe+jceAqZ1ex3ycm5KfBoqXMx+k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-cOyLmxCeMuqXB4fUzldCgw-1; Thu, 07 Sep 2023 21:59:04 -0400
X-MC-Unique: cOyLmxCeMuqXB4fUzldCgw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c3257c8971so22131675ad.0
 for <ltp@lists.linux.it>; Thu, 07 Sep 2023 18:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694138343; x=1694743143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4+DpBXuWtfWVZT5bWXEc2SYagl4LgvUrKP/nrv+9/k=;
 b=pkBbdCUHwOjhU8knj3/TgGzext0LuawPRt4Q88vuafF8wlWcBaFgw6I7gO4EICImEf
 r+iUEnWtnWNT3sd/MkTuHA5nmvjJe9mWs2m4ZaCNyP79C5YwByvtD5ec+Hq5gZ96Ggqj
 xBIIOZMbH+p/KJvIoomEWQ/mdvT9BdSmeUjb4GL3dIEjHaNCqdvuaYOQg6YQqs9YD0oU
 ljVkJ9PnsWkrEeGO316Ut0ZcdWknwRbAJxpAOUPh/O7jCMW1xnTQAS/ZphYvUqSGYoIu
 bjjGOeUyP6iZ69TRzpvppG1aFfUfBYmi/SatGRdD9lnjHjscS5F/Z3RSzVV+Czx4xYvv
 5Cmw==
X-Gm-Message-State: AOJu0Yy1cHXJ1p+3x3OObHCmDhOOxgxVdRkeCqEyj7xEgMlyyYNGhRsQ
 Nu1198m0Ui/QZFm8hMqnVKTLyvOEPYdQAt2jfNeJpH9TmOLMhyQSIH+TKKxs3t5TZ0aAosU3ryc
 jA1FHcACmnbQErPfNkzQ=
X-Received: by 2002:a17:902:ef82:b0:1c0:e014:90c1 with SMTP id
 iz2-20020a170902ef8200b001c0e01490c1mr1183884plb.48.1694138343013; 
 Thu, 07 Sep 2023 18:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZgGI/+YxQi3qXfGF7uTtiq6wFjeeXM+9Hs3Z/si86D92DEaKfsefHA0g3gpWbxM+4Fdq+GA==
X-Received: by 2002:a17:902:ef82:b0:1c0:e014:90c1 with SMTP id
 iz2-20020a170902ef8200b001c0e01490c1mr1183874plb.48.1694138342674; 
 Thu, 07 Sep 2023 18:59:02 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a170902d90200b001bdf45eb5b6sm375473plz.284.2023.09.07.18.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 18:59:02 -0700 (PDT)
Date: Fri, 8 Sep 2023 11:58:58 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZPp/4seXlgt5QAVf@fedora19.localdomain>
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
 <87il8xhr05.fsf@suse.de> <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <87r0nae259.fsf@suse.de>
MIME-Version: 1.0
In-Reply-To: <87r0nae259.fsf@suse.de>
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

On Thu, Sep 07, 2023 at 09:26:29AM +0100, Richard Palethorpe wrote:
> > zram01.sh has been suspect from the start, because since the original
> > upstream zram commit (8e19d540d107ee897eb9a874844060c94e2376c0)
> > zero-pages have been de-duplicated and not compressed.  I think the
> > reason it minimally works is because there's some non-zero file-system
> > metadata; but it's unreliable (hence it randomly failing, and this
> > email) and not really stressing what it wants to stress, which is the
> > actual compression paths.
> 
> Maybe it's not testing what was orginally intended, but filling the FS
> with all zero's is an important corner case. We don't want to remove
> that coverage. We at least want to check that the kernel doesn't
> crash.

I don't think this is really a corner-case.  Perhaps filling the
*device*, with no file-system, might be a corner case.  But as you
say, this isn't exactly what it is doing -- it is filling a
file-system with a file that has all zeros.  The problem is that, for
the reasons expalined in [1] but also incorporated into comments in
the patch v2 [2] this is both unreliable and I do not think a good
exercise of the compression path.

The v2 patch was written to test both the same-page and compression
paths by explicitly alternating data that should hit both.  This is
essentially doing the same thing as the current test, but with
increased reliability of being able to correlate final stats.

> > zram03.c always filled with a non-zero value -- presumably to avoid
> > the zero-page deduplication -- but I think what this missed is that
> > when same-page detection was added in ~2017 (kernel
> > 8e19d540d107ee897eb9a874844060c94e2376c0).  Since this time, it is
> > really not stressing any of the compression paths either, since every
> > page is the same.
> 
> So it is testing deduplication of non-zero pages. In general these are
> testing a degenerate case.

I take the point that 'a' is different to '0', but as written the
kernel checks for zeros the same as any other value (it walks along by
unsigned-long and if the whole page matchs the first value, records
that value).  I haven't actually sent a patch to remove zram03.c;
since it doesn't try to assert anything it's not been unreilable.  But
I do think it's not really adding much useful coverage as is.

-i

[1] https://lore.kernel.org/linux-block/ZNB2kORYiKdl3vSq@fedora19.localdomain/
[2] https://lore.kernel.org/ltp/ZPpOuK9lyWr2wZWI@fedora19.localdomain/T/#m1e037003252012ac115e57285a926db77380897f


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
