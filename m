Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0A4C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 09:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D8B23D393D
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 11:40:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10FE23D3920
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 11:40:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6345E1000997
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 11:40:24 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C712C60F3E;
 Tue,  9 Jul 2024 09:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3933C32786;
 Tue,  9 Jul 2024 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1720518022;
 bh=zDQMeE37biW7ERmyjD/Ec9NvHO+hvzgb1NmDdJv4Pic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B7Jhoz0bHAUt5hHwJtGldKeFjGjaOfySM/ZjXWWGO1FoZ0/IbAlAxbAptHEMDoBqM
 7DNHn//Nl7rJjGue9y/sRNTFc8f+jXuOjuCNBz5KewiY0JO0GTyCgjiNsk3OAb3Z0f
 tXGu1Bfjy3rKly/jK5SbR7Q1/g8ea9Vi/6dh1ffU=
Date: Tue, 9 Jul 2024 11:40:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naveen N Rao <naveen@kernel.org>
Message-ID: <2024070958-plant-prozac-6a33@gregkh>
References: <20240705203413.wbv2nw3747vjeibk@altlinux.org>
 <cf736c5e37489e7dc7ffd67b9de2ab47@matoro.tk>
 <2024070904-cod-bobcat-a0d0@gregkh>
 <1720516964.n61e0dnv80.naveen@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1720516964.n61e0dnv80.naveen@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] WARNING&Oops in v6.6.37 on ppc64lea - Trying to vfree()
 bad address (00000000453be747)
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
Cc: matoro <matoro_mailinglist_kernel@matoro.tk>, stable@vger.kernel.org,
 Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 09, 2024 at 03:02:13PM +0530, Naveen N Rao wrote:
> Greg Kroah-Hartman wrote:
> > On Mon, Jul 08, 2024 at 11:16:48PM -0400, matoro wrote:
> > > On 2024-07-05 16:34, Vitaly Chikunov wrote:
> > > > Hi,
> > > > > There is new WARNING and Oops on ppc64le in v6.6.37 when running
> > > LTP tests:
> > > > bpf_prog01, bpf_prog02, bpf_prog04, bpf_prog05, prctl04. Logs excerpt
> > > > below. I
> > > > see there is 1 commit in v6.6.36..v6.6.37 with call to
> > > > bpf_jit_binary_pack_finalize, backported from 5 patch mainline patchset:
> > > > >   f99feda5684a powerpc/bpf: use
> > > bpf_jit_binary_pack_[alloc|finalize|free]
> > > >
> 
> <snip>
> 
> > > > > And so on. Temporary build/test log is at
> > > > https://git.altlinux.org/tasks/352218/build/100/ppc64le/log
> > > > > Other stable/longterm branches or other architectures does not
> > > exhibit this.
> > > > > Thanks,
> > > 
> > > Hi all - this just took down a production server for me, on POWER9 bare
> > > metal.  Not running tests, just booting normally, before services even came
> > > up.  Had to perform manual restoration, reverting to 6.6.36 worked.  Also
> > > running 64k kernel, unsure if it's better on 4k kernel.
> > > 
> > > In case it's helpful, here's the log from my boot:
> > > https://dpaste.org/Gyxxg/raw
> > 
> > Ok, this isn't good, something went wrong with my backports here.  Let
> > me go revert them all and push out a new 6.6.y release right away.
> 
> I think the problem is that the series adding support for bpf prog_pack was
> partially backported. In particular, the below patches are missing from
> stable v6.6:
> 465cabc97b42 powerpc/code-patching: introduce patch_instructions()
> 033ffaf0af1f powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
> 6efc1675acb8 powerpc/bpf: implement bpf_arch_text_copy
> 
> It should be sufficient to revert commit f99feda5684a (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) to allow the above to apply
> cleanly, followed by cherry picking commit 90d862f370b6 (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) from upstream.
> 
> Alternately, commit f99feda5684a (powerpc/bpf: use
> bpf_jit_binary_pack_[alloc|finalize|free]) can be reverted.

I'm dropping them all now, if you want to submit a working series for
this, I'll be glad to queue them all up.

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
