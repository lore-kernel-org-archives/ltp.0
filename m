Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D4B104950F
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 09:13:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 265623E239E
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 10:13:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 095943D753A
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 10:12:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08567200B06
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 10:12:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E3735BDF2;
 Wed, 11 Mar 2026 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773220366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loEL/eI4AgPZ7c777Xy0P9KMJGa+2/ygLB8LzhLLObE=;
 b=opv7oZbnbe5/kpDkvFsdCHpJ6bSJF2WS8Nq1Z8IIWo/AoyjCu5F1lBrJA2zv1/83fc2zNx
 SbwZjaU5EB+6teXHbmPUdS0Ows2/43PALF0zCZ0tWWv7vlt0S/B7NA9R02JnElBjiwWeHv
 dnvr7jG9cCMjERHz7ost+nqNKB0S9VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773220366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loEL/eI4AgPZ7c777Xy0P9KMJGa+2/ygLB8LzhLLObE=;
 b=QRxy7Do064sYndLBDkdcXW784+m+RWim4vDCh1T301bQwDjg9s3IYjEqB2w/e4boSz4+jE
 VfUbzZIgL6sZN2AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=opv7oZbn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QRxy7Do0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773220366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loEL/eI4AgPZ7c777Xy0P9KMJGa+2/ygLB8LzhLLObE=;
 b=opv7oZbnbe5/kpDkvFsdCHpJ6bSJF2WS8Nq1Z8IIWo/AoyjCu5F1lBrJA2zv1/83fc2zNx
 SbwZjaU5EB+6teXHbmPUdS0Ows2/43PALF0zCZ0tWWv7vlt0S/B7NA9R02JnElBjiwWeHv
 dnvr7jG9cCMjERHz7ost+nqNKB0S9VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773220366;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loEL/eI4AgPZ7c777Xy0P9KMJGa+2/ygLB8LzhLLObE=;
 b=QRxy7Do064sYndLBDkdcXW784+m+RWim4vDCh1T301bQwDjg9s3IYjEqB2w/e4boSz4+jE
 VfUbzZIgL6sZN2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB65D3F938;
 Wed, 11 Mar 2026 09:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oop7NA0ysWkYRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Mar 2026 09:12:45 +0000
Date: Wed, 11 Mar 2026 10:12:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260311091244.GA90982@pevik>
References: <20260128080121.18878-1-pvorel@suse.cz>
 <DGC5KMP8J1V7.ALUWBN4R82H1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGC5KMP8J1V7.ALUWBN4R82H1@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E3735BDF2
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/ground_rules: Add Kernel features check
 rules
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBIaSEKCj4gSXMgdGhpcyBwYXRjaCBzdGlsbCB2YWxpZD8gU2hvdWxkIHdlIG1l
cmdlIGl0IHdpdGggbWlub3IgZGV0YWlscyBhcwo+IHN1Z2dlc3RlZD8KCkkgcGxhbm5lZCB0byBt
ZXJnZSB0aGlzIHdpdGggY2hhbmdlIExpIHN1Z2dlc3RlZCBbMV0uIEJ1dCBpbiBhIG1lYW53aGls
ZSBDeXJpbApwb3N0ZWQgbGliOiB0c3Rfa2NvbmZpZzogQWRkIHJ1bnRpbWUgY2hlY2tzIFsyXS4g
T25jZSBoZSBmaW5kcyB0aW1lIHRvIG1lcmdlIGl0LApJIHNob3VsZCBwcm9iYWJseSBzZW5kIHYy
IG9mIHRoaXMgcGF0Y2ggLSB1cGRhdGUgTGkncyBzdWdnZXN0aW9uOgoKICAtIFRyaXN0YXRlL21v
ZHVsZSBmZWF0dXJlOiBJZiB0aGUgZnVuY3Rpb25hbGl0eSBpcyBjb250cm9sbGVkIGJ5IGEgS2Nv
bmZpZyBvZgogICAgIHR5cGUgdHJpc3RhdGUgKGB0cmlzdGF0ZQo8aHR0cHM6Ly9kb2NzLmtlcm5l
bC5vcmcva2J1aWxkL2tjb25maWctbGFuZ3VhZ2UuaHRtbCNtZW51LWF0dHJpYnV0ZXM+YF8pLAog
ICAgIGl0IG1pZ2h0IGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBNb2R1bGVzIGNhbiBiZSBhYnNlbnQg
b3IgdW5sb2FkZWQKYXQgcnVudGltZSwKICAgICBzbyBjaGVja2luZyB0aGUgS2NvbmZpZyBvcHRp
b24gYWxvbmUgaXNu4oCZdCBlbm91Z2guIC5uZWVkc19rY29uZmlncywKCSByZXF1aXJlcyB0byBh
ZGQgYWRkaXRpb25hbCBrY29uZmlnIGNoZWNrcyB0byBjb25maXJtIHRoZSBtb2R1bGUgaXMgbG9h
ZGVkLgoKQWxzbywgQ3lyaWwgbm90ZWQgWzNdIG9uIHRoZXJtYWwgdGVzdCB0aGF0IHVzaW5nIC5z
dXBwb3J0ZWRfYXJjaHMgaXMgYWxzbyB1c2VmdWwKdG8gZGVmaW5lIHdoaWNoIGFyY2ggaXMgdGFy
Z2V0ZWQgKHdoZW4gdXNlZCB3aXRoIC5uZWVkc19kcml2ZXJzLy5uZWVkc19rY29uZmlncywKd2hp
Y2ggd291bGQgYmUgZW5vdWdoIGZvciBkZXRlY3RpbmcgdGhlIGZ1bmN0aW9uYWxpdHkpLiBEbyB3
ZSB3YW50IHRvIGFkZCBpdCBhcwphIHJ1bGU/CgktIFRlc3QgdGFyZ2V0ZWQgdG8gYSBjZXJ0YWlu
IGFyY2hpdGVjdHVyZSBzaG91bGQgYWx3YXlzIHVzZSAuc3VwcG9ydGVkX2FyY2hzCglldmVuIGlm
IHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBhcyBhIGNoZWNrIGJlY2F1c2UgdGVzdCBhbHJlYWR5IGRl
ZmluZQoJLm5lZWRzX2RyaXZlcnMvLm5lZWRzX2tjb25maWdzLgoKQW5kIGJhY2sgdG8gbXkgcXVl
c3Rpb24gc29tZSB0aW1lIGFnby4gRG8gd2Ugd2FudCB0byBkZXByZWNhdGUgLm5lZWRzX2RyaXZl
cnMsCndoZW4gQ3lyaWwgZW5oYW5jZWQgLm5lZWRzX2tjb25maWdzPyBEbyB3ZSBldmVuIG5lZWQg
aXQ/CgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gS2luZCByZWdhcmRzLAoKWzFdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2x0cC9DQUVlbUgyZmNfQ192R25LdGJZcXNNek1WS0xTTkxoQ0ZXTEdlbVN5
VlRXQnpBQVREQ0FAbWFpbC5nbWFpbC5jb20vClsyXSBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjYwMjA1MTM1NzI0LjIzNzcyLTEtY2hydWJpc0BzdXNl
LmN6LwpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwL2FhXzBZa0E0VUt3aE9qcGlAeXVr
aS5sYW4vCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
