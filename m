Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B205C43458
	for <ltp@archiver.kernel.org>; Sun, 28 Jun 2026 06:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A50353E4BFA
	for <ltp@archiver.kernel.org>; Sun, 28 Jun 2026 08:46:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4FC03C55F3
 for <ltp@lists.linux.it>; Sun, 28 Jun 2026 08:46:35 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 083932005D1
 for <ltp@lists.linux.it>; Sun, 28 Jun 2026 08:46:32 +0200 (CEST)
Date: Sun, 28 Jun 2026 14:46:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782629192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6T+jKxVNPj8HtdmIshnp3RzbENyOCOySitbVzKctHY=;
 b=Vj7IvZ9UMT4+Db13X/b3/7bw0iie+NVGsMGBnBJjZ4Uw2Q2P4RbeAWqjd8oVPg9qu+ms+Y
 ZiAiyuG5+Jlrk6gj2FPTqwqdNgpw++OCiCR/yfiLkKW0eTXlvcteNfKSXnmDM3yvGqyhh2
 Pdt2tN8uMhtGTfhTrQPnvROL04Tyc+w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <akDDQ_eT17mvMOjo@linux.dev>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
 Linux Test Project <ltp@lists.linux.it>,
 Mark Brown <broonie@kernel.org>
References: <20260626-master-v2-1-d1365499b710@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260626-master-v2-1-d1365499b710@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl10: fix the sscanf() call to handle
 64-bit inode on 32-bit arch
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
Cc: Mark Brown <broonie@kernel.org>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 26, 2026 at 02:20:01PM -0400, Jeff Layton via ltp wrote:
> This test started failing recently on arm32, when we switched the
> kernel to displaying the full 64-bit inode number in the maps file.
> Change the testcase to allow for a full 64-bit inode number on all
> arches. The value it's compared to is already 64-bits, so widening
> this field is all that is necessary.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
