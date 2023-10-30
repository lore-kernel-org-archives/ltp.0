Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B94CC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 03:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4633CF42A
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 04:30:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B961C3C8493
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 04:30:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1A2660029D
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 04:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698636607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HakdvsedFW9SxjEp4SBKLgonKbRNDrunIW/s5OHrGKk=;
 b=Swe2Ox8Lr29frKYdZ++IijFTBHlgsWXX7Cd8a5MwyAFiJCKUyG5zv7qyAcyxlYS1TUFklp
 CqkFgQiiKCob918dGnSGL6vI+p4TjmmHeFeXAu1C7LhBDVmGkxIXV0M+jGZ6ztcx76Jmlk
 eEtXMGrghN0iMwWRn5V0zVuqts7PTRQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-6m7YzKEWMKmaJq60B-HfwA-1; Sun, 29 Oct 2023 23:30:06 -0400
X-MC-Unique: 6m7YzKEWMKmaJq60B-HfwA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so4435726e87.2
 for <ltp@lists.linux.it>; Sun, 29 Oct 2023 20:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698636604; x=1699241404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HakdvsedFW9SxjEp4SBKLgonKbRNDrunIW/s5OHrGKk=;
 b=dNs2nWAp+4TjLVedR+tVkKAOLgawDgNhHN66wbUqhXn+t3Y07aeUKsdA7ifjU59qNJ
 45VmmxfHSWtO0e1BaJklTEbzWCDcd8xxoIT+2yOT9iLnELkKaTJrPfhHhfYdKjfpNTGT
 e00iJ6rTugYOZx0a1MD4JcMI1RLkHXvbbqyD0L2XI3mv2jVSTm+T4BFsEwJK7sGTAzQ9
 xpg5+g8HaHzR1UrWOsBb9lh51/RbYC6yjtD+Ng0JftLLPUZwc36ECfxdVFHZ6xiM0edj
 MDOgqLfWQNP6/4EV1fgCSLSo6FtiqXnQHTiUaAL2Vd43wxhpD1cOLmNFLg1hUgiswBha
 FCJA==
X-Gm-Message-State: AOJu0Yw2Hj+GWZFFkEHLanI2rJTohUaztJhIo2HHPxADqrndIytst4/H
 cZCRoJ6S7vIS4rNTvZD6futcLQCJQGG8P0bMQwEDy6WJksq0q1FibsrLHeUcRzUSNSUKusvWgjd
 SwfZLcTSD/23+x/SSHQf4F69b6itqwBSTzu6TH1Gkq00=
X-Received: by 2002:a05:6512:457:b0:508:21c8:92e3 with SMTP id
 y23-20020a056512045700b0050821c892e3mr6187419lfk.9.1698636604149; 
 Sun, 29 Oct 2023 20:30:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4zsCSHZ9qBnx6JD+p5SVuK5fZ+fsZj7zX0umGG1eDCMTC2OWI/VU4yOY75fWoqHAVxqFVlvHSGviPoZdOMz0=
X-Received: by 2002:a05:6512:457:b0:508:21c8:92e3 with SMTP id
 y23-20020a056512045700b0050821c892e3mr6187414lfk.9.1698636603771; Sun, 29 Oct
 2023 20:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231027174322.710674-1-pvorel@suse.cz>
In-Reply-To: <20231027174322.710674-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Oct 2023 11:29:52 +0800
Message-ID: <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:


>  DEF_16                 := TST_USE_COMPAT16_SYSCALL



> ...



> -%_16: CPPFLAGS += -D$(DEF_16)=1
>

Seems we need to keep this one line, otherwise it can't transfer the
'TST_USE_COMPAT16_SYSCALL=1' macro in the compilation.


The rest looks good to me.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
