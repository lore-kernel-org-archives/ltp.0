Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75878C433F5
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66FF60527
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 18:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A66FF60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2E843C9458
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 20:51:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8778F3C8E0B
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 20:51:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A0581A00915
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 20:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632768681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e9qKCi3TeSZ7u8iFrrHJUmuKpIjXTK7k9xJIvqBA+sw=;
 b=XiiKoi/KEZL5nAR/cbDcbuJTa5Hu17Up7PlAdUaU6c32RajX3PGFi1mNXo+aw1cZMOULQD
 4KNsEQO5tUctzILKEEemLlXD9MAQG22403Tu6yuAqx10Qhk52lnXNabu3oN4RtdqBW7FLg
 j5vp/Hnuv1ulmVdG1SprXLO0tQLlBf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-_SCqgygdN2KWbwHATyj3fA-1; Mon, 27 Sep 2021 14:51:20 -0400
X-MC-Unique: _SCqgygdN2KWbwHATyj3fA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86BBC1084681;
 Mon, 27 Sep 2021 18:51:17 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E2D85D9D3;
 Mon, 27 Sep 2021 18:51:12 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
References: <20210927161955.28494-1-rpalethorpe@suse.com>
Date: Mon, 27 Sep 2021 20:51:11 +0200
In-Reply-To: <20210927161955.28494-1-rpalethorpe@suse.com> (Richard
 Palethorpe's message of "Mon, 27 Sep 2021 17:19:55 +0100")
Message-ID: <875yuletsw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] x86/entry/ia32: Ensure s32 is sign extended to s64
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
Cc: linux-s390@vger.kernel.org, rpalethorpe@richiejp.com,
 Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-api@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

* Richard Palethorpe:

> +#define __SC_COMPAT_CAST(t, a)						\
> +	(__typeof(__builtin_choose_expr(__TYPE_IS_L(t), 0, 0U)))	\
> +	(unsigned int)a

So this casts to int (triggering sign extension) if the type on the
64-bit kernel side is long?  But not in other cases (unsigned long,
pointer)?  Just double-checking.

Thanks,
Florian


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
