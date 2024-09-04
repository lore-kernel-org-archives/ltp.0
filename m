Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B553FCA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725432630; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YZvjN7I+Rqx2eYxRvTXyG7kATMDN8WGQ7wtmVh7XSaY=;
 b=HqXERMujNRu47EH90gYgglYt/lQ1V+l/lyY5ZunoB+KgbciutgbOKWco4xiRPMd+Lr0V+
 ei3CtrBKEepElnUwEIloAkohf03VTPRZwMOIauIEeXHYvPVFy+9PPl9aCStwEiVLhNWSWbD
 nBojzMcv4sCNo7pLOpNDyqpKYXwb5Kk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18A183C182E
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 08:50:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D04433C0CCD
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 08:50:07 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 609DB61020F
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 08:50:07 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a86c476f679so740718066b.1
 for <ltp@lists.linux.it>; Tue, 03 Sep 2024 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725432607; x=1726037407; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FvmZimQ1y3CzchqpIvDMWYfhhr4M9vynJm+Wj/dAOas=;
 b=b33rt3hWLSV0/+YvnnDLgFgHY74WaDJT+pprEZ4DHdzXP41qMJMffwaLGMiWRsdtVO
 7r96TeA5yhlopRAdfGoo6LQnXc6/gjHqbXO2LFSUS8SqQKlW25sylhVjIN361WVWsS19
 7keJC+Exk24f4lcTbrJt3byMhlHvkETeFMuJxaL4GOPXdA/jnK0Zv11PFFID1lTHwnVi
 Fhx2uLoRJVYaKCG0mxoaEJJkUMtUs08vhWGBCHvDwCAfA+kr21VQOqW3qUpGHYhmWKEb
 B617xIbqwodacemRCPN1yI3plt0XzTkkQeJBe8yQEKSUhU54X+Sr0mfWmL7uBpcUqokN
 QcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725432607; x=1726037407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvmZimQ1y3CzchqpIvDMWYfhhr4M9vynJm+Wj/dAOas=;
 b=HMtmCs9DLx1iYGtiB+SrXp+JkH3fiKNHTBcX+IjobFAK0RZQEqiB0ie4GuTRJl/BaQ
 7y7c0KJ9/j7EQCLcS8pQu4ofs4yuxLyarO4QR36Hma51mQJL+X79KlPcCnQzVRIRTE0n
 LV8aVKwRKwf5prDlNx752sIaTxtULbUAkSSZeyLEu3gQgS+E1JimCyCDqqKdmXoZxo1K
 5ZteUbaS19+xvobJnlB5bZvlaMDPKQS8eFbrYXaCxAuBhaUc38DslpbPCJ9HC2YCgrKT
 4Uk+0VMRLIYcDcun31UddRt7EctQDu5u7R3OCwgJhDIl349dH0Q5B7V9VZ2WW8zEv3eA
 bjTA==
X-Gm-Message-State: AOJu0Ywd56wgMjvkLiMRhmRwm3ponQowb46sR9YWGu3HaWHRQ+nYPSbV
 Kt3BO6lnYE242n98IQp2uSwH08U1kHPthM1AOoqd3OJ5o34/ppnpSdzzCUidG6tM1AKD0wTKJvs
 =
X-Google-Smtp-Source: AGHT+IEDdEGQrDppRn1giAtZZvqnsDjcZLPrES4FeuKo2T2gBQFkYq15KR5YmmIjzvs65JbYdr/ggA==
X-Received: by 2002:a17:907:2da6:b0:a86:851e:3a23 with SMTP id
 a640c23a62f3a-a89b94c809dmr1003551866b.27.1725432606512; 
 Tue, 03 Sep 2024 23:50:06 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89891d8345sm780806266b.173.2024.09.03.23.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 23:50:06 -0700 (PDT)
Date: Wed, 4 Sep 2024 02:50:01 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZtgDGaiUhNiBb3pL@wegao>
References: <20240903081916.27033-1-wegao@suse.com>
 <20240904035808.5891-1-wegao@suse.com>
 <20240904044710.GA834275@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240904044710.GA834275@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mpls01.sh: Add --allow-unsupported for modprobe
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 04, 2024 at 06:47:10AM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> I suggest these changes:
> 
> 1) use mpls_setup_driver also in mpls_setup()
> - replace tst_net_run(). I don't understand why you did not do it in the
>   patchset (I suggested that), but I can replace it during merge.
Sorry i forget that, will sent another patch. Thanks for point that.
> 2) update the commit message: s/mpls01.sh/mpls01/
>    (fixing all mpls tests)
> 
> With that:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> +++ testcases/network/mpls/mpls_lib.sh
> @@ -47,7 +47,7 @@ mpls_setup()
>  {
>  	local label="$1"
>  
> -	tst_net_run -s "modprobe -a $TST_NEEDS_DRIVERS"
> +	mpls_setup_driver
>  
>  	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
>  	tst_set_sysctl net.mpls.conf.lo.input 1 safe

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
