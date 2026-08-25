Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C7C5DF94
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 07:42:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63B843D0FB7
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 09:42:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5BD3CC02A
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:42:08 +0200 (CEST)
Received: from mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F7F110009A5
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 09:42:06 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=4XWfprlniAU/G8NmiAKdndxjR6ZaBa3i5u8wBEmMk64=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787643726; v=1; x=1788248526;
 b=ECa9qw6IW7ApXY2BqLTwhX9nPszButl62W7LiqD0YnzROM5TXK3oYCX7/7CaPfUu9ZBz14Ry
 CyoA3okjWqrt2ZIvZRGMzrLjFBwofoXhr/fYnzTPXcLnYxZ0lYU6QLbwA3UdEgpsvYKoa2/Clki
 DTrugTGOCIQ0BW4wItysstmg=
X-Envelope-To: ltp@lists.linux.it
Received: from localhost (60.247.5.98)
 by smtp.migadu.com with ESMTPS id f047b1678fd86a51;
 Tue, 25 Aug 2026 07:42:06 +0000
X-Mizu-Trace-ID: f047b1678fd86a51
X-Migadu-Flow: FLOW_OUT
Date: Tue, 25 Aug 2026 15:41:55 +0800
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ao1HQ7xA5KCuNoWg@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 00/31] Add sysfs sanity tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis wrote:

> This is a first bach of the sysfs sanity tests I've been working on
> recently.
> 
> The main goal of these tests is to make sure that these files contains
> expected data, e.g. files that are supposes to be boolean are 0 or 1,
> numeric files contain numbers, etc.
> 
> I've tried to make the code of the tests as clear as possible. Hence the
> first addition in this patchset is a library that implements common
> assertions for sysfs files to be done in a single line of a code.
> 
> Majority of these tests are just reading the files and checking that the
> content is sane. The exceptions are loop device, veth, tap tests that
> cerate virtual devices, which attributes can be changed freely.
> 
> v2:
> 
> Fixed all problems pointed out by Li and real problems by the LTP reviewer.

Generally looks good. I did a quick review - didn't dig into the details,
but the test results look solid. :)

Reviewed-by: Li Wang <li.wang@linux.dev>
Tested-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
