Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B97DF33832
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773741590; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=sf21SXSvX2oBWr1kTFPaUzIcVkugF2te1ZupumrsjbI=;
 b=IyovZKseZ42o6czw8y4mRxkTlqpQ3qx659FTu8dIh7i36mTVdby1Z2FP6Ot61bq0hO3js
 ZQfimkDzbfkpnx5NzKf4j5J91qN6siKCM+flucOnN6cXeliN9eKlR26RDgky4wl4KEYz90w
 vjHjXQW7wYPqbh5pFYIqo48tUuv7ooM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5ADB3E2B6D
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:59:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE073C1E06
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:59:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 432011A00889
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773741565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAcoO1MJ2ZlisqYaokHFfhsSz/Phntz2f0GzOpjADeo=;
 b=U2zrUYevnpwVrSCePSH3ZAlWgAZ3jlfIEg5YbHKKiI9PI/kotipHr+SbGjf2m1oMgWNMyU
 tC7oWtxp+WWXWUQX0b611rFXEFnKHb4mwaUFOG/TvWl+9aaiMtc0i2tqgyKPbnH161mRdg
 h33kT97n2Wzu6oOuyQSTz8etxpgMR6w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587--flWKrn_NrCLmKpdcNjjdQ-1; Tue, 17 Mar 2026 05:59:23 -0400
X-MC-Unique: -flWKrn_NrCLmKpdcNjjdQ-1
X-Mimecast-MFC-AGG-ID: -flWKrn_NrCLmKpdcNjjdQ_1773741562
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b06395b8deso11606595ad.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 02:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741562; x=1774346362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAcoO1MJ2ZlisqYaokHFfhsSz/Phntz2f0GzOpjADeo=;
 b=jnHy+4vrDsISwlxzM8iKzOzBgtD7k6FuKEyi7FcDK0AWfIPaxBWMm64agBzbtkbHxB
 mtNxMCL1+ehysXeEY2xUZ/eHxYFr3u9awOLSv+k00nuqWIjpnLE/8aGs/CM8D6Ee48Uo
 CPxzmgW24n75D2Rxlma3XgXQ1DFUoLiiv2oKHWXD2TKMUramOu5HqJ+H1CsTMAYmPHom
 nhcNeVDFUndwy8WnARDAK55tuVfTxT0Rw6Pzn7bGU6qgoKZ/ruV4FqDjkMhPC6SeQH7M
 TABWiMY7MKgZq2y943Dj1MmvMLo3M8yEUZmvgXIR53XQBoEcDu1Xy+wYuwBOxVL8c7WX
 ktyQ==
X-Gm-Message-State: AOJu0YzjhgU+Sj87m8TDk2qhOXRGf6S7yK7Tj6+3D8AD3nWNlS92OuTH
 xN4W5x9QBT1MO+09ucp9bsil1SRD3RS2dzsW7HczrzV3Q6RCcoI+h/VZy2P7EwJzR9jsWChagYS
 vsk899J0FA9QJeDIkyC5SdNkw7RJdWEs5znsYy62hCR9nRjrdKZdbTmM62cTS
X-Gm-Gg: ATEYQzzb0P/Ug4hkGmCKtf/b4oGXHcHzMN4a/Pz7eiP3CB5wZ9yIgSdgqQF/s9DTFtO
 5SVMdLQzQkkGCTx7VpP+UKYBxHMUEV7FRRcN2tiSfPIhtww32CWjKYEK8Rp7SBQITuzXxfiawVB
 ZU/Y1wA1uy46QAC1nauiNj1npAsRAp8ajujik95rH2fn/ncHXdXkF7nkvXbq0SzSl5S9DlcZyk3
 3JB7zl6dR96V87/BUygTe7dQjXobOk2YEE+m5jVbh8IaPPOO+WGjQgsYvo527fynFyclCGg2qj0
 cgqCfC0oAXXGEcwyefm/aJQIeIccrudFSPITu/ke/L+lksLm2OR+28oj9iWIOnPGIby8i49fRbk
 dCYIQ2t+xFG2I3L7c5w==
X-Received: by 2002:a17:903:2b03:b0:2b0:5371:c23f with SMTP id
 d9443c01a7336-2b05371c7a8mr76854105ad.51.1773741561838; 
 Tue, 17 Mar 2026 02:59:21 -0700 (PDT)
X-Received: by 2002:a17:903:2b03:b0:2b0:5371:c23f with SMTP id
 d9443c01a7336-2b05371c7a8mr76853945ad.51.1773741561465; 
 Tue, 17 Mar 2026 02:59:21 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b05d95796asm50740605ad.52.2026.03.17.02.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:59:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:59:18 +0800
To: Samir <samir@linux.ibm.com>
Message-ID: <abkl9sUAP6H0W86Y@redhat.com>
References: <20260317084203.2956-1-samir@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260317084203.2956-1-samir@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWtnHrCprsy0IGAT9o--CwYFcqUz9p54eVeUgwwc2lc_1773741562
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [LTP v2] controllers/cgroup: Skip regression test
 on cgroup v2 systems
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

On Tue, Mar 17, 2026 at 09:42:03AM +0100, Samir wrote:
> The cgroup_regression_test.sh test2 attempts to mount a cgroup
> filesystem and expects a cgroup v1 hierarchy. On systems using
> cgroup v2 (unified hierarchy), the test fails with:
> 
>   TFAIL: Failed to mount cgroup filesystem
> 
> because the legacy cgroup v1 mount layout is not available.
> Use the cgroup_lib.sh helpers to detect the cgroup version:
> 
>   cgroup_require "memory"
>   cgroup_version=$(cgroup_get_version "memory")
> 
> If the memory controller is on a cgroup v2 hierarchy, mark the
> test as TCONF since it is only applicable to cgroup v1.
> 
> This avoids false failures when running the controllers suite
> on systems where cgroup v2 is enabled.
> 
> Changelog:
> V2 -> V2
> 1. Use cgroup_lib.sh helpers to detect the cgroup version instead of relying on the /sys/fs/cgroup/cgroup.controllers file check.
> Older Patch link: https://lore.kernel.org/ltp/20260316115800.GA311158@pevik/T/#mc4b1bb1d0f73d0267a74f3de9764fa8fb398eecc
> 
> Signed-off-by: Samir <samir@linux.ibm.com>
> ---
>  .../controllers/cgroup/cgroup_regression_test.sh      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 276231fe8..cc8fa1f99 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -117,6 +117,17 @@ test2()
>  {
>  	local val1
>  	local val2
> +	local cgroup_version
> +	
> +	# This test is specific to cgroup v1
> +	# Use cgroup_lib.sh standard way for version check

The tst_res printing is clear enough, so we do not need code comments here.
I modified a bit and merged this patch, thanks!


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
