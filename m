Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61B910BA420
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 03:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774583169; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9acAaOwRQnynwtusFcbzK9yGunwo3kiZeb1bZBSHJQU=;
 b=Qr5IO3bRUZHesnfReBwjkDlyNO7UGMbkN3xRb413nO0nkmE+REZJnRv0CoAn0qi6sWUUH
 U3Cu8QWtKBtm0vSvCZRS7oZCn0Ys2qBws2W8hQjbHwsKeyQrUhaBUNSewDOhO832JVHrrSV
 xmnTZEMEsBbVV2pTiPjn1RZbPSE5Upo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E0953DA365
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 04:46:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89F063D75B8
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:45:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13827600AE0
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774583143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P6IDNNJSbkwMwoD9vi3WobOMRHppiGrGA9NE/2G+0mU=;
 b=hup5XzCv1NBplG3VBNc012RZnjIrVPNHmCBvqfTO8UGKJ0WqgQnCpQbB+YFpYmD7XD/h32
 3IFenVVLKc/B4jxXkNYE3GB846/4JQNOYl4JOPR1s4nTYlZZgeN7MbgVgoHGZrAbMJrew9
 /y0cW0g9edP76QQ5h9M7NRWJAklyFQY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-QSyFylOaOvWiKZ_Da9SJIA-1; Thu, 26 Mar 2026 23:45:42 -0400
X-MC-Unique: QSyFylOaOvWiKZ_Da9SJIA-1
X-Mimecast-MFC-AGG-ID: QSyFylOaOvWiKZ_Da9SJIA_1774583141
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b0c954ff58so23235985ad.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 20:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774583141; x=1775187941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6IDNNJSbkwMwoD9vi3WobOMRHppiGrGA9NE/2G+0mU=;
 b=MBEwSc5OHCw9/LFJwikVkngLAFtRkElSjyN4F42CGGOfx+PKt8qFKRVRKZjMORoDnG
 u5Kyo9ZkETsGYVnXDAGt7t6rw0MK6dK9w5qYbhnYBL5ZVRN4OytF1HsU82KoGb9cSW/F
 dXt8cwDPrGI02MMZEcOJyi9rnx4lh5R6jdZMqGU0hsyc435OqHfk6LxA3e1gZuOHvQjH
 mzDy3E+GRC3Gv6lLRmFp6TzkcjX0zNGZRe66I4orwsPHs+JgcPxbw760JdSSQ4J8LQ0D
 1L17RFvdrbcW6LCydJCxU4SQRI8+RqbY4IyKLig8LUDjurzgCG65GWKCDUlE8yTbAtPT
 HHLw==
X-Gm-Message-State: AOJu0YyRHbZFJ4ofD87yALQ2kViUc/Sz4VZqvt7s+eVoWV0jC2Fs3YzY
 HzWE/6JisLTgQwwct2LRBJp1zRdpK2ruL5bTFbniOQOxw/VUDAMxB71mY0gvPdd28sFxJPhQE/r
 OwJKJNeFIT+XIm0Hmecb3YQuTQwAjcLzH9mhoww9I5zY45TmWKuNV
X-Gm-Gg: ATEYQzykuBQoj7NiwxvETY83ia+aUKWMRfYIoVHRMIpod5Z8b8BbzqGr30cFt/0RMos
 9yogZJn9bjYuqU9O7JQezjhLIf+qp1pnaX3wFhHEuke8z8p59oH7CQh2z1NMFt3icd6t4HHuY5O
 PwKxPoHu1T2U4emU0rUO9hrjMDfgJnI28o12qhYxezzYuDdl8OAt6M8zDe9UMXHBUJGdd6bc6Bp
 DO22gOCYH9Rb7bpE2KMaq7bxuUM1xet+brWhyxbwwRksLycJBNbo1RAdtT6yslfVCuj/zafs1+7
 9QdkAGPfYA8ggEBVIjYrhBPtckt36E4lKmDKQqNikvdb2MgbU7d+SHFTk7Fv9s4dRwwZ/fIbr8u
 ucCJHaUARDySWRcCZ4A==
X-Received: by 2002:a17:903:40cc:b0:2b0:59fd:bbe5 with SMTP id
 d9443c01a7336-2b0cdc041f0mr11849655ad.4.1774583140944; 
 Thu, 26 Mar 2026 20:45:40 -0700 (PDT)
X-Received: by 2002:a17:903:40cc:b0:2b0:59fd:bbe5 with SMTP id
 d9443c01a7336-2b0cdc041f0mr11849405ad.4.1774583140420; 
 Thu, 26 Mar 2026 20:45:40 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc90c845sm42711475ad.77.2026.03.26.20.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 20:45:39 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:45:37 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acX9Yd23S0gfTJZa@redhat.com>
References: <20260326170435.22566-1-pvorel@suse.cz>
 <20260326170435.22566-4-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260326170435.22566-4-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SmPrwYri2Z2viFH4ey72ETkVQZOiZOTSejGM-IZfdG8_1774583141
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Prefer LTP_DEBUG over -D
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

On Thu, Mar 26, 2026 at 06:04:35PM +0100, Petr Vorel wrote:
> Environment variable has usually higher preference than getopt.
> Also document it.
> 
> Fixes: e434de62b4 ("lib: Extend LTP_ENABLE_DEBUG to support verbosity levels")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

> @@ -825,13 +825,15 @@ static void parse_opts(int argc, char *argv[])
>  			tst_brk(TBROK, "Invalid option");
>  		break;
>  		case 'D':
> -			if (optarg)
> -				context->tdebug = SAFE_STRTOL(optarg, 1, 2);
> -			else
> -				context->tdebug = 1;
> -
> -			if (context->tdebug)
> -				tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
> +			if (!getenv("LTP_DEBUG")) {

My preference is to shorten the code indentation:

  case 'D':
      if (getenv("LTP_DEBUG"))
          break;
  
      context->tdebug = optarg ? SAFE_STRTOL(optarg, 1, 2) : 1;

      if (context->tdebug)
          tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
  break;

> +				if (optarg)
> +					context->tdebug = SAFE_STRTOL(optarg, 1, 2);
> +				else
> +					context->tdebug = 1;
> +
> +				if (context->tdebug)
> +					tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
> +			}
>  		break;
>  		case 'h':
>  			print_help();
> -- 
> 2.53.0
> 

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
