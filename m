Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DDAC52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:48:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C553D2123
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:48:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9F6E3CCB17
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:47:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=schwab@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2CBE100043C
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:47:48 +0200 (CEST)
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1C81B22622;
 Tue, 13 Aug 2024 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723538867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ7XG7oAkhCRG5286WJ1vzC+c9k5jJy4fOZNAP9hBN0=;
 b=ZJ7VSI+rVr/jtQcn3IpzgHNd24ZlUqoQkx7UiwmvpX8bCDZSu7h5xdKVVWU3dRD5wpL3Vn
 StWxxHmBKwYdGrSdaSl26sScku7m1ferFz0y8OYGx8VEY9nMa6ehYQbBzVYilshCPp5YCK
 9UqZ8kkPPuILRkvjQ0U3E7d2i89V0cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723538867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ7XG7oAkhCRG5286WJ1vzC+c9k5jJy4fOZNAP9hBN0=;
 b=PS8QI5vgyxxJ32h8nzIEja9lt3Op1HIhvTC4zKCbdwgA7y/w0PQjm97Vmw4F8CSe6HdBrF
 cPo5kzD9jh23pkCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZJ7VSI+r;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PS8QI5vg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723538867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ7XG7oAkhCRG5286WJ1vzC+c9k5jJy4fOZNAP9hBN0=;
 b=ZJ7VSI+rVr/jtQcn3IpzgHNd24ZlUqoQkx7UiwmvpX8bCDZSu7h5xdKVVWU3dRD5wpL3Vn
 StWxxHmBKwYdGrSdaSl26sScku7m1ferFz0y8OYGx8VEY9nMa6ehYQbBzVYilshCPp5YCK
 9UqZ8kkPPuILRkvjQ0U3E7d2i89V0cI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723538867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ7XG7oAkhCRG5286WJ1vzC+c9k5jJy4fOZNAP9hBN0=;
 b=PS8QI5vgyxxJ32h8nzIEja9lt3Op1HIhvTC4zKCbdwgA7y/w0PQjm97Vmw4F8CSe6HdBrF
 cPo5kzD9jh23pkCA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 61D304A04EA; Tue, 13 Aug 2024 10:47:46 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com> (Andrea
 Cervesato's message of "Tue, 13 Aug 2024 10:19:18 +0200")
References: <mvm7cckdeqf.fsf@suse.de>
 <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com>
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
Date: Tue, 13 Aug 2024 10:47:45 +0200
Message-ID: <mvm34n8dd1q.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 1C81B22622
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.964]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix landlock06 test
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

On Aug 13 2024, Andrea Cervesato wrote:

> Do you have a validation test (for example in openQA) for this patch?

I don't understand this question.  Please expand.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
