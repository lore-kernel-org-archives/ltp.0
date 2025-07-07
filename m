Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102B5C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBCF3C75F2
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 13:10:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4ECB3C2365
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:10:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B16C21400990
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:10:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0F601F393;
 Mon,  7 Jul 2025 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751886617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiuTWcY9xV/BOJCNN/eyjxpc4glGOFBx+PZY9ZA24vk=;
 b=uT1XYD2ecc3F+hCV02EfajIPBBHdJsglxmojzdlFevp9eaa+dYfYKBhgOiFvevOHg+o70/
 qHYcwHzafF13pubshHW0z6kQfEAcpXDYE8RvEcdqIPthOl8Ev4VbU6RpHSUYy1BNNya5Y7
 0Z8Do206rdZ+YdcbFMDL0sVezvx/t9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751886617;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiuTWcY9xV/BOJCNN/eyjxpc4glGOFBx+PZY9ZA24vk=;
 b=P9OUxr/wNvfCDfBCC8GrIRa8UJg0RY73opVq2+AiQU+Ak/01xMQ+OaBiXw4bv0ajBRrJY5
 UdjbQJ2sxmVn6PBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751886617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiuTWcY9xV/BOJCNN/eyjxpc4glGOFBx+PZY9ZA24vk=;
 b=uT1XYD2ecc3F+hCV02EfajIPBBHdJsglxmojzdlFevp9eaa+dYfYKBhgOiFvevOHg+o70/
 qHYcwHzafF13pubshHW0z6kQfEAcpXDYE8RvEcdqIPthOl8Ev4VbU6RpHSUYy1BNNya5Y7
 0Z8Do206rdZ+YdcbFMDL0sVezvx/t9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751886617;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiuTWcY9xV/BOJCNN/eyjxpc4glGOFBx+PZY9ZA24vk=;
 b=P9OUxr/wNvfCDfBCC8GrIRa8UJg0RY73opVq2+AiQU+Ak/01xMQ+OaBiXw4bv0ajBRrJY5
 UdjbQJ2sxmVn6PBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90BCC13757;
 Mon,  7 Jul 2025 11:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ey8LIxmra2jyawAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 11:10:17 +0000
Date: Mon, 7 Jul 2025 13:10:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aGurP-pQEQkcPIy2@yuki.lan>
References: <20250620154346.19864-1-chrubis@suse.cz>
 <9fe4918b-431b-4ce0-9094-710385d5dd89@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9fe4918b-431b-4ce0-9094-710385d5dd89@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Two more metadata parser fixes
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
> Feel free to merge, I will fix kirk later on.

These changes also crash doc generator since the format of the metadata
has changed:

Traceback (most recent call last):
  File "/home/metan/Work/ltp/doc/.venv/lib/python3.12/site-packages/sphinx/events.py", line 97, in emit
    results.append(listener.handler(self.app, *args))
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/metan/Work/ltp/doc/conf.py", line 517, in generate_test_catalog
    text.extend(_generate_setup_table(conf))
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/metan/Work/ltp/doc/conf.py", line 407, in _generate_setup_table
    values.append(f'{value[0]}, {value[1]}')
                     ~~~~~^^^
KeyError: 0

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
