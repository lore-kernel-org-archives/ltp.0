Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DBEF9EDC9
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776863355; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=frSSmfkDPqgTRVssIQj25vnASGezbSWx8sOwEH0xDrU=;
 b=amygWnOda+GnBt9QXWg2g5UMNgZXpygwaj8fheAHHBBbWuUG8fAz2GOBf7bitXUE26dtO
 Ku40+EQe5/joVFgaIil+niqktnWreDxgqRDlBAXeJI4tkHQf8jCxGkMW4N9igh7/fAH2Fbs
 BMkIVA2DOkeYhF1Sgt6lz/ahZ4hK1L8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA46D3E53C0
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 15:09:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDAC63E53BA
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 15:08:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 451FA1A0036C
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 15:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776863329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4kzq26YTddBWUKoQQjpxC60sRmM7yX65o4pe1lLUKs=;
 b=WYYEfgeCMwB7HuwN39qVn0ZVJ1PFMruJ5rXPZ7A5o8AULHJWTSfB7/ydEhMutxrBzbOvId
 aaowPDcyU2j0oqI+0MPqHcKP1Ga6UIib4PiJE5c8QEMCK/Jb5q9DNPso1ITAcmLOHLvqm1
 9c9ppjEVKAWJ0/Ru6ewv4d2dmHZlnI0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-uFCcwCLyMPKTmEloHvoFwQ-1; Wed, 22 Apr 2026 09:08:47 -0400
X-MC-Unique: uFCcwCLyMPKTmEloHvoFwQ-1
X-Mimecast-MFC-AGG-ID: uFCcwCLyMPKTmEloHvoFwQ_1776863327
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c797efdaa9cso2507093a12.3
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 06:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863326; x=1777468126;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4kzq26YTddBWUKoQQjpxC60sRmM7yX65o4pe1lLUKs=;
 b=Wb5O7/2pA1P4cXJSqrbhixheQnCs60HyPLmp1jhx8bezXKKTvBtAsY8BrgnwxwlTN7
 L65Gkmq3NiencOTxdL/MmaS8Wb1WZsTCSVv3/dF+3tO2jLjHPhMfLcRMq2Lw08SKeyxt
 qydNk1/SZuA0Yc/c3gMsFicy5guRcKS/KxGA8GxCsvwvHZ8tPBoaFlw34/4XQDVhEc4f
 WDP/Ww4ujBdfmi0eECC+a4CNd2EoGc935U5a9zURzyoQLuo4U8hOcj4wSPIeugDymohg
 blW1Fa5uR3V1dWUh3887svb2dEv1Y3VzYJsGYusQgKU7kbnaHF5B8fPNxSgYKk0deGMH
 i1dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZGIEKMf1dBTJC0/X/WMdTv1VUwGVdkXSt+Ryire4SJcxdiJF49XUm1bLHcwy0Lm44tE8=@lists.linux.it
X-Gm-Message-State: AOJu0YzSwkl/CO7VbavNmTiqkHfiS7kB1ZgzZDb+AeXWC6uDqX3IqqXB
 /IYyPoCY7EkWCTKW0ZpGHTtU7UXDa2ZyOKSHLaIzVs6dZiOxlCNC6YvgtA9ebC0XkOzk1TJHAyg
 SmrPq+8dlqfQOayXJz7ql+yOR0I+9P0JqeCCfJfV923wdI7bABz89E3ybZ5sj
X-Gm-Gg: AeBDieuKotW/1Hx3caUcRL4IWUjhVIZ/WalCVaLoc5TcwA3hfoB6pCBghscdcTelvVP
 iIPP0WcEOb911uoXSr/gXKnuQdSB5sJtLhPxnA9oCqe0gYeUiuSaXyZRvRMgvUKpRRyji1r5wQS
 mvF7OuM6IOQRZ8vOPUdT/uw8ZloPXhCKpZK7JtEtKbzFyj8amXq8W7aZckmvoMTWnOGt3cQpTk9
 aKbXIGSRz6wSSSKu7qHRmSi8TzUFpwfw4f61CRMzABSTrvAXLzH8QlZEpg5QoCBxH/1pZzTS4Le
 1a/LqBuKUCKKq2XTGlxokM81UrXQr2PzzIt3OL0/r3uW3CB1dK+2AUOFgFY3TF2hvTZLXYMTGfB
 lL75UUnt19VrGsj5kKZFGcGbtcsHCRJm2yyBwLgnsnpsV
X-Received: by 2002:a05:6a21:33a6:b0:3a2:d68d:9e6e with SMTP id
 adf61e73a8af0-3a2d68dd1aamr13014205637.10.1776863326453; 
 Wed, 22 Apr 2026 06:08:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a6:b0:3a2:d68d:9e6e with SMTP id
 adf61e73a8af0-3a2d68dd1aamr13014156637.10.1776863325833; 
 Wed, 22 Apr 2026 06:08:45 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec0307esm17450426b3a.53.2026.04.22.06.08.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:08:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:08:37 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260422130837.cdkcwxtbhkumx3eo@lida.tpb.lab.eng.brq.redhat.com>
References: <20260421152349.1673057-1-mcermak@redhat.com>
 <20260422053712.GB392764@pevik>
 <319d3965-30f0-49c5-b747-ad16334391e2@suse.de>
 <20260422121742.GA419002@pevik>
MIME-Version: 1.0
In-Reply-To: <20260422121742.GA419002@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yMBwVW_EoF2YY79zxaqjUvAEzcKDIsv4Hy1VC5iz-aw_1776863327
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Wed  2026-04-22  14:17 , Petr Vorel wrote:
> =

> =

> > On 4/22/26 7:37 AM, Petr Vorel wrote:
> > > > However, some of the testcases can be easily changed to use forked
> > > > processes instead of threads.  That's what this patch does.  When
> > > > client program forks, Valgrind forks too, and that allows for the n=
eeded
> > > > parallelism to handle the page fault.
> > > You understand process vs. threads more than me. But shouldn't mmap()=
 use
> > > MAP_SHARED instead of MAP_PRIVATE for those which aren't using /dev/u=
serfaultfd?
> =

> > The documentation for userfaultfd mentions threads.=A0 I'm afraid we'll
> > lose vital coverage if we move to forked processes.
> =

> +1, at least some tests would keep threads (not all userfaultfd tests wou=
ld be
> converted, but yes, that's why I suggested to use MAP_SHARED, which could=
 be
> similar to threads (yes, the difference between processes and threads in =
Linux
> kernel is not that huge as both are created in clone(), it's mostly about=
 what
> is shared).

My goal is to make at least part of these userfaultfd tests
compatible with Valgrind.  I've experimented with clone() and it
seems like Valgrind has limited support for it.  That said,
adding another set of userfaultfd tests using fork() or clone()
instead of threads might help.  Some of such new tests will be
"incompatible" with valgrind, but it might be a test coverage
improvement.

m.


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
