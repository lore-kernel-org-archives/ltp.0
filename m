Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF46ED31A09
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 03:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768359856; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Dch0ShAj8yp9nqlnosZvIdLcZdqe3W3OHvxQuw7jzGs=;
 b=piYXcs5cR+PfUsK7JsOlNPYcr219CSTM+TQOsergBRD0XiqYGaG3ImudhVduxWVNaiVFL
 IWots3lA2Kw9/wQEo2cXaNTc9L8QdggWC8Soh7qYLzvw2d1gv2h9sCZ9/V026INiraM6EpY
 sI763iKjSV79cpWVNHNZQQvnjOHLdJM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49F823C93D2
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 04:04:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5043C2A26
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:03:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF86D100074D
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:03:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768359829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAjX1iAhDlnl6AoQXQumbQs/TYlRVXKkLYdPxQX6JCM=;
 b=EgDkR8jhZ+sJq4nztc0nMTEQJgUcVjx4XR1RJ5UR7BnodXXP4VLFuVAg27kegaFe85OOLq
 wJkdbcPhB0S2Kfe80Jd3Ng9CzVBN9O9z64XmaiAZ9WDM1vafvQl8QMxSb3oKhAT1QC5oPC
 mpiX1sqPQDBZwTNLAYZ3OUCowOcpgtA=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-zqSvARxpMZu6gYei3jL3oA-1; Tue, 13 Jan 2026 22:03:47 -0500
X-MC-Unique: zqSvARxpMZu6gYei3jL3oA-1
X-Mimecast-MFC-AGG-ID: zqSvARxpMZu6gYei3jL3oA_1768359827
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b0530846d3so7713318eec.0
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 19:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768359827; x=1768964627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAjX1iAhDlnl6AoQXQumbQs/TYlRVXKkLYdPxQX6JCM=;
 b=gOxFgHu1dsT+3RmRo9vzKvXl1i68nhaYQcFAfNeq02SjzkjKHK7AAxxAPBOtJu2U8Z
 JDh0o2rSW+8wN9L5qnZKZQzqOwI+Lzpy22djZKoQhEWAsIITD6788BZd+xssVcrLWOGj
 QhxEiJgcA/30avVJK5UKFNtwd/DjHXFH+FMHN5hUswPGqK3rgLCuX6goLdm0vBmth0H6
 RU3bpsvsCguMd4IYZsIeY3yNFxBpdiDT/OuQbNMhu3TRgpVHTtpB+jdt8MSO1+hS7JqX
 1Ic4dGRDDEsHSqVLVf6WlC9hIbrOW9BO/ZHmcV0y7qKYHxZ1RlCYf1t/5rg/dFv1XPoV
 KP1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw6j9YOLQluDvFWxpJ+dFL4EiIAaq2HbOEsw20rV2jXEna9uyoPXwkQC8JjqanDZz66e4=@lists.linux.it
X-Gm-Message-State: AOJu0YxzQqHrtGbpg8xfT6ZJVqcrzpp5qD/5e9TRGx61/g6IAgwoW9T0
 +hBYwHLFQXHrETNHkjx7n5NGKXnfVwU8ekBGdo7KUbNa3vWlLjlkoTLwNhkJoCKNKi2kS+85oyD
 uoA7V1C6zzsbcTkeiOjLXIs/1Ybz6RbpE1G9rhXZcRyRQjrn2UZsoVlPjxX4AivW/LoMZ6BPPQC
 msKYIwB6p4SYR0aV0jElWohgQ8jJw=
X-Gm-Gg: AY/fxX6reQbyl8vxZYuYZrTAlBJjbfWMImFtYz/sBwE+J6J2DOpfVC9kLL+6bYPBmgl
 3qAHMV9nLr4bABQTS6vAPN9XVP02ggDwWZo2r7nf5RGn6Xo5qkENt9xY4Fv/yDIEths5gVcfuy2
 9Ia1H72kw0ONPXB4KmONNakrxZrRXX7AX2CtJkJR3N5rXjQB82elHjyLPbXPcZrEqLaU8=
X-Received: by 2002:a05:693c:374a:b0:2ac:2dfd:9ff with SMTP id
 5a478bee46e88-2b48731ffeemr1419237eec.41.1768359826668; 
 Tue, 13 Jan 2026 19:03:46 -0800 (PST)
X-Received: by 2002:a05:693c:374a:b0:2ac:2dfd:9ff with SMTP id
 5a478bee46e88-2b48731ffeemr1419208eec.41.1768359826269; Tue, 13 Jan 2026
 19:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
In-Reply-To: <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
Date: Wed, 14 Jan 2026 11:03:34 +0800
X-Gm-Features: AZwV_Qjc-HKo1Dr4vurfWTOj_-HPTqxBJgbA54oMedrOiki4SWvlV1QqFFNwJro
Message-ID: <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zBjXUQ-RMyJ2XS1xDpgJR0aH9frlCT6EjUjO6qEAV3E_1768359827
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > I'd keep them separate from core library. For non-core libraries, I'd go
> with
> > something more distinct, like "ltp" prefix for file and function names.
>

Thanks!

> > When I look at "libnuma.h" I'd have to think for a bit if this is
> > header from numa-devel
> > or LTP. "ltpnuma.h" seems (to me) more clear that it's not LTP core
> > nor numa-devel.
>

Good point, but the ltp* prefix sounds too serious to me. Anything with
the ltp* prefix inside an LTP makes me think it's critical information.

Perhaps we can use a lightweight name for the extra libs/:

est_*: extra test library
xst_*: extened test library
lst_*: ltp test library

I prefer to use lst_*, which is not only different from tst_*, but also
implies
this is ltp tst_ things.

What do you think? or any better prefix?



> >
> > my 2 cents,
> > Jan
> >
>
> That's exactly why I was suggesting to keep `tst_*`, which is more for
> code-library. The `lib*` prefix is pretty generic and we need something
> more specific for LTP.
>

Indeed.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
