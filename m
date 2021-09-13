Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95344C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:26:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A9D60FE6
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 07:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1A9D60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8253C8A74
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 09:26:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E849C3C1DC0
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:26:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3602600A31
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 09:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631517996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhASDTPaoYbQUOENCzHZYs9/MBYqYTxDbvKj6WWw50A=;
 b=WyQ/arWievkI4PK5ga3+gWZZTGarMRyIr+wI3nqvBXpj+ys9IQLrZmWNeuSWfX66h7fRdO
 rEwDWu7sBB0PKYmHOUPqjDYVIP1so0XJuWECMr1UIbDQMIwLk3Z03spDF2S22AzbLq1nYR
 4/Uh9XDh75YB7SqOoaerwgiLh/11dIc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-ajNX3V7UMWSi-yg0znfByQ-1; Mon, 13 Sep 2021 03:26:35 -0400
X-MC-Unique: ajNX3V7UMWSi-yg0znfByQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 b84-20020a253457000000b0059e6b730d45so11821462yba.6
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 00:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bhASDTPaoYbQUOENCzHZYs9/MBYqYTxDbvKj6WWw50A=;
 b=gxWPEFimZE7M2UbEZL7iwU/UPLxsrKEpdK5wwUXf88/F4Mloqw/MAwvt9ttgVser8h
 SK1TLA2CJ9PYtmjUM+I632guKTZdClIU/O+V0zN+uH/SiCX9J0jd0mABdzI4zZZyJioz
 d7sEkkfvAK0Zej+Rx9UnDUSBZoGbRdHVoyooCtP+shYiw3NZBgQDwpwxtaW6Gef38q/z
 wFw+/ikqB12m3s9b7x26FnWm6C+IURbBwGGA1tGkEm0czHP+sH7NXnDMXB+M0cEXUi5j
 5MfofRK/tstEhDtxbGW5/S9lLdZEWa91lncphyQY5oNijvUlfVNYVKyT6GI1uT73sXhV
 NZEg==
X-Gm-Message-State: AOAM533S7mINRYet1W5JpM/ZsULKxwdnq9Q/KnZGA0RT4426XlxJzPmF
 qqHnGnPWRbnTxJ67kFoseCJzumWElmvgVgT8SkYLtur7RV1T3HGbS/87+IusDvOovLziQD/VJhP
 UM+x1Y1xvSmYZEDNWo8IKDXoNzgM=
X-Received: by 2002:a25:7c44:: with SMTP id x65mr12272249ybc.186.1631517995014; 
 Mon, 13 Sep 2021 00:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTM4x4Wj0avdMFszC44zFTtAxuFmE3k8GPYD79g8idYzi2Zv03QMiQN2XsGMxxHxGC12tDDQ4ZfshA9Q2zZAQ=
X-Received: by 2002:a25:7c44:: with SMTP id x65mr12272233ybc.186.1631517994761; 
 Mon, 13 Sep 2021 00:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130820.21141-1-pvorel@suse.cz>
 <CAEemH2evPtStSndYb0viwt-+x+g4dB3FER366_KEjcRUn7pWYg@mail.gmail.com>
 <YT7wZrmi8Jc0YHfL@pevik>
In-Reply-To: <YT7wZrmi8Jc0YHfL@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Sep 2021 15:26:22 +0800
Message-ID: <CAEemH2cO31kSwK3=tk6krB8ZZYPPaP+c-+5D7FGRK2ofYSmbtg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] Cleanup sched/process.c
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
Content-Type: multipart/mixed; boundary="===============0444425556=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913072622.Jppc1nym6H5EZFNkZsiOJixqMmlg94Avq3sUMFOUFQE@z>

--===============0444425556==
Content-Type: multipart/alternative; boundary="00000000000085d7c305cbdb628e"

--00000000000085d7c305cbdb628e
Content-Type: text/plain; charset="UTF-8"

> > But I just wondering, is there a run test file to perform this test case?
> > I greped the runtest/* but find no file currently includes this:(.
>
> IMHO it's in sched:
> $ git grep -w process runtest/
> runtest/sched:hackbench01 hackbench 50 process 1000
>

Hmm, here "process" is only a parameter to hackbench01, it
has no direct relevance to the process_stress/process.c.

After checking the history a while, I think that process_stress/process.c
is an independent test and obsoleted for a quite long time, maybe
we can add online back to runtest/sched file or just let is there until
someone converting to the new API.

commit 576f1ee560b2370818b49366bad581952af3dd70
Author: robbiew <robbiew>
Date:   Fri Feb 1 16:39:39 2002 +0000

    Removed a test that was not correctly running.

-- 
Regards,
Li Wang

--00000000000085d7c305cbdb628e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; But I just wondering, is there a run test file to perform this test ca=
se?<br>
&gt; I greped the runtest/* but find no file currently includes this:(.<br>
<br>
IMHO it&#39;s in sched:<br>
$ git grep -w process runtest/<br>
runtest/sched:hackbench01 hackbench 50 process 1000<br></blockquote><div><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">Hmm, here &q=
uot;process&quot; is only a parameter to hackbench01, it</div><div class=3D=
"gmail_default" style=3D"font-size:small">has no direct=C2=A0relevance to t=
he process_stress/process.c.</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">After checking the history a while, I think that process_stress/process=
.c=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small">is an =
independent test and=C2=A0obsoleted for a quite long time, maybe=C2=A0</div=
><div class=3D"gmail_default" style=3D"font-size:small">we can add online b=
ack to runtest/sched file or just let is there until=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-size:small">someone converting to the new =
API.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">commit 576f1ee560b23=
70818b49366bad581952af3dd70<br>Author: robbiew &lt;robbiew&gt;<br>Date: =C2=
=A0 Fri Feb 1 16:39:39 2002 +0000<br><br>=C2=A0 =C2=A0 Removed a test that =
was not correctly running.</div></div><div><br></div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li=
 Wang<br></div></div></div></div>

--00000000000085d7c305cbdb628e--


--===============0444425556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0444425556==--

