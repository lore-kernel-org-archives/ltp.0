Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EACF8E48F
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 23:25:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ADCF3E9561
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 01:25:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E2693E1BDF
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:24:54 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4190260085C
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:24:53 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-506251815a3so1007791cf.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 16:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776381892; cv=none;
 d=google.com; s=arc-20240605;
 b=K0n67Tm0yAZ9QYZuJlHDNDg9hPdPWChI6Cxa0+Ip1MB2Qd3O3eZMNIX3cZfqmP3/M9
 0HBZuLb2DOYFsGUN22WPGQMuQ6VNT+dof1k38JRoA06yyK7Z81G75XKN416wtaJOF1o4
 UP9ji2xx6Nx//VHrNPTWzThtYSQuE9hVR7faxpRrqE6kz7wxrNq2sn/i0vh4bLFIMGQG
 B/tTnKV2tVip1ny2vLjRRQDwa6x2nk9+wA5Og41b1dOjs+fZECZuhtv7GfqldKM/WaVF
 aITiLQP6zJUNTEpPEknpNKwEKiOpxRa35h4hnoCMSvRfrXsiYOErOBWVlOE/Lc25w0Ia
 PQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nDk56+YBuc7S3WnspKrcSTJ1VuOeL5ji3wFP5KKUCJI=;
 fh=g7dvOd5baOddimVnTBLfuXPxQpOtpx2sw/aOklaR/vI=;
 b=grIKlqH8sVytK/3cqolDYicTm6+vmZkVkQkMxgCv20NQ4Ln8zzIe2i6S7OZ3ydWI/B
 Qo5na0G2OEgX+iWJYKEN7Nm0YwaSiChFYYuj5y04NbLC9vfT4Lcm5txYLynC0TBWMSt3
 tTAheRljOZ7NqG378S/cTL9GbWFlKuSW3pFmyDEl89kg62a4+eEzcfoWerT1chlc9C/m
 oTeQSwZ9SvWoSnBFF01/03qdWSJBQpyf708/bjjxdNMJ4u2NzjO2GuYtYwKpEHShYi/O
 lYXxbxplj/IWFKxJ3H6v2/3A6f1fqaBSl9p/qfpyIJwMnePGMm+1siJ35U7W0hbXXPgM
 jrSg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776381892; x=1776986692; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nDk56+YBuc7S3WnspKrcSTJ1VuOeL5ji3wFP5KKUCJI=;
 b=J/s1V1fDW4sF4vckk6wcV9XSvf1H863PNvsURs2mf7qtUUHEiohYZRFffhwRysqUEK
 8pLBSPYQM3BCcnMdn0y39npMmjopHqDHjnDzH2hr8leCMgBaSWeOrBVBa9a5ymgHqtSG
 I3AilMSJp7gKURlsLFjDWP4m+UXIes8sB2nG1/LqtLmx/b8VuQdZBQTJUi7cDVfXg3Jw
 +GHiexc6feWE8Lolbj4XzeX2/97PqXvCFm4i1xsXM1Cpw+FSANkQjN5tNusOg+8RZIqD
 P/dFeTejDaksIVpbuewQKIpgNzFJqXCbYcnZy9/YRE2dwuOhnhVENjMCKuxzHRrqZamD
 R1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381892; x=1776986692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDk56+YBuc7S3WnspKrcSTJ1VuOeL5ji3wFP5KKUCJI=;
 b=Qg0v0Y7jGEVf0p1gcMF5aBkrwizPT6K0gZ3OnmF6H04/OnRs+exa3toHbUUXFgrQVG
 XOKQkf2hNJamMv/+rS2NJv6RcTP6K4UI7dsdbnbb1WDexwUUw4kfyWAouafJrLvPBaby
 a9MqTfcKmoOMgYwkfuoM5Yg0FzY9yw5GIj9T/JHXgNMwdA8w/HGXlpWvtp9f1wYRZVtv
 1UCeOGijmFTX2rsdKFGR8BbU7TTedAiAp5yESEMGdaL7gRH4Gpix2JJsVn/MWWjzB9rK
 pa8cEzfTT5XDhdevQzWYcqONvLV6HRTAqyWZgtIZFOOlJt5E6mOt66de8ccxiTrpxLmg
 ifcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4DF+mFP0LCZfJcDCL6/rkjLGmho60EHF8DYcXYL4iyzTc6SDP1b04SuF9Bydm1Sr4R2o=@lists.linux.it
