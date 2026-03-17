Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18573F3380C
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773734480; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/o7MztyY8iXQagCx5brmt2UCuim+mKiOYFXeWJvnPDk=;
 b=a51RYhGK6GH/rEgtByYCppJSIaDF5H0YzjI2aJpeUh3yQUf9r/72VuieLHjDNsmlqKXMH
 7wCC38N3TanfTKJXnrcYow4fD8fDBBUQvyxIQWtkIjQBUC6CWIUbw9PHdXjAGAUT+1P+ZFS
 MFarrOzkOOgPT0RWkfWrXJ5OXesQBks=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 943663E1CB7
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:01:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CA413D0343
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 09:00:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCD20600BC9
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 09:00:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773734453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5kj/b2bAOecPRUSsl7qsgrYB17dDJpd9KM54zIrkv8=;
 b=Og3xvKBvF7ZnCmGcqZHztwm8LXlrz1S3xvg28+jxW2Lck6W3niXEICu9uzg+R4a3JxXQSl
 RYs1+M4lBaHlKk5oB6mNXtOzbWUpzbHdqqMGN99qNMu0sFHs3Qx+UVSfYXUmrtFxlxPS7f
 KUzgBekYY1Zz6xsRaWqh4eN91Jnt2nY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-WiEHyONwPa6ACblU7Ct6Gg-1; Tue, 17 Mar 2026 04:00:51 -0400
X-MC-Unique: WiEHyONwPa6ACblU7Ct6Gg-1
X-Mimecast-MFC-AGG-ID: WiEHyONwPa6ACblU7Ct6Gg_1773734451
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c737b6686ddso3701724a12.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 01:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773734451; x=1774339251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5kj/b2bAOecPRUSsl7qsgrYB17dDJpd9KM54zIrkv8=;
 b=njKRRnkztnxMnWc3hDSX8VYDZDjKhFUdVo2xdF1iqRDEEPgkpYuHD5uvXqAmvHaXPS
 DO2D/jL8wiMyKY64YebNDzxaO2RP7VAY/Kt0BhztiIf4nkZXHWp3suVuXjykqXxdPzgx
 lLu8shruyPrcpmKL6CJ9LWMkWV21Bz/AFv/Ob+Mb95Wi7i7bYvlwyviw736cXlGboY7K
 n43XdV8dQXXpLmURbdnInE5tlJOnfHVpBwdWyyvLO0Ix+f2Y9y/WVEE234Eb0CmVHsqj
 GQPOSiUeytcKNelaH5LFt41EG2OOac6/HS9VXXw/mQFtZ5cpHc51LEXhH77UyECc9Xx6
 tjFQ==
X-Gm-Message-State: AOJu0Yw+pqSxpjh9XAP9RZ0wou3YEsXoZ91sBpmqSEU8wO+AQgTAnrrn
 snWNEMsFmGaysjPByAtwk6nWBHegvn4TkJLSjTWKN/uNZ0EY71dBRGUFGT7bzEotWh62ptxDcbW
 tJVVLRaFMSQGAA0tITO1/rAtZVhK1oZv+XEex4CzIKBW5BeWNI47A
X-Gm-Gg: ATEYQzxzxWu5l6bNoC9BmyKpk4klTdzy4cj21ggXIXhByTpH/jowv7Sjoqsp02tzQFZ
 M1qeUQwhsflQgZDkdVoMZhJekDjX+WHMYASTsDeY+/ZJnb3OvkUp3LK6dc+EWKNU13UAUilt8mR
 kP4wPPC7GY5x2/eCrJucmWBdInActbG2xz1fJsSaQSARGnU55MWxwdlAxSNdF3RVt6YczT3t0Bt
 H8wPUcSmHcAAx4DE2gnJk1XHZg+VrBcryJo9iGzoWVi8qSgfAb5R9w+G1RBXFFT8NenJXjNRLbM
 8LJQTMooWlh431I6+H68c/oYzNUNTdAxQlwJOJQvriebjSHfWknNKIqrk2AFjWtqNlHfZeFylMY
 MgJAXAgyrZ0Xpcyu3/w==
X-Received: by 2002:a05:6a21:6f14:b0:398:866e:a22f with SMTP id
 adf61e73a8af0-398ece0cd9emr14692727637.65.1773734449890; 
 Tue, 17 Mar 2026 01:00:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f14:b0:398:866e:a22f with SMTP id
 adf61e73a8af0-398ece0cd9emr14692602637.65.1773734448301; 
 Tue, 17 Mar 2026 01:00:48 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73fc935ad4sm7087497a12.2.2026.03.17.01.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 01:00:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:00:45 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abkKLbIUu7ZDzuxh@redhat.com>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-4-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260313142600.243939-4-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xIEpgzJb_0L9AoouY7rlBZlRKXJqLBw_XZPugfe4ZoE_1773734451
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] shell_loader: Start test count from 1
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 13, 2026 at 03:25:57PM +0100, Petr Vorel wrote:
> tcnt in C library starts from 0. But TST_CNT in tst_test.sh started
> from 1. Keep it compatible with the shell code with increasing variable
> by one.
> 
> Fixes: 5528da0231 ("testcaes/lib: Add shell loader")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
