Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A27C433F5
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 15:02:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 353213C903C
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 16:02:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B383C7047
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 16:02:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DDE57140163B
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 16:02:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638457323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/3xlIYEWyvboPKd2VFHttveDDWJjCPblrUV213W3J78=;
 b=fA6IBDxH7ZpNmAlzgD3GTMqRfIzVlDRKnUqOsoJUFO4/1ta3/5eMCYP7+luLVRQxPmiM/e
 ZNwEfXsN3ouhmjjyFRZO9+3dX0+TRmG2Ys1w3iNIPv876lVAT2te24WO+OljmR5sC/dydE
 EYSWT0Zb/W2FfjmraYHTDV7AQg5kXKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-Z6f8F3GTO3ux06V1OWFmmg-1; Thu, 02 Dec 2021 10:01:58 -0500
X-MC-Unique: Z6f8F3GTO3ux06V1OWFmmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D97294EE3;
 Thu,  2 Dec 2021 15:01:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 256E85F4ED;
 Thu,  2 Dec 2021 15:01:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
To: "Zack Weinberg" <zack@owlfolio.org>
MIME-Version: 1.0
Content-ID: <913508.1638457313.1@warthog.procyon.org.uk>
Date: Thu, 02 Dec 2021 15:01:53 +0000
Message-ID: <913509.1638457313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dhowells@redhat.com, David
 Laight <David.Laight@aculab.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Zack Weinberg <zack@owlfolio.org> wrote:

> I could be persuaded otherwise with an example of a program for which
> changing __s64 from 'long long' to 'long' would break *binary* backward
> compatibility, or similarly for __u64.

C++ could break.

David


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
