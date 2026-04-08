Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC12FD5F87
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 08:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775637920; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QWT4aJHl8351iel5MERC4WbXHok27F+OYRDvKJzYd3Y=;
 b=F/FpquXYaKh3+fxr+4u6fQNhi0lEreHRS6xI48dQ9T9t1pCFTxd8r7Xb61jd6zgnsKsYZ
 9dPiUMWn45A05HyieIYAH+Te36cNRcdNCiKj51Vj1adgRZEKTxVJ63Egq6//MA6FKS7BckA
 3m3CQ3bOdgNdimiKodMwpIfnvg8SRzg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CC1A3E2180
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 10:45:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85F413D0F4D
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 10:44:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D8BC0600942
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 10:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775637894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lmStAYTMSBWz0lEG0W/ChwV+p0gL5PKfgaiGbvviFI8=;
 b=BYxB3yk25hR4aLaqwlP+rLdTEOkuPb/LlYiEDhjw17dj935kQo8d0tqZKMZHQQhzocyzzI
 mqP1/DKqITYWIrfTF6gNojdvy+nHKL6FQTyNezNigVybm15F/Wxo6xtFCh9ORbq/eHfcC3
 Zq6iEVnmZ1/wwt4zanOdMZBPhQiISFU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-EC466-A1MjWBCerJRfER4g-1; Wed, 08 Apr 2026 04:44:51 -0400
X-MC-Unique: EC466-A1MjWBCerJRfER4g-1
X-Mimecast-MFC-AGG-ID: EC466-A1MjWBCerJRfER4g_1775637891
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2523e0299so148438275ad.3
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637890; x=1776242690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmStAYTMSBWz0lEG0W/ChwV+p0gL5PKfgaiGbvviFI8=;
 b=D5YEQyCIEYWZKxcpsaRqm8A1qi9C6MEKgp3PBKj8tUzBaeLHyOvnKCFJ3vF6p3Z4if
 PV7Q89zV3pjSkITjQnfEfpjenIiQHe6QbpkE9eaHv11e9TDeatdquwh8IE6C9mSBX6ul
 QSky5ZiHBoVBzilj+gTXlV2nH0CzwYVXtGd1qWXRkRloQVm2Uv5r73eQpjYCbwq34IWS
 5ovBbDIm6rxrmkPZbgVpJbBT4LZqHTuhuI3H8YhbvWMMYjOofHO7/P4hDGvguoyoJP37
 TUluUGEB/J6w/+VaH5eGw86Yo3y6P1GQnjxKRbnzxZzlx6k3+HVu9UYnQyYrna5SblY2
 i4sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUoCvaEaNzLU6KmyIA/U9eodQeTz/6aOggHU+KQpVA9Zutl4OR/b1GuXrP4rln7qcSGzk=@lists.linux.it
X-Gm-Message-State: AOJu0YxtbwjGn/ASiTRSg6+cTbBS5ymsJ2ySXgjxA1NeCxUchXBKnxd8
 0SDANPjFjyxreIwqn3wpskly9wYBvA3ssqdxHKsMdGPtXm0dSaxUmceUPV/fumNkdTzHLFQACUS
 agI5+Q+J306+BraqHPioju5CWoRJe9usqMnwoz8XjJgOq99syLO0amvCp8DGU
X-Gm-Gg: AeBDiet9qjmMMe1pTgYncTNbVoVtdkt62eYGBK6xgjnyMv6Ameu1dS+4cNQly40cZA5
 FUsRClxjD81FFUqzP530xHMTYYM/V7u6k5nhE7S/CizEF5Hd5w/ct1YbHYZcPUDoHW31c61fkSh
 5NYUBvSPqrH52pQ5Qj++gik/EJ6n4D0hb6oH4L9ecACJvnzPjZ20s5MZvr4NCwz9s6A/nuQr2gY
 1sR7q4lX+g8JpB/TdQ6AMjS/nEyMDYUFTfl9E7BdJ8IcDnND0xJn1Oh3LiVxrf+5olu+YNbvA9c
 7XXoAqgET6da9M3TZUOeFDqD+mdNzpcOJg5wPztXv9HCyfL7Ut+bog6OxJTflcfN6EtpgXeP2M+
 AclCklG8Urb5IJ24Q2w==
X-Received: by 2002:a17:903:4b28:b0:2b0:6829:9414 with SMTP id
 d9443c01a7336-2b2817070dbmr193705215ad.8.1775637889875; 
 Wed, 08 Apr 2026 01:44:49 -0700 (PDT)
X-Received: by 2002:a17:903:4b28:b0:2b0:6829:9414 with SMTP id
 d9443c01a7336-2b2817070dbmr193705045ad.8.1775637889309; 
 Wed, 08 Apr 2026 01:44:49 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27473583dsm197122305ad.9.2026.04.08.01.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 01:44:48 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:44:46 +0800
To: Petr Vorel <pvorel@suse.cz>, vasileios.almpanis@virtuozzo.com
Message-ID: <adYVfl5DdrNPZ4vp@redhat.com>
References: <20260330102909.863484-2-vasileios.almpanis@virtuozzo.com>
 <20260402095804.137387-1-vasileios.almpanis@virtuozzo.com>
 <ac5miylZZhkkylI9@yuki.lan> <20260402201129.GA158008@pevik>
MIME-Version: 1.0
In-Reply-To: <20260402201129.GA158008@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vpQW7RlqFJADXNFSlyzJSkdpCGaFFC7n7bEdu5BG0Y8_1775637891
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: scale checkpoint wait/wake timeouts
 with tst_multiply_timeout()
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 02, 2026 at 10:11:29PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > Hi!
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> This is really way better than the original approach:

Agreed and merged this, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
