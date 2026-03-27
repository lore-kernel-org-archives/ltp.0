Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325DC10BA42D
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 05:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774590103; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gl2n+F5f8Utn6n58LXfxE7CEnWSonDFypStcd4fvxW0=;
 b=VqGR9MJm9Q9RGD+PypXIE3ORn1rCHl/BYv8r1qtdFjgxL5Ov1M1Tj4N/zWfmPeeGh14jv
 VVe3wd/V/ayyR6mG2638aNwfL9DCsZk0qJnYXm9FHuki0ByfFnxGAuMrKJJOrVUu9+5bud3
 dwDXeoUWTixrm1vrwDNU8QO5qfuMBRM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93A583D9E8C
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 06:41:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51FF13C572F
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 06:41:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 13C861000DAB
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 06:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774590074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2Oqcj5gsI+f9oPfLPS2sLTOTF0MpwfuLG1kKhRd9b0=;
 b=EIj3HR69FlsWbm3sC1n+tfnwpb3ASZksAKgJc3i16RGzXHxKQqID4rXEJhINuqp2ZwJk8R
 GJ28l4Z2uL0VLreNWjUyqQsFyT++e6zXwmTOtWt0KXVL0sy2z4g5w/8QtBGDim4J4jIn/M
 Pj5kLgJH92vBKZNrbktfkcCj/umxDi0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-BQopA4KyMf2_cYO7nY71Mg-1; Fri, 27 Mar 2026 01:41:12 -0400
X-MC-Unique: BQopA4KyMf2_cYO7nY71Mg-1
X-Mimecast-MFC-AGG-ID: BQopA4KyMf2_cYO7nY71Mg_1774590071
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a6906e35fso3330247b3a.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 22:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590071; x=1775194871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2Oqcj5gsI+f9oPfLPS2sLTOTF0MpwfuLG1kKhRd9b0=;
 b=r2DnXDA4I2b60d3U3EkjLSSqSOjB8YULZ2yKXA1L7GBD0lu35WyYag9ChMYJzjFJVz
 TbLEWX1qxuL1FuTgVyU34D/ByB1n3YpIRlPwLQ70KxpAYsc2hqfZlr1+aY0gvYXmIkNP
 ZAzf3G2awfH3HJB2sujwGujvdbNlHvh2qS5ZXVbBphk5Ljiixv0uSsWU5DMTC3EKwBbD
 ezJtfoIVVadWHMJAo9I5DY1omDUNrf5iOmDZ5aIRQL4mbOW4omeD1wJ1s0NrtiE1O3Hj
 gElgxuIhesJ9lSJi7b0jB5LmmBtPuckRP2XwJadJxtKkEEzau9Mlr/hcANFLhw7TAkxM
 kQOA==
X-Gm-Message-State: AOJu0YwyFm6JVmuaqYMEwq+DwS4zpltcizr01Q3/DPVw3cptrT9n+81G
 P4S8kKVR72ksoqGLsE9hEegyDZvrh7nkkhszzNmEfvxkw3MVxJSYvZizZP1ztUKI9Ub7CrYVjW7
 tTJIuH5cX3Sd0H0BQgolC2PTgnzv6FYDkTaZV0ZVVZZ4CqaE2yuuQ
X-Gm-Gg: ATEYQzw2cKculoufWbiLwt/nThLsoK+ctnLu1qzoFP3sUcECMI009fpOYz6dOtTLpK4
 85m4ArmpXmCOC1RoHADf8zs2XtOtD32/cPVuVkCs03s8fGvE/yc6NDGGgCQzoBVCG/qsiU0czI/
 MDxgbsVD40D91KIfhmViHofXLEumJL50IQJwkyoPrMN8lkUProvgz67+jgQZIxkr0AzAX4fMsIx
 G0l8xyOLJ2kojwMB8fWV5+Z2foDfLzvTSbwyjB58Xwllqdj4undiNxNbzKiXlsDNKLrhnwtgchM
 5e+pZNgRyIneJbtB+2XyW5fIxCApaE4pk7lOoq+TOTB7v8jI8h6D0yVY6fO5QWd5UZuqe3y6GIU
 KxjMBBKdl8dxOLe7TEg==
X-Received: by 2002:a05:6a20:2453:b0:398:8ea8:5f9f with SMTP id
 adf61e73a8af0-39c73557894mr4179041637.16.1774590070872; 
 Thu, 26 Mar 2026 22:41:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:2453:b0:398:8ea8:5f9f with SMTP id
 adf61e73a8af0-39c73557894mr4179026637.16.1774590070358; 
 Thu, 26 Mar 2026 22:41:10 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7685ce90c5sm712350a12.16.2026.03.26.22.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 22:41:09 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:41:07 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acYYc47HXGYa5Mqj@redhat.com>
References: <20260326125216.159239-1-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260326125216.159239-1-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yRAw7mjG1jQoa3AdUWCyMdIx8vNyLjDPKoU6DfFnfS8_1774590071
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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

On Thu, Mar 26, 2026 at 01:52:15PM +0100, Petr Vorel wrote:
> Required kernel functionality was added in kernel 6.1 (not 6.11)
> 2d5de004e009 ("userfaultfd: add /dev/userfaultfd for fine grained access control")
> 
> Because it's a new kernel functionality which has not been backported to
> enterprise kernels we can simplify check with just .min_kver.
> 
> Fixes: b63ab54aee ("userfaultfd: Do not use min_kver as gate for test")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> @Li I suppose RHEL kernel haven't backport this.

Why do you lack confidence in RHEL? haha :)

I have confimed that both RHEL 9 and 10 have backported this
feature (commit 2d5de004e009).

As RHEL 9 is based on an older kernel(5.14) but includes this
backport, changing this to .min_kver = "6.1" will cause the
test to be incorrectly skipped (TCONF) on RHEL 9 systems.

Anyway, back to the topic, what is the point of creating this patch?
Anything I missed?

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
