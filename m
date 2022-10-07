Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA0C433FE
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 07:13:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22633CAE27
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 09:13:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CCFA3C0796
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 09:13:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FF781000F02
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 09:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665126789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8e7tP58pMw6stG3xOSzRR/XPi3eBQmDYv3RgkeRmik0=;
 b=jRGqGloN9vgATK8gmzKbFDxUvzFncwa5RLvTWnExNQYzPDZJeIhJ7kUGAu1hZNnBlFIhkH
 NlPkf1X+JodJM3b7fKcKs7/vyO5aQ+D0H5w46PwJfWAp0eWPSQl7dUGnvHEjNdVfdUeQl5
 EsEZM3VgTYZ3rY+9OVrCgNB11KqIf4Y=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-25-dMChDRMjMV-OM8Y78G7_hg-1; Fri, 07 Oct 2022 03:13:07 -0400
X-MC-Unique: dMChDRMjMV-OM8Y78G7_hg-1
Received: by mail-ua1-f69.google.com with SMTP id
 n33-20020ab013e4000000b0039f1bede4c9so1493030uae.4
 for <ltp@lists.linux.it>; Fri, 07 Oct 2022 00:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8e7tP58pMw6stG3xOSzRR/XPi3eBQmDYv3RgkeRmik0=;
 b=fgxPaHHBpBaa7P0PfOoXhWzcIFbzi/kIR5a/SJnUfoc8oytQTxE2sdexEzFck6Y7pT
 NEIHpWg5dLT/ulDaqD5JHUxn0NcgRbYOzheheSWGMyoUBbpJkdnslGLAHZApGuhNL3vX
 yDFkSGrlEaBWxbWvVuuFZKlyNzXAGIPAliLbFmzlBZfVt3/MzOMZRI0XajvatQzW6uJu
 Vdf5FzHk6awNQe1fwop2315wkkFUcLGzjvqfI83DIdCjXxdkzVcGCQnW1Uix9GGADlZu
 BUlwGRYa5X5Fs+FaxSICdB0UQMd0ZgvY183W063p8YXoWXinMZ+g6qRGU+amdL2/92iT
 IKWQ==
X-Gm-Message-State: ACrzQf1lg0ec/u5Y8xA6ASyrbcKHdGRBm1e0Hxis2Cnkuc70YU3/dU8V
 vgNANGF3yjwg2j/c775ThEQfEEl9WZBI9LHMkxsxwTCgQZC/zOgekUWGmx5vkaSf8dv3h99yYVG
 ipv4PhIYAfx4lRofj9n3bwWDytBc=
X-Received: by 2002:ab0:7c7c:0:b0:3d9:d475:29fe with SMTP id
 h28-20020ab07c7c000000b003d9d47529femr2267547uax.4.1665126787004; 
 Fri, 07 Oct 2022 00:13:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Lwiw454y8W2NjBiuSOWoQyVcwQ+0agipUFwoiah6irHKGEkoyP30+6sJcbG2HuWHwnxFLRfqLCqQGx+Mn5+w=
X-Received: by 2002:ab0:7c7c:0:b0:3d9:d475:29fe with SMTP id
 h28-20020ab07c7c000000b003d9d47529femr2267539uax.4.1665126786693; Fri, 07 Oct
 2022 00:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <cf13ddfffdb08e0771be253ac6911febb96a47c4.1664979933.git.jstancek@redhat.com>
 <75b528baa58724ff96ad47fa0ed84b4b801266d5.1664979933.git.jstancek@redhat.com>
 <Yz2qPOv3HFHmYFSf@yuki>
In-Reply-To: <Yz2qPOv3HFHmYFSf@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Oct 2022 09:12:48 +0200
Message-ID: <CAASaF6wRRV1cyF4vmo7Nq6A=yBYnRqtU=SDpLODRrF96zN6ewg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] update all call sites of SAFE_WRITE()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 5, 2022 at 5:59 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
