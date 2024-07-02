Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65B3C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:26:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0F63D3ED1
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:26:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84E7D3D0F60
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:26:31 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D08011A0099C
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:26:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28A6A21896;
 Tue,  2 Jul 2024 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719926789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0WWXjKgTq989dUknXKvRTbG4/2YvTkav0cijp1V1iQ=;
 b=kEWujKk1qIhMrPDXlq8qH4LYbClyKGs17shFlFvQD4nSW86WIxcx+4rqc5D1igv2brWCJ3
 mA6C+tJWDwGW0U1U7wq6JF8ttYmVBb04YZ7sEao021YulFMuTHO+5QzvjLtKxCDBCRYMK2
 T4TcghL7aiANK2yFZ5KLi4tJf6QLVbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719926789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0WWXjKgTq989dUknXKvRTbG4/2YvTkav0cijp1V1iQ=;
 b=5aCAqOZCdXBhgh6MeOOa2ZkdtXNGJTigXSon4D1Bq5N7rdPXqMD/z+2/Enj8kGgD9w1/ej
 bPuV0ZADkTcZIPDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719926788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0WWXjKgTq989dUknXKvRTbG4/2YvTkav0cijp1V1iQ=;
 b=qHep0jAKS48udpkJxMgj+81Z/+Isilf+BI8IXucuLAtl/EzR7yH874u3On+enhQeEQWTZX
 4usSA/0i1lpdniIbrhT2LxQ4vffF+eisyHojryI8jKx7rRofYGMUc3DgjR9UniQ+Vj+f2R
 R9dwN7P0OkC210vdX+SZ/2asIwPFifY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719926788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0WWXjKgTq989dUknXKvRTbG4/2YvTkav0cijp1V1iQ=;
 b=DOpY06xRBPTlMEvcNzIL2q7+iJVIdOPSI36/++jbz3RHiQ+IhcHvwYJ/9jSRRRvhqYbag8
 kUgk1lWLkBOvAnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9011395F;
 Tue,  2 Jul 2024 13:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZzrGBQQAhGbHfgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 02 Jul 2024 13:26:28 +0000
Date: Tue, 2 Jul 2024 15:26:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZoP_-6z9LPTn8Yac@yuki>
References: <20240417144409.11411-1-andrea.cervesato@suse.de>
 <ZnllGpZEj6TOsWqB@yuki>
 <9b70179d-2bfa-47e3-8ae3-5cbb971bd5c3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9b70179d-2bfa-47e3-8ae3-5cbb971bd5c3@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add stat04 test
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

Hi!
> This test is basically a clone of the lstat03 test. I'm wondering if it 
> makes sense to have both, when we already have that one.

You are stil missing the point of this test, the end result we expect is
different for stat() and lstat(). The point I'm trying to make is that
we should:

1. Make sure that as many attributes are diffent for the symlink and the
   symlink target for *both* stat() and lstat() tests, since if they are
   not made different the test does results are not conclusive at all

2. For stat() you should get same result on the file and symlink since
   stat actually follows the symlink then gets the data

3. For lstat() you should get different result on the file and symlink
   since lstat() *does not* follow the symlink before it gets the data

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
