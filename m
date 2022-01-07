Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A495C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:07:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C7793C9029
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:07:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53EF43C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:06:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2F31F1A01164
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641546411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FAJQR01MM8kqFJ5XxU84l1yV3KdB2maRqFaAuRmKeM=;
 b=Ube3iBmPbOqp+6ctuewabYLxsvH+1wka8+L3KmFVfuXdst6L8NhyJ8hFK+Fzh+Qvj/FKPc
 eToYV9wcIRED6ECbxWC7bwu+LcOzlHEgoymiCsXOKj//gD0hxZVV0T5jo/qgoYK55n4v5N
 BFNov3y6mWS5AojQ0/YC4EpnoyXM1xA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484--5kgSpuOMDmMxy2gVwgccA-1; Fri, 07 Jan 2022 04:06:48 -0500
X-MC-Unique: -5kgSpuOMDmMxy2gVwgccA-1
Received: by mail-yb1-f198.google.com with SMTP id
 i129-20020a255487000000b006107b38b495so1602037ybb.16
 for <ltp@lists.linux.it>; Fri, 07 Jan 2022 01:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5FAJQR01MM8kqFJ5XxU84l1yV3KdB2maRqFaAuRmKeM=;
 b=m2wu32TxtKojrSsN+NJ8WJC7s4Uq7VjP6FcCyPIgP7m7RIX918wwcw/ilC2NT2ONym
 kgUYQQJVmilrVtWBA6tQY0ExAXJfHmWZOPsaDm+YwijHx44zzzYduK9WrRjUlC/ylpVA
 TEybajkCoVdyjZP2nc6caj8/i8dNT9bbjJN7eoXJZk2V9TFLY3qMqzBkV5LC2qjtgWu7
 IWv12VTc7t366U6dI9rjpkEzylY0OrHqD4XJqeIbzuKoAZt/3yYQGyJOxZUABnEz+PRT
 qWwWch8MiBHGLrgUnxcPfQoWKRPWzoI33eJLiQy669ca2V5Kc6zd8h/+0XlPzgqt7xfr
 7Mww==
X-Gm-Message-State: AOAM530Ei03F6SBadt/e1pxA613KY4rhCPbGohCwiEVZ8T2EGTT4Zac/
 AQ1Z0XIUiEfOIWsxI/ceRz8gNz27zhBRffmyhrb/l5ckfV+610XUKap+VxuriAA0snWIiKtCFWr
 X51ND324TLbS6kofs+1NzNkZCp5I=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr81068692yba.248.1641546407724; 
 Fri, 07 Jan 2022 01:06:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjP9SiAyjsEKON0HZK5IO3qDC+XF+UVZhquEFesGVod7ca04GZE4qNraEEblvJzqDhQWzsnK4mv5EJFQV3rA4=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr81068652yba.248.1641546407184; 
 Fri, 07 Jan 2022 01:06:47 -0800 (PST)
MIME-Version: 1.0
References: <YdWC0f+70TF6Eluk@yuki>
In-Reply-To: <YdWC0f+70TF6Eluk@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Jan 2022 17:06:30 +0800
Message-ID: <CAEemH2ceOdg2W+0ZsZEQGfoCCC0a7hDz9XLsbgQ_HqQXPRPOeg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Type: multipart/mixed; boundary="===============1267746547=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1267746547==
Content-Type: multipart/alternative; boundary="0000000000007bac2c05d4fa4ed2"

--0000000000007bac2c05d4fa4ed2
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 5, 2022 at 7:35 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> As usuall it's time to start preparing for the next release.
>
> Given the amount patches waiting for the review I guess that we should
> try to get reviewed and merged as much as possible in the next few days.
> I would go for git freeze at 14. 1. as that would give us a week for
> pre-release testing and the release would be, as usuall, finalized
> around the 21. 1. Feel free to reply if you think that the schedulle
> should be different.

Sounds good, I'd kick start pre-release testing on 17.1 from my side.

>
> Also if there are patches that you think should be merged before the
> release let me know ASAP so we can have a look soon enough.

Maybe could consider the concept of the test max_runtime series?
https://patchwork.ozlabs.org/project/ltp/list/?series=268799


-- 
Regards,
Li Wang

--0000000000007bac2c05d4fa4ed2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Jan 5, 2022 at 7:35 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br>&gt;<br>=
&gt; Hi!<br>&gt; As usuall it&#39;s time to start preparing for the next re=
lease.<br>&gt;<br>&gt; Given the amount patches waiting for the review I gu=
ess that we should<br>&gt; try to get reviewed and merged as much as possib=
le in the next few days.<br>&gt; I would go for git freeze at 14. 1. as tha=
t would give us a week for<br>&gt; pre-release testing and the release woul=
d be, as usuall, finalized<br>&gt; around the 21. 1. Feel free to reply if =
you think that the schedulle<br>&gt; should be different.<div><br></div><di=
v>Sounds good, I&#39;d kick start pre-release testing on 17.1 from my side.=
</div><div><br>&gt;<br>&gt; Also if there are patches that you think should=
 be merged before the<br>&gt; release let me know ASAP so we can have a loo=
k soon enough.<br><br>Maybe could consider the concept of the test max_runt=
ime series?<div><a href=3D"https://patchwork.ozlabs.org/project/ltp/list/?s=
eries=3D268799">https://patchwork.ozlabs.org/project/ltp/list/?series=3D268=
799</a><br><br><br>-- <br>Regards,<br>Li Wang</div></div></div>

--0000000000007bac2c05d4fa4ed2--


--===============1267746547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1267746547==--

