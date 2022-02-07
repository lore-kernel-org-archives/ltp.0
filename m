Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60816C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 04:10:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C81733C9834
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 05:10:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E427F3C06E0
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 05:10:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4136600681
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 05:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644207002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYDgqR3dBnocdUHbMyzSRw0aRNJpva6E8eruANR3W28=;
 b=Qd6e/YW4jKTloJtNUZDXPnuq33kWTheUQiRET4RL9HRQcBIxaBvT32JitYY5YhlRHcVGbF
 bjF/woV5N3FBWiUMjELdHSsP8Q7GvrBWaYBfNm3rynHRP+XyAh0KJDhcs6AoTy9OYdMtV1
 Xhxu/r1iascyrzfMBDRcptzKYvqDlY8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-TsA02XOsMniLw25Gsujz4Q-1; Sun, 06 Feb 2022 23:10:00 -0500
X-MC-Unique: TsA02XOsMniLw25Gsujz4Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 m10-20020a25800a000000b0061daa5b7151so3690060ybk.10
 for <ltp@lists.linux.it>; Sun, 06 Feb 2022 20:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qYDgqR3dBnocdUHbMyzSRw0aRNJpva6E8eruANR3W28=;
 b=F3GP3BOK5mXFM7V1BAL3LazRevQ8P7Ws0AG8c/uHjVsVDVw/PV/cf+mFWyfh+BijMj
 SvYZvvihr5Z0wlv1BKT3JeyNwFvwbEPYMjAqGGQmpruOPPvu4s9qc6esUXkIA65Zqa+P
 Hu9ALdnfawRBrhxAF7PCXwZAgGq0ntUZV4MbYqqnC92P+Ztp1LkNgVPG+TrIJKXqLaxu
 j2Jsfm/QhhIf3gmM9qm0mihCPnR4ObAWPxnXEW1mfhLp1HAUs0seBxAaXaVrV31YRmAd
 5xitctW3Kl4li3st1mU3sCLg+ZpzfogrXqSCBSmuiWH9Q0wCdhfFN2oXXoD4xCataddd
 VOlg==
X-Gm-Message-State: AOAM532JH5V8ZNALy0bw+WG/vw7z+B1ng56yEqiIEnICh0Qv1F4BCmDW
 COouCq4jcIC/2VfvZXESxePAl+x+FvUZo6gv2bsm0+p+MiqD/YAkJrjnW1qVjzkyK9HuHZySj1m
 lMpOOuxEWgEvvgQEPg6yRvc3KmVs=
X-Received: by 2002:a81:3e20:: with SMTP id l32mr9556391ywa.208.1644207000035; 
 Sun, 06 Feb 2022 20:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXjimRCBk57BxKEPA/FNgGZPte2OWocd8hRkdiuKKJBsPINHhQFJw0htgb7kD7hVYL8LhGQqSQzjuagpNmAIk=
X-Received: by 2002:a81:3e20:: with SMTP id l32mr9556374ywa.208.1644206999772; 
 Sun, 06 Feb 2022 20:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
 <620095ED.1040808@fujitsu.com>
In-Reply-To: <620095ED.1040808@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Feb 2022 12:09:47 +0800
Message-ID: <CAEemH2cs3-rBd+XTkh1A0ZtQxU-1WVx_pQtYGMyZX0zG48csew@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1993643313=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1993643313==
Content-Type: multipart/alternative; boundary="00000000000028b5d105d765c689"

--00000000000028b5d105d765c689
Content-Type: text/plain; charset="UTF-8"

xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com> wrote:


> In fact, we don't have mandatory rules that TAPSS or TFAIL only can
> occur one time. a example ie memcontrol02.c
>

Right, that is my hesitant part for counting that.
Seems many tests abuse the TPASS|TFAIL for defining test fail bound.

-- 
Regards,
Li Wang

--00000000000028b5d105d765c689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><a href=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fu=
jitsu.com</a> &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.j=
y@fujitsu.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
In fact, we don&#39;t have mandatory rules that TAPSS or TFAIL only can <br=
>
occur one time. a example ie memcontrol02.c<br></blockquote><div><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">Right, that is my he=
sitant part for counting that.=C2=A0</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Seems many tests abuse the TPASS|TFAIL for defining t=
est fail bound.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--00000000000028b5d105d765c689--


--===============1993643313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1993643313==--

