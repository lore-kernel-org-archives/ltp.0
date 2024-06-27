Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E4AC2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 12:15:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D1943D12BF
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 14:15:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EFD23D1242
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 14:15:40 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF71C2069E1
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 14:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719490538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsOXAoDn5bffQyRIqPDYdPxHZP/hsS5xsGS5YUwoaVg=;
 b=BcNYuKZf07bSCLtWhl0CNXY0MDI5gswRDny1ITaBzVtL11399oSgL/2Kwg/y3s5TpTPxes
 sZrkR426u3BOY0T3SkAP6gbAocETG5mwUhq/J6x3XDx3tUoS5DFIzr6zbnHH6eBzyxO2ho
 gyYPeqRf4n7Tf/erLJpIwaDhVxe5Czw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-jzORiPmgMYG5sNCGPsXHzg-1; Thu, 27 Jun 2024 08:15:36 -0400
X-MC-Unique: jzORiPmgMYG5sNCGPsXHzg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a8fa8013so9450726a91.2
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 05:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719490533; x=1720095333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LsOXAoDn5bffQyRIqPDYdPxHZP/hsS5xsGS5YUwoaVg=;
 b=h9j9Z7Df62lawUb/8eloLkr+oRrZLt4bPuC8tirm6ppAE+bzdGC5nwYeiK2kw9piyg
 RFKB7gYfojGdF7LyVNPywU1p20PpFnmHykpa/6c7MS66N7KEkrwXWjV7d03otjjy322f
 KW56R5FfS+6+y8HAYhGE/PdN+lKs9ErvKpCZygPIi0iR5PH83urTIKztsdiAFvy8VdYm
 gHmOdP5e5zY9MfmUPmo8j5MxtGaHKm6XjreKh63vGgz98hSsuzzcxME3ZIpqI+fcMYJK
 POrvljE8g4URxbB5IWXNKYn1Fzc78XXkogU6d93VjZgiGbdm8ByyG6YcgawaM7UTI6HF
 e3hQ==
X-Gm-Message-State: AOJu0YxbbU7D2Rg0J6n2hjnDGde2k1YkEvbwHgtCorh6JLiP/1efnKLB
 vx3KMykemqdcfvhwigz+eDyemCZwZZG17bwFc2H+Vl6IdZmcIsrxt/aI+2S06wi+v9B8xoIYk/d
 Nkbzm5gDX6BkMpZGfrYqFkUt6qlyhHxq2CUvb8QjF6EoHHw5B8TykuO4F4IPBK4BQ5CVUgGJ691
 SmdoLhwn0UwLhHZ1OD9CIiQWjo7SgyEFn7u81r
X-Received: by 2002:a17:90a:fe0c:b0:2c8:647:216 with SMTP id
 98e67ed59e1d1-2c8581e6bb8mr12852235a91.20.1719490533496; 
 Thu, 27 Jun 2024 05:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjRSKstkUsdXwCpV8RW4MWkNAGfP1XHn1KGILI9lX6lIyyCmhmypORsMLixaY8NH7zvZniQIN3DQsckQa4hxQ=
X-Received: by 2002:a17:90a:fe0c:b0:2c8:647:216 with SMTP id
 98e67ed59e1d1-2c8581e6bb8mr12852215a91.20.1719490532995; Thu, 27 Jun 2024
 05:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
 <20240627031440.799114-1-liwang@redhat.com> <Zn1PluxR0lVO1qdn@yuki>
 <CAEemH2eh3kDZ7xLPp94buH1f9b3Z3JgiVaRVEzvgiGw8mv3mow@mail.gmail.com>
 <Zn1RbDki07G3_yJB@yuki>
 <CAEemH2dr-UMbVQo9EVcr8mbW-PpVJ6mvv33GoKnRLVWq2ez77w@mail.gmail.com>
 <Zn1VawzZsbkirhjN@yuki>
In-Reply-To: <Zn1VawzZsbkirhjN@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 20:15:20 +0800
Message-ID: <CAEemH2erMqJD37nZ6AoWp_5pvE3ADd0+muxGd3fM_y7xdNd0XA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime
 remaining
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

Cyril Hrubis <chrubis@suse.cz> wrote:

This is not the number of messages though, it's incremented by writer
> threads once they send num_iteration messages. So most of the time it
> will either be 0 if we had to stop the execution because of runtime, or
> 2 * num_messages, if we managed finish in time.
>

Make sense!

I modified the patch and pushed it like this:

--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -214,7 +214,7 @@ static void run(void)
                        break;

                if (!tst_remaining_runtime()) {
-                       tst_res(TWARN, "Out of runtime during forking...");
+                       tst_res(TCONF, "Out of runtime during forking...");
                        *stop = 1;
                        break;
                }
@@ -243,7 +243,7 @@ static void run(void)
        remove_queues();

        if (!(*fail))
-               tst_res(TPASS, "Test passed. All messages have been
received");
+               tst_res(TPASS, "Some messages received");
 }



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
