Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A33C433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 11:22:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 561543C9FDF
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 12:22:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBA263C8D8B
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 12:22:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8290B600718
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 12:22:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644837721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lgob6shm3XGT9PYiMwXj0X1tvbbgy21gYuNFummMcCY=;
 b=FNgvjYnBm/rMMZ2tBex5o1QO34XgwL6vD3VlBGLNievuIlZ/9nB5cYDJpy4blk2XiVdphH
 pEJZZzNMDrNgmQcS5ve3DxgG7NCGUjI5l4o6TG8UE+RxKARpaOgB89ogXl0j0LxKDead0D
 ycN1arHj6HRIFqVvqIYPEO7D9u5DEjM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-_FkH2v--Nq6NU0VMabRqMA-1; Mon, 14 Feb 2022 06:21:59 -0500
X-MC-Unique: _FkH2v--Nq6NU0VMabRqMA-1
Received: by mail-yb1-f198.google.com with SMTP id
 b12-20020a056902030c00b0061d720e274aso33131275ybs.20
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 03:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lgob6shm3XGT9PYiMwXj0X1tvbbgy21gYuNFummMcCY=;
 b=yjeg5xbm1AEXWHdDPHiP5gtQW9I9RYrmllqi7wx6JEHWiO+Twc88jECh2DJ6q/wCRb
 0F4vNXdNNIlpu85Cw8CyJBR52mZcQE6ENZFc5M3KAME/psEcFFkKf0wVS/TY1xnijHIF
 UypbQ32eFA9FrL+mH+fjhhxmF9EJ0+O7Xm+TYoe5nwwUwPPloihbyQKgCcEznuEFYvGd
 tjXWa8aqraDx/SHqk/VvzvhVNVi3sC4B/4JeIpGjdFjJwMBiu+1TOYK6MUDKWIWmGEyy
 NUMRQgY8QfANS54FKwVEUuYvlK/YbnzBpgE+BR57om7fbm2HVnZjk6f03THStP3ZAWrm
 E4LA==
X-Gm-Message-State: AOAM532kckzxJxTR4VdpkTCm/1TNQxSsi00lM18iiuW9R7Y8+XPVyC6n
 8wiegm5+M/bmpIYP5mOkAtc9bJNM5UyQ6C+VUeEUnG82Tifu9G6fyK8SUyZ7rlQI0ymFyQ/xFoE
 Rl6+IEYGOUdxsGIvt59QEpGTgWuo=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr12344374ybp.421.1644837719101; 
 Mon, 14 Feb 2022 03:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAnyhsEgUkA9pYpmlw9Fq5onVAwBJ5azDy+rrjts2FKtnBZjDsMgJ+ZuSw/0no6nRN45Rk1R1lShV96LkB6yg=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr12344364ybp.421.1644837718884; 
 Mon, 14 Feb 2022 03:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20220213042836.3028266-1-liwang@redhat.com>
 <Ygk4bFjqdKozU+zL@pevik>
In-Reply-To: <Ygk4bFjqdKozU+zL@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Feb 2022 19:21:44 +0800
Message-ID: <CAEemH2fubR_RhapsQw0MOGw1rSm7sNTRt4OSeu3rG5LVYDSQRA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup: allow child zombied for a
 while
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
Content-Type: multipart/mixed; boundary="===============1196588854=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1196588854==
Content-Type: multipart/alternative; boundary="000000000000f299db05d7f89f12"

--000000000000f299db05d7f89f12
Content-Type: text/plain; charset="UTF-8"

> > +elif grep -q -E "Z|zombie" /proc/$CHILD_PID/status; then
>
> task_state_array[] in fs/proc/array.c has "Z (zombie)"
> Is there a reason to grep just "Z"? Because -E "Z|zombie" matches just "Z"
> and
> when we don't grep for "State:" we can likely search for different result.
> "Z (zombie)" is here form kernel git beginning (2.6.12-rc2), we should
> match it.
>

Thanks for pointing out this, but it seems this fix-way will be superseded.

-- 
Regards,
Li Wang

--000000000000f299db05d7f89f12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; +elif grep -q -E &quot;Z|zombie&quot; /proc/$CHILD_PID/status; then<br=
>
<br>
task_state_array[] in fs/proc/array.c has &quot;Z (zombie)&quot;<br>
Is there a reason to grep just &quot;Z&quot;? Because -E &quot;Z|zombie&quo=
t; matches just &quot;Z&quot; and<br>
when we don&#39;t grep for &quot;State:&quot; we can likely search for diff=
erent result.<br>
&quot;Z (zombie)&quot; is here form kernel git beginning (2.6.12-rc2), we s=
hould match it.<br></blockquote><div><br></div><div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Thanks for pointing out this, but it seems =
this fix-way will be superseded.</div></div></div><div><br></div>-- <br><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--000000000000f299db05d7f89f12--


--===============1196588854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1196588854==--

