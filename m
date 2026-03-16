Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE133F3028B
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 03:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773633187; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Nf9rBWdgUP/+QWd7vzFJuj9Xfn+4cenyejKlbn7CeaQ=;
 b=YCcT/jQap0SgloXIBbFkt3a8X3FpCK2BAY5ybIsI8+AGxo/Zzul41+qncOKsghd+Ox9b2
 GTmmJGQR8ASMhNfFRQiFpPdrgFo6yPeFuW4LnnIAmvhxiPs83WMk/VimrWYfDLgt/cbcMfu
 zDJowvBos6227I3u6wX0WO8DeMKUVLU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12E8E3E1332
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 04:53:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8CC23CAEC3
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 04:52:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 08DCB6008BB
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 04:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773633159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=63Y3bKbiiFUUvHjiYZjTBVrKhj6ktRXCjZAZDviS9qE=;
 b=Wb1AxbZNS34E/o5rIKIuRIGh2ag+PO5GkwlmDI5fLmkcSWChK5JSH1L6bRCK8d7KZqw0a7
 aPG5gO4lSrSfqn8Qx3IjL5GRIGDIYRHLZiTYCzmM0IDWd7UDZ/MKppQowXMbd5kg0/HsfA
 PZejQ3dUJ02nyOmm/uFuxMx8gBbFdRk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-A82AJ-uUORWO8UsGimiKrA-1; Sun, 15 Mar 2026 23:52:38 -0400
X-MC-Unique: A82AJ-uUORWO8UsGimiKrA-1
X-Mimecast-MFC-AGG-ID: A82AJ-uUORWO8UsGimiKrA_1773633157
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35ba4bf54beso207020a91.1
 for <ltp@lists.linux.it>; Sun, 15 Mar 2026 20:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773633157; x=1774237957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63Y3bKbiiFUUvHjiYZjTBVrKhj6ktRXCjZAZDviS9qE=;
 b=H+6jTHSn8IVefDm2pmx3aHWHIDsfPA4cBUdXOEHako/8I6lrDlqE7dxjwovsbddy/q
 JIN5mXy8qT77p08IcqWxT4fjxgCzApNto0A8dbxJFLs4y2CaGgrGEM5DzSYoU8d4whyc
 MuJ+3/j7unq27Xs2X5NCs7YN1mRyi6a1WZmxNtPwedm550pe+PcBetBI0wo92Ld4V6EA
 iNek9mSmVf6NnalANIEwy2cz4/xL0wCzXktx1Ug0pdeLvx0mYz1jUMh5g/VnIUzZc2hw
 R9kBljM/RD4uuBheR5+TfOv5K+K+Pf7xCzjC5RBiIRFCYtj3qx3P22U7j7FMmV94ttSC
 4w9g==
X-Gm-Message-State: AOJu0YybLPMSs0mw1OjAEhtbES/GBUKBnHg0Me4S4pUDdRjjexDhxa/F
 dAxY8o+rsiMKEje0RuMBHm+FVoj2FQ8PUe2LTl7gfWuPEaG+FM4iztvZw8tdPWan6Gj/q9RiztS
 XEfkGnKd4tVj4DhzKJLfibMj1I8lrZ+6gU0aTfXn0gVG0Ca7JQ2Kt
X-Gm-Gg: ATEYQzxpaFV+dQStHG9DAv6oDJ3iGfg1XHMuBZByVrN/Kkyn+opzcLkP49/E+Y9XLAq
 e+IJs4iy0Wnf38G8c2adipfSZK04VdFRhogS3eDvNLqNrzUKONE+jCQc4HAxCxH2bCYtjJFbxV9
 tylUIS4n9WiUyW43vTvhHKKKTZ2TPOv2ibr+vjtnt65UiQhYsJP9Ah+3UYlCZLH1PfjTCgzKRLK
 /5DIHwVB3ZbJJVDPnzyLyoM/xnBzwCVrI/DgWv1vztZqgv23eV5DGIHBSjaHj5Cs8x5bHhfldgW
 pZh4D3aG2aryqpcHGoucDH8RxzRYKdL0HPMmS8ENNjqo9FxfY7cmTZPERsK6ZP7MvqowfVHxwq2
 XPF/dNemdNk8EfqcJxA==
X-Received: by 2002:a17:90b:1e45:b0:359:f0e1:f8c9 with SMTP id
 98e67ed59e1d1-35a21efae49mr10571222a91.6.1773633157107; 
 Sun, 15 Mar 2026 20:52:37 -0700 (PDT)
X-Received: by 2002:a17:90b:1e45:b0:359:f0e1:f8c9 with SMTP id
 98e67ed59e1d1-35a21efae49mr10571211a91.6.1773633156692; 
 Sun, 15 Mar 2026 20:52:36 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eba9e183sm7372027a12.14.2026.03.15.20.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 20:52:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:52:33 +0800
To: Samir <samir@linux.ibm.com>
Message-ID: <abd-gW8X6XU0BWbe@redhat.com>
References: <20260315125934.1291918-1-samir@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260315125934.1291918-1-samir@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RboJMMIQkKvQumpQ9WQ2oB5EIcNjtL1Coy9RDXYlVQA_1773633157
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cgroup: Skip regression test on
 cgroup v2 systems
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

On Sun, Mar 15, 2026 at 01:59:33PM +0100, Samir wrote:
> The cgroup_regression_test.sh test2 attempts to mount a cgroup
> filesystem and expects a cgroup v1 hierarchy. On systems using
> cgroup v2 (unified hierarchy), the test fails with:
> 
> TFAIL: Failed to mount cgroup filesystem
> 
> because the legacy cgroup v1 mount layout is not available.
> 
> Add a check for the presence of /sys/fs/cgroup/cgroup.controllers,
> which indicates a cgroup v2 system. If detected, mark the test
> as TCONF since the test is only applicable to cgroup v1.
> 
> This prevents false failures when running the controllers suite
> on systems where cgroup v2 is enabled by default.
> 
> Signed-off-by: Samir <samir@linux.ibm.com>
> ---
>  .../kernel/controllers/cgroup/cgroup_regression_test.sh    | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 276231fe8..f6deb0d43 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> @@ -118,6 +118,13 @@ test2()
>  	local val1
>  	local val2
>  
> +	# This test is specific to cgroup v1
> +	# Check if system is using cgroup v2
> +	if [ -f /sys/fs/cgroup/cgroup.controllers ]; then

This is typically right as the '/sys/fs/cgroup' is Cgroup default mount path,
but if a tested system does not mount there, this won't work.

Maybe we can go with the cgroup_lib.sh standard way for version check?

  cgroup_require "memory"
  cgroup_version=$(cgroup_get_version "memory")
  if [ "$cgroup_version" = "2" ]; then
          tst_res TCONF "memory controller mounted on cgroup v2 hierarchy, skipping test."
          return
  fi

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
