Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725A2C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 11:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A2283CA052
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 13:59:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B1E73C9CB4
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 13:58:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 545A820023F
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 13:58:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F18E21601;
 Wed, 30 Mar 2022 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648641532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+x8gxxGkak8MKr4bhLIFOBljnv2gJK/wwVgTAkC2o0=;
 b=T3xnnGRzhWKuH6vwc3yXMR5W+P0LilFQfL37itD7A5VS6Xz2+DC5cT4RZu6PgTa6G8fiiz
 3crsjqevWVJeZ1BZtgCxIPNWf9anLzgDFO6O42b2p7aymLBHhg0v+LVNFN7JukAZteNVJo
 yTrIkYZcERa5AjkbDG4l9QK8wHR9u1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648641532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+x8gxxGkak8MKr4bhLIFOBljnv2gJK/wwVgTAkC2o0=;
 b=kwWDYxzIEUJrm7tdL++5O2XIhMPAAdhNC86txAHVQj//RBC4okKNQCr4vEgl2I8nCNsr+z
 H95FEvzii0fPKJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86A2E13A60;
 Wed, 30 Mar 2022 11:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uqWmIPxFRGK5KAAAMHmgww
 (envelope-from <pvorel@suse.de>); Wed, 30 Mar 2022 11:58:52 +0000
MIME-Version: 1.0
Date: Wed, 30 Mar 2022 13:58:52 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
In-Reply-To: <20220330090817.21950-1-andrea.cervesato@suse.de>
References: <20220330090817.21950-1-andrea.cervesato@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <1faf27214b18ef9d3237734388342308@suse.de>
X-Sender: pvorel@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Fix wqueue09 according with 5.17 kernel updates
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On 2022-03-30 11:08, Andrea Cervesato wrote:

> This patch fixes also the issue of loosing events on big number of 
> iterations
> such as -i 1000.

Unfortunately when testing on machine with older kernel (older 
Tumbleweed with
5.9.1-1-default) it still blocks and then timeout:

wqueue09.c:52: TPASS: Meta loss notification received
common.h:134: TINFO: Reading watch queue events

NOTE: I haven't tested it on 5.17 yet.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
