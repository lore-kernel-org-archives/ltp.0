Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A98EFCD0AE
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 05:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773811121; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5tkkNolOECcyhWBYm3EnMjCggVbvQg4RZ7/fHTv9rPI=;
 b=jV2y+p4R8S73+T0Dygy9NM65uqUDNVc4whj1Lqqvl5Onb0HsMvpnzsWG4oqnp4ekLmkQ7
 7jcA3D3384CaOK2JWP9nw6d5XvGhRiGedvp3rrP5PGnEFqIADEuER49g9fbXB60qWccra5L
 FzhOvm2GZK7EiX8XoY3t50xXDEcACyw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FAE73E4869
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 06:18:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A7C3DA365
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:18:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6966D200907
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773811094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DsX4WDxF1zZbzsc1CGUcWccoa4f9uw3fRGrDp5lVKVA=;
 b=Z0hDqe+Qv//VQuU7/CR+mp117Yf6xVMGSu2/CNM43TM5FEbr6wM4ovu1EZ3jA8PfSbKhBs
 AJoM/wGTqk4FL2/g7UyclMil8dMeYAdj5MA0jtX07fTr08INFlhELOY+EEnSYV5r6XCJUF
 vuLo27TgUUpJn/tCsGQu+QgaEjeN+Ws=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658--LHDAUO-NB-M7xiTBkHzsw-1; Wed, 18 Mar 2026 01:18:12 -0400
X-MC-Unique: -LHDAUO-NB-M7xiTBkHzsw-1
X-Mimecast-MFC-AGG-ID: -LHDAUO-NB-M7xiTBkHzsw_1773811092
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a71ea4127so642608b3a.2
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 22:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773811091; x=1774415891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsX4WDxF1zZbzsc1CGUcWccoa4f9uw3fRGrDp5lVKVA=;
 b=iRxCloNDffGD0ZnB6EVFXGtu5j0tEtvYyFBsoDcaQweBsHrrPDcTiDxlRZQzXEdYYB
 suimEWvqbjGFrXkGRz/51s+6Y4J2woG2DilXmmhdH11Y/fw/ois0eDxyCObdoySVS0v7
 5KL298w8bq+0fdEebw6M+DdtaCQ0sNRl0jG/egpwyfelNsJzslSzXx9dDtnTRW8qnRMV
 rTJtr8ZTHyyh7SlLrJjH9qQsZX2rIOJ/7cdl8mAYTaYEXi8BLHbC/FrtkqJ+C0dyhxXM
 x/9y9nX8ahoYUJnJkitCpQJOFqrxF/2YtcT4XRPPkGKsgMX1VJNER+uK8nWX9mgElbBk
 3SFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCGrwXpJWB8/wOuXKVMDP3144J9rwDJ4I7P8lkt9kOuvMPDAQ43s4Ad8iMIBod0F7gNxw=@lists.linux.it
X-Gm-Message-State: AOJu0YydhNbBAd611/D2LghV5XW++4FwsqtNpiIeOYClcsHgj0lMpsqc
 x785uNixdcVIxBJPFelefftGM/ipau6VH8dzfb046eR9uw7PsuVEUjF8X8AKrniJjO0L7wtPZRz
 oujl8rkyIlrVWwT/ie4ARO/TG6LpFeo+EjhkLPitj2+YcdJpvBgfT
X-Gm-Gg: ATEYQzw1c1K6KKOE1xV2HoVQV8pn/CGTd6O27MYclhpYOA5rcaJAYN5Z5qvo2XY6R31
 6aUyynfZ/xvlR72DZKioX13XfaUp0VSIOyGAj/1Nyr4aYATWZDNqiePjvtN9508PDYXzhqjMs5q
 sZkN/A54gRnbztootw5dzFTWAzEkJgq2Hw+0IIsCTnc8dnG3GwK+1uQJf6zT+SE6jACM6gIhfAI
 VWXoFe6My5Sdf2Bzi+UJxZ/HomghgZqsLE36+z6qs5ZZnUwxT4apKMRFW/oHgCcVdp8+WG+8unG
 7cIiW2aAV8CarNHXBQ+z7sWXh+SqmvaJjJwMND6cYSe9DvO0n5pwooc7uuWdF6WH43z8iXAaPzT
 FygQigix7WOBB5hPkxA==
X-Received: by 2002:a05:6a00:4fd6:b0:827:28ba:ff03 with SMTP id
 d2e1a72fcca58-82a6aee233dmr1856815b3a.44.1773811091655; 
 Tue, 17 Mar 2026 22:18:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fd6:b0:827:28ba:ff03 with SMTP id
 d2e1a72fcca58-82a6aee233dmr1856798b3a.44.1773811091175; 
 Tue, 17 Mar 2026 22:18:11 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe5ea9sm1168566b3a.45.2026.03.17.22.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 22:18:10 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:18:07 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <abo1j7frPELV8-xb@redhat.com>
References: <69b93029.050a0220.2e2929.5885@mx.google.com>
 <abl0DkVFXKT-pS34@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <abl0DkVFXKT-pS34@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nCcH6TtNmRkUUdxSYuyYJXd_U2JBxSjg_lrIvCA_eGg_1773811092
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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

On Tue, Mar 17, 2026 at 04:32:30PM +0100, Cyril Hrubis wrote:
> Hi!
> > .. and tests conversion for tests which are smaller than 200 lines of code
> > requires minimal (if no) edit. I will continue to adapt the ltp-convert skill
> > in order to tweak and to improve this process for bigger tests.
> 
> I would disagree here withe the minimal edit. The old tests are quite
> often garbage. So the human in the process should asses if the test is
> actually doing anything useful and guide the machine to implement better
> test in a case that the original wasn't doing anything useful.
> 
> > ~~ Said so..
> > 
> > .. since this process seems to be quite straight forward, and with the usage
> > of LLM we could easily generate hundreds of patches per month, we don't really
> > want to flood the ML with garbage and to overwhelm who's involved into
> > maintenance review.
> 
> I'm pretty sure that you will get this down to smaller set as long as
> you actually spend some time thinking about what the test does. At least
> for me I'm able to spend 30% time on a test conversion because LLM, but
> you have to spend some time understanding what the test does and making
> sure it makes sense. Otherwise it's garbage in - garbage out.

Yes but not entirely. We can have AI summarize test methods within
code comments, which helps us grasp the underlying logic much faster
than reading through legacy code directly.

And, nowdays AI is gradually becoming the producer of code, while
humans(specifically maintainers) assume the role of the ultimate
guardians of code quality.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
