Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA0AC433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 16:47:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6BA3C8E67
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 17:47:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BDAF3C3189
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 17:47:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78160601CFE
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 17:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637686060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGWhtGhPtpq/ZiEd6igWpm4/71FIAUKG5LmWLh1yu0w=;
 b=CpYzwHr5GjNeVs7i3GEIY5jgKVOdaEuGfj0IfYbYxOTYEFPpqUx6M1OfcXwR32Wia8NnVn
 /I38TIpHWvZceLwAPIl4XQay+vbNAD+9spK6V8n+dA+DIBg/Lu1NZHaus4HPut2MFJ5rW3
 Mgl8VUA3+xdaUAeccCzIi2QLcHGfogY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-66xCcqg-MdGoCOG_LgKrhA-1; Tue, 23 Nov 2021 11:47:36 -0500
X-MC-Unique: 66xCcqg-MdGoCOG_LgKrhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500BA80668B;
 Tue, 23 Nov 2021 16:47:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B473360C7F;
 Tue, 23 Nov 2021 16:47:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
To: Cyril Hrubis <chrubis@suse.cz>
MIME-Version: 1.0
Content-ID: <1618288.1637686052.1@warthog.procyon.org.uk>
Date: Tue, 23 Nov 2021 16:47:32 +0000
Message-ID: <1618289.1637686052@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, arnd@arndb.de,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:

> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.

Can you guarantee this won't break anything in userspace?  Granted the types
*ought* to be the same size, but anyone who's written code on the basis that
these are "(unsigned) long long int" may suddenly get a bunch of warnings
where they didn't before from the C compiler.  Anyone using C++, say, may find
their code no longer compiles because overloaded function matching no longer
finds a correct match.

Also, whilst your point about PRIu64 and PRId64 modifiers in printf() is a
good one, it doesn't help someone whose compiler doesn't support that (I don't
know if anyone's likely to encounter such these days).  At the moment, I think
a user can assume that %llu will work correctly both on 32-bit and 64-bit on
all arches, but you're definitely breaking that assumption.

David


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
