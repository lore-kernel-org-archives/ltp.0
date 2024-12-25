Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488DE7718B
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 11:57:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CFD43E5593
	for <ltp@archiver.kernel.org>; Wed, 25 Dec 2024 12:57:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E0B73DA818
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:56:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38DFA206C55
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 12:56:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735127808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ekyeE/ODFICy8m61DT6TyLOECgT84W9yQAg7HqnfKeA=;
 b=PGzgj+U/jqYIHMX5FlKSDko/6bLfokfDXmkuCMaBfEJYQ40l0G81yg8nECNiCuSrNdjPlb
 H0jmlnOnrFAOeZecpgylooHBjODHJJSvcBw5JfJUIIOxnd4BHj6XwLJP94h6d8+ARdaQeF
 4ZJVAZwS7Ya8rhdfh0Hh8d06LQqPngc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-OUOcqX9GMI-5z60Cvv_afw-1; Wed, 25 Dec 2024 06:56:47 -0500
X-MC-Unique: OUOcqX9GMI-5z60Cvv_afw-1
X-Mimecast-MFC-AGG-ID: OUOcqX9GMI-5z60Cvv_afw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso6781316a91.3
 for <ltp@lists.linux.it>; Wed, 25 Dec 2024 03:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735127806; x=1735732606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ekyeE/ODFICy8m61DT6TyLOECgT84W9yQAg7HqnfKeA=;
 b=HEHK/JWKy0s8uG7hANzJtCpfvd2w4jqGRtXWpyHLcLXJnlw3Zqq2s2enJYuniJRdI1
 TCT4aqazI7YLAw7tSbktZRVE+54wq09tSZLnha/DiGwRcuVJ0K98hb+NjvRvACbfSAdj
 KK0tbVlyhAJUhW1y6nL85D6138TPbobSC/iDinX4vsuWafxRn/csSAOzJ6tlNU5AsptX
 Zy6KkWqbCIhfV8CkdmWqrV74m87otuKwusOpU7qPwby3dNALO2lWRaas7HiOmLxVOhhZ
 L1Z7WMNXiZ9+P1Z11sq3uCvYkHiot0/Gwu/1FprFkzcNMEOL+/1r+iF/nqVnka81V6hs
 JQcw==
X-Gm-Message-State: AOJu0Yz3jLg4o+HFsgb3cLAGo9u/Ou7/s57/N3jhIAMteNrojVIDdogv
 xcqao/ptKDAHWOyjjgmWWWru32gCTeycIPAipcP1ChSVbrjXL3o1ZMQgvvAclqX6TUof/o7jfic
 I5TXUP7yArZUrzIB5fnRy6bCWJPfRzkrZ0lsn/m1bZqNAq7ZSaZcvDmMN2V+Dro37E3uA7OhukV
 QD2fyMu/7yeerQDMmtO6JrnjY=
X-Gm-Gg: ASbGnctPsQiesISjIty1X0K46AP4OzyHQDR66zNc4wfv7ecD7V3pCsa5YUGNHFUWs+T
 0g+gbMsQNbkIbmiMoUtz/Yi5J/H6wrKkLAbt/Clk=
X-Received: by 2002:a17:90a:d88c:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f452eed6cemr26706455a91.32.1735127806105; 
 Wed, 25 Dec 2024 03:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl1DrhGPKsb3gdN3kEsKZnfnv9GM8v/7XMu9qSrTIPeZMGQ3CEY5yxcegOlYgxZXTlk+sRr1AT7aA8z6vJczA=
X-Received: by 2002:a17:90a:d88c:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f452eed6cemr26706442a91.32.1735127805875; Wed, 25 Dec 2024
 03:56:45 -0800 (PST)
MIME-Version: 1.0
References: <31564d54-4fea-4450-997d-45e14c4957f4.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
 <CAEemH2cFissakwU4N7s+XPLrWvZu4Do5nsEZ8aFohP7zA-TVyg@mail.gmail.com>
In-Reply-To: <CAEemH2cFissakwU4N7s+XPLrWvZu4Do5nsEZ8aFohP7zA-TVyg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Dec 2024 19:56:34 +0800
Message-ID: <CAEemH2f5fm76Z4mPJArQu4MWGT618tswKEwHfxsSjqYf8UGDhw@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dld9hTqX6W2hTvJKJ5407sf9BvL82n9pg6nTXNaMxZs_1735127806
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it,
 Richard Palethorpe <richard.palethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

There is another problem in that tst_cgroup lib that
the definition can lead to -1 during the | operation.

Because If the field is uninitialized (contains garbage),
it could hold 0b1, which is interpreted as -1 in signed arithmetic.

At least we need separate fix:

--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -44,7 +44,7 @@ struct cgroup_dir {
         */
        int dir_fd;

-       int we_created_it:1;
+       unsigned int we_created_it:1;
 };

 /* The root of a CGroup hierarchy/tree */
@@ -71,12 +71,12 @@ struct cgroup_root {
        /* CGroup for current test. Which may have children. */
        struct cgroup_dir test_dir;

-       int nsdelegate:1;
-       int memory_recursiveprot:1;
+       unsigned int nsdelegate:1;
+       unsigned int memory_recursiveprot:1;

-       int we_mounted_it:1;
+       unsigned int we_mounted_it:1;
        /* cpuset is in compatability mode */
-       int no_cpuset_prefix:1;
+       unsigned int no_cpuset_prefix:1;
 };


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
