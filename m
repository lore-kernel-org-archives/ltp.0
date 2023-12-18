Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0E5C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 03:52:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FD63CF38E
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 04:51:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1E443CB043
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 04:51:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC45B14001EB
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 04:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702871507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JwFOQcF1Bhv3MC/EURAQX92rSn5k12e96D18qzIb1Fs=;
 b=IhzSQ6TLlBNCt+pScqfonxXqZeb6n1LT+xnvWkFU+XScqsIcuxrBkAXQu4zqiWU9Qk4HLk
 Sb8g3ydHp+EXhCDg2dHrq/PefkioXv677T+blFEWxBRwT8qSr3a/wEsN3Tlt+jZrcpK6Ia
 ltuwHBlASNOiW+MQG3HGJpxzCzorowM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-bdnOPPgtOCqB2WrU77SgaA-1; Sun, 17 Dec 2023 22:51:45 -0500
X-MC-Unique: bdnOPPgtOCqB2WrU77SgaA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e394109d5so219907e87.0
 for <ltp@lists.linux.it>; Sun, 17 Dec 2023 19:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702871503; x=1703476303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwFOQcF1Bhv3MC/EURAQX92rSn5k12e96D18qzIb1Fs=;
 b=XhtLMsAgzmBva626qzxu9SgX3V3cG7W7Zjd/aEtyXP6Q6Xf8H+FZYuGCVtGWuMw5eU
 2BGgPKIuy1PTkL0BPVdkyXu3kPKGLRjcAw/jt3b9RX1HN441qB1QmAAUt53WdhC/urly
 TP3hBjBgrbUJSnJRkfL38U2krP3Q+JcGBV41+1Cr0yqLj6e+UXTLX0yMm/aoKxS4VsJ8
 tMKLjBK/BMloiS4aWzgfmSmU5lYHmC/KhR4YdXeZdHuYdZvex2aSTx2VEEwSVAuI3vH/
 y0KI4YNcxsTYIWSOv7PURYRXOe+Zcf44ZD08uR3+AhnfLWca/5Yfau3TZYHBe6fKgcTV
 jAIQ==
X-Gm-Message-State: AOJu0Yymkxk8UbGAOyK2qcsi4OgHHE2ke2GI8Eu5CTNdEzZ64r68kTzE
 tXggbCXQZzXwlXQz4LONgkE+hBy2vbfszcuCUNcwtYpLaAvHQ+ePiVcpEMgzigk7dMyrDDOmxM5
 4WEKY3h8yGDcvSSjj+NhwG1gdP0k=
X-Received: by 2002:a05:6512:1293:b0:50e:1cc4:2e66 with SMTP id
 u19-20020a056512129300b0050e1cc42e66mr2598857lfs.105.1702871503044; 
 Sun, 17 Dec 2023 19:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo+UeH06IXdr+d31X2UnpQKedNusmdtqCJ2a+J6AKkyZbxkEvGYKYnLGqRgq/Md4tEFaR007ahIIVXjRWYyKw=
X-Received: by 2002:a05:6512:1293:b0:50e:1cc4:2e66 with SMTP id
 u19-20020a056512129300b0050e1cc42e66mr2598854lfs.105.1702871502785; Sun, 17
 Dec 2023 19:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com> <20231215185749.GA58273@pevik>
 <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
In-Reply-To: <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 11:51:31 +0800
Message-ID: <CAEemH2ehQ6CPakouwECeWQGSvSOe1rhA=HKnk1Uig81Cj7tzTg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

Li Wang <liwang@redhat.com> wrote:


>
>> > +++ b/lib/safe_macros.c
>>
>> We don't want to add anything to the legacy API (otherwise it would go to
>> lib/safe_file_ops.c), please add this to lib/tst_safe_macros.c.
>>
>> BTW I'm slightly confused, what would be the best place for this,
>> lib/tst_safe_macros.c is being used nowadays for everything. But there is
>> also
>>
>
>
>> include/tst_safe_file_ops.h, which does not have C file
>> (lib/tst_safe_file_ops.c) because it internally use lib/tst_safe_macros.c.
>>
>
> No, basically it does not use the lib/tst_safe_macros.c.
>
> From what I understand, 'tst_safe_file_ops.h' is just a header for
> collecting
> all the file operations for Linux, it doesn't touch other subcomponent ops.
>
> 'tst_safe_file_ops.h' defines macros for all functions in
> 'safe_file_ops_fn.h'
> and archived them in 'safe_file_ops.c' lib.
>
> Something like this combination:
>
> tst_safe_file_ops.h:
>     safe_file_ops_fn.h
>     safe_file_ops.c
>

The reason to split them into two headers is for backward compatibility.

Technically we should declare 'safe_file_ops_fn.h' functions in one header
'tst_safe_file_ops.h' but you know we have 'old_safe_file_ops.h'.

tst_safe_file_ops.h:
    safe_file_ops_fn.h
    safe_file_ops.c

old_safe_file_ops.h:
    safe_file_ops_fn.h
    safe_file_ops.c

In the future, the ideal cleanup direction is just to have:

tst_safe_file_ops.h
tst_safe_file_ops.c


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
