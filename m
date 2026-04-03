Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CBDD73088
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775183464; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z0/YP+roEwRQb7Av5ZpWMayWqOU7O7juUn4Rbyk6pb8=;
 b=UD9Y60irExwpIJsuMAhsfKeLzpfazPG/3CQ6gBHTp717f6D6Fs+r5BWKLHTCTIwuoJ+NN
 y7WfeQtsPioUYgwObAdUOE/hoKIm1OAp0t4AaunW2B1zyVlufPLmmtFy9k6vrIGe7wytn3I
 4RL15W7P0Xb/DLgKa23Eur4j2Kl/e5M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0AF23E54DA
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 04:31:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D5E93E2344
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 04:30:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C38001000D90
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 04:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775183438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Ky79PIhXNkW912Br/it0zvOkAaP4QrRnnnnMmhMckY=;
 b=WD8AlcYz9kJLfYx7X73SHchfFQ6z/XD/TaOhrn14LVKb5pz+RmnGUEKkCey8qKCqC9GOtM
 vJQxf/6vdSMajA7rak7SSevOYCYo492YXJURLCOX2KOvj7V3cgcyVvVNQM/Sef8RnLWG1u
 IX9CvySze9qSh4TqKlq3YNVTIBNCpo8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-zMQOSDnBOgGcLSX05OcifA-1; Thu, 02 Apr 2026 22:30:36 -0400
X-MC-Unique: zMQOSDnBOgGcLSX05OcifA-1
X-Mimecast-MFC-AGG-ID: zMQOSDnBOgGcLSX05OcifA_1775183436
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630753cc38so2417873a12.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 19:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775183435; x=1775788235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ky79PIhXNkW912Br/it0zvOkAaP4QrRnnnnMmhMckY=;
 b=luOEvvW3IKBXlNC6aEVMs7DTE7YkCsdVl6/oBzXvh4RxA1rh8y67tqzlgshLWOItSs
 yOZw/s37loGzRDsrOiZGOQsJXD/XPDnj5mVOktUTPDFgtUnAesp5cELOb3kSpHGj8+KO
 fHCktZmKxogvHYMOsqmHIP1Bdep8ujui+v3KOLh4/YQv+RZ2LTxUJ1rYorYQMSHQkP3I
 +sni7PEqb1CZGKj/Z0a+Cy+/GZwTV2mBFPE1JqG7FkgGrUX/I6dNzOafCx0KEylXfxbc
 /hh/oG9l1u6KanVykqegXOqhR87oC8fCxQzEbRXT5xTmRvcJmli+eBIfilzPji8s4VLP
 alEA==
X-Gm-Message-State: AOJu0YxBLKPUXSTuaFRKHfwsXqJtJjM4j86l/WEEeC9tHhz5Fb7qP+vp
 IA8DGd5CuxPKe7c8IpgPknECBvbqe9x9eWuXeJvZdcAB6vM4KfyurKlHqWc6qlkf4pZ5ruAZhgm
 afL03vQjVVKYh9yLRQFz+67+83YnHw88+BmozvMHstTSNELFh9c2x
X-Gm-Gg: ATEYQzzeoHf7u2fdy8BtlLcztujUHytQlNw0fGkcjo/fx0bfPhMzccBPuW7p7hVMK3E
 TZu8KKjt/6TIReVtqim4l0CvXkWOMXWGSbhfudkB7sWWxx1onyZsT20Gn6ue9ouDml8XfZK23IG
 /FLP7qERB0I8nyxF5iKh08EyeAO6/wYJP3E842Gm09/xAL1geGd23zS8Caefvg4b7qgjtK1i3lc
 BLxX0qhSj2Z8mvBZks+IgnPtE30Ez4wD8H3nueayUGZ3gc9K4cBtSPN6dQJBtcfeUXqmBF2IRpZ
 CgAt66TmXd6ehHSF3yTXoCpn1k7yOTsMOEo/bZqaZfGuA9yGGRZVji/AYZJaGO3Vf1InDu3axCn
 McLHBp/CEauL9OF/M0w==
X-Received: by 2002:aa7:88d1:0:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-82d0d743763mr1377977b3a.0.1775183435546; 
 Thu, 02 Apr 2026 19:30:35 -0700 (PDT)
X-Received: by 2002:aa7:88d1:0:b0:82c:9e00:f958 with SMTP id
 d2e1a72fcca58-82d0d743763mr1377948b3a.0.1775183435023; 
 Thu, 02 Apr 2026 19:30:35 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c3d67dsm5153457b3a.33.2026.04.02.19.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 19:30:34 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:30:31 +0800
To: Soma Das <somadas1@linux.ibm.com>
Message-ID: <ac8mR-0enzhgMeka@redhat.com>
References: <20260402082546.3245433-1-somadas1@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260402082546.3245433-1-somadas1@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JFbWiRNsBF3p6O7v5p1v81xfxANn4M9KaODP4xqR2sE_1775183436
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup: make regression test compatible with
 cgroup v2
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

Hi Soma,

First, thank you for cleanup this test. Yes, it is only compatible
on Cgroup v1, and it's definately could compatible v2 just with
some adjutment.

But I'd like suggest to make use of the LTP standard Cgroup API, for
version-check, mount/unmount, ctrl-file set, etc.

You can take a look at the cgroup_lib.sh, I think it will be more
convenient to reuse the mature APIs.

>  test2()
>  {
> +	if mount | grep -q "type cgroup2"; then
> +		tst_res TCONF "cgroup v2 already active - cannot mount v1 on this kernel"
> +		return
> +	fi
> +
>  	local val1
>  	local val2
> -	local cgroup_version
> +	local cgroup_mount="$PWD/cgroup"
>  

> -	cgroup_require "memory"
> -	cgroup_version=$(cgroup_get_version "memory")
> -	if [ "$cgroup_version" = "2" ]; then
> -		tst_res TCONF "This test requires cgroup v1, but system is using cgroup v2"
> -		cgroup_cleanup

The code you removed here is actually what we recommended as a way to
check the system's cgroup version :).

We can not simply rely on kernel versions to think the cgroup versions,
because for different Linux distributions, it may backport the new
feature to old kernels, and kind of Linux supports v1 and v2 flexibly.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
