Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A5CC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 11:21:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09E583C4BDC
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 12:21:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAB8F3C096D
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:21:41 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4A1DD20FF5C
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:21:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737631299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63Ef0P5g/mTo51BjPtQqIza5jWhczeDYQap3NksZvjI=;
 b=Kznx1NIuHglP1Ic0rFfvvAhm6DP/b/EYJORcb2+ogbqHsPFJG9ysblHPZJ2QhuG5b1uQys
 XHaeY59QDR6TIIo8py6F5o8qM9BKa4yJszofV8TLVOv03AfEvRHiyFmF4qAqgn3iJXpeYI
 gCNcRoR0ZNdz6NX+9AZJqOQ7as4dDbY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-7uQP_401PRSl5Nq7lXPDYA-1; Thu, 23 Jan 2025 06:21:37 -0500
X-MC-Unique: 7uQP_401PRSl5Nq7lXPDYA-1
X-Mimecast-MFC-AGG-ID: 7uQP_401PRSl5Nq7lXPDYA
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e572f6dee18so2077405276.0
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 03:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737631297; x=1738236097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=63Ef0P5g/mTo51BjPtQqIza5jWhczeDYQap3NksZvjI=;
 b=IJTPbpX0XkLXXC/sD4PFG78gcABii2haczg09+RxFna2mzcaPqiXNESvm93IP4oM/s
 GvKB5vuT/9wQZOMulH3NuHimIkJN0P5UEkN6Hp0Exrw3KsxZzwmrevEsDxjfEYDflz6r
 AouhPYN2DcgYQm9//zA18MbCYOiMb4AkktyfHXqpNpww6VX0vQ5NvcfCh44/2wfIxFBI
 5FQJy5HuTd9qsQ+G9wjU56rwFivW84PJ02qCa8qHwSC9MzpaDovvhS9qfFSI6sBkIxtf
 Yhb+teuaQgpGKIaFLPE3SrIrGKJ0H3fBg6g1IKkpxQqTB1TkasfuWb9pMcvdoVhGlIee
 SHBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXCVt5IAf6/Hjpuounl14pCb/tK/FQsQUfWi7173ut+XIasdKqvUpa+vFDzxd+IZww0BY=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/qvJw4UGLPdMTCzMkLuTRum5rKL5g37u64HKrbxp8HZy8qKrU
 XiHGr3jA89/8104VPo+qGGiQhpzc28lRKZLJZ0lSaKl92sU1y1zVF0ElQPwVoQivLNGoMggOBW3
 5VbOQcr5h0QUoj/K8vw4DUi85b5dIwt82I4ExiCv0AF39j/uDhHFncduAEsEBimwD2ajD9krzIl
 H8OUoqMNMuYpVq0XzI3+Qqjvc=
X-Gm-Gg: ASbGncul8m7F3xFbFqIhLZJaX/7Vo2o4RcuOP138lQEZa1pswYjvNOo8Fw/YaAUhwUW
 YyKYkxob49ceNoLVi/oM69fzSqDu+pJKFzv2+Pbi2WE7D97h/t/8=
X-Received: by 2002:a05:6902:1207:b0:e57:3656:5bfe with SMTP id
 3f1490d57ef6-e57b105a856mr20442198276.15.1737631296906; 
 Thu, 23 Jan 2025 03:21:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7KybgTf16uMHGPfnOZO7G5xeyiXoX2Dwksn8KhJj0pj5YDkPK7gzumLIZ2eQSGz63Sl75z/ah62kASYnqiMg=
X-Received: by 2002:a05:6902:1207:b0:e57:3656:5bfe with SMTP id
 3f1490d57ef6-e57b105a856mr20442184276.15.1737631296587; Thu, 23 Jan 2025
 03:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20250117135745.909549-1-afazekas@redhat.com>
 <20250117135745.909549-3-afazekas@redhat.com>
 <Z4qCv9LJe6uMXtEH@yuki.lan> <20250121091546.GA894129@pevik>
In-Reply-To: <20250121091546.GA894129@pevik>
From: Attila Fazekas <afazekas@redhat.com>
Date: Thu, 23 Jan 2025 12:21:25 +0100
X-Gm-Features: AbW1kvYM-wGmg5RRedZ22LYkPOr8fjwA8R5CbBIgE2hF99BAWK15STHwGgn3EVQ
Message-ID: <CAMTxPK1ipen=RDbrDO51hrGJZ9fex0gvdSoCHc9yEVjmKAUzXQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2RAlDk2QBJNhwuRBu-JrjwSSKUC3aYjnWihrgpQzBeY_1737631297
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] sched_football: use get_numcpus()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgQ3lyaWwsCgpUaGFua3MhCgpJIGhhdmUgc2VudCBhIGZvbGxvdyB1cCB0byB0aGUg
Q1BVX0ZSRUUoKQpodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNS1KYW51
YXJ5LzA0MTg2OS5odG1sCgpCZXN0IHJlZ2FyZHMsCkF0dGlsYQoKT24gVHVlLCBKYW4gMjEsIDIw
MjUgYXQgMTA6MTXigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhp
IEF0dGlsYSwgQ3lyaWwsCj4KPiBwYXRjaHNldCBtZXJnZWQsIHRoYW5rcyEKPgo+IEtpbmQgcmVn
YXJkcywKPiBQZXRyCj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
