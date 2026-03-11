Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC9106286D
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 11:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773229139; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SFbWy4AN5wuBPkJS9zs3KeTxbRYn/KVlicmNjUbil6Q=;
 b=FOe4k1NtRwoSG/NcQRGtA3eB/wq7ZXY4SM/QDhg1Mic05zzG7TpcWhfOzrOjdxYDDtxP5
 qRnbJp67LkEohnoFFbD+IDITNE3j1eFBxS4Xaqmpbmp8YRavoerMpLdslZ0T3fE9JY8PRwX
 zgGEOvxMX41uN76Y2vM5G0Kt+yHyFpw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64F533C0692
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 12:38:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211943C2A49
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 12:38:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF8DF1400996
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 12:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773229113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8Sk7mtS9hk9PP5Syt4pm6U3PKns1KAlUn+KXps7CR4=;
 b=C91qTF55aj0hes3teSrZ7hNiWAGohYKlCm3/RpLdtDY9KwAYFeaFyI3uyd32wYWzuyfkN3
 4X0w+TNk5p7d9liYfCiGxWbuTl6RgCFvPeY+24ZwlYaLu2MC3+hcoigLxHIBbrd/p8PDX2
 5tyW4VLrwZXy0d7kOzJide+fVMVTOmg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-O0kTBdpWPnWdVtH1B_Q8vw-1; Wed, 11 Mar 2026 07:38:32 -0400
X-MC-Unique: O0kTBdpWPnWdVtH1B_Q8vw-1
X-Mimecast-MFC-AGG-ID: O0kTBdpWPnWdVtH1B_Q8vw_1773229111
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aeaabedbc3so83098465ad.3
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 04:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773229111; x=1773833911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8Sk7mtS9hk9PP5Syt4pm6U3PKns1KAlUn+KXps7CR4=;
 b=f8hPa8ohfgxwFCSJ3LyxfEpuP61YUnaW+ZAqKz2GQurvcwG3L0D0xJN1iSNIMAFUeo
 UiETopX9fUEOWkJr0jDQ8EtLg9kxovPQdeD1rHlnsM2N9st0hNY2D8GdCztbTbW3vBmD
 kkBSkC40dmY4+3SAhJMPhThsCtvVpJzF/M3J7BKMLypCGxmNdIBW1hwgoI+4Yrlz2d/1
 frS2wsvL8PsuFsNUJVN2/cxv3z/iaq32MvrD0+iOaUjsphfmU638KTbQjRrmyvTHpUKH
 HEwETp3P0XNZT/q43A8rGQWL7BtRenLFxMYgjogj8W40RYcIRaVT+tTm7BQQ4ub8ROfN
 4YMw==
X-Gm-Message-State: AOJu0YxPsWLvxYXMlrnEcCoOnvKAPI3ieBfpsch9Yw3w6qrMLaMpE2E7
 bxCot4dHTWryIXJ81zgzqsVnesdycBR0yeAXdVUEYCiWfPb4KNAHgnDmEIHnMUGxmG5lrUdBm9a
 5cQkbeBhBoIsj2QmfRbnoZAu0UyBlR49zakFP0LGDfHRa9YNGwtsn
X-Gm-Gg: ATEYQzzeGHycAjyqbB6MDZZj1XdHpc51pAQSSFRKMxG6rG26qXe1qM+c2U+/4yk0O8W
 kNADlOevPKllYvpHuq91e6N9VwjSXSnCXgTXK8dBbw7gjpRrDYBYcFJIVame99Ei581gLV1MYQB
 xFfe2KzOK1DLExmUkzxv1I3+fDriHHCb9W7oFeaoLdvTq94UD2ONYEWdk3rtC5eNV/OXopOTx8o
 Ro0zzZaNPct3EGHgJpshXFgSOZ4ixfyE3I94YSsq5xN8h1HmLtU9XXvoKBsFaK9mTFhPE2jNUZ6
 oyMvsKGz2jgfDMytM/w0/hG9H3d7rfrnlYxk+BIe+I9tw6WMvD36P6F/a2jzDLG5hsVk1vHNc3F
 xzWSCfoNXCHZk2aUZUw==
X-Received: by 2002:a17:903:2b0c:b0:2ae:6133:d170 with SMTP id
 d9443c01a7336-2aeae7bde95mr23908545ad.20.1773229111537; 
 Wed, 11 Mar 2026 04:38:31 -0700 (PDT)
X-Received: by 2002:a17:903:2b0c:b0:2ae:6133:d170 with SMTP id
 d9443c01a7336-2aeae7bde95mr23908215ad.20.1773229110878; 
 Wed, 11 Mar 2026 04:38:30 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae378249sm21390625ad.80.2026.03.11.04.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 04:38:30 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:38:27 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <abFUM_omuZzJuCzE@redhat.com>
References: <DGC27F1BK4VU.1MC5BNP80A236@suse.com>
 <69b14994.050a0220.a455b.bf65@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <69b14994.050a0220.a455b.bf65@mx.google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ZqsaAwIvstlkJ89VNSUtIgCIe1yRgVO9Fb8yUYzRFA_1773229111
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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

On Wed, Mar 11, 2026 at 10:53:07AM +0000, Andrea Cervesato wrote:
> Hi!
> 
> > Hello everyone,
> > 
> > what about scheduling a new LTP meeting after the release?
> > When's your first available date?
> > 
> > Kind regards,
> > -- 
> > Andrea Cervesato
> > SUSE QE Automation Engineer Linux
> > andrea.cervesato@suse.com
> 
> We still didn't decide a date for the LTP meeting. I was waiting for
> more feedbacks.
> 
> @Li WDYT?

As long as it's my daytime, any date is fine with me. Thanks!
(FYI: 9:00 UTC is 5pm Beijing time).

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
