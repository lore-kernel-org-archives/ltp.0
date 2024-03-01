Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5912C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 07:27:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E75193CED44
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 08:27:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4073E3CD103
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 08:26:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0496D602A06
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 08:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709278011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOqmYAhmPv6ts0tvzPUyb36QlPoeWnqez002Iew+lfk=;
 b=G8k8bCXowAFGIb8T9VM8bZYn+czMc1sL37DCI0yoEYMK9f2kfoPt8QpgBLggGFKyabMtnH
 /hxbzxtDKZ6+IOSs6vcERKZrH6H1dwVbFvVAMAHsiBecF7ZXDby2lfHrVE4Dtm4WCMONrP
 6jeGABAdrZcyqlwxknbfgiNDTURJm6o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-85BpqhWwMceTE2b0GsFZcQ-1; Fri, 01 Mar 2024 02:26:49 -0500
X-MC-Unique: 85BpqhWwMceTE2b0GsFZcQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e5ce471890so14917b3a.0
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 23:26:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709278007; x=1709882807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOqmYAhmPv6ts0tvzPUyb36QlPoeWnqez002Iew+lfk=;
 b=IUomu7oIT0dTXzeuj6l36VymtoZFlzjL9OvvOnBmFUTClpbHChag6+4joVTUfo6e4e
 lXtI03BCxgcMdsGqAUpt4tvjt7QFRXQfyA/esn33oD49j6FtQm+GMOCZ1GstjCPvzRHz
 I2pFWqru05tkR9ZCHvO0Vx5UfPHza5pBo1eowKku02x3c4GPa54oeAvthQodgyW1oqZd
 btoIagL8yHAkQS0NkZ000+jBfvzgONJOGQ8ZVKIVwAHGUnc+ezpGAXRhqKhTyPinFKuU
 m4rUffvGZwhBHvKSzWZ1VxiCw/uTDPtguMuIdRT4dGX6IgFwanYXCGx4uFYCJOGYlukc
 zt9Q==
X-Gm-Message-State: AOJu0YwrnnRplnvakSyDIfrUwAdL70NTRZG+4iBw1JZSy3OedcvYGOvR
 ZNJJA4B0p6/3LNQPsfzIZLIaITq2BlJju47d8VQdRVHwxxcySjFiF6TDXXxAPf3n7zTAnTVg+NQ
 v4RTR/V1LKZ+EgONAi88LfCrmMAkd+v1Uu8Op7zDfytS5h3HFhq0UK+uj3b+AVDuVNlZzvBcpg1
 YNwFcYIidR68xxp8FgvaJ37Uo0dopEwh9qCigu
X-Received: by 2002:a05:6a21:339b:b0:1a0:f096:502d with SMTP id
 yy27-20020a056a21339b00b001a0f096502dmr804344pzb.22.1709278007697; 
 Thu, 29 Feb 2024 23:26:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM5q3I6pQZvKjVOcoGxsqe3zKyDvHsYXEXeMm5F70R1XgcdQ8I3TB/Ia05Rh/xJmGWvvWJ1uF7Nj1hG2vaeJ0=
X-Received: by 2002:a05:6a21:339b:b0:1a0:f096:502d with SMTP id
 yy27-20020a056a21339b00b001a0f096502dmr804338pzb.22.1709278007406; Thu, 29
 Feb 2024 23:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20240221084256.32661-1-wegao@suse.com>
 <20240222031018.12281-1-wegao@suse.com>
 <20240222031018.12281-2-wegao@suse.com>
In-Reply-To: <20240222031018.12281-2-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2024 15:26:35 +0800
Message-ID: <CAEemH2cXOi0DpE1p36H-hUxuH2o8WwhD8DUPndBDMoKBbJJnCQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 1/2] cgroup_core01.c: Set system default umaks
 to 0
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

Hi Wei, Petr,

Seems the problem Wei met is the default umask of 0077,
any new files or directories that are created will have their
permission bits modified by this umask.

After looking though what you both discussed, I think maybe
another better choice is to set the umask to '0000' temporarily
before creating the directory, and then restoring the previous
umask right after.

All these operations are just put into cgroup_dir_mk function.

Something like this:

--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -368,8 +368,11 @@ static void cgroup_dir_mk(const struct cgroup_dir
*const parent,
        new->ctrl_field = parent->ctrl_field;
        new->we_created_it = 0;

+       mode_t old_umask = umask(0000);
+
        if (!mkdirat(parent->dir_fd, dir_name, 0777)) {
                new->we_created_it = 1;
+               umask(old_umask);
                goto opendir;
        }



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
