Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D64AEA7951
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 01:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770255909; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IPZwy5/fqYZI4di2AmzjOSYMuH4NlTN1zySI/0S6stw=;
 b=nxtKPVu5zpuu/L3vPjR7yVBCcGCycBNmZsvW38ckM3uhhQuQbdmbD7hhcG7YieVLheU0U
 HJytFqP9AS8z4s8KSIDjGzbdZIZG3U4b6oO0Lpmb3mMP+gvZtN0KFrWrXI55+2tg50J6u1G
 5cZlJucEIYb9cHbodByAhB7h1DTVm7o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 120503CE20C
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 02:45:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9813C3CC316
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 02:44:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3A43200049
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 02:44:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770255881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9+ciFbXibg7T6l7w8dRNgSm7VLfnGtBWpmp3gBRP70w=;
 b=McqXqQSkXjEx00RkBLdRE+3BMbw1Lej8gfPNFLtDqT3THmP0bqBs8wO+2R79gstqm9ft4O
 qh7iQMdQwVedFpb/6bx8dwcKJF+UAx0m9pcgxlBHTpzONovXvL+PvUlkS9Q/Qj5hjVNSO3
 FI0lX67C7Xac4paX4Z8s3rFGTbrEXbs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-u7vUYavvPaaO7r345JvYOA-1; Wed, 04 Feb 2026 20:44:40 -0500
X-MC-Unique: u7vUYavvPaaO7r345JvYOA-1
X-Mimecast-MFC-AGG-ID: u7vUYavvPaaO7r345JvYOA_1770255879
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34cc8bf226cso284833a91.3
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 17:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770255879; x=1770860679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+ciFbXibg7T6l7w8dRNgSm7VLfnGtBWpmp3gBRP70w=;
 b=ipq+0va1PJB+I8UfBUdmwnB44ezCXLEFlR1YDFH5B1Em4bWwEiqHv9iJd3SQ6lTB9i
 bATfz7Knn2/+/tCuNZBlWpuIz/cMjcM8dsI+cmIg8icoopYDwXoLnyjh1+tVGZ/SFLOb
 a1qer9bq0r4iLDXHaqaPfylsrVJ7aGv+g67JdmRRKtCxsKPfF7HOPOSvr6D+AdKL3VkH
 qYEt4iJl8vTv2VNzrTCK5PmCJGFV8k/KD9hauFR3Jdt+jMt+JyWrABIaRCngQXN2YFZU
 pGsv09XvLhDmPlhc6f8JO32/G/0cpBilxtNG+3rtaRavtF46jqs0VzTXcqStAwGI53W8
 l6ew==
X-Gm-Message-State: AOJu0YySUezHEbBuDlW87YDsOOGQnx74k3la20XVj1DFrNqVCLMo9F23
 tASRrduScZhNrLUwQL/UYzeZWdQ/VWWgfD1t1+l4xNF+3KF5pMH/tWJX8wIFoVMgr0NHcjy3gMP
 HCxZ+A7WPZf0XFIce1RS3LbS+Z4advK5n85gZmzwQ9uVzF583DWlA
X-Gm-Gg: AZuq6aKi4KdpPVWx9zZgU+YgFpoHF9oL+jtwKiLF/7FN38sAD8D9sdGaY2ZohS3/thu
 JcIMngHz+GWom5Wi0j4cN8LmwTaGo0CPGYW3fepJ5MEtWFdHNtae6p3FsJUG2E/wzoTwChaglks
 bHwl2CCf7zM4vzfgySAyvxorA7IbyM0lEyCcQFkLONe188Pfym54AY8heA3ij45Pxc2u1UxqU7n
 xGsdqb9sLryCnL9JB2rqfSQGlKbsxn94hSlicuh8UkfeXCR6pi/BVuGIw107e10refpLkp10ihB
 L8IJ7pAsqDBcw4A54iwLaScHjmDrSyP9Xx9uTMXCxO69mGtNhjKFoKwGgwyEvVYkKlutk/2Vp35
 QQMpe
X-Received: by 2002:a17:90b:4c51:b0:354:9b9b:54da with SMTP id
 98e67ed59e1d1-3549b9b5549mr1031293a91.14.1770255879215; 
 Wed, 04 Feb 2026 17:44:39 -0800 (PST)
X-Received: by 2002:a17:90b:4c51:b0:354:9b9b:54da with SMTP id
 98e67ed59e1d1-3549b9b5549mr1031283a91.14.1770255878782; 
 Wed, 04 Feb 2026 17:44:38 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35487131849sm1800639a91.0.2026.02.04.17.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 17:44:38 -0800 (PST)
Date: Thu, 5 Feb 2026 09:44:35 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYP2AxZJeXgEDMpA@redhat.com>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260204122332.GC224465@pevik> <aYNVsiL4xf2P9R6A@redhat.com>
 <20260204222753.GA279256@pevik>
MIME-Version: 1.0
In-Reply-To: <20260204222753.GA279256@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z2Z4IzKp1hh1a2kv4u3fSkRQ4lO7PHnEhRGHHGmmBs0_1770255879
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 04, 2026 at 11:27:53PM +0100, Petr Vorel wrote:
> Hi Li,
> 
> ...
> > > lapi/openat2.h uses struct open_how directly, shouldn't be included lapi/fcntl.h
> > > there?
> 
> > From my understand lapi/* are appendix for missing stuff in header file.
> 
> Yes, but we agreed in the past, that it's better to include relevant libc/kernel
> header in the lapi header [1]:
> 
> 	LAPI header should always include original header.
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#lapi-headers
> 
> I thought we had a discussion about it, but now I see nobody acked the change in
> ML (cfbc41d775), therefore I somehow pushed this approach without consensus with
> others. I'm sorry for that, we can revise that. At the moment quite a few lapi
> headers use this approach (likely majority).
> 
> IMHO it's better to include it than expect that all tests which use lapi header
> will include relevant header *before* (otherwise tests can happily always depend
> on fallback instead of using a real value from a system header).

Yes, I generally agree with this, and here is my understand:

1. Testcase should include original <header.h> (but not "lapi/header.h")
   if *only* need the original <header.h> file.

2. LAPI-header should always include original <header.h>, it handling
   the missing/conflicting part there.
   Thus, we can treat "lapi/header.h" as a patched <header.h> and only
   use it intead of the original <header.h> in testcase if needed.

3. We avoid including both original <header.h> and "lapi/header.h" in
   testase at the same time.

> It's a minor detail, but being consistent helps for newcomers to understand
> LTP code.
> 
> And *if* we agree on it, it should be now doc/developers/ground_rules.rst.
> 
> Also there is a different approach where should be fallbacks. We use some lapi
> headers (e.g. lapi/openat2.h but there are more) which don't have public
> equivalent in libc (/usr/include/bits/openat2.h cannot be used directly, but via
> <fcntl.h>). Therefore I would put content of lapi/openat2.h into lapi/fcntl.h,
> but that's a minor detail.

I am ok with it, the advantage merge lapi/openat2.h into lapi/fcntl.h is
keep things more centralized.

But also, keep lapi/openat2.h seperated is more modular, and it should
contains <fcntl.h> as well.

> > Test cases should only include standard header files, and lapi should
> > only be used in case of missing or conflicting header files.

> But lapi/openat2.h also uses struct open_how. I would either include <fcntl.h>
> in both sources or just in lapi/openat2.h. Having it only in tests looks to me
> as not ideal.

Right, thanks for bring up this topic.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
