Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7553FC636CC
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 10:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ACDA3CC381
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 11:09:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9990E3CB269
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:09:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 457C81400DB8
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 11:09:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62ABB5BCEC;
 Fri,  3 Feb 2023 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675418967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMxr/mRVGfQsZ/R6pFPzMN066GCDpCnj4yxZazELhZU=;
 b=FgJeD9xIuUbSlKW9L/71catD7RyQrr+67s8TUbtEytL9dMJP/kdOFvJDptHq9HzGpiGgW/
 rQoLHB3+iQKUZ2nPdtqpVy1l695t+sAYN+FM4gPIZVIWVTN9/yZgooGbaGO98QZGiZcRzu
 pVrb2i43B28xVxObYLMJBb1VnWFXBAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675418967;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMxr/mRVGfQsZ/R6pFPzMN066GCDpCnj4yxZazELhZU=;
 b=pQtAHDG9grOwbzg9KZQBr4EqUaWVuSCm/TKpv9WDmavNJObOap8EoHcAyoiZOAIiXs3XMZ
 akpAKIz/cEAvc0Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DD501358A;
 Fri,  3 Feb 2023 10:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Vk8QBlfd3GNrKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Feb 2023 10:09:27 +0000
Date: Fri, 3 Feb 2023 11:09:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Y9zdVezVY/hKz/ku@pevik>
References: <20230203100613.13395-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230203100613.13395-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] arm64: dts: qcom: msm8992-lg-bullhead: Enable
 regulators
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
Cc: Jamie Douglass <jamiemdouglass@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Jeremy McNicoll <jeremymc@redhat.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Andy Gross <agross@kernel.org>,
 Dominik Kobinski <dominikkobinski314@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm sorry, wrong list.
Reposting shortly to the correct one.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
