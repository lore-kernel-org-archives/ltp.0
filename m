Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB716CC6B1D
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 02:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775181810; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aUOX5FaGutSyBsFjOk26M6rLF8bPpOrUZ6JD8ILwiqY=;
 b=Jv0fSnY/Ju1ITvq6Q5iYKxdDupYyzmYsGvDPyF90U1uNuELgd7vIMBtkaIxinKzkHzozN
 isEIjw2aBpVV8Ns/VeA0R+/AfckI3qZWPeKrzW6biQHWULrn3LbemUpfiM4i1XEFqdg4wf9
 sx200oPDKQ1E/DGIwVQz0Sq9Mq+irGo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6388D3E5493
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 04:03:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A91CA3DB86E
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 04:03:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2DD9601B16
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 04:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775181783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Oi8ln4DQfKeap92igexZ2oJPlX0jbv19gwdh4VXwss=;
 b=dU5RsAwPW1AvYSATfND51hrh2YlMsGN2r+UY8uc01787HwqiS8b/xjVIHC3SKnJPl8Z7Ij
 4n9706bZD4m1GJI6zxvZ1nB+v3VXpiQThwy6pUhfzBCiU/w4sPjiRE07DVhC5FD67ZJtxu
 +EVfEzZIMthMt9+QC31tyvBCF84BD7s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-j1OsGSF8PO6SZXlXaiR_hw-1; Thu, 02 Apr 2026 22:03:01 -0400
X-MC-Unique: j1OsGSF8PO6SZXlXaiR_hw-1
X-Mimecast-MFC-AGG-ID: j1OsGSF8PO6SZXlXaiR_hw_1775181781
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so3215676a91.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 19:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775181781; x=1775786581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Oi8ln4DQfKeap92igexZ2oJPlX0jbv19gwdh4VXwss=;
 b=Fqe4o4o61sR3ECovo9Qt3F0gZJSlQdlftsXiV1uhwQ7qEq9R7kj0IX1oNgSLp/fKsZ
 EsBbwh9Zcwl2uE48Mi/3E6Zt3PH4+bMuCYNi2FhJ07i0KC0F2U4PuahS2ify0kFR+7Du
 1LOfE19BsX9hwUPwiM2D+iVGvW1pM9mt2fW7zk/Q+oyFXQw/ETm1DdlOggzqcfeOIivR
 sGf8N/0QKbf691fX27JjiMOhg3fdA7UZBUPJNTQrGz1hfjV8bGpqbaUfv0qmn9D07jQ/
 y9tbV++dSQzQbqWL8IOPVm2hNjQ9cZp/DZg7OHL+/8yC1SCRnx/o0cmsTzmm+bFvI6Pw
 RFMQ==
X-Gm-Message-State: AOJu0YxLfeLBMWRg6BmkVKYLsdzOg7zIm+Ej/WU0JBxLbZ7EnelR3JWt
 8N7vSzGnALdeJFlIr8H0OKTTMk8sgo0/2suGavnrGB4rpgAKyKgPGdUZwokAwCZ5l7pl6AZcnDI
 u0EI6GqsU4t7ApVlQPhmF9WIriDzz5tBTkzsZ+w7GYQI6uHB00EzN
X-Gm-Gg: AeBDietYbRHBDPHT+3h3gor5bq0c2AW0od/di1O4mWCFHQ8dBFvMtS50EoONPJ7FmmK
 IzCRosZW2fR1oFwVuvgyGv95anUSqVhY8UB3kFfnlKjHQGcYMpG/fRzU6Qg0sgMdrgAQmhkCTtD
 9Eqd7h9EGBn+4H9Ht2NKxOeMxzI4X9O6K0TqkjX71ksPXdsnF9wjQDvJY8lR5P5L9sfnx4T21Y0
 HwVMIEwZPw29Qo4JZo+N2Rb7scO4HAAqTUA+bJk9fVsVMfWfs3uVPwxyfcW8C7M7tZr6fMT7WuW
 1LqamZJjaVCtHzjznE3py227f3O69HO3/HTNVeVIpyPts/bOlBrDzqclOvMPsdPrRCtBtDfj29q
 +ljsYCMZWbPSH+Hjgtg==
X-Received: by 2002:a17:90b:5292:b0:35c:f82:fef2 with SMTP id
 98e67ed59e1d1-35de68ce974mr992508a91.14.1775181780754; 
 Thu, 02 Apr 2026 19:03:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5292:b0:35c:f82:fef2 with SMTP id
 98e67ed59e1d1-35de68ce974mr992483a91.14.1775181780256; 
 Thu, 02 Apr 2026 19:03:00 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm4041961a91.0.2026.04.02.19.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 19:02:59 -0700 (PDT)
Date: Fri, 3 Apr 2026 10:02:56 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ac8f0MPErGdZzDNe@redhat.com>
References: <20260402200431.157875-1-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260402200431.157875-1-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SKOtimg5JJBkGmXgksFnouCQ927aeYazw4-BgA54S9E_1775181781
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Remove s390x test
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
Cc: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Elif Aslan <elas@linux.vnet.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 02, 2026 at 10:04:31PM +0200, Petr Vorel wrote:
> vmcp_m.sh is a pure user space test (out of LTP scope). While test
> claims testing vmcp tool and module IMHO it's mainly testing vmcp basic
> usage (-h, -v), exit codes on error. The only real use is 'vmcp q dasd'.
> 
> s390-tools maintainers confirmed they have internal CI and are working
> on to be part of s390-tools on GitHub [1]. Another reason to remove.
> 
> Remove also runtest/s390x_tests, which contained only this test.

Agreed.
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
