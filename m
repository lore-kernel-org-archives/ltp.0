Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90E1C25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717153268; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=p/fPKUMZLYMj5YjrK4ldm5P/KNtEa77VP/AeatLCeL0=;
 b=HcROI3emgpvP2CPsQyRG73Tx93APQx46illT+KNt8V9WndqSbXwtlPT3vAjL0NiU1GjQR
 9qvx8aikOKR/lWfj/xwBHx+qz9+scCJXXbFESINj7AYlTmLKvntEHEKxTYrHmntvpoXO0NZ
 T3OGdbfhmJ/V5YkYoVjb8EdoMXpiH4k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 113713D0771
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 13:01:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 711C13CBBBE
 for <ltp@lists.linux.it>; Fri, 31 May 2024 13:00:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 577F6605649
 for <ltp@lists.linux.it>; Fri, 31 May 2024 13:00:45 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a635a74e031so244888066b.0
 for <ltp@lists.linux.it>; Fri, 31 May 2024 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717153245; x=1717758045; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FiVM0ygPuaw1bl9s+lUoM7AxGljwuUsEzSVex2cCjao=;
 b=FXG1v6MpNtZ737Rh9dkJ6WbBzVY+RjXYq9YDsXwyEAHN6FEuATz7x/1w3tXXchug2y
 GyqFjUUwGw3n1+I24kCEtkaUyfMAFbDR4hyuZABcw8L9bXVQ4YgUX5FuapHgbmGZw5y5
 Np+mO0hHpG3F+CLosdYkPpenX0h3DJh79bIfmdPKVtS05RwLjjUpQZfn5k0IvkXgUj4Q
 wDXCaYEHf9iTyw36WNHE54K6472ENx477d+JznZ1oSrchUYK9GJRIF5frsrs8FhAYzmW
 2bsmOt2kEL1oExxzg2Pje4oFh9C916xEbnbrwcDZORb5Tln1yM3bkJq2+lmb04yOAp44
 tEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153245; x=1717758045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FiVM0ygPuaw1bl9s+lUoM7AxGljwuUsEzSVex2cCjao=;
 b=Ci0VRd7IsBZ9hJhjui6TzPmyVaWgIelFk45z48MVcg1KZ/9oPSfgdZqu8lVESBG2DJ
 xdMVt7ca2e5BdOvF5aWF3mntYLJcUVGjXLhvDDLlzoQJfeB82VxxepVN9fO4OtNYyLYE
 CCv0OigjGv6MKiAPeTK6ksMtaAAO3m49Xa6YpMAf4RLRElCW9i5Ohj0m6tt2Ykil88d0
 y+6iGMzjlmognNhnhgmwNtuXAs/ypIKn5hU4/3YQyCI4iRUCZoP+A0yhPUM4qYYf3ZQq
 fwnBv41CrYV6XJaeRfDDjPsF+K3Rd5ZBDJEXpdandtCaYGqgQ6St54+U8PTHHyVWWh/v
 dr1A==
X-Gm-Message-State: AOJu0Ywq4UhMSOtgUU7rvqTM1eH8nuL0kFXRPHE1+acgNfYuU70bJ9bc
 DZi03LDo+DLgvx0d9mSg+xsmhre6Zz+154G+pBXLJQYrOM0kQCwLx6t4bNfCBo577+yEOsbgUmd
 pidg=
X-Google-Smtp-Source: AGHT+IHD6aEVqh5zceIid68fhxJRFOG4VIxC+VfGtpgUqXayJWh9qVNmTrod3pBpjObzg6IBXVF/pw==
X-Received: by 2002:a17:907:9708:b0:a62:ddc2:8493 with SMTP id
 a640c23a62f3a-a682022f5cbmr174955966b.20.1717153244687; 
 Fri, 31 May 2024 04:00:44 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.46.100])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67e6f03728sm74510066b.20.2024.05.31.04.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 04:00:43 -0700 (PDT)
Message-ID: <2ebf350b-7fad-45cc-831e-03fd836d8048@suse.com>
Date: Fri, 31 May 2024 13:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-2-fa96f07d0fca@suse.com> <ZlhZ0Na1LtFVPvNi@yuki>
Content-Language: en-US
In-Reply-To: <ZlhZ0Na1LtFVPvNi@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Add ioctl_ficlone02 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for review. I will send a v2 just to add FICLONERANGE as well, 
otherwise
we need an another identical test for that feature as well.

I will do the same for ioctl_ficlone03 as well.

Andrea

On 5/30/24 12:49, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
