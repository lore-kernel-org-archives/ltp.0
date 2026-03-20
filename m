Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2C41093168
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773977296; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rnmK4LVu0Fp2PsCnUBd5bwmkbdKykZq3NMxLpKV+0Ik=;
 b=Q3h+aXjVY/yvJeohAd2WRyT3u7jxD9pVzlI1wJ2PDwEKp2NZFfZZVbQA7rC0dVxE57Aw5
 szOxOVwojhr53UTgz23bR+oA1CMfFVPZOUw28GguRNNnGZYw4d4MXMuunn4nyewg4O/ixf9
 j5+GtV7xsHKaMg+vD+vI20xxXb4ILHI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E38503E279A
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 04:28:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8493E200A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 04:27:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55E2F100117B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 04:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773977272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WepXaECo9qIWUJ5BkTZRFHB5uxStV/cLxfLUgyAjemw=;
 b=dzRQyBU0DYY+8udjb5g1o0h050aj37rXF7FLMvHaTZouVP3slFxxV62FYDw/Ypxei4SQxn
 qGq+MbZKrxWvXHN38qKfJZmcaUA5sY8BhxEWYujEdRghup33H6e/uDAQuM+nvT5vJ3rrpb
 +rJLqq8hRWtukrJkyEvj+qlC9Zjtc70=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-KA3sw_E7MParByiP-0Z77A-1; Thu, 19 Mar 2026 23:27:50 -0400
X-MC-Unique: KA3sw_E7MParByiP-0Z77A-1
X-Mimecast-MFC-AGG-ID: KA3sw_E7MParByiP-0Z77A_1773977269
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35b9894f9ceso1717716a91.2
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 20:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773977269; x=1774582069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WepXaECo9qIWUJ5BkTZRFHB5uxStV/cLxfLUgyAjemw=;
 b=Nj+8oLE/8p3crl7XzW4tRv/4+3h/stSeMR2yT8nVtBqLOYRhVKVVgiRiDsi1vFQnxK
 tO7O0F/LTJ2R4kxOkY7SXqtgvONGsNSneIxD1tPcYF7eUBuDllwfVDW2k0BGgFjwZ2s3
 nUI9wLM9DHkn4wsvZFTbpFmu51gUrRfevEXIHdh/JGznq0yPDlpAlDj7/2Q2sy3TKC8Y
 i5AF+US3gAExYBPU0y4OQz68mCXKm2bQV5dVj2rYGjCM9WYLJwLRIF0hvPq0zfWEmg1Q
 U3McYDFveyKzeBbWXBo6kfcfyYJbPx7x4v7ZS4A9YAijeeWauWi6nMvMomtRk09twZwQ
 Xx9Q==
X-Gm-Message-State: AOJu0YyLnMye2/pl6pPllT6OEM4UhcaoXnj1QR65r9CEkZAx5oEXVWDN
 Nt0hdIQ41a5Xc7od+00PS6R4/d5zbRIw586BfCJj80btMKOU3DyWWVK9rVQ34TTxJrsu+gry8g3
 iG9b/9qOWrYrJjsUPInIjrHT8CWmfmZB9JZ3n8Brz7pHHjGRgWR4+gF/A2o9A
X-Gm-Gg: ATEYQzzRErV31uoKt4bI7dYog3G9J7PhxCTuseOlcA8jdBx8CIWpAMdZB3lhxgboDjg
 h9rIJxmlrSLclmUREdprciEgc/Xs0MmT8Ji7kixMX9Jrf0/JDecw/WXAiLrvf7UEj9l9S0n1WHD
 L9e/OlRIpGGOvXND4dvVK+Mv+v6tCivkGtmDa0f71EYAL15fEBO8bfF1FmJXvckzVwNYDFZ0ADa
 giFux+DhWQmktaKPuadv2PpCiiPQleiID0nymUodpc8n1W8jId4Zol3h3rUocTEXQH6lfRHeG9f
 VUPh2A4pcLRwJ2EawtPuzk2VemKcBHO9gc7qceI7HJ8ko2HU+OPGMCYE9ib79wR9g1+KER664Qz
 26U6ZgSH4Lv2gvheF1g==
X-Received: by 2002:a17:90b:4cc9:b0:35a:329:73c6 with SMTP id
 98e67ed59e1d1-35bd2b97774mr1147201a91.3.1773977268804; 
 Thu, 19 Mar 2026 20:27:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4cc9:b0:35a:329:73c6 with SMTP id
 98e67ed59e1d1-35bd2b97774mr1147184a91.3.1773977268344; 
 Thu, 19 Mar 2026 20:27:48 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd271c507sm298201a91.5.2026.03.19.20.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 20:27:47 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:27:45 +0800
To: Gao Xiang <gaoxiang@kylinos.cn>
Message-ID: <aby-sTD-GhYeHhxE@redhat.com>
References: <abvtSlnT-1P2pYZG@redhat.com>
 <20260320020730.11233-1-gaoxiang@kylinos.cn>
MIME-Version: 1.0
In-Reply-To: <20260320020730.11233-1-gaoxiang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y3FDyVu8oht_MI5HrpUMOKhpBz__q0MSSKTnmY3gnvM_1773977269
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] madvise09: support cgroup v2 via LTP cgroup API
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

On Fri, Mar 20, 2026 at 10:07:30AM +0800, Gao Xiang wrote:
> Replace hard-coded cgroup v1 memory controller handling in madvise09
> with the LTP cgroup framework and cgroup v2 control file names..
> 
> Rename the related limit variable to reflect the new interface instead
> of the old memsw naming since memsw.limit_in_bytes and memory.swap.max
> are different between cgroup v1 and v2.
> 
> Also fix the munmap length argument to unmap the whole mapped area.
> 
> Changes in v2:
> - Drop .needs_cgroup_ver = 2 becasue cgroup framework already maps
> v2 control files to v1.
> - Renmae the comments to use v2 control file names.

We usually add the change logs in git note:
  git notes add

> --- a/testcases/kernel/syscalls/madvise/madvise09.c
> +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> @@ -17,8 +17,8 @@
>   * o Write to some of the madvised pages again, these must not be freed
>   *
>   * o Set memory limits
> - *   - limit_in_bytes = 8MB
> - *   - memsw.limit_in_bytes = 16MB
> + *   - memory.max = 8MB
> + *   - memory.swap.max = 16MB
>   *
>   *   The reason for doubling the limit_in_bytes is to have safe margin
>   *   for forking the memory hungy child etc. And the reason to setting

I have modified all the relevant ctrl-file names and pushed. Thank you!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
