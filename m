Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF39C6FD1D
	for <ltp@archiver.kernel.org>; Fri, 17 Mar 2023 12:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 950303CD407
	for <ltp@archiver.kernel.org>; Fri, 17 Mar 2023 13:29:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2EB03CAB4E
 for <ltp@lists.linux.it>; Fri, 17 Mar 2023 13:29:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 963AC1001169
 for <ltp@lists.linux.it>; Fri, 17 Mar 2023 13:29:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679056168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCipJJSChvt3EjVDu5YvXz0jp4szYdshH/GhSpfgVzU=;
 b=AvaHhNZ9KOXfZ2SSC+N2p4XNPeDQujhL43G/ykn6Jglz8sK98Xe3b1USJgc1RDUcrRC5rt
 7VqO2fBAtmyft8no3BtJUdBKaJHOakEkDYdl7TEW5GzVGw6iQnobR6xAoRYqIIO9iUa+Xn
 qltcbUAuVnfEpkSTGG7538seJNYQwKg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-F_FKPmgCMdicrxmUOXql0w-1; Fri, 17 Mar 2023 08:29:19 -0400
X-MC-Unique: F_FKPmgCMdicrxmUOXql0w-1
Received: by mail-wm1-f72.google.com with SMTP id
 b8-20020a05600c4e0800b003ed2d729092so2218016wmq.0
 for <ltp@lists.linux.it>; Fri, 17 Mar 2023 05:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679056158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BCipJJSChvt3EjVDu5YvXz0jp4szYdshH/GhSpfgVzU=;
 b=hDkcgLC36kTbqRdvkImbBFHIBreZ3JsPqWlBHyaMEIw0sF+0mi133izMbN4Bk0W7vR
 aS2MhL0Ut1I6Vivis9H2j7DkuVDnpLgCMifeJTCR9wjOhGUED45mxu4hAq/zXLHjwDY6
 yrrL2xXXjc/pPc1GWRIBYdse6XCtJaBTvHzG5b7zqpSVY1RaqqtdoACnWx5k7WqXigBa
 jtOpwqdOKTxCIPRRLpBJepryBJbFJZr9TJaYoSFcuUUsCYg6ijbHyaSFAXZ3H4GPX8H5
 eaSMLbS+qemwZvUAyGADxBJRqMAxVIkmj2NaMLN55GnRKHbUrYRZOGnGcf6RxkWZc//9
 Pzug==
X-Gm-Message-State: AO0yUKUC0F3pXsnvmEP7xSbO4UBNREeancN0oANnBc+lmELVMUZ5pxyr
 wOJ0arbXYA6XvrP3Ga3OkWucLcEzODaN/LaCHu2j87xrcmD1B/vNSkMWJiZQi2J4ALDP6wrAYh3
 uyXu+DaQnkoAyAUgKSF2gcDGJHRM=
X-Received: by 2002:a5d:4c48:0:b0:2ce:ae85:7b61 with SMTP id
 n8-20020a5d4c48000000b002ceae857b61mr585903wrt.2.1679056158066; 
 Fri, 17 Mar 2023 05:29:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set++DXMd6TpqBv6/TISzB3+njf2phVhUAnbDoJm+ztGcSjqJ3rPu8KtZySBgJhZZyv66uPUNJ//dJcIWroQUSWA=
X-Received: by 2002:a5d:4c48:0:b0:2ce:ae85:7b61 with SMTP id
 n8-20020a5d4c48000000b002ceae857b61mr585900wrt.2.1679056157801; Fri, 17 Mar
 2023 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-2-wegao@suse.com> <20230315123119.GA164307@pevik>
In-Reply-To: <20230315123119.GA164307@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Mar 2023 20:29:06 +0800
Message-ID: <CAEemH2fU8CC3-Xj=26VaeejphxHfFBOAE6pPzXFp3n32WC1v+Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] Move semaphore/ tests to semop/
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

Petr Vorel <pvorel@suse.cz> wrote:

Hi Wei,
>
> > There is no point in having two different directories with semop()
> > testcaes so it would make sense to move these two tests into the
> > syscalls/ipc/semop/ directory as semop04 and semop05.
> > So we move ipc/semaphore/ tests to syscalls/ipc/semop/.
> > Also update runtest files accordingly.
>


> As I already stated, I'm not really sure this is good to do, but maybe I'm
> missing something.  I wonder what others think about it.
>

This patch makes sense. Petr, I know what you're concerned about,
but it is correct to move them into syscalls/ipc/semop/.

They essentially all belong to System V IPC way to use
semaphore which includes <sys/sem.h>:
  semid_ds
  semget()
  semctl()
  semop()

To distinguish from another POSIX IPC way which
include <semaphore.h>:
  sem_open()
  sem_close()
  sem_unlink()
  sem_post(), sem_wait()
  sem_getvalue()
  sem_init()
  sem_destrory()

The sem02.c needs '-lpthread' only because it invoked pthread_attr_init/exit
functions in the test, but not any POSIX IPC functions.

So you have my reviewed-by in patch v4:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
