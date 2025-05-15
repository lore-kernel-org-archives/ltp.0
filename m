Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEA9C3ABDA
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747275495; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=j2L5W/RVvKSu8+xTJrXyZ/9Xe53y0o7WbZyV6yn+zsPSIV0UxuYw1iyYCXWh4HxSCllFw
 qF0tXj43RdvnKIxOqQnuZBYXwQi+5hISKlkbwHlLbzD74tFhHoFrko+x4z60ZhW3RDhCY0N
 JeRFGeo5rT9QORV7AGLQAqof66F3EtE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 190C53CC3B6
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:18:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C6663C96C9
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:17:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0655100049E
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747275470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=Ifx4c5yUoHrNSQfOxSWzPvw52VzhEeDmNWxhBjMAsTINDoKH5jPyu1/Jb7n3MsCRLyIH0T
 2zfXinyNaQY6MjuP7Qkldwslp3scmLrti6Livgysny6muGo9aVW6C+8Q99GxU0ohXS/y93
 tzW4VgGHNHuZSwSk1owGWETLa8a6PSk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-zQZkwtcyPBS5ngQLwkF2CA-1; Wed, 14 May 2025 22:17:49 -0400
X-MC-Unique: zQZkwtcyPBS5ngQLwkF2CA-1
X-Mimecast-MFC-AGG-ID: zQZkwtcyPBS5ngQLwkF2CA_1747275468
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30c21be92dbso448846a91.0
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747275467; x=1747880267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=VhhSERWQSDEV6rQ7si0tfxBxkA67K5Nq995FYoaKXUgPRYYBKGXVVZCyjtm6Dv6Esm
 ZeIVpTnXRwrDLSBdRrGgbmBZy2eiRPpDP0+s5DHCU1GAYcTKFrisLOAmycfyNUbHEjiB
 HptdDDKLIO3JcLK85j0jO2X3IifHIdEiibCTGn1H6AtS5VEzPT7iRmKdDIzk78sNDrPj
 cNJJSqg2dY8YIarCMMnC4FD05PWr4Rzah+dPgpjiRn7aQ2TQzSWGgDaTcZszD5sO4e1w
 Hs4DrT/c12iMXVMEz3Oz3Zl2wLiAnhI5fIyZKb3u2Q0jjSKUNYhpDk+F06j3siq2xcrX
 TSqg==
X-Gm-Message-State: AOJu0YzvFEzf+hLbg7kK7YWO9Y6JHRXQbm2yyrHzz82w7JZEVQOu9gBt
 b6U5l9VcbxcoBLV1v4p/9LkVM74A00hznng0EuqDUrJXfz4fcjjOYC+24j4UmAYM2vT+35O7e6p
 j0kVfvTQioUOELhER5K5QlRUmwegR4QWbbs5i0vqbqgs+TX8QUtU+rzv5UAv0uGI/WHxeGF8126
 +f2BKID0WEIAbrgw2ydpCFRKgB3Z3zTSpNWg==
X-Gm-Gg: ASbGncsqY8gz3TAkELASb3cH+lsoUSQUZ0woJfzReeZRktAK0aGCiv5GH90dEiv+fWx
 S/iazWz9tihpdg2iZFLAidFesU9xgiKCRiL02QUWJ0+ZtcxqFcHbqrOX+9rHl34U/7/imEA==
X-Received: by 2002:a17:90b:3502:b0:30a:204e:fe47 with SMTP id
 98e67ed59e1d1-30e4db6eefcmr2640035a91.16.1747275466720; 
 Wed, 14 May 2025 19:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhE/1gICi6hYmEYqjNmzRwUsEabzIuNaqVCXvqS3fkbXzu9yY+whE/n9iWz+BY4ySefiPmpvm+UcmpuKGCLiU=
X-Received: by 2002:a17:90b:3502:b0:30a:204e:fe47 with SMTP id
 98e67ed59e1d1-30e4db6eefcmr2640013a91.16.1747275466424; Wed, 14 May 2025
 19:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-3-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-3-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:17:34 +0800
X-Gm-Features: AX0GCFsY9nZP2myEzmAJGSMLPjarcliUDlJsFxdGSshDIXzQBHN9y--RZwXbves
Message-ID: <CAEemH2ctch3bXkKkYE-5fXTUdFgWPPNfFbQkfjBe7Hbg4496uw@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cb1OpfUZt5UP4cg_u4cILO2Is_65G6C6FlyUClIH9GQ_1747275468
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] syscalls/kill06: Fix test description metadata
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
