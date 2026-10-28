Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20755606A31A
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OfbPBzuQ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4542A3E998E
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 10:10:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AFAE3E1F41
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 10:10:29 +0100 (CET)
Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1224600864
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 10:10:28 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=6obZcCP10I/AYzX3BBKkxEEEAA6EncbdHfHES0veaho=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793178627; v=1; x=1793783427;
 b=OfbPBzuQPtZ1LhEZcN4B0a35rFz7gXfwX5YXkfNIAUj43/QQZMZXdQuGmR/8fMFABAnyXz1t
 GutoSdbWBOYf7BIad3FXAHWslBVaID+dgIjNSuZVCAGmR31UtEcbBNrd63BlL1ANru/YCp6vahP
 SGncG4VA/iq8rsUM6V0CESKQ=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 2c0a0c7fe0a87ff4;
 Wed, 28 Oct 2026 09:10:26 +0000
X-Mizu-Trace-ID: 2c0a0c7fe0a87ff4
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 17:10:19 +0800
From: Li Wang <li.wang@linux.dev>
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Message-ID: <auG7-z7S1xXfUpRB@linux.dev>
Mail-Followup-To: Huaisheng Ye <yehuaisheng@open-hieco.net>,
 chrubis@suse.cz, pvorel@suse.cz, ltp@lists.linux.it
References: <20261026070732.74314-1-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261026070732.74314-1-yehuaisheng@open-hieco.net>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/3] hugemmap10: Account for memory policy in
 counter checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

Patchset merged, thanks for your work!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
