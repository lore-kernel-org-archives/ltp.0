Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A64C36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742563438; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mBIdP659vQr1lWJbKgJ2XDEi+r0v3B6+jIYbcC6+gfQ=;
 b=OtHWHnzSjazrP4SD8wHu9JpSQQWsOOn130pbfp9rU+aboaBLhooT6yzXQRfiSx2IW1aJ/
 jvsoi58jyOeMzHjC7egNzXKlgZ54SvZd2nwW64TMOTSMzLhW/MEEQijUog2DkcgCi0aXz/l
 iyN/dzz+tsQDtd01yTSFVikai7vJbvY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3E43C1C53
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 14:23:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C789B3C0636
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 14:23:36 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF4AE200142
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 14:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742563414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGMQ8Yk7+CsMxHWMvptorQ6Uc2VZiRJ5Qt0cvOsZANM=;
 b=U5cEx+crKshKARsgjOWCGfaEEVH47a8xEqK4RPPyJq+lZh9GMQmKpeGIadlWL16TwVL8BP
 AHWbYA5Xi7L4f8KYGutSMsCyk6zJr6evXZOTs6km8SW8vcnErLMF7ZDLRqgE5E5+GgrYlH
 XGu3NND66Rs8p7+H9B0dPBd0nzolh/Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-pk2PNnCEMLGxJQaZsjLkRg-1; Fri, 21 Mar 2025 09:23:32 -0400
X-MC-Unique: pk2PNnCEMLGxJQaZsjLkRg-1
X-Mimecast-MFC-AGG-ID: pk2PNnCEMLGxJQaZsjLkRg_1742563411
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso5024003a91.2
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 06:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742563411; x=1743168211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PGMQ8Yk7+CsMxHWMvptorQ6Uc2VZiRJ5Qt0cvOsZANM=;
 b=JSPxyQ026yanAW2xDAXV6E5fXPyWDuCd8OVAbhCRtdQgHPgbq+oxl2+UK93lLfWjKc
 I6DH+/WKKwTQLpeTlQ/VcI6J1RyTBtpQ6sv7BqhV4AL3G/fYGcKIZ+AUcvoRuY32nC09
 VEjJE7CrD6JM4Lyi0bMskaoW6fjBZiAba3YAMYllZotPe3/fFB14cEkKTb/a36T+yUzP
 0Z5aQ+Qh+UZ5Kk4fWc1OZP24RKSB5njONugOgD74fnytESKrH/oNFMV+iRqN9/6pgB3s
 z7gEYVZ/il2Ww4bp4p8UK3kKC6EzIkq0O1dfAHL2byzi/1NQ1K3r6uVj6cUXOysY9utC
 2xIw==
X-Gm-Message-State: AOJu0YxPY8nEkuTXuAY/uq6LO3nty4dwr4tMPhMQuzDMrXtAmVIdzvdQ
 3MOaMi2dWRFJNdXW+Eb6IE0FK247YYNTYPnXg5/HsdAdwhPASPFMlOIEZ57wT4RWtSf0Mp0OTPD
 e/3YOBekkyoOf0a9FCZL0vffKcOl0UtbQSirbd7P2cGVioG91P5hhqrfmMcjifLs8BsAL4uFX4Z
 agcsnuFEYahMY8KGxP6aXwn9w=
X-Gm-Gg: ASbGncv5+zk599ndNql0UI3sZKVw5UqMXUO1hozoeaA8cOwRP/EwAV4KZpL3jwEEj9D
 2h7sGUrJJS/a8UF1pRSdkfg71R3Z+VpfbqhTf0Ex7foCeYVT2H4iUWtI0pLvVmEthlIl3xbuleA
 ==
X-Received: by 2002:a17:90a:e7d0:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-3030fef4abbmr4830297a91.28.1742563410947; 
 Fri, 21 Mar 2025 06:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf2rDN+P/VU2clXGulz5mJKUr4DGjZIm6mCsilk06h3cM2MXuQl6OMVeI6j71CSOelTZnln8zeIZzEIw2HhmM=
X-Received: by 2002:a17:90a:e7d0:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-3030fef4abbmr4830252a91.28.1742563410457; Fri, 21 Mar 2025
 06:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250321131621.1870655-1-liwang@redhat.com>
In-Reply-To: <20250321131621.1870655-1-liwang@redhat.com>
Date: Fri, 21 Mar 2025 21:23:18 +0800
X-Gm-Features: AQ5f1Joec-PFz579wb-Ytw5R8iI21k7J2Ef_PTvaA4UamZ7c4c1vlF_Zat5HSo0
Message-ID: <CAEemH2chMcRyFmhY0NY=JMACKMkB5_XhDx9+X32459E5PWkghg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>, Petr Vorel <pvorel@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 62zbrgzof9ShAWRJEaKL1IZ_WCV7Cb98cFGh4-iTxso_1742563411
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] shell_loader_filesystems: add tmpfs support to
 avoid fail in GitHub CI
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

FYI:

In the previous github CI, due to the lack of XFS/Btrfs support,
shell_loader_filesystems.sh was not actually tested and resulted
in a False Negative.

See:
https://github.com/linux-test-project/ltp/actions/runs/13968146513/job/39103228371

*** Running 'shell_loader_filesystems.sh' (exp: TPASS) ***
/__w/ltp/ltp/lib/tst_tmpdir.c:316: TINFO: Using /tmp/LTP_shew1KAxt as
tmpdir (overlayfs filesystem)
/__w/ltp/ltp/lib/tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
/__w/ltp/ltp/lib/tst_test.c:1900: TINFO: LTP version: 20250130
/__w/ltp/ltp/lib/tst_test.c:1904: TINFO: Tested kernel: 6.8.0-1021-azure
#25-Ubuntu SMP Wed Jan 15 20:45:09 UTC 2025 x86_64
/__w/ltp/ltp/lib/tst_kconfig.c:88: TINFO: Parsing kernel config
'/boot/config-6.8.0-1021-azure'
/__w/ltp/ltp/lib/tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m
30s
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.ext2 does not
exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.ext3 does not
exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.ext4 does not
exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.xfs does not exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.btrfs does not
exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:105: TINFO: Skipping bcachefs
because of FUSE blacklist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
/__w/ltp/ltp/lib/tst_supported_fs_types.c:58: TINFO: mkfs.vfat does not
exist
/__w/ltp/ltp/lib/tst_supported_fs_types.c:128: TINFO: Filesystem exfat is
not supported
/__w/ltp/ltp/lib/tst_supported_fs_types.c:128: TINFO: Filesystem ntfs is
not supported
/__w/ltp/ltp/lib/tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
/__w/ltp/ltp/lib/tst_supported_fs_types.c:49: TINFO: mkfs is not needed for
tmpfs

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 0

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
