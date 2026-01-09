Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D80BD232D2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767928097; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0p2hqQtuaSGnGSkHw8p4du+Y5em+z3yMp3+E8Ovc4bw=;
 b=RsMU29QjNxBPF6aLI/UvhdaHu7AUwZGypZOq7uLrV8EZkg7e26fg21HZUpzy4I7an20ij
 h7DaLlUe7mhoHfqh9BUENmyxOxtTGzOXOYa37+0O1RkaLDD6CUbPuP1SUCYf+Ul2iYt+8s2
 2wDVDA64AJsZcYxdEFgieBPBsGjvHE0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E02C43C699A
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 04:08:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5667B3C54E7
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 04:07:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB5841400242
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 04:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767928070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMFP7JTenBPUjE2sdu24Oi1TWO0KfTMDqFJ+iDDlfUk=;
 b=AChdpv9TFyIKtWsMaZ5GattBHhVU7h/kJe89kB5h/ovN5q7Z39GuBnA5rPGzyFTNf/AWdW
 vov4fd7/NtX0zBKkPjRcb+94gkDnDMzHD2GmpagAVWEfFmm0Ipk7V5fWc1+LbEo0DjXVWM
 7qdIMyxD1KmBoIzRgA5TDl6Wp9v5dLM=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-L9KkrVT9N4-Qf2BH1GpjjA-1; Thu, 08 Jan 2026 22:07:49 -0500
X-MC-Unique: L9KkrVT9N4-Qf2BH1GpjjA-1
X-Mimecast-MFC-AGG-ID: L9KkrVT9N4-Qf2BH1GpjjA_1767928068
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-121b1cb8377so5192588c88.0
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 19:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767928068; x=1768532868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMFP7JTenBPUjE2sdu24Oi1TWO0KfTMDqFJ+iDDlfUk=;
 b=dFo6GldNHqOH9wex2wjDVeqOTtYbpa6BWggZQccIMg+aamRxn21cjPiMmIClSjmg5I
 90GU8pIBSJLy3lMP2n16vh+ir71qufs91XQg8doKr+NHyGGO8iivRmsbIFo1I3MIWKXW
 /g2dV6DHkS04YrjOAXBl+Hjn1HTsI6+w0qjATi2EJ2IpYfjt7/LE91blLg9gM60e4/O3
 hhBzfbFYyKZv9YSegv1Hk7HJmFT0Ydy62yN+bpXNDqkAcbyZEu8UYIHAT5ZiC3m/tvm7
 M7sj0y5ni/d8wlMsZlZRf9guQJuAU/raWo/HJu2UnS7Wq9gtnLSjTG7ddpNr4M+4eaCQ
 WPWA==
X-Gm-Message-State: AOJu0Yx/GssL8wTLSjpET5E6C5stYzp5r6unp16Uc+S3npQN+gIEYWiD
 SF4GbsvYJRVZqBImUch0K5zo+mPqXt/dRP59leaFpXjQQ8lXgMxKq1hLglFl0UqAT6NLXi39o2m
 3e+tMufgA+cds/ySjrPQPEtx/FeLGBEgfAK2rsTAScY5eBHPzBKyFOpUg9w/uV5FpTdLlvWu9HT
 kunv9mliXHKh7zPVklnqYAEHha44M=
X-Gm-Gg: AY/fxX51OFyjTpaBw74O1X1NCDwo44Qs1c3gwZUS/AGgnG1mvAAcRR8EJxVMOdk0zYA
 W/X6MjkZk/h5dCXB7rUP2ET3KbBzYDNvfDqQX8qybVSfc3M0FA63WIKUDSKpPqWkBMscFSneraX
 aWpr52gJKsOmzBsduKrpQ5g0C9ymyNgwopTUrnv2LgHc8/gBVgrS2z2bRaifsuipceMk4=
X-Received: by 2002:a05:7022:160a:b0:119:e55a:9be6 with SMTP id
 a92af1059eb24-121f8afe9e1mr6250246c88.2.1767928067977; 
 Thu, 08 Jan 2026 19:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXU9Yx1YtoUmbo42uyryrMdxFL1iz/BbDh/XLhcJKcPgzNIKSYb4hyZRHZC5dRa9Bd1KxkXJiwzjG8jiipnro=
X-Received: by 2002:a05:7022:160a:b0:119:e55a:9be6 with SMTP id
 a92af1059eb24-121f8afe9e1mr6250232c88.2.1767928067550; Thu, 08 Jan 2026
 19:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
In-Reply-To: <20260109023914.45555-1-liwang@redhat.com>
Date: Fri, 9 Jan 2026 11:07:35 +0800
X-Gm-Features: AZwV_Qi7ke5p34gLBP9T7WHLLdcvgjPICQirtkfSJskW2q_dihZJvpVpSdJTJw4
Message-ID: <CAEemH2eJ+owHCTtLEumnJqDbkgLYgJttyyjWM01rWbDn0ZBJfA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c9gCvBKIvpPxtOfYxgx9LWro-PUnVomqXs-yqihsjic_1767928068
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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

>  include/ujson.h                                           | 6 +++---
>  include/ujson_common.h                                    | 6 +++---
>  include/ujson_reader.h                                    | 6 +++---
>  include/ujson_utf.h                                       | 6 +++---

Btw, I intentionally did _not_ rename the ujson header file with the
prefix lib*.

Unlike the other header files, ujson is a standalone library with a clear
target (which is for tst_run_shell.c), and it is completely different to the
tst_* test function API.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
