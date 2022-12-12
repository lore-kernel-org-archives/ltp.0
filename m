Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A68C4167B
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:40:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 103FA3CBE7E
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:40:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 957C23C2B4D
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:39:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 00545200758
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:39:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670863189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f+MKzh8LMLpF6fZwjrwKL8EIWrQsY+iofndmiLR1ngA=;
 b=ee7WK8UAe8nuw5P0BOp9FmV3xfY2Oo+dXf1AkVpMuIQXZj62k8razPn1rYst48/0nLBmyy
 0Y5KvDrsbcGPKbKQcNcHzjpKqtcNIdmYDt1X3hdXOFiYFJicKyFJCIsm3UB+FH1UskIiX8
 H9qlDZSj4YELhK3VaFjCPmNgvffpTjQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-ULKQyFmRP_mfeLxBQtpWkQ-1; Mon, 12 Dec 2022 11:39:48 -0500
X-MC-Unique: ULKQyFmRP_mfeLxBQtpWkQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 y10-20020ab0560a000000b003af33bfa8c4so5531750uaa.21
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 08:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+MKzh8LMLpF6fZwjrwKL8EIWrQsY+iofndmiLR1ngA=;
 b=XjPm0JirIkcysprVxK77AJGpkvmfR6esvufUwzTGLeN4hIhd9u9oP1wguynlQJLwDU
 m3UENmIK/F9zFgqBAloZbHeWqXBEKB/msDVX30iPILVF+0GFv19s+EAfvKZcIWkzEbuX
 G9/F8HS+rCgFH5bsoeX1E36r5MG9cuC9cZ90swMIGYOhaWANZTgYFnNWxFkh7lgYFTnU
 MuZ8N2u5GzFN6KPLHyCqOnD3Vdid/8o8PAuP9F6Tyk6tN54ugeVk78u7vklVkcgEUGTS
 hC/15YXjQWXscknJeETRim6tx8/npgKuoSIY6EEQ1VZd6+lpCjvtlIn+i8cAmyLFTCxe
 oTLw==
X-Gm-Message-State: ANoB5pnWvCP0/aRdDP1Birbg06LdC2HaVc+N6mDQszk02JGFXASMWxQ3
 HmJHZVkQikRGcqE/Uw1n53BhA15IL0fSigdA+2cC4/DkLqLu+7YFsVA2s+/iSWC6TFbxx1A/0Ur
 IHkUsO6kHemdQO+Ra5H0RYE1o0WY=
X-Received: by 2002:ab0:7785:0:b0:415:65dc:4733 with SMTP id
 x5-20020ab07785000000b0041565dc4733mr47556709uar.87.1670863187894; 
 Mon, 12 Dec 2022 08:39:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vIskReS1Eny/vVZ9qMxwxePESmXZ+n63VBK6ADBe5ZUHPsSM94ktM6Jco2NBrqobiRLs5CPXcitVnHfSE1fs=
X-Received: by 2002:ab0:7785:0:b0:415:65dc:4733 with SMTP id
 x5-20020ab07785000000b0041565dc4733mr47556702uar.87.1670863187659; Mon, 12
 Dec 2022 08:39:47 -0800 (PST)
MIME-Version: 1.0
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
In-Reply-To: <Y5dJDFk5DpAhTKDV@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 12 Dec 2022 17:39:30 +0100
Message-ID: <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 12, 2022 at 4:30 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > Our travis-ci has dropped or never used them, they are useless.
> > So delete.
> They were here before CI. They were meant for using by tests
> (no CI related at all).

Right, it's not just CI. RHEL5 is EOL, presumably Oracle as well, so
those likely won't be missed.
RHEL6 has 2 more years - Isn't this removal going to break tst_kvercmp2()?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
