Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D50C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 14:42:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77AD03CC1FF
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 16:42:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A15C23CC1FF
 for <ltp@lists.linux.it>; Fri,  9 May 2025 16:42:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E96A20014D
 for <ltp@lists.linux.it>; Fri,  9 May 2025 16:41:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F32731F38A;
 Fri,  9 May 2025 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746801718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01FZUiKkHzt49IKrxUZbkVo88loQn57TH+8uE9BhEqM=;
 b=FlgojeuabXxu1zKubhVMdNdpgXPnk0IFQ8/DBRN/uEsqLLwzBGYtSA9jewTsghbbeaChL3
 ih0OXhsy1+5PhOO2Y6QNCwhHgai6xGB7WTkXx+i+c8uROsSKbNU6qvThI7JBFj3sciWKvc
 kIpSUCrK/H8lO51SP1ofbk3KmchZ0Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746801718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01FZUiKkHzt49IKrxUZbkVo88loQn57TH+8uE9BhEqM=;
 b=n21jbZK2tLhuQ4XoPjgK3/8WZRXBEOy8vrm9TXoCxjDHtf70Ik41vBZw4i/DPKmfrq9EB7
 tTaQxcMUqo8s6nAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746801718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01FZUiKkHzt49IKrxUZbkVo88loQn57TH+8uE9BhEqM=;
 b=FlgojeuabXxu1zKubhVMdNdpgXPnk0IFQ8/DBRN/uEsqLLwzBGYtSA9jewTsghbbeaChL3
 ih0OXhsy1+5PhOO2Y6QNCwhHgai6xGB7WTkXx+i+c8uROsSKbNU6qvThI7JBFj3sciWKvc
 kIpSUCrK/H8lO51SP1ofbk3KmchZ0Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746801718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=01FZUiKkHzt49IKrxUZbkVo88loQn57TH+8uE9BhEqM=;
 b=n21jbZK2tLhuQ4XoPjgK3/8WZRXBEOy8vrm9TXoCxjDHtf70Ik41vBZw4i/DPKmfrq9EB7
 tTaQxcMUqo8s6nAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D1F13931;
 Fri,  9 May 2025 14:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFBSNjUUHmjHUAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 09 May 2025 14:41:57 +0000
Message-ID: <144b6bac-edba-470a-bf87-abf492d85ef5@suse.cz>
Date: Fri, 9 May 2025 16:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20250505105310.15072-1-mdoucha@suse.cz>
 <aBts4kDaqLKLJUuw@yuki.lan> <3ff8ee4c-881a-435d-a416-8bd32c35a17e@suse.cz>
 <aB3JFz8PK2okhULz@yuki.lan> <f3cbed38-82b1-45e3-b037-a943f9956ae8@suse.cz>
 <aB3Si02rxzhhZYFv@yuki.lan>
 <qbca5sxzfw53o6nku5ulu2dl2xygxqghgsuerjjjfoea62bacs@a5qm6cl7hhnu>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <qbca5sxzfw53o6nku5ulu2dl2xygxqghgsuerjjjfoea62bacs@a5qm6cl7hhnu>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMDkuIDA1LiAyNSAxNjoxMSwgTWljaGFsIEtvdXRuw70gd3JvdGU6Cj4gT24gRnJpLCBNYXkg
MDksIDIwMjUgYXQgMTI6MDE6NDdQTSArMDIwMCwgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2Uu
Y3o+IHdyb3RlOgo+Pj4gVW5mb3J0dW5hdGVseSwgd2UgY2FuJ3QuIEkndmUgdGVzdGVkIHRoaXMg
YW5kIG1lbW9yeS5jdXJyZW50IGNhbiBjaGFuZ2UKPj4+IGEgbG90IGR1cmluZyB0aGUgZmlyc3Qg
cHJvY2VzcyBtaWdyYXRpb24uCj4+Cj4+IFRoYXQgZG9lcyBzb3VuZCBzdHJhbmdlLiBATWljaGFs
IGFueSBpZGVhIHdoYXQgaGFwcGVucyBoZXJlPwo+IAo+IFtQcm9jZXNzIG1pZ3JhdGVzIGl0c2Vs
ZiAoZWNobyAwID4kdGFyZ2V0X2NnL2Nncm91cC5wcm9jcykgb3JdIGl0J3MKPiBvdGhlcndpc2Ug
YWN0aXZlIGR1cmluZyB0aGUgbWlncmF0aW9uPwo+IAo+IChBbHNvLCB0aGUgYXBwYXJlbnQgaW5j
cmVhc2Ugb2YgbWVtb3J5LmN1cnJlbnQgbWF5IGJlIGFtcGxpZmllZCBiZWNhdXNlCj4gb2YgTUVN
Q0dfQ0hBUkdFX0JBVENIIGV2ZW4gd2l0aCBpbml0aWFsbHkgc21hbGwgYWxsb2NhdGlvbi4pCgpU
aGUgcHJvY2VzcyBtaWdyYXRlcyBpdHNlbGY6ClNBRkVfQ0dfUFJJTlRGKGNnLCAiY2dyb3VwLnBy
b2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwoKV2UncmUgZGVhbGluZyB3aXRoIGFuIGlzc3VlIHdoZXJl
IHRoZSB0ZXN0IGhhcyAyTUIgc2FmZXR5IG1hcmdpbiBmcm9tIAp0cmlnZ2VyaW5nIE9PTSBidXQg
aW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHByb2Nlc3MgbWlncmF0ZXMgaXRzZWxmIGludG8gCnRoZSBj
Z3JvdXAgb24gUFBDNjRMRSwgbWVtb3J5LmN1cnJlbnQgd2lsbCBiZSB+NE1CIGFuZCB0aGUgcHJv
Y2VzcyB3aWxsIApyYW5kb21seSB0cmlnZ2VyIE9PTSBhbnl3YXkuIFNvIHdlJ3JlIGluY3JlYXNp
bmcgdGhlIHNhZmV0eSBtYXJnaW4gYnkgCndoYXRldmVyIG1lbW9yeS5jdXJyZW50IHNheXMgaW1t
ZWRpYXRlbHkgYWZ0ZXIgdGhlIG1pZ3JhdGlvbi4KCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNo
YUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5lZXIKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJ
YQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
