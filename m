Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22187F9D0E9
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776186055; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XVWGFRXaaqvtT4ks3zGBQU/cmuniPgma2YHQJqvYx7s=;
 b=rnPKy4GhjlwC8jKS75eeEioQX7aZj+sW5CVX/XmYS74Ire82rZhJuD6wTgGtVsfzENmyT
 tb2C8KjxobXcQTO4DNfWrY0y4dQXExzvKRnAKX7SJ6GithaufUi/7ckr/IcGdTbWyvUooP1
 2Tmb6EDNdXLb2aP5L/CThL+4gcgZZKI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1F23E5E10
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 19:00:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD313CDC78
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:00:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 403906008E5
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776186029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdVJiV+05DALoJF99wSYq1A25EQ3k8AtSs8szYPGt1k=;
 b=E4wbASQdWZINvSel9QsNmkFJhYEKy1xuwWGqGf6VMzi/MJDogOkUCI57FDUHqsfT0sqOrj
 lKgvai4mOhItCAO/NevVTfg3bP7+oVVUPRzg4rqSabQhUgLIc2FCgQeLeCYsYSGCQMX3nd
 tbiak8FA7wmsts2ohVmBQT1OpgvM+GM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-HqlxxqMQOCGTfd-T5ug_vg-1; Tue, 14 Apr 2026 13:00:26 -0400
X-MC-Unique: HqlxxqMQOCGTfd-T5ug_vg-1
X-Mimecast-MFC-AGG-ID: HqlxxqMQOCGTfd-T5ug_vg_1776186026
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8dbc9af20edso1188537185a.0
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776186026; x=1776790826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdVJiV+05DALoJF99wSYq1A25EQ3k8AtSs8szYPGt1k=;
 b=o++C1++MKqj///NM6KEcTt3jtZJlXEXHSo1JTOnm6reMcxPsiKysdt8kDvkJIMlFQm
 x8c41JPuofMT7X1MrThsPqhLjy2Ik09i9peD5ePqMCFUQcsiPZIPlsoyhqJYD9CB6KO4
 29dcBJ7PikeCJNs3GGF+nAyY+vKPirTaCrbAADprg//A3xzbItG0xcqpMxRhFpRemswC
 rt+8/FcmpOYyW8g1hPz5l4LhBJzTFxkEhM9SYhRWqFKLr8WoXKJIJ2kD30aC0ERk2/4y
 4m7htU+68F+e2BsFNuY8cy6Pk17bqnTBeU2fP8QvLFO5nTD2VX5mgdZdhfv8Uv24X2aG
 jN6w==
X-Gm-Message-State: AOJu0YxID9X35HzfnQZxdvaw2ZOiLPfUAwyvgLAeY2+S7RwW/lHi0iIL
 WFeyYUZELaGLwyAwTXXg7PIvwfALP0H1CZ//acm90hS6Dqw9Vi90t/SFc8uwShmInvS8rYsGlbe
 XNrvhWMzZhizXxFqac9k9YuAtA3F98Olp28qZrwN1zLf0UnCmpnnN1Kgc0pVvrx8ksUPPL+Znmt
 7Ug4J8Jrb5/b3yNGWnrDhi9u/ZQF0=
X-Gm-Gg: AeBDiet34OYYk93B+Dl35IBCrSBovNcJFI/FsWBE3dAfdYjFt1UePWcet5wXAkTgUho
 b8Eb0rUuXYE0Ka1XwMUP8BzT7WL8lBRgnzDk/MBaqFbKcs5j2DuIaR4+cJWQ0gOW1N3BzQBrYBs
 TKMVK0x0B7uL4KzW/tEMCagBLWb4CgMBRiE0omNlPrDzHtF7d8XLSIZhuu5rnr1qxjQhJ5M6Rdn
 Ad8GQ==
X-Received: by 2002:a05:620a:290e:b0:8d0:8dd:eb50 with SMTP id
 af79cd13be357-8dc43be2348mr2780252285a.1.1776186023905; 
 Tue, 14 Apr 2026 10:00:23 -0700 (PDT)
X-Received: by 2002:a05:620a:290e:b0:8d0:8dd:eb50 with SMTP id
 af79cd13be357-8dc43be2348mr2780205785a.1.1776186021077; Tue, 14 Apr 2026
 10:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260320020233.211264-1-sbertram@redhat.com>
 <ad4pE16FjW4zlQRm@yuki.lan>
In-Reply-To: <ad4pE16FjW4zlQRm@yuki.lan>
Date: Tue, 14 Apr 2026 10:00:10 -0700
X-Gm-Features: AQROBzCc5gFjEgYreDJUG2JP3rjmXAMPyC0ZF8wr0q14zXyNjqPwWmB0uEGVdpo
Message-ID: <CAD_=S2mtc_aQnBw_cb6G_hLmTeS-BQBuL9w1b3+SJOu6Lpc_Qg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dUb2eyftHzbaKR8wjT2tKEsFEtBa3c-tswEJBAwy4iE_1776186026
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] semctl: updates for multi worker testing.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi  Cyril,

Done.

   - [LTP] [PATCH v2] semctl: updates for multi worker testing.
   <https://lists.linux.it/pipermail/ltp/2026-April/047617.html> [1]
   - [LTP] [PATCH v1] semctl: use IPC_PRIVATE to minimize interference.
   <https://lists.linux.it/pipermail/ltp/2026-April/047618.html>[2]


Thanks,

stephen
He/His/Him

[1] https://lists.linux.it/pipermail/ltp/2026-April/047617.html
[2] https://lists.linux.it/pipermail/ltp/2026-April/047618.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
