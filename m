Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17EDC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 08:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB36F3C5A9F
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 09:29:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8C93C1FF4
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 09:29:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39FB560065C
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 09:29:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646814554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxS+TbRe3qxpy8WhkRm/iSV6/Qor/m8czt7C7RQOujs=;
 b=YVnuqFuc8Rfib8pydtsYpeI/o9n2HrgCDrETOAtm9G/PPyc7avKkiGCZOxaP+ZIsO3NXbt
 I8HrV51cMFRf69D8X7Ovcwrtc4aOcFXeqvWv0Qnj6dfBii6e+xiGVSCEL/PTyLY4cmM/Ve
 xoiJQmp6zvU6XAHrfrvaWDWlAkgD8cI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-aooyaSGEO-218K1-4aidow-1; Wed, 09 Mar 2022 03:29:12 -0500
X-MC-Unique: aooyaSGEO-218K1-4aidow-1
Received: by mail-yb1-f198.google.com with SMTP id
 a3-20020a5b0ac3000000b006288f395b25so1174794ybr.18
 for <ltp@lists.linux.it>; Wed, 09 Mar 2022 00:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UxS+TbRe3qxpy8WhkRm/iSV6/Qor/m8czt7C7RQOujs=;
 b=Yld0Qr3/rkDarWpznAqTEUw6Um9LNKDh4Njs5bki4NaAmBKxdrjKTedxcUQZgkkNWV
 wo3nNe1jaMQjjULQT2O5FJ/VyXEEPyQ/lBqfjjy5LCjdLka8+C0GgrVLQtFowm93M2KC
 ELvPM9GqBiOttB94MOAbnyQ6Bvd+EgGiiDNMF9ur7UIUo8xRRHC76y7CyRXBRaBuUfEs
 NnvqCF7u2gzqgl5stA9WkbhNVx/CrK7R/DCf319/FsI35KjWcEA/9l2s0b0EPaRjfzLk
 82O4CB/vX3o7YrAvkpooyvMIevMUMhgpOLGuNpcM2HYKXGElgd7yeF5JTLcKmUxvlUcq
 nncA==
X-Gm-Message-State: AOAM531+5XXFpzfWYDNP2z2bVOd3RaeuzXORNeGW8qjohZ89t+Umn7q1
 4/19W6kUcZnqA7ROTUoxpVNBF0I4n+q+1M6tIVZQ0YqyT+myKpY8KItJlwUI7Lw901HPFFW3hWg
 AUnzoVXEZO+xjUQ8VlFN6KDqUEnI=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr13895208ybv.211.1646814552484; 
 Wed, 09 Mar 2022 00:29:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyatSO8BsbPm7WgD7A3wgQ6Bdb5YbANtvint/XxW8sjNtu8M7SixK6EiIOjbccEHXs+giBbnnMbnI/XEAgOsss=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr13895195ybv.211.1646814552219; Wed, 09
 Mar 2022 00:29:12 -0800 (PST)
MIME-Version: 1.0
References: <1646858946-1470-1-git-send-email-daisl.fnst@fujitsu.com>
In-Reply-To: <1646858946-1470-1-git-send-email-daisl.fnst@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Mar 2022 16:28:57 +0800
Message-ID: <CAEemH2ckk=F_vOhGjN4QbVhrF621JT8yzEsOfy=pPoMtDCwN8A@mail.gmail.com>
To: Dai Shili <daisl.fnst@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] runtest/syscalls: Add missing futex_waitv
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
Content-Type: multipart/mixed; boundary="===============0130723535=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0130723535==
Content-Type: multipart/alternative; boundary="000000000000657cd005d9c4e427"

--000000000000657cd005d9c4e427
Content-Type: text/plain; charset="UTF-8"

Good catch, pushed!

-- 
Regards,
Li Wang

--000000000000657cd005d9c4e427
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Good catch, pushed!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000657cd005d9c4e427--


--===============0130723535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0130723535==--

