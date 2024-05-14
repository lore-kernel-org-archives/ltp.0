Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF78C04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 13:02:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C920F3CF2AD
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 15:02:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7E563CE185
 for <ltp@lists.linux.it>; Tue, 14 May 2024 15:02:36 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=jv-coder.de (client-ip=5.9.79.73; helo=mail.jv-coder.de;
 envelope-from=lkml@jv-coder.de; receiver=lists.linux.it)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DDE6960344D
 for <ltp@lists.linux.it>; Tue, 14 May 2024 15:02:35 +0200 (CEST)
Received: from [10.40.94.1] (unknown [91.26.40.236])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 69BBD9F778;
 Tue, 14 May 2024 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1715691754; bh=O5/4U5qqyVr0p1KPoE/5ihbaabSYWbAdHeKfGkJShto=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=dyWwvm9H4+19YOFoZU0qBjUGZHbI/Eg/kxWJByURWPFiWarbT26IciGJvDm/D6dne
 WAQwZXPMusruFgSTJTKK6RD853kjs9risO7k6Y5v/SIjITmA9ZfCS5tFcYos2Q0X/I
 FrHZyvlMmkisAKNJc9nueJffM1Eun3jN7u6kRa5I=
Message-ID: <58c5dbe8-5647-4019-a883-31a155669111@jv-coder.de>
Date: Tue, 14 May 2024 15:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <trinity-74891c6d-f969-45be-ab73-89e340d7f6d3-1715633259373@3c-app-webde-bap30>
 <ZkMgEkifrsjZIOXR@yuki> <20240514121557.GA88586@pevik>
Content-Language: en-US
From: Joerg Vehlow <lkml@jv-coder.de>
Organization: AOX Technologies GmbH
In-Reply-To: <20240514121557.GA88586@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Replace old -W commandline
 argument
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
Reply-To: Joerg.Vehlow@aox.de
Cc: Detlef Riekenberg <wine.dev@web.de>, Joerg Vehlow <joerg.vehlow@aox.de>,
 LTP <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Am 5/14/2024 um 2:15 PM schrieb Petr Vorel:
> Hi all,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> @Joerg I plan to merge this, can I add your Reviewed-by tag?
Sure:
Reviewed-by: Joerg Vehlow <joerg.vehlow@aox.de>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
