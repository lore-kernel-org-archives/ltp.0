Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54CFC433EF
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 02:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7278D3C9F3B
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 03:16:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 619073C9F0B
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 03:16:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 547CC6021EA
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 03:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644632204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NbTjYHq6xh+uP9hkWF6I/sNNyYCGcy2UhPXmKnsB2iQ=;
 b=hoaFxo5KkzUL5rLUc+DXCArxrLPdHgM/cLzcDSTbToTQhxK1ZDeoLBl4QkqdrSvv8VwaDX
 tBPLXpfMcxwqVoJ8/88IbWaUBJqqLcTK8URcif/j1VLdGU0DlD+iMTtSnuNaWdS+bQgJAy
 7r/QhwTZR7Oq4fXsM8XjS7RxtQPSlqg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-LN2Qo9I9O9q4zv2Cne8SXQ-1; Fri, 11 Feb 2022 21:16:43 -0500
X-MC-Unique: LN2Qo9I9O9q4zv2Cne8SXQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 g205-20020a2552d6000000b0061e1843b8edso21622110ybb.18
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 18:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NbTjYHq6xh+uP9hkWF6I/sNNyYCGcy2UhPXmKnsB2iQ=;
 b=S03ZCosSAjPDFO/daltegd0AhhzqyO/8ZA7XvnWEoiFlc0j6fom/y3ka9d/rEuhAuH
 1W0/cayBQp/JnDAgHOH3DzZTGvKVx3YgjvFj5LfF56PEwLTt28dQd4Kzw5Idswn/TwCa
 62HJ+i1eCaY9jwIsgMzXHWk4jtAi3Dhtk+pCnwTPLzPOZpyfWGNL9IOWBZCvg6QQlvtI
 CVWi/M7+X9VzhaXTo6XsGUSt8rBXfJiniaQwOGMVYJ7HjNOFjcY/Kki/umpesL8aBLLo
 bp93FI5zmtX1WjP5f1QxQ5qrMUP5JkK5yu2KIlutZ9qcKMBNl9Bc12Hxr/LZ7tXzHSqD
 gVlg==
X-Gm-Message-State: AOAM532REGC/wNWl6uLOlwfPyEa1mJEv+30bBK1pSnJMq6J0qdMFuQ+8
 2jGxpJpvU6lGWQLgG5h8p7zPc/wI7ULnzghf8hnkB8wTBo7botRkjC3qIPxC8HQd+36ToQvFKQt
 v5FNJu71sCxwEM2AiYgsYOMCBnBw=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr4266610ybp.71.1644632202569;
 Fri, 11 Feb 2022 18:16:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHA0XhrAsdD38HjZuCjIrAspu35YXw5chOGu4Mz63c5a/VFb9jrCG2Bvxk+N1NWyij1qqVMwxC5jz72NRCcRI=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr4266597ybp.71.1644632202302;
 Fri, 11 Feb 2022 18:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20220211162426.12284-1-blezhepekov@suse.de>
In-Reply-To: <20220211162426.12284-1-blezhepekov@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Feb 2022 10:16:29 +0800
Message-ID: <CAEemH2d9AdMXi8qrBN23M2AR6W_MXaUZ9AzE6h3f1Sn-oD6piA@mail.gmail.com>
To: Bogdan Lezhepekov <blezhepekov@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/swapping01: Use .needs_kconfigs
 instead of .setup
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
Content-Type: multipart/mixed; boundary="===============1614601618=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1614601618==
Content-Type: multipart/alternative; boundary="000000000000346f1d05d7c8c6f2"

--000000000000346f1d05d7c8c6f2
Content-Type: text/plain; charset="UTF-8"

Applied, thanks.

-- 
Regards,
Li Wang

--000000000000346f1d05d7c8c6f2
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Applied, thanks.</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000346f1d05d7c8c6f2--


--===============1614601618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1614601618==--