X-Gm-Message-State: AOJu0Yy8CKeaWE66+p1jMGsB2MIzTERAoTLE7ap4R+YsAruKISrZOAtO
 nUeAo8FC5ZJtPThw0PMfwHicwl4i+qI/AaDBwwM/6N23owh4PvNDLgOensXWDyPeJX053UhTmG9
 8M5q8rjyQpiVcj3WUYMBcqL0v9Kq5Vg==
X-Gm-Gg: AeBDiesUWUWigdrVGXXfSfrAMJ/8ec6FCULNJC6f9qv3G+MFEZgUsRbBfwEazl7FsFa
 8APsCQoyYtIBlf2+af7T++HflX7USBCeyiNge6Z7rKpQbKfvvQMX9RG3V3O87AgrJyriYv53QfD
 IshQ3xJWoxJ8Raatmzm6EGKHXO/eHmPdJAbpQUuz3yxd4hM/uZmhIAkUAMbFXYWH5JUnc4FqQFM
 PT3qHzD65VVhPsqfIc0cpzj/oABJ9jJMSKKQaIWeV4uTpwHYcCKErm8rXtU3KJ8BWJoPKpq1eEg
 9ussgTdabg1W63Qs
X-Received: by 2002:ac8:6f0d:0:b0:50d:86cb:db80 with SMTP id
 d75a77b69052e-50e368219bbmr7627501cf.8.1776381891951; Thu, 16 Apr 2026
 16:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
 <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
 <20260416180559.GA303991@pevik>
In-Reply-To: <20260416180559.GA303991@pevik>
From: Li Wang <wangli.ahau@gmail.com>
Date: Fri, 17 Apr 2026 07:24:40 +0800
X-Gm-Features: AQROBzB6i6SIkAENhaXvjKy3Zsgy2I_9CzcFCyvlJjL9O1n37Ps0Lp_81rWqDfA
Message-ID: <CANgNiRxx3MyMGsEXszhV1TcBc8XP9jSrYL_pnbwsUa4bb0-XiQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Petr Vorel <pvorel@suse.cz> wrote:

> > > +INSTALL_DIR            := $(includedir)/lapi
>
> > I'm doubting should we install the include/lapi/ local header files to
> > the /opt/ltp/include?
>
> Do you question *whether* install lapi/*.h or *where* to install them?
> We install include/*.h files. What is a difference with include/lapi/?

The former, I guess we don't need to install any.

> I'd say either install both or none. I would prefer to not install any,
> LTP library is not separated anyway (there is an old Andrea's effort, but that
> uses meson anyway). Installation was added in 2008 and I doubt anybody is using
> it.

Yes, that was exactly my point, we'd better remove the INSTALL_* part
from the Makefile you posted.

-INSTALL_DIR            := $(includedir)/lapi
-
-INSTALL_MODE           := 00644
-
-INSTALL_TARGETS                := *.h

> > > --- include/lapi/syscalls/Makefile
> > > +++ /dev/null
>
> > Does the `make check` still work (inside include/lapi/syscalls/)
> > without this Makefile?
>
> Sure not. Do we really want to check generate_arch.sh and generate_syscalls.sh
> in arch? If yes, sure it needs to be added, but that was not my intention when
> creating #1262. I really wanted to check C (and shell) library and tests code.

I'm ok with both, so without that Makefile we could do `make check` in
/include/lapi/.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
