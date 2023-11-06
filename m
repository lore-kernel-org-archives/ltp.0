Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E4C4167B
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:58:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E3A3CE2A2
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:58:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAF683CC737
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:58:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C6A9360563C
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699268304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRKLxhaItaJ81pNT3O0zb/UuBsfFKpOn4KLhdTnEcAg=;
 b=C5PhMWzLXQtTRnO2/PrQws648KPVNVP3jBGdaGmhjYCxpu4Xal85Zw4tsM3fyey3DQbqiW
 WjcvSCHqWxwUIJGX6sjgCv4eVKBorGvuQAFtX7kYpnmzrx0HYPIdby0zu6Jor3Dw0NGD/x
 3oMv0o6xtgCJBsbrbza84y6lbHjSLzA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-RvgWlFrhO6G_l0pEdkGibw-1; Mon, 06 Nov 2023 05:58:22 -0500
X-MC-Unique: RvgWlFrhO6G_l0pEdkGibw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50798a259c7so3979953e87.1
 for <ltp@lists.linux.it>; Mon, 06 Nov 2023 02:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268300; x=1699873100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRKLxhaItaJ81pNT3O0zb/UuBsfFKpOn4KLhdTnEcAg=;
 b=STkYc4RnUwwt0Db1fqHTeZWrttYUMwadKf1C+CTrBnuqjX2PXSWsLPzV1Z8tWgYaOq
 su+HAAnS7r2+eo6o00B7WIYKGNZUBQ17J7/+mG580CTIZN64FtLoX/eyNE9/cFH+P5jO
 ffn72ArUefqW0Z7vNEUlX6qJFkBBTMVz78mAU+ifCOuHhW5YSnfq/RgV+G40ZmUiz0ER
 /184zqARCh2qCa+o8NpoWQQYlK2IairnLXqSfK6x9aCZukZS8J2GzASrhpgstW/UEmwp
 Rc3uNkSQh0af6eTe5XdCMa3NcAfSCdZE+OR6N4QHwJ2I2Zi/uK+Sr3mWe1/PQjhXdOdi
 E0eg==
X-Gm-Message-State: AOJu0Yy++Yne/3zEE9Rf+XRMqrf/DGnTenj+8jQ5PK1R8S6/z89y6HhB
 SWPd2pbN7O0FbC/uU+aEQ2RHUuWUhOtQQZjtr85RxnlEHCCa/LgzxqfnjBuCjBzQyCimSpn5Z/r
 hGVMlpT/NpRym6M0oJ/7E1b4zDYo=
X-Received: by 2002:a05:6512:3096:b0:508:11f5:8953 with SMTP id
 z22-20020a056512309600b0050811f58953mr11591520lfd.26.1699268300528; 
 Mon, 06 Nov 2023 02:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM4q+JGpEztpvxkYtJzO9UiEqQNtCsFY2JvVxl9Wiq1b8+kZrh606pMhOXwJNw89CO2l4T1f3iaauBC4b9ORk=
X-Received: by 2002:a05:6512:3096:b0:508:11f5:8953 with SMTP id
 z22-20020a056512309600b0050811f58953mr11591508lfd.26.1699268300156; Mon, 06
 Nov 2023 02:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
 <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
 <20231103091439.GA1026385@pevik>
 <CAEemH2ewUHBC17LL+4OXd8AZqciGrRqo4Ty+Hik2KcXP+t4fNA@mail.gmail.com>
 <20231106104023.GA1236692@pevik>
In-Reply-To: <20231106104023.GA1236692@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Nov 2023 18:58:08 +0800
Message-ID: <CAEemH2fbsZaK11MRgS+jqowWihStX9NX5dc4fcgcDrbFfJULOA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:


>
> > > If we want to add both CentOS 8 and 9, we could remove some of
> > > debian:oldstable (bullseye)
> > > (similar kernel).
>
> > > And, we could add just openSUSE Leap 42.2, which has older glibc and
> gcc
> > > than
> > > Ubuntu 16.04 LTS xenial. For sure there are more people which use
> xenial
> > > than
> > > old Leap 42.2, but as I said, the goal is to test the oldest distro we
> > > maintainers really care about (and do not have extra work for nothing,
> > > which is
> > > IMHO keeping CentOS 7 compilable).
>
> > > WDYT?
>
>
> > Your explanation is quite useful, thanks!
>
> > I'm fine to remove the CentOS8 build in this patch,
> > should I resent the new patch or push it directly?
>
> You can push it directly. If it does not apply, feel free to push my change
> first. I'll post a note about keeping only openSUSE Leap 42.2 in the
> patchset.
>

Done, and sorry I just merged the V2 then see you post V3 patches.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
