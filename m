Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE409CD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:01:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F1C33E2D34
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:01:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3E603E1BA0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:01:16 +0200 (CEST)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A972760080C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:01:14 +0200 (CEST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777536073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4cGIcXFpN8V/PeAwxlmGQlnR6Davjcs2i+M8ASKuVI=;
 b=mpwwPeaeZnxyz8dl2X/Hp/qZJ9TaVD2qQvPvCD5jsACMvkoRw+xd/tb/ujSRsuVAb28iyI
 0NfPpWtoW927cDpg7cJ4MV/M5oDtEPYfxS0q5I439+etdPJrvOEceoEL82/bzYRCWQIpi1
 BHuaqTBr5KsdZH2AyucQ6++dG3shxQQ=
Date: Thu, 30 Apr 2026 08:01:12 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Li Wang" <li.wang@linux.dev>
Message-ID: <8487d43450ec53d7fdb2110cd653231d31b91d43@linux.dev>
TLS-Required: No
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <afFrf9OtAUkcOjLT@autotest-wegao.qe.prg2.suse.org>
References: <20260427115941.31945-1-wegao@suse.com>
 <20260428125804.GA921372@pevik> <20260428163415.GB921372@pevik>
 <afFrf9OtAUkcOjLT@autotest-wegao.qe.prg2.suse.org>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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

Hi Wei, Petr,

Wei Gao via ltp wrote:

> Base description/implementation of test case, The original test is "passive," merely creating a 
> mapping and relying on external processes to trigger swapping(case has sleep_time parameter).
> Further more, this case is "ghost test" for current kernel, it do mmap but never 
> writes to it, so kernel never actually allocated memory, 
> Together with current obsolete logic(test targets legcy mfile_swap) i suggest just delete 
> it instead of wasting time patching(refactor) it. What do you think? @Petr @wang li?

After looking into the details of mmapstress06, I agree that this
test only simulates progress and still requires another stress
tester to create memory pressure and trigger swapping.

Instead of removing this test, I prefer to refactor it into a
new API and encapsulate the orignial method within Cgroups.

e.g.

 1. Check system swap availability
 2. Create cgroup with memory.max and memory.swap.max limits
 3. Create large anonymous shared mapping (original size)
 4. Allocate stress region: size > memory.max in child
 5. Ditry every page in stress region
 6. Check process VmSwap increase
 7. Cleanup


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
