Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72FBC433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:04:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E43863C9B61
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:04:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD1403C87BB
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:04:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0472E20076B
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644307448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9buv96VJytxyIpwkqFI+aBFQ4oPgjmViPjTC4XMIVQI=;
 b=HJmatQuVZzJPGwHmUtawGL4Bl6QAnTm3QJPjzxF6WzAhAP5HngZI5iLzqk/TKqkk9UHMhm
 zOoAToJNvLGQtutW/GmM+XMBQELOwtwRCSp+1inqFh/CO1LHj46ZqfdSGkXgIfGjCawwjT
 F2ljeG/F7DzvXurBFaQ+rZ8pq/BgMmE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-XsinnYxAPb6D1d63Gw8aBA-1; Tue, 08 Feb 2022 03:04:06 -0500
X-MC-Unique: XsinnYxAPb6D1d63Gw8aBA-1
Received: by mail-yb1-f198.google.com with SMTP id
 i22-20020a25d116000000b0061d9400c540so14562285ybg.18
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 00:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9buv96VJytxyIpwkqFI+aBFQ4oPgjmViPjTC4XMIVQI=;
 b=2bZOW7y2c823/qBLIZyPbRMl7Kry/WLUtfUCNnrC/mNxYAdpyiopuuoiiBYK9ay4m7
 A23PMI9DxJ1G3zpDTgxtuF4OKrXPxnBZ+IVHFHli0/1cwdBtqWzYLE+PQAHONCDuMafP
 e/uaYl3Du08+lGbJH8IwM0YzQtl28GBf+BfIciKC5fAOxEJaIsAVpHQ3mP6aRVTh1neO
 1kenMUkuHn0c5K2Vr6yL81IYMnFBXZbF+wnjbMr30Il3UrWZSNu1oDr7Zsq6h6IbClHo
 RxvzS0paPyG0Z04osW3gNBwN12BOG4CZITyMHTCHLmQGac2CAh35KiWJgGbW2tlRGB95
 no+g==
X-Gm-Message-State: AOAM532NWKBL0w6bu28hsSpqrCpfrdTmLsZcatSggC30HD5077juZUqV
 OqyWAALsZTMjJg69E/b3rD5qZpsMYgDtvVNzSr+sny42G5I/S16rxchuzGH26vAq01TgqCp8svW
 p5tD6TpJTARQJEdemSzr+VCKFBDw=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr3716733ywm.25.1644307446120;
 Tue, 08 Feb 2022 00:04:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS5NQSgMOwAG0SJ/1IfC0Fjszp8vQMukp1MuVlMnFiREu6aZCSDh8dSGZHddOHA6sEecf9WbaHFhUnsLB+vdk=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr3716722ywm.25.1644307445916;
 Tue, 08 Feb 2022 00:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-7-rpalethorpe@suse.com>
 <YfveE3QtrfAQvTac@yuki> <87tudbvsh2.fsf@suse.de>
In-Reply-To: <87tudbvsh2.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 16:03:50 +0800
Message-ID: <CAEemH2eRY8Si+tCS-J8x7kkQZaSjRMsm4xd3hqjGL7F29K+rrw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] memcontrol03: Copy from kselftest
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
Content-Type: multipart/mixed; boundary="===============0179669877=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0179669877==
Content-Type: multipart/alternative; boundary="000000000000373ff705d77d29fc"

--000000000000373ff705d77d29fc
Content-Type: text/plain; charset="UTF-8"

> > Also I think I asked if this si really needed in v1, don't we enable the
> > required subgroups in group_mk() anyways?
>
> No, we only automatically add the controllers to subtree_control in the
> test's group. Note that this is not the same as enabling the
> controller. The controller becomes active as soon as it is added to the
> root node's subtree control. Adding it to subtree_control means that the
> direct children get their own allotments in addition to sharing the
> parent's. I assume that for some tests we don't want that, we want the
> children to fully compete over the parent's resources.
>
> Also subtree_control can effect whether a group is a threaded
> domain... We could perhaps add a variant of `tst_cgroup_group_mk` which
> enables subtrees by default. I just don't want it to be hidden that we
> are enabling it.
>
>
+1 I think that is wise. We explicitly reserve the usage of CGroup V2 for
users.
In case of bringing confusion for people who are not familiar with LTP API.

-- 
Regards,
Li Wang

--000000000000373ff705d77d29fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; Also I think I asked if this si really needed in v1, don&#39;t we enab=
le the<br>
&gt; required subgroups in group_mk() anyways?<br>
<br>
No, we only automatically add the controllers to subtree_control in the<br>
test&#39;s group. Note that this is not the same as enabling the<br>
controller. The controller becomes active as soon as it is added to the<br>
root node&#39;s subtree control. Adding it to subtree_control means that th=
e<br>
direct children get their own allotments in addition to sharing the<br>
parent&#39;s. I assume that for some tests we don&#39;t want that, we want =
the<br>
children to fully compete over the parent&#39;s resources.<br>
<br>
Also subtree_control can effect whether a group is a threaded<br>
domain... We could perhaps add a variant of `tst_cgroup_group_mk` which<br>
enables subtrees by default. I just don&#39;t want it to be hidden that we<=
br>
are enabling it.<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">+1 I think that is wise. We explicitly=C2=A0reserve the usage o=
f CGroup V2 for users.=C2=A0</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">In case of bringing confusion for people who are not familiar=
=C2=A0with LTP API.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--000000000000373ff705d77d29fc--


--===============0179669877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0179669877==--

