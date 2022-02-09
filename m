Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6758EC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:54:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA6A3C9B8D
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:54:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8351A3C9B69
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:54:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A5856011EF
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644404052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4bKTs+SJLZsi/wpWfaKumdnbxJklT1j4RjK6vBkeDQ=;
 b=NKfTenPjSk7no0hzsd2FnGoY+cqk1CvFagX9VSv3IXqO0DLRSQVjPdZ3T+Rs1/n+8MGARB
 RNsoHVP3iEVKeeBuunw41mtyKTyKFvfEcTJ/Edl/SWIRgcVqPwlby+9uQ/PH6HMQSm7Yn2
 tiCIjkuYSwZJ508lcAygsn/7dRa15vA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-jTHQFD86PBSHz_w5uMyGIw-1; Wed, 09 Feb 2022 05:54:11 -0500
X-MC-Unique: jTHQFD86PBSHz_w5uMyGIw-1
Received: by mail-ot1-f72.google.com with SMTP id
 n99-20020a9d206c000000b00590dde2cca8so1170629ota.9
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 02:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4bKTs+SJLZsi/wpWfaKumdnbxJklT1j4RjK6vBkeDQ=;
 b=dOeeHYfwRWncVoXZbh9QnPI2YsvpGzMDtmhgoTRF47Iw1N+hipcSnmgL25mJ2JTvpk
 xwSVBMqLv26aU24oh8nKZMzSa7O9Qteddul6+O1/g4PN2tT7J5Y90U+abjWc6yb3KVaj
 OB0DmybQqzH6y3mxdwmBnn6b8SmLynUp8ulaFSGyxXhr4H4epWcadaw5ha2LVAwVGTNl
 TtiYeHSIrw6wTXbfk3brrE+Q9zhO/L2vuljBSjNCCc4gCFRe5KVF1yfyNltjZo66jZ/D
 VBP8v76JMTANLHC3PKSyqXd4lluW5yaISZci+LorVJX48C20YGeSdYucP41VUbOqDY3y
 kRUQ==
X-Gm-Message-State: AOAM5327Kr2TXK/0XEmUSb3JjQi8Z6Cbgy5ASimSUGzYc/X66s1QnJaR
 U6PAA4qYkcI8HplYENsQDVrkzo61lws3VQdh2biWcbKBArYaGVehOExSelj1W52B18orRe3+77M
 QkF/bu5gqRi8pE0TGZclWNObfY5s=
X-Received: by 2002:a9d:58ca:: with SMTP id s10mr618379oth.176.1644404050861; 
 Wed, 09 Feb 2022 02:54:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2CslmSy9qansb/7/oHXPmGUoF+L5gi4+MBXndoKkkHSQfjxj7jdVIQXZNpD1iyvKX8WuUlKSxY3zmfCjUQjA=
X-Received: by 2002:a9d:58ca:: with SMTP id s10mr618373oth.176.1644404050601; 
 Wed, 09 Feb 2022 02:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20220209085700.2882422-1-liwang@redhat.com>
In-Reply-To: <20220209085700.2882422-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Feb 2022 11:53:53 +0100
Message-ID: <CAASaF6z1J4UGTse_8fDRGQSsNp+nHYCi2RNHKjfRd1_-LhCb-w@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add .min_mem_avail in tst_test struct
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 9, 2022 at 9:57 AM Li Wang <liwang@redhat.com> wrote:
>
> As the name implies, this new field is mainly to set the minimum size
> of MemAvailable for LTP testcase. If system available memory are less
> than .min_mem_avail, test will be exit with TCONF.
>
> And, it also helps to reduce OOM occurring in test parallel run. Due
> to running more than one process that consumes a significant amount
> of memory at the same time.
>
> Signed-off-by: Li Wang <liwang@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
