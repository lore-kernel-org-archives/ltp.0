Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C71606A320
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TZFBywsi
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 326693E9AD1
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 05:56:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAD163E26C4
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 05:56:24 +0100 (CET)
Received: from mta0.migadu.com (out-169.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::a9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AD14600067
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 05:56:23 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=jju6/zoBjCAQzWEUQqLbq8Z0mePGNeIApBT1PdmuGkQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793076983; v=1; x=1793681783;
 b=TZFBywsiO70wrcP2TlLaBfEHCCIyauxia9wJNSif0dFS0TYqGT83vevnTD4j10qjyyMGGqMg
 +lsqBzSpHRz1/E2Bcqf0eDrKUtfhmF1M7dVE08Jh+klQfJmYxKOS9i6kO4QaqiWhCP65gQHMdiQ
 ebaCAEnW2DNIEId4JVI71ilE=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 09833c5367a263d8;
 Tue, 27 Oct 2026 04:56:23 +0000
X-Mizu-Trace-ID: 09833c5367a263d8
X-Migadu-Flow: FLOW_OUT
Date: Tue, 27 Oct 2026 12:56:18 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@linux.dev>
Message-ID: <auAuxMRJrylrGqCP@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, ltp@lists.linux.it
References: <20261026-acer_maintainers-v2-1-4cf0f350fdf1@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261026-acer_maintainers-v2-1-4cf0f350fdf1@linux.dev>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] MAINTAINERS: Update Andrea Cervesato's email
 for LTP
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 26, 2026 at 11:47:17AM +0100, Andrea Cervesato wrote:
> I'm not working for SUSE anymore and I will use linux.dev email to
> develop and maintain Linux Test Project. Also update .mailmap.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@linux.dev>

Reviewed-by: Li Wang (Hieco) <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
