Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C63C77B7F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 12:32:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7CB43CD749
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 14:31:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2215F3CB56A
 for <ltp@lists.linux.it>; Mon,  8 May 2023 14:31:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2DF7A6005D8
 for <ltp@lists.linux.it>; Mon,  8 May 2023 14:31:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683549106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lt4o7WicPvsXDxZXMq0/gyE1pPMo9+7yigo1mMvFpXg=;
 b=UHWLRIBC7/sApdInUBRY5ydQ9LbzPrWnOR0QkKvhPkk8F0UmtuXjklsgw939rG7IATPgoN
 jQSJHRBcBYSLjm3tDGceyMxsnguZhSggV9sCGdOcOeG8o5UE1oKFxIdxGNqxJZ+nqPTHz5
 kOqdYXYYqjartwJsYoJNqZnIlDOyQgM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-b9V9vTD2NFqN3ce8ECtYRA-1; Mon, 08 May 2023 08:31:44 -0400
X-MC-Unique: b9V9vTD2NFqN3ce8ECtYRA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ac89cef5e8so16615051fa.1
 for <ltp@lists.linux.it>; Mon, 08 May 2023 05:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683549102; x=1686141102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2fuQjUhkX70Grb11EjMql0ubu1ictedXXOD7kqam6A=;
 b=DMdG1xluxoWjt7A1rkhTP9IPPpL3J2KQXYIuFGkoGD5OdYlu4zMoSp2nN1JODTzZbr
 qZahVrLn0Tsx718urpAql8Hio0bZx44jJV1vN55IU9yYJBPyYrq+FcBjtoabG1yMirba
 ZRpNhJv9R5a5R+fh+P3F7KE+oYoFbet4S7YjlNLy7i8nescj6u2UDGYv9E9cCy0LKr07
 QOiznxGJqoc82ChDtQuKKFo5bhkpstvZU/wWn7GZTUex/b7Iq110pZMjflJzwwXu7lHF
 oFDe6SOeYun1U2CfWe1imNAlLAJ14CYY2xAg2zFO5wrW5o/bTMPzEMsPu3OL7ueBl5GF
 nx3A==
X-Gm-Message-State: AC+VfDyDFJNRwlrQ6aqEqFsopLAj04tmBo6hBWmtISxvQzYWsIRe97Jl
 MPp/0hsci1ZVM/d2e/NiOQC9g4oT5E/a9haTtK4j43JhIPd7fgLFm6T1vhlAuYEfjfZEW3+Th9I
 x2Lxg5FTkNUk2oz0sMMDDUWFYzNI=
X-Received: by 2002:a2e:97d7:0:b0:2aa:3cee:c174 with SMTP id
 m23-20020a2e97d7000000b002aa3ceec174mr2779998ljj.13.1683549102544; 
 Mon, 08 May 2023 05:31:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6d2Lf5DTyZUFi2B80FAA978hQ5ZLUa540EOe1mi91S3ZYZN42FTVJS5Zbvyqq7Dir6uU2zFMAFRWsyqitaTVM=
X-Received: by 2002:a2e:97d7:0:b0:2aa:3cee:c174 with SMTP id
 m23-20020a2e97d7000000b002aa3ceec174mr2779994ljj.13.1683549102235; Mon, 08
 May 2023 05:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
In-Reply-To: <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 May 2023 20:31:30 +0800
Message-ID: <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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

Hi All,

Li Wang <liwang@redhat.com> wrote:


> More widely LTP pre-release test will be deployed base on RHEL products
> as well.
>

I have completed the LTP pre-release test against RHEL 8 and 9,
all looks good except one test warning as below, but I suppose
it's a tiny problem caused by the ppc64le configuration.

This only observed on ppc64le arch:

3 cmdline="hugemmap32"

     4	contacts=""
     5	analysis=exit
     6	<<<test_output>>>
     7	tst_test.c:1558: TINFO: Timeout per run is 0h 01m 00s
     8	hugemmap32.c:34: TWARN: Failed to close FILE
'/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages'
     9	hugemmap32.c:35: TCONF: Can't update the gigantic hugepages.

10 hugemmap32.c:69: TWARN: Failed to close FILE
'/sys/kernel/mm/hugepages/hugepages-16777216kB/nr_hugepages': EINVAL (22)


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
