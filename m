Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE15C41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 11:00:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33DFE3CF2ED
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 12:00:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BF83CE613
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:00:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF6091000341
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 12:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702983631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXPAikjSlGU1zCai+67468aLlmCwlGkkR4g8geBkwV4=;
 b=e8yNVhpR17H9c9cTmqmFbJf5AG1w9bQJZBQHRlBqJyK48TWFka6t6tiFW+MQDW5MRnYxVK
 M2n5igEkrzyRVPydPIS6ws9gpK9mHvjlI9XfKYiWj/9TT8fd250R/YemcEW2zpTbrAn1+q
 ndTVkKpt2HE7W1q6LGPbEOovIMfk9UM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-vZCtHM3rN0yqmGNsSbrcSQ-1; Tue, 19 Dec 2023 06:00:29 -0500
X-MC-Unique: vZCtHM3rN0yqmGNsSbrcSQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6d9f6b89aedso5990482a34.3
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 03:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702983628; x=1703588428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qXPAikjSlGU1zCai+67468aLlmCwlGkkR4g8geBkwV4=;
 b=LzeQxwLTTOA2MEEJP+cQgl/wuVvolODLb6pBjqI5xa7djg/B9x/L2J/+ikMouHRJYT
 3KJ68bkrAqviLY8jHnfHWgNauSDAk349zKh3IHWQH/oIEGwBlUixN2yIlV9wXd8WKSWX
 xuHsWAL/aTQqRzfNvf37WrcYN3KLFaTiJvvp50J0JrHLCR6SP5ddMMacCAp065f6lz67
 KKXyXfYlnA9GsQY6q6pwQpp6NrvtoH9vqHlNu0VCD48co0ZdGICwq9vUCHEWmzgsXTKi
 0OH4xkZLVlzRFNtG+uCFXSm1ND2hVF9yia9oR6V/8N1I7XSwGk5ZPZ2UzbGDLWGX7rU6
 gOEw==
X-Gm-Message-State: AOJu0Yw+l9VKDqmL96NB33OhElmon6GAnOxnotCR6SXsaPCCVqfAjfh3
 MegqU7iuwKY3o6ZNTOseaM8iYxbvlm9NdykTAk8pC8J68927A8f9kB+Q+BXJ4HgSsiMfF1zptQ0
 rtHcEVxYR14jusGlp7+3/MwKO9Jg=
X-Received: by 2002:a05:6870:638b:b0:203:38a8:19b1 with SMTP id
 t11-20020a056870638b00b0020338a819b1mr11984031oap.87.1702983628664; 
 Tue, 19 Dec 2023 03:00:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPtEzQrG5fn7sga7FPkBXMI58jwagEkNk7NSELiXCyz9Qjjtwi8fo6KINp0EbXoDK2HpjPdxikWOjyHG/qOeI=
X-Received: by 2002:a05:6870:638b:b0:203:38a8:19b1 with SMTP id
 t11-20020a056870638b00b0020338a819b1mr11984019oap.87.1702983628393; Tue, 19
 Dec 2023 03:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20231214151954.840244-1-pvorel@suse.cz>
 <20231214151954.840244-5-pvorel@suse.cz>
In-Reply-To: <20231214151954.840244-5-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Dec 2023 19:00:15 +0800
Message-ID: <CAEemH2dQpNrFj3JTMkzBG1byqrK9ZJRxTpcg_Jh8+bqLrgUK-g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 04/10] ioctl02: Rename option -D => -d
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

And, we need to correct the option info for -d.

--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -223,7 +223,7 @@ static void do_child(void)
 static void setup(void)
 {
        if (!device)
-               tst_brk(TBROK, "You must specify a tty device with -D
option");
+               tst_brk(TBROK, "You must specify a tty device with -d
option");

        int fd = SAFE_OPEN(device, O_RDWR, 0777);


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
