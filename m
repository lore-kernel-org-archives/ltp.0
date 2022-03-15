Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B4EC433F5
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 15:29:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31CC23C935B
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 16:29:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48AB53C20CC
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:29:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B7D391400FA9
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 16:29:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D76221F391;
 Tue, 15 Mar 2022 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647358172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZRj5lR1TS2KtklOSLMBMoAHBrG6Uw6cP66iikc84wU=;
 b=V4SgBTaN5GHG08Bhvd3/XbQ+5t4c0fPtBefIhrEZ7OEcFzuKz3qA4/b0pVgaBzqZ9mG05S
 HLHG6WjHia2gCikqtMnTY8uKxQheTgKwMDR15x/uYTOPnP67cOgWGVYoonDdXI2/7WKJgZ
 RHfKzq7UlqJQsEyAt+YzViJ3DWInf2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647358172;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZRj5lR1TS2KtklOSLMBMoAHBrG6Uw6cP66iikc84wU=;
 b=qm5O/Ipf0dIPeqq2aDOWzSKp81L2lYi7z17e3NN+GM5VcR7D492Lf2coJ5h0Jhk/n1Naqs
 3ezGovDCZsSxa+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9548913B4E;
 Tue, 15 Mar 2022 15:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2B10IdywMGLoJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 15:29:32 +0000
Date: Tue, 15 Mar 2022 16:29:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YjCw2nlacKpMI0GF@pevik>
References: <20220315094901.5855-1-pvorel@suse.cz>
 <f55747f8-2505-b2e8-41c0-79f4b895faaa@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f55747f8-2505-b2e8-41c0-79f4b895faaa@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] quotactl: Check for missing quota_v2 module
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

Hi Martin, Xu,

merged. Thanks a lot for review and testing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
