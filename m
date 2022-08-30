Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE197ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C8613CA617
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:13:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94DC43C81E1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:13:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B783600147
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661839988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5NR3zdnjxEmZ3dWc0csHZM9jIy6Mw5P+U1OqBQ8zeYE=;
 b=feJuXrpBLd0yteUcQKwkwA9xxdRn9EcwjATB0JA4ojQLP4/RuHcU4q0VAnp1Rz09Haxx9n
 8//+X5HTnvLGzaH1r/kNPpYLX/HjpC9tZF0+eY6/jrDA7HhXpQP3zUVH9bzZf7+FmuhOoM
 MqkHYd8Zl5t3v6miycrFNtY8aMUQF4M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-N7yaKwBvMJCRLAiYFkOgOQ-1; Tue, 30 Aug 2022 02:13:07 -0400
X-MC-Unique: N7yaKwBvMJCRLAiYFkOgOQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-337ed9110c2so162560537b3.15
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 23:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=5NR3zdnjxEmZ3dWc0csHZM9jIy6Mw5P+U1OqBQ8zeYE=;
 b=hjM6sSVskAe2pP+lV97nCDjuczZaXdN7Ryiklb0cf2wKXQ3LO6OutaXucDav2Z7gS6
 5IX9ru80w0Yy8Hac/sr8A2Msp3XzksxzBJZ+8/SAk16l6B9d1b3fHkTM+maURY0EQkjN
 8J8X4K8iq28LEZjqOb7j5gHB/h5KcfjHdS5xqYBNRhfaVVvOxi/XxdIBq7Nq+/6W8bFk
 tsmwbuPX8BFZ/WCSpeDwyHsGnOkU38DW1qRVP3DDmY76u3l3eLnvOu5Q5+5tsGmO7+rV
 gyIzDM6sx8/7pdhK4yb/v3f+iJ9E39PmgrU0cwvin5kHgTVDeVUR1VAYdLWdFgIMA2bl
 HjQQ==
X-Gm-Message-State: ACgBeo1JSKwg2NGmJw+qMbbAeBy3rJ++sjhOt9zyEvle9n+mtatm24mH
 TB6FcqAAcUvT2r0Ggu1KklILzO4ZC1hH0x0Ed+OOUGCj9D9Icra7PcstqSybyQQRrF08rz7Ewei
 pRHljLJykqk8ow2JdhLdg4iv//Wk=
X-Received: by 2002:a25:e047:0:b0:695:8f0e:4c91 with SMTP id
 x68-20020a25e047000000b006958f0e4c91mr10280412ybg.301.1661839986407; 
 Mon, 29 Aug 2022 23:13:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7un4ALK2B5kQVrew0jgUgqh2a+zgJYDRzEoLasH+IKR+wUA5mf5Z2rNxsVT1iO5H9zVliMGfcXpbEYr9DvQPY=
X-Received: by 2002:a25:e047:0:b0:695:8f0e:4c91 with SMTP id
 x68-20020a25e047000000b006958f0e4c91mr10280376ybg.301.1661839985081; Mon, 29
 Aug 2022 23:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-4-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-4-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 14:12:54 +0800
Message-ID: <CAEemH2dRx75Kjo+pwVAXhAa3RbVA5HLt5c6YHP+EEM-NEGKjYA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] tst_test: Use 16 MB also for tmpfs
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1226725388=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1226725388==
Content-Type: multipart/alternative; boundary="000000000000fc1bea05e76f45ea"

--000000000000fc1bea05e76f45ea
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000fc1bea05e76f45ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redha=
t.com">liwang@redhat.com</a>&gt;</div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--000000000000fc1bea05e76f45ea--


--===============1226725388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1226725388==--

