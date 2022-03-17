Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2262EC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 08:16:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB4D53C91EC
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:16:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A512F3C91EC
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:16:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D9CDD35A96
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 09:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647504996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PCrYskShJgq0kIYAmxtHlfKisG3xiSMRcPUp9YX8wNY=;
 b=P+X86Cyy9J5q3cIOR3vw7O9P3TH1cN569NfQMnjylwFsSKcHoLX7UaCutdqSMqL1qTwfK/
 d+X5NzWmS97hAH29RQtXT7EOl9U5MQNjzUPEfCbNAWqq59GOq0LyoYU2Qy8g5GO95vSKZF
 /lWnD/WSKMrQO6cgBst21ew9pnrWRWs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-0o_WImxENeCVawHG23hIPA-1; Thu, 17 Mar 2022 04:16:34 -0400
X-MC-Unique: 0o_WImxENeCVawHG23hIPA-1
Received: by mail-yb1-f198.google.com with SMTP id
 h16-20020a056902009000b00628a70584b2so3928392ybs.6
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 01:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PCrYskShJgq0kIYAmxtHlfKisG3xiSMRcPUp9YX8wNY=;
 b=SnZmy9KmvcVP0+1ZU7kxzwuC1PTLrW6P0KzxSaTTnrM6j57LNDm3qdbxopa/hXN7XH
 ZX+LSxEHUwiNAWRUukfzgsGrNcIg36C03KyfPsFwvL6EOdHq13Hp/EKBmNDNWgH5UNQ/
 OUV9h+x41dQLDpnejJzfgdoQaSVSiUSoYBFODlWXE8Z0N3C1OTHsKQv9lUMy22xgSQMj
 KscZV9GNwtPTf3rq+iubwXGSBES+ld1lTNbtCuUQi9qgfkERNSQzPsF6hxUubgxKS9va
 1fCX16kKUzkaQL22baHrPVQyxRg7PpJGPOuOdeMiWrxCyuP+aWwdEJU4eXedWHSkfMqs
 v4dQ==
X-Gm-Message-State: AOAM531pRR2fj/+ldcu1GIM7d454Ydrc0FNWiWuHuKK+a/M0TWMAz07A
 MjUhRDvaEL3f5Z2KsezjZoUlHbnIIkLEmwecqGYG8DJy+L2KX/CivOqsJAI57ZuTjFN0K+P9nB/
 3RQMDx+516Q5iLII+obgWxG5UhHQ=
X-Received: by 2002:a25:ce4f:0:b0:633:8f69:dbb8 with SMTP id
 x76-20020a25ce4f000000b006338f69dbb8mr3821752ybe.26.1647504993658; 
 Thu, 17 Mar 2022 01:16:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO4Lf1ly5NkHtVwjshlmL0k3vzrVpT4IvEgMtI2eLixcVegopTeYlPZEfq1DO74RB+bIwpg/aIAdlL42p2/BA=
X-Received: by 2002:a25:ce4f:0:b0:633:8f69:dbb8 with SMTP id
 x76-20020a25ce4f000000b006338f69dbb8mr3821743ybe.26.1647504993472; Thu, 17
 Mar 2022 01:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220309164954.23751-1-mdoucha@suse.cz> <87k0cv5ij5.fsf@suse.de>
 <60ee7094-fc86-b06c-87e5-500018d9de29@suse.cz>
In-Reply-To: <60ee7094-fc86-b06c-87e5-500018d9de29@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Mar 2022 16:16:21 +0800
Message-ID: <CAEemH2e7NA30CkCcKZSo7wZuU2ZEDizyhODy9vSvxXj+VfeFiQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] KVM test infrastructure
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2013867588=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2013867588==
Content-Type: multipart/alternative; boundary="000000000000e6e8c305da65a556"

--000000000000e6e8c305da65a556
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

Martin Doucha <mdoucha@suse.cz> wrote:


> >> +    /* Create VM */
> >
> > These comments are pretty redundant when we have ioctl's like
> > KVM_CREATE_VM and KVM_CREATE_VCPU. There are much harder things to
> > understand in this patchset.
>
> I know that the code is straightforward. But it's quite dense so I've
> added the comments as section headers for easier navigation when you
> need to change something.
>

I have no dissent on the comments.

But I'm wondering do we need a check if the SUT support
creating VM before doing that? Or, should we guarantee
the KVM module is enabled.

I simply built these codes and got TBROK on my KVM guest.
Probably we should avoid this but I hoping it can skip gracefully.

[root@local-guest-rhel83 ~]# virt-what
kvm

# ./kvm_pagefault01
tst_sys_conf.c:64: TINFO: Path not found:
'/sys/module/kvm/parameters/tdp_mmu'
tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
lib_host.c:133: TBROK: open(/dev/kvm,2,0000) failed: ENOENT (2)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0


-- 
Regards,
Li Wang

--000000000000e6e8c305da65a556
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Martin,</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz">mdouch=
a@suse.cz</a>&gt; wrote:<br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt;&gt; +=C2=A0 =C2=A0 /* Create VM */<br>
&gt; <br>
&gt; These comments are pretty redundant when we have ioctl&#39;s like<br>
&gt; KVM_CREATE_VM and KVM_CREATE_VCPU. There are much harder things to<br>
&gt; understand in this patchset.<br>
<br>
I know that the code is straightforward. But it&#39;s quite dense so I&#39;=
ve<br>
added the comments as section headers for easier navigation when you<br>
need to change something.<br></blockquote><div><br></div><div><div class=3D=
"gmail_default" style=3D"font-size:small">I have no dissent on the comments=
.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><di=
v class=3D"gmail_default" style=3D"font-size:small">But I&#39;m wondering d=
o we need a check if the SUT support</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">creating VM before doing that? Or, should we guarante=
e</div><div class=3D"gmail_default" style=3D"font-size:small">the KVM modul=
e is enabled.</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">I simply bu=
ilt these codes and got TBROK on my KVM guest.</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Probably we should avoid this but I hoping =
it can skip gracefully.</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">[=
root@local-guest-rhel83 ~]# virt-what<br>kvm<br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small"># ./kvm_pagefault01<br>tst_sys_conf.c:64: TINFO: Pa=
th not found: &#39;/sys/module/kvm/parameters/tdp_mmu&#39;<br>tst_test.c:14=
58: TINFO: Timeout per run is 0h 05m 00s<br>lib_host.c:133: TBROK: open(/de=
v/kvm,2,0000) failed: ENOENT (2)<br><br>Summary:<br>passed =C2=A0 0<br>fail=
ed =C2=A0 0<br>broken =C2=A0 1<br>skipped =C2=A00<br>warnings 0<br><br></di=
v></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e6e8c305da65a556--


--===============2013867588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2013867588==--

