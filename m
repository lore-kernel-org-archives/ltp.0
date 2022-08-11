Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA136C19F2D
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 08:00:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56C783C95BC
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 10:00:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91BFF3C0895
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:00:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 826E66009D9
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 10:00:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B431B38859;
 Thu, 11 Aug 2022 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660204802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HbrEfip3zUUSM7UPivXvJq9mebh9XdVYkl3x6A0bPk=;
 b=aje+A2Zy63D96vgaKB+v+7ue4AS7r9T/4e3j0pj6V2P76m/thAD//WWwDAReJiRo7kdZJY
 LpMTmAuoj7UaBFKfLv68DU3Uaanct3KMU90J/PDIv4C5ENXVMEDeAFuH66tgjEe0Dgyk28
 Ro84WQyrYH7jhFG6sAY7vUF9OesgHlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660204802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HbrEfip3zUUSM7UPivXvJq9mebh9XdVYkl3x6A0bPk=;
 b=ooIs6EsRIwKmBdFE8K3vhs+buIEtuVdJXxNrRJNbCCxn475Yngq1I1GImmD3tlt6FaRJVg
 5pRI8fbI6ZRpY0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D09513AF7;
 Thu, 11 Aug 2022 08:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G1X6JAK39GIWRgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 11 Aug 2022 08:00:02 +0000
Message-ID: <18ff8839-7a73-306f-9c3d-1078e8e309d3@suse.cz>
Date: Thu, 11 Aug 2022 10:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-4-pvorel@suse.cz>
 <7d501d57-2438-cd28-5e49-019ea06fb8f2@suse.cz> <YvPdB6YhTlDAlPBR@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YvPdB6YhTlDAlPBR@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] tst_test.sh: Fix _tst_cleanup_timer() on
 set -e
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

On 10. 08. 22 18:29, Petr Vorel wrote:
> Hi Martin,
> 
>> Hi,
>> a comment explaining why this is needed would be nice, otherwise looks
>> good. For patches 2 and 3:
> 
>> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> 
>> On 08. 08. 22 13:37, Petr Vorel wrote:
>>> If test exits on time (i.e. no timeout) kill in _tst_cleanup_timer()
>>> have nothing to kill therefore following wait exits 143.
> I thought this is the explanation. Or would you prefer anything else to add?

The commit message will get buried deep in Git history. It's better to
comment this in the code because it's not obvious why the "|| true" is
needed after "wait ..."

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
