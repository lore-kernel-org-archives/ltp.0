Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CCC77B75
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 05:47:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 423723CD721
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 07:47:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19DA3C25BE
 for <ltp@lists.linux.it>; Tue,  9 May 2023 07:47:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE7F32003BF
 for <ltp@lists.linux.it>; Tue,  9 May 2023 07:47:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 538451FF02;
 Tue,  9 May 2023 05:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683611263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8au5xoWbG9FMfphv4g02AZaJvtZvuvS/RzivIxrnonE=;
 b=UjkcU2FxxckbCok3AaPRua2Wd561nqohRPNtIHop55LgatVuCt1ouh3Tijhixig8uxTDkt
 NCEK4ZQcoCkRDdFVVkdRGbSRQ5UmfJC9oyHJ1p659he+KwWnxknaQzgowBOOFqxmSjNbwm
 HhMy/N5hpBrAlnu5IQmh+1zJr+IK66A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683611263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8au5xoWbG9FMfphv4g02AZaJvtZvuvS/RzivIxrnonE=;
 b=YI4wJEA4Gjv02GDeU7rnMXsHUu631vOcZXaxkiWONVQQPvkxpz4WrjmhH2nNYQUQpWirgd
 ht3AqRTS/4Ozs6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E3C51346B;
 Tue,  9 May 2023 05:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RGDFCX/eWWQDeAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 09 May 2023 05:47:43 +0000
Date: Tue, 9 May 2023 07:47:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hao Zeng <zenghao@kylinos.cn>
Message-ID: <20230509054741.GA128837@pevik>
References: <20230508013914.245451-1-zenghao@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508013914.245451-1-zenghao@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] testcases:Fix the failure of shell script to
 get path
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>

> Suggested-by: Petr Vorel <pvorel@suse.cz>
I actually didn't suggest this, the above should not be added.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Let's see if it's accepted before the release or after.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
