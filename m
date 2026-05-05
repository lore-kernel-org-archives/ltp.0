Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BEBFF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 07:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C58FE3E289F
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 09:13:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02943E1F50
 for <ltp@lists.linux.it>; Tue,  5 May 2026 09:13:39 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5386600920
 for <ltp@lists.linux.it>; Tue,  5 May 2026 09:13:38 +0200 (CEST)
Date: Tue, 5 May 2026 15:13:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777965217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xgOY1iGdLsUmu+l+QDuRaLaABYOobLdJXKUgCRy8ebs=;
 b=ag6EPUXlLYjuKCiuLhaK84V7WM0EPiQ54G7oDFUSo2oK875eid0hmxIaH1zVmqLjj6lid6
 EwMj9x722GVjER1fk7ikNque4r6NUbIdp1vPBRIGO3VN/dxkVblQIG3YRWL/0nG/5kLaIP
 NySvqVBB7KcmC9ptBLhxG7A09AXToUs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <afmYkFKQiCCOJKAv@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260501135100.42278-1-li.wang@linux.dev>
 <20260504133020.14129-1-li.wang@linux.dev>
 <afi3Ml5vFv2irnc0@yuki.lan> <aflePEoKwEB_oad6@linux.dev>
 <afmVo02vLqLWlwcr@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afmVo02vLqLWlwcr@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Introduce tst_path.h to consolidate
 system paths
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

> > Which version (v3-A or v3-B) do you think is better?
> > Or any other suggestion?
> 
> I vote for v3-A, it's simpler and descriptive enough.

Thank you, I feel the same way.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
