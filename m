Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A00C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:58:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3CA3C9423
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 12:58:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D91D3C93D9
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:58:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C9507200051
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 12:58:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655809116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hy6KOcY0sRAojRWcsjR0aWULa6jJaSKcS71iuLiH50w=;
 b=PNkwbpVQ+QLpflGF78SW1uNx+JBLefmxla6VcjUjWmnGBqh6Jn/1QBmDhrPTxLBwRYuGZN
 uvnQZrq0710fnQ4Cb9DUy36Vx+JHwTsphx6DJ6b1Hy9fZLuDzcNzYVUVUvkwfRjQs8fCPj
 wMkFLrXJi0qiURpNMk8ERLRGbOwMzG8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-WzjmQB9zNRa7eiyrfXXRvQ-1; Tue, 21 Jun 2022 06:58:27 -0400
X-MC-Unique: WzjmQB9zNRa7eiyrfXXRvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8F69299E773;
 Tue, 21 Jun 2022 10:58:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F239C2166B26;
 Tue, 21 Jun 2022 10:58:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Cyril Hrubis <metan@ucw.cz>
References: <20220621090951.29911-1-metan@ucw.cz>
Date: Tue, 21 Jun 2022 12:58:23 +0200
In-Reply-To: <20220621090951.29911-1-metan@ucw.cz> (Cyril Hrubis's message of
 "Tue, 21 Jun 2022 11:09:51 +0200")
Message-ID: <877d5a1dww.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] uapi: Make __{u, s}64 match {u,
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
 David.Laight@aculab.com, zack@owlfolio.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* Cyril Hrubis:

> From: Cyril Hrubis <chrubis@suse.cz>
>
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
>
> This allows us to use the kernel structure definitions in userspace.
>
> For example we can use PRIu64 and PRId64 modifiers in printf() to print
> structure membere. Morever with this there would be no need to redefine
> these structures in an libc implementations as it is done now.
>
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
>
> 	printf("%" PRIu64 "\n", stx.stx_size);
>
> We get:
>
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Could you add some motivation for the C++ condition to the commit
message?

Thanks,
Florian


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
