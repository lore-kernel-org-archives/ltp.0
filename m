Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7D1CCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762943700; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=t1mpBrh6tSgqybFl9UGjWok0ZWo9HZsyMJbz5+DOvzw=;
 b=N4MJrV7AG/FYlWDqh55B5FLnc5STthpGLvv82uyX4k9lnUfFIYSX7vniUI3Ch94Gf2pcP
 jTBV6ltNSaEB5psuULrDZnu+2pCsLPg2uJipfAhoY0vZDSlNiXdt3PRtti++QxTI19ZieFe
 QuSn+C1kX/QBLKEhp42WW3jH/rK5eqw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0F403CF738
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 11:35:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADC443CF72D
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 11:34:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0CB21600BB5
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 11:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762943678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w5KMuogvecvQRlTYpQih2FpS8b9K+8JYLyfnDSqGgKI=;
 b=R9uoYWk8mKGjwnqzbzpdcWqtumxKGA6Too3s54Qcu2TUfLpb+OpUq/cNqsJ8figS2GoLo4
 ZUOBnZ74con5W4QUKL2ToVXQWzxtcDvyevALARDYz+mB0QUi0OLHK0hzlp3jmvUbp7vzAk
 ZdPW4Q8JCDA0A/Hf9b21TXenbkkM1ts=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-RIUgkxy6NgyMulDhxBLrzw-1; Wed, 12 Nov 2025 05:34:36 -0500
X-MC-Unique: RIUgkxy6NgyMulDhxBLrzw-1
X-Mimecast-MFC-AGG-ID: RIUgkxy6NgyMulDhxBLrzw_1762943676
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2982dec5ccbso16308295ad.3
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 02:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762943676; x=1763548476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5KMuogvecvQRlTYpQih2FpS8b9K+8JYLyfnDSqGgKI=;
 b=tzp8Ku4OjiQHrNG9ZPr+pSE6gSNXyxiR5sfeGG0K9vJv52OpHShu4BreSFCUhFaVoh
 409VZgMN1ccY06/eANQb4K0eTqnh/TnpSr3ySWQS0mDEu/agFZsx2lCpJSZnsCSSQa++
 S00P+1k7/bpQ95PKNAYRekgu0MqcRVVCsFYLh9eSBj5QCV430zyv4dkJHO/ynDh+cTN9
 xkH4EBQjg+2SCxaC99SoQ1rHaiJ5r7+uGJ6ZE3/O80FwJqW+jnY9BfKTI8uFcRkys+Da
 Yt8s0Spl7i/TLl8Jj6cXaM9Ilh1rdP1P6WIGNR3zwTrJfVW7lWSC5c5rbtxuKluFjDMA
 ULHA==
X-Gm-Message-State: AOJu0YzIqwgewtLfndN3G9vKE+CZwyDBGwMhQkrpUmQvz7TlijMzIXUQ
 Kv6npfPDNNCnu0SQp/8DTMfohmLP0IdivAl9TqR4QVdeC2NifjjqfyXG/f9LBYkSuZUN/s9hLwB
 eEv3bcOX9jdHwrjqsK+yO2G/BaqCg5drUd9FwzGUQLJAxhLRLRb4EfH12+AGUH9VgipzVWpEUOz
 XBU7pY9DHObR37KEEWiC6BUllMF7E=
X-Gm-Gg: ASbGncuh1NNRCG7F9if7UD3M8mh/0TgtMEQkLLmNgOhCocDd6rDJNFo4BPiqUjOzO4T
 3XaDFmVlB/FMrL0INdJCjb6LitgJTAnkWX4Q4JsZYtVPmC16fZQxMJhElLCzTa2/BjCD1eWmS31
 bvW73s2D8tAp8chxnwW6PQjixmK+GzNOvFCO3lOQNyWFTSqthvd5yMRMqJ
X-Received: by 2002:a17:902:d54e:b0:297:dabf:98f9 with SMTP id
 d9443c01a7336-2984ec8e279mr33475315ad.0.1762943675708; 
 Wed, 12 Nov 2025 02:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYnj4GN4Lc+ePpEld0VycwNsIKoEwWSSJTF4QhX+heLreCZxfEEC/AnWMBnK7kz2bwE9CuKHxhdVzn+E8I+Mo=
X-Received: by 2002:a17:902:d54e:b0:297:dabf:98f9 with SMTP id
 d9443c01a7336-2984ec8e279mr33475185ad.0.1762943675391; Wed, 12 Nov 2025
 02:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20251111153453.547195-1-sbertram@redhat.com>
In-Reply-To: <20251111153453.547195-1-sbertram@redhat.com>
Date: Wed, 12 Nov 2025 18:34:23 +0800
X-Gm-Features: AWmQ_bnAS7aLHsgbozKY4viQII0q-XNPjagy5yjVKP697ctjKdS7KYZtBXlYC4k
Message-ID: <CAEemH2cQam9tOeQj_4SdvoYG5ZNmar6Quc5M6mtr==2-HQR9yQ@mail.gmail.com>
To: Stephen Bertram <sbertram@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0wbZBFVRO-vkOKQoXAXH9h1wE_ytP4WfnvhOsiOy0ZI_1762943676
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Confirming EPERM is returned when
 CAP_SYS_ADMIN is removed from clone3. Signed-off-by: Stephen Bertram
 <sbertram@redhat.com>
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

According to the clone3() manual page:

       "EPERM  CLONE_NEWCGROUP, CLONE_NEWIPC, CLONE_NEWNET, CLONE_NEWNS,
CLONE_NEWPID, or CLONE_NEWUTS was specified by an unprivileged process
(process without CAP_SYS_ADMIN).

       EPERM (clone3() only)
              set_tid_size was greater than zero, and the caller lacks the
CAP_SYS_ADMIN capability in one or more of the user namespaces that own the
corresponding PID namespaces."


Shouldn't we separately test both? In your test, we don't know the EPERM
comes from "set_tid_size>0" (or CLONE_NEW*) with no CAP_SYS_ADMIN.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
