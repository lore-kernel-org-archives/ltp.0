Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F313CC6B19
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 05:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6196C3E2AD4
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 07:01:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E389B3C57DD
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:01:37 +0200 (CEST)
Received: from mta0.migadu.com (out-36.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C6CDB2009E3
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 07:01:35 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=EZBGocd+SZWH2MuRFvvX8MMXgVy5JrHjg4IVMpFRgXA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791954094; v=1; x=1792558894;
 b=eN5sCg9h82tzTg6Xaepvw2pnDB6YJWl4g2M0PtWlf4UZWru9UxERAgoyUm4gva2A8aUAM9e+
 y1PArbaqG3ySbrhmHFNyQEZIxI4AjImtR0Ql/461y/jXmBGhBAHE7zItZGcfFbs7kmhjJ/pf391
 Gpflfxm3+jmP1t0kQ/iSRqdk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 919c7c4f8ddb83e6;
 Wed, 14 Oct 2026 05:01:34 +0000
X-Mizu-Trace-ID: 919c7c4f8ddb83e6
X-Migadu-Flow: FLOW_OUT
Date: Wed, 14 Oct 2026 13:01:12 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <as8MmB6eIyIh3tT2@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it
References: <20261010033622.68927-4-li.wang@linux.dev>
 <iDTNt1jXwFqCtxRdYVwoga28j8OKFAmDRyJ6@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <iDTNt1jXwFqCtxRdYVwoga28j8OKFAmDRyJ6@localhost.localdomain>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

After thinking it over, I'd prefer to leave this patch unchanged:

The test does need root, but not for the reproducer itself -- it needs
root for setup and cleanup:

  - loading vsock_loopback requires CAP_SYS_MODULE;
  - unloading it in cleanup() also requires CAP_SYS_MODULE.

Without .needs_root = 1, a non-root run would skip the automatic
module load in tst_kconfig, bind() would then fail with
EADDRNOTAVAIL and the test would abort with TBROK instead of being
skipped cleanly.

Keeping .needs_root = 1 and dropping privileges to nobody in setup()
is exactly what makes the reproducer run as an ordinary non-root
process while still allowing the modules to be loaded and unloaded.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
