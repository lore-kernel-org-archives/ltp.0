Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F936C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 02:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643963C8CB5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 03:22:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210473C0681
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 03:21:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 74E4C100047A
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 03:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637547708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=whwUvebF9VrcS6afgIrkbTaIlgSVBSrXtbVY9eQijDE=;
 b=b39fap7osMLJJpSm1cDIjjIrX9Rv5ZaL279FfkpXKZM4P4VX8ZiS9FvxAuU5t5sl1cqRBt
 N7Z0WZFf6eSbvw2qvoQ9iaOe1/cS9au8q24ayzU2lzzTLFvKGf5NItbvy6eRypuVM2zWs2
 qohNVlHvXaFAhwKx1BgK3uR4f3tfEcg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-zCqYxD7hOo6SbL3-oyZvsQ-1; Sun, 21 Nov 2021 21:21:46 -0500
X-MC-Unique: zCqYxD7hOo6SbL3-oyZvsQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 z2-20020a254c02000000b005b68ef4fe24so25866889yba.11
 for <ltp@lists.linux.it>; Sun, 21 Nov 2021 18:21:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=whwUvebF9VrcS6afgIrkbTaIlgSVBSrXtbVY9eQijDE=;
 b=x8mw2bsfsckJFqwHpzbI9Kd+DiKGTrWUDETf7Wi083aGcURg+nImqfmzSnpFCInB0D
 K9ZRviNgPEc5fUCX0vdlwv0Fk5XA5ihmidiyR7BTwZainbexF+PuWwo3MT/7UFDon5zN
 O6+4tbj2KVdmf5yNAJbOOdKUh8Oog3D87K8PpyHpoKVGTIBFyKmhQW4B0jdPaQHXqZDl
 RsQFLmVEUy8XIlh1Yy9XIOFUGG4dwqSzJC3ELrvJxd0gimakCc/QErVeMr7gdfpUQbbi
 5yU3AymLXrMYEZOIpFIC3AX/HJW0SDOwFBA/hX5QDCJMN7nsNRetWT3+dyVMUleKqCFr
 MotQ==
X-Gm-Message-State: AOAM530hxtZbJhRfFFsyY8rzLrX8tXC+Mk586q4UqD3jMKZLwng8mzuM
 eHhYLF4AgdOBHHV50FxNmZ3tgW8Kp/qsi2pJVaTh7shc1C3W84gGFRysmMG2VdfS/jNO6OkbUaT
 pU/q1fuDcoyp7uLX0W5NwRzMcDsI=
X-Received: by 2002:a25:82:: with SMTP id 124mr10253453yba.490.1637547706325; 
 Sun, 21 Nov 2021 18:21:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhHWidh1YdSLmzsjQfpDaYSSnr5SmVNY6rGqFE4UFwtBlFKdxBxprojyJOJ/sDVmQ7c7KCy0qqhyTW0Mx58tw=
X-Received: by 2002:a25:82:: with SMTP id 124mr10253425yba.490.1637547706088; 
 Sun, 21 Nov 2021 18:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20211117070708.2174932-1-liwang@redhat.com>
 <77e0b8b9-5de6-73ab-0f73-e3d95bad0935@jv-coder.de>
 <YZZCAXWRcrsYJo9+@yuki>
In-Reply-To: <YZZCAXWRcrsYJo9+@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Nov 2021 10:21:32 +0800
Message-ID: <CAEemH2ehTUoDTqa21vKDvC4vQuTPBM1j23Dqa=FFEJjcPLsvvQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Content-Type: multipart/mixed; boundary="===============0260695771=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0260695771==
Content-Type: multipart/alternative; boundary="00000000000053112705d15749ec"

--00000000000053112705d15749ec
Content-Type: text/plain; charset="UTF-8"

Hi All,

By now, should I push this patch v5, or is any else change needed?
(From the above discussion I feel v5 is satisfied almost all of our
requirements.)

-- 
Regards,
Li Wang

--00000000000053112705d15749ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi All,</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">By =
now, should I push this patch v5, or is any else change needed?</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">(From the above discussion=
 I feel=C2=A0v5 is satisfied=C2=A0almost all of our requirements.)</div></d=
iv><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000053112705d15749ec--


--===============0260695771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0260695771==--

