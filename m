Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B92CC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 08:12:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B176D61139
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 08:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B176D61139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A01C3C6F3E
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 10:12:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCBA3C66BF
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 10:12:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A2CB1001349
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 10:12:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7A6A2032D;
 Wed,  6 Oct 2021 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633507947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpeOBHE9SQVUDTPbzhFAFDH70OG1ukKVGtzZJTc7zK4=;
 b=XsJrye1Y6Rac9uqYKdaAbtaXMRPdw3iCAp9W5uxwLqM+ZkqJB2wg6HAjOoKEASHidId1To
 judm6nCB28Eo7rfdlPC0SCYZ66D/gluNYUFbWYmRHN/f+zSK3+JOiBj5jfWlHLmJBYkwKZ
 TgSvrA71nj3BV2bVeFHdDEzjqxWjC7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633507947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpeOBHE9SQVUDTPbzhFAFDH70OG1ukKVGtzZJTc7zK4=;
 b=VS+O56NQBRpkARi3F0W4wVrHviL3McFDN73fNrC4tfk68otzvX/IVE63wahjXxHF01YPqT
 zBlXZvtSTFL3fJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E89B13E19;
 Wed,  6 Oct 2021 08:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z23BIWtaXWEhJAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 06 Oct 2021 08:12:27 +0000
Message-ID: <270c020c-5028-5c73-935c-2a8785d1eb30@suse.cz>
Date: Wed, 6 Oct 2021 10:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <petr.vorel@gmail.com>, Steve Muckle <smuckle@google.com>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
 <YVtBt+WeskISn5+9@pevik> <2a6a43e1-25da-7eef-f212-bfe0371275d3@google.com>
 <YVy0fTqiKM3lCCQj@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YVy0fTqiKM3lCCQj@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
Cc: Sandeep Patil <sspatil@google.com>, ltp <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 05. 10. 21 22:24, Petr Vorel wrote:
>> On 10/4/21 11:02 AM, Petr Vorel wrote:
> Looking into tst_get_{g,u}ids() implementation it "The function will fill the
> remaining (size-start) entries with unique UID/GID values.". But the problem is
> that it expect there are no gaps in UID/GID values. While this is true for
> traditional linux distros (not sure about embedded distros), it's definitely not
> true for aosp, see AID_ definitions in libcutils source [1].
> 
> e.g. tst_get_gids(test_groups, 0, 2) (from setregid03.c) returns GID 1 and 2.
> But on aosp getpwuid(1) and getpwuid(2) fails (I verified that by running code
> on aosp 8). There is GID AID_DAEMON 1 ("daemon") and AID_BIN 2 ("bin"), which
> has been added for aosp 9 (8e8648463d7 ("libcutils: Add "daemon" and "bin" users
> for testing only")) and IMHO no use of tst_get_gids() so far does require higher
> GID that 2, but once higher ID is needed it will break (and even adding GID
> "nobody" would help much).

Actually, the tests using tst_get_uids() or tst_get_gids() currently do
not query any additional information about the returned UID/GID values.
Those tests will work just fine even if there is no corresponding user
account or group.

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
