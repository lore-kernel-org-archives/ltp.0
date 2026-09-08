Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9402AC79F99
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 06:20:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F04B03E2FB2
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 08:20:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFCCD3E1895
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:20:36 +0200 (CEST)
Received: from mta0.migadu.com (out-186.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ba])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4911210009DE
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 08:20:35 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=A5cwG9Y/qzzlXw331y1MSp+CYUBNGaTHCec1ZksBB0Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788848435; v=1; x=1789453235;
 b=ZDoK7Ax4Is6d6/2YqLcuFrAYgcNXhAC4mg3cdOYAWr14WvqgW4yXfiw0hy5uOITaT0sVs2Wx
 5NuxF1FydiCdImXChAaP8ZLuII29pLJ7zhRrMRn4IZ7sEje51HC3cq6l6+dpEwA1vd9zFHPbSaX
 Eb7xWZh860MjkaxFwKB2mJog=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id ab8ced1bd51ca820;
 Tue, 08 Sep 2026 06:20:35 +0000
X-Mizu-Trace-ID: ab8ced1bd51ca820
X-Migadu-Flow: FLOW_OUT
Date: Tue, 8 Sep 2026 14:20:29 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ap-pLeAK6NONYbgh@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260904-coredump-v7-0-a32b7ca1acea@suse.com>
 <20260904-coredump-v7-2-a32b7ca1acea@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-coredump-v7-2-a32b7ca1acea@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
