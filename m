Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D24CE7AFB
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 10:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A83D23C2615
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 12:12:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 339393C0352
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:12:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=91.218.175.179;
 helo=out-179.mta0.migadu.com; envelope-from=kent.overstreet@linux.dev;
 receiver=lists.linux.it)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0175D26B448
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:12:26 +0200 (CEST)
Date: Fri, 6 Sep 2024 06:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1725617544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zNuPmzz4xYBPuROeNW2jBZZ/AakkUGXSmJQVuDxnntA=;
 b=GdzHCf4d6L0pJI/sy5DvI/t9jeFYSLGLnI7qc/P6og3S1hCOAZ1H1OPtcgpUb+PHlmzXZ/
 9COnbjtTTE9RIcBJ7EI7/gkPnfFxYFjJ/U/wHNN2UPpl60xMKd1J6lQ1EO9XBpYaIqzFzQ
 yzsyKKAmuQ13RA+yLH1M6vONdkqWyl8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <gmjff4tugu3ccio35isd4jfdbvxmriepvd3z2vxruzw46zcpha@7mk7g3awjgw5>
References: <20240905134502.33759-1-mdoucha@suse.cz>
 <20240905134502.33759-2-mdoucha@suse.cz>
 <20240906080200.GA985598@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240906080200.GA985598@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fallocate05: Deallocate whole file on bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Sep 06, 2024 at 10:02:00AM GMT, Petr Vorel wrote:
> Hi Martin, all,
> 
> [ Cc Kent and Bcachefs ML ]
> 
> > The default deallocation size is likely too small for bcachefs
> > to actually release the blocks. Since it is also a copy-on-write
> > filesystem, deallocated the whole file like on Btrfs.
> 
> Make sense.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

I haven't looked at this specific test, but one thing that we run into
with the weird CoW behaviour tests in xfstests is that bcachefs btree
nodes are 256k by default - you're going to see weird effects from that
if tests are looking at disk usage.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
