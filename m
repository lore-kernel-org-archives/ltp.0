Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38E1088E60
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773923691; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=v7ASNqQq2SaLVwBQcyyHGQAZLj9Mp9cHwv+f4sIKW+4=;
 b=PAGEAXFqKL3p0L6E84rTc1yq3oKnBYUxxv9SU71MXv7lE6SzrhFFWVhJyWgvM9l9s1z3a
 MBNfXn662UDvNw8jsYnKRFunCDLOo1I36mxUXnfA/BVwqOWJGxura3kqvc32cl4jwZaSLGf
 MGKW4ivaccRLsXuDEJo3dZjV0/8iTC8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E1193E2B53
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 13:34:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01F033C2EA3
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 13:34:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86434600F8C
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 13:34:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773923664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GbJtG+mpK0mrHxdOTly3pGHUptzcAJzKeZSmtRrkMY=;
 b=Ac2LtV4dqb7O7j2o0QMiZtq0DS74nQSWfJ/0PglLiIkdIBpTnSlZ36Q4XltR5jKslTA2li
 NBxDoxP7fjSaJyLRSOpegVU/EG3htmrOaaybAezdlHG4P8IOUOD0qNiscgIONBAJb8ua42
 ax6a8IznpsHZeAY3za7DzJWlw8gT8IQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UdjxCh-LMOumAMfBmKi3uw-1; Thu, 19 Mar 2026 08:34:23 -0400
X-MC-Unique: UdjxCh-LMOumAMfBmKi3uw-1
X-Mimecast-MFC-AGG-ID: UdjxCh-LMOumAMfBmKi3uw_1773923662
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c74217894d9so832864a12.2
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 05:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773923662; x=1774528462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GbJtG+mpK0mrHxdOTly3pGHUptzcAJzKeZSmtRrkMY=;
 b=nlOqIlnz0B4RZYUcUIYkt8SYRw85Iu+315rQ/JoTrOYjFMAdBEaQnqOFXy/1gG2QL8
 r/SGw7uT19G0xTrfZexnUtI2gHdd7HhOMPXA3mEkvJsOLDSLGVlFLnCRjgu1OOIpjrFf
 LSii9lpD1v1L5UmsNCbYq10eD5lwdHKIF7Pi5ELEBz2RGsiTqLuWh1zmEIbiSLwjFS/c
 sl3j84BZo3JpqCRIp1jYskWHbKa+L9Zn7cG2DvZz5t2xudXvfwhidh5/HVJT0YYkm+SA
 S9mvhtiUsoVbTFLmFmhxWh3eI6Xxrj7Lz6tbbSGXZR2F2BszXmu2xnGaqINqWDuI6I3l
 AZMw==
X-Gm-Message-State: AOJu0YwRha4WD83Fdr+99ti5BHrNt11zpC5TzNWL5wXKvCVFxQGGadGY
 re6fqtFt/gJHV1zkimnJ9svkUtph5TNxVgPr4NYIglneY3McQyihwYIkX+Wm3tPA4Q70VoNqtYh
 PF6CyebNKlhFIaT0hLhdSp225YubuJL0SW21T2gOQ/6ex0XIwfFYAbbuaInfowz8=
X-Gm-Gg: ATEYQzzVwnalnw54iFBPqSi+TQgfgW5WKe5WxX6sDZZcRovWh3ASq+YU9fgrWSAs+0W
 fGcWsdG5nBP3deadrSYvcU6n6yxZJD7sP15KLiMeu6CWmH3oaJUgLixevkGDPHcJ50t0VHBEk7k
 3phPIlVcwG2n7UHVn6rq31uvIFW1E+CGpbpo0m3FBDKBp9bjCTVZqzF0HtVjcIvtF9g2Bh4Nu4U
 zMVC9VoZdQh4vGnqQubSLTXzuy02kPpbtVFtyvB2Qf+wfbcIspw66Fb+j23zA7HpuOSpr3HG7Jq
 R/FhPevEo4Uc/EKS0yBPPgxm6aiG3oJjN8eGhlIowj1YyNion5YuesadSchKbG+HplODmty1GH9
 mBJogVZGDMNk9csiF9w==
X-Received: by 2002:a05:6a21:111:b0:398:a060:a97b with SMTP id
 adf61e73a8af0-39b99c8d2b4mr7316296637.1.1773923661751; 
 Thu, 19 Mar 2026 05:34:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:111:b0:398:a060:a97b with SMTP id
 adf61e73a8af0-39b99c8d2b4mr7316265637.1.1773923661156; 
 Thu, 19 Mar 2026 05:34:21 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b52e671sm6996803b3a.3.2026.03.19.05.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:34:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 20:34:18 +0800
To: Gao Xiang <gaoxiang@kylinos.cn>
Message-ID: <abvtSlnT-1P2pYZG@redhat.com>
References: <20260319073248.4681-1-gaoxiang@kylinos.cn>
MIME-Version: 1.0
In-Reply-To: <20260319073248.4681-1-gaoxiang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ZHz7-mfvVN-NwG2JYo9_CR9A5CYPo_-wVJ4NHNDrGQ_1773923662
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] madvise09: support cgroup v2 via LTP cgroup API
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

Gao Xiang wrote:

> --- a/testcases/kernel/syscalls/madvise/madvise09.c
> +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> @@ -18,7 +18,7 @@
>   *
>   * o Set memory limits
>   *   - limit_in_bytes = 8MB
> - *   - memsw.limit_in_bytes = 16MB
> + *   - swap.limit_in_bytes = 16MB

The previous ctrl-files in Cgroup v1 naming which should match in v2 as:
  memory.limit_in_bytes -> memory.max
  memory.memsw.limit_in_bytes -> memory.swap.max

Maybe we should standardize all the names in the comments to v2.

See: ltp/lib/tst_cgroup.c line#183.

> ...
>  static struct tst_test test = {
>  	.setup = setup,
> -	.cleanup = cleanup,
>  	.test_all = run,
>  	.needs_root = 1,
>  	.forks_child = 1,

> +	.needs_cgroup_ver = 2,

LTP now supports automatically mapping v2 control files to v1,
therefore, there is no need to set cgroup_ver restrictions here.

IOW, with your patch applied, madvise09 works well on Cgroup v1 too.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
