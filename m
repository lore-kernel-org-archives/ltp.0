Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A4CCC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 03:43:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883963EB10E
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 05:43:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E76B3E6AA4
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:43:31 +0200 (CEST)
Received: from mta0.migadu.com (out-217.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78F221400B83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:43:29 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=ZuexxopPv5jVBGWlV/W+LifWRexYOIYKdeju2y7fRWE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791949408; v=1; x=1792554208;
 b=EfjMro3JKbRCOvcr5AM7vXFANZbsuyZrwE4Zh/zMQ6Rxb7HHQeeeAOhz1YHYH5hIyZ4jPBE8
 4yJeECzmS3xaR83UrK3mpr6UX4SPuIpz+aNqF2qA9l580VlImJMSu+uARMJ0jQlGhqyB9J9Mco+
 SArJT9B6AAYuFegry2yj8Mhs=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 41dbcb0a08422a58;
 Wed, 14 Oct 2026 03:43:28 +0000
X-Mizu-Trace-ID: 41dbcb0a08422a58
X-Migadu-Flow: FLOW_OUT
Date: Wed, 14 Oct 2026 11:43:21 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <as76WWbV729wXj6k@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it
References: <20261010033622.68927-4-li.wang@linux.dev>
 <iDTNt1jXwFqCtxRdYVwoga28j8OKFAmDRyJ6@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <iDTNt1jXwFqCtxRdYVwoga28j8OKFAmDRyJ6@localhost.localdomain>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tst_kconfig: add module mappings for
 vsock/vsock_loopback
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

On Mon, Oct 12, 2026 at 03:51:32PM +0000, Andrea Cervesato wrote:
> Hi Li,
> 
> > The test needs root only to load the modules; the reproducer runs as
> > an ordinary nonroot process in the initial namespace, which can use
> > loopback VSOCK on nonprivileged ports. Drop privileges to nobody after
> > module loading and regain root in cleanup() so the modules can be
> > unloaded.
> 
> Please drop the root _only_ if we are root, we shouldn'f force the test
> to be root always, even when we are user.

Yes, that's right.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
