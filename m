Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2438C433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Apr 2022 03:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43BE23CA599
	for <ltp@archiver.kernel.org>; Wed, 13 Apr 2022 05:37:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 090B73C9F54
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 05:37:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5D9461A0067E
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 05:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649821050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5t4I0zDrsP7oEo/pWlKBmXZQ1v9NhbevRThotUW3HY=;
 b=Vs/pC1vlZdhbPWaSgZNl0F2hLXGSJ9yNE3T7AE5g9Xf9bpk1UhTT1NvSEMGoNMSFAbe0kj
 /LFZCZIKOU66yh8pnXWQPRyF0dEhPThgiOm647XUei2gBEh1snKwHUsKjZghLhJZeX9yp8
 Ao60MrVatmKcI0enJ6QsRArb6WWTlH0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-cYkld4faPnC6I7_bvivioQ-1; Tue, 12 Apr 2022 23:37:29 -0400
X-MC-Unique: cYkld4faPnC6I7_bvivioQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2d11b6259adso7000517b3.19
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 20:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e5t4I0zDrsP7oEo/pWlKBmXZQ1v9NhbevRThotUW3HY=;
 b=crwOiujvdRmMbrUjXbdYhnoaGZgoyeYVA28/t9+cPgUKjm67vN4Rb4aeh96Ds7/LyC
 noXJVkSRubihbgc9h7/aphX/1Tmje1xe7LZBOrY+RsiR0ygfPEAg1g1VnVwRgjaCJZJF
 Q04IPrOXjevDDWeFM7eEcoGKZufvDnwxco0UrYKfL/ONyoANk2Y7XzXRjYm5xfWIaaGZ
 42tyN8QYm2XYJNN1j2PjJ5/jtdeXOciP2uHxSJAUHOV6WNH3EJFcamsHpmbCQ6H30Rz+
 nTuTeyrkEsZheNdH93ICLMGorz3yOHu5s5PRGqMee10ymbp5RJMaiTC2xOSE7GNkQ+Ny
 hUpg==
X-Gm-Message-State: AOAM530yxoX+qXgyYg3axb7v/auiPcVzGnE8TPP0aiL6cYTzXNrDvHKC
 bD7o7YMe3Vbw7QNEzrQNvSgJcE3xu5M8LK7KP8lFRhEJM2U0vJmR6cIb8aToZHiIjFxUx0A3gip
 BCiilnSbG6K8TMiZWTqQVnU1Dpzo=
X-Received: by 2002:a25:a203:0:b0:63e:4e0c:2e5 with SMTP id
 b3-20020a25a203000000b0063e4e0c02e5mr21667794ybi.233.1649821048531; 
 Tue, 12 Apr 2022 20:37:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjxU8UvKQchzOoIWUla/x7WZcD2+OQXkQ8DeVdmxfZlFQw9wg1LOVszlB/WVCtXn1btyGTrhNsz9v8eMlt2NM=
X-Received: by 2002:a25:a203:0:b0:63e:4e0c:2e5 with SMTP id
 b3-20020a25a203000000b0063e4e0c02e5mr21667788ybi.233.1649821048312; Tue, 12
 Apr 2022 20:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405093307.6156-1-pvorel@suse.cz>
In-Reply-To: <20220405093307.6156-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 13 Apr 2022 11:37:08 +0800
Message-ID: <CAEemH2dHjH_UjLbgW+N2Wmuw7D943k-uDxF7k84cOJ0Ncyp+dQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] syslog12: Rewrite into new API
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
Content-Type: multipart/mixed; boundary="===============0901440280=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0901440280==
Content-Type: multipart/alternative; boundary="000000000000872aa605dc80e50b"

--000000000000872aa605dc80e50b
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Tue, Apr 5, 2022 at 5:33 PM Petr Vorel <pvorel@suse.cz> wrote:

> Changes:
> * set also GID
> * move non-root user test to the last in case SAFE_SETEGID() or
>   SAFE_SETEUID() fails
> * simplify test structure
> * usual cleanup (remove bogus code, use safe macros, tst_syscall())
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Nice work!
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000872aa605dc80e50b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Apr 5, 2022 at 5:33 PM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Changes:<br>
* set also GID<br>
* move non-root user test to the last in case SAFE_SETEGID() or<br>
=C2=A0 SAFE_SETEUID() fails<br>
* simplify test structure<br>
* usual cleanup (remove bogus code, use safe macros, tst_syscall())<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br></blockquote><div><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Nice work!</div><div class=3D"gmai=
l_default" style=3D"font-size:small"></div><div><span class=3D"gmail_defaul=
t" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liw=
ang@redhat.com">liwang@redhat.com</a>&gt;</span></div><div><span class=3D"g=
mail_default" style=3D"font-size:small"><br></span></div><div><span class=
=3D"gmail_default" style=3D"font-size:small"></span></div></div><div><br></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000872aa605dc80e50b--


--===============0901440280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0901440280==--

