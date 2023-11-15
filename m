Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913B3C072A2
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 17:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90EAD3CE471
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 18:34:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 578333CE465
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 18:34:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D4A814044D0
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 18:34:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 541B5228FA;
 Wed, 15 Nov 2023 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700069668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IWg4tuGHVSoskEJI6jGOZBSzt8DuI6gEUKsx+eahthg=;
 b=3Bj65hWHd7+xlLc41YYY6eDf7mmqZdzlTq2FDgReYpWQjkx+6sAJfdfx7t9EaOPtWqvFDd
 6v7A8cFAEuTD7hK1I6VE+5Zmbj3a0icgOF0MGb86tHbMyYbHpFd2fuH7+WdH//pAPCPc0Z
 XhAzk4MiFYV3F3NjDcJ9LEr4LLtvoB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700069668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IWg4tuGHVSoskEJI6jGOZBSzt8DuI6gEUKsx+eahthg=;
 b=mD4IskzULLNVlwzY9OM4HVkqZ8rkwocueAniFzPJDZji4m54C8FT1HK+8+94a0DWYPcepD
 9qxRPNynMeAUEkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39FA613592;
 Wed, 15 Nov 2023 17:34:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /bkJDSQBVWViTgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 15 Nov 2023 17:34:28 +0000
Message-ID: <42d14d08-84a7-4f0e-bad9-e3e54ff1858a@suse.cz>
Date: Wed, 15 Nov 2023 18:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?B?5rKz5Y6f6aKv5aSq?= <souta.kawahara@miraclelinux.com>,
 Petr Vorel <pvorel@suse.cz>
References: <20231114123140.1144-1-mdoucha@suse.cz>
 <20231114123140.1144-6-mdoucha@suse.cz> <20231114153907.GA2357693@pevik>
 <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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

SGksCgpPbiAxNS4gMTEuIDIzIDg6NDMsIOays+WOn+mir+WkqiB3cm90ZToKPiBIaSBNYXJ0aW4s
IFBldHIuCj4gCj4gCj4gMjAyM+W5tDEx5pyIMTXml6Uo5rC0KSAwOjM5IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PjoKPj4KPj4gSGkgTWFydGluLAo+Pgo+PiAuLi4KPj4+ICsrKyBiL3Rlc3Rj
YXNlcy9uZXR3b3JrL2lwdGFibGVzL25mdDAyLmMKPj4gLi4uCj4+PiArLyogQ2hhaW4gY3JlYXRp
b24gYW5kIGRlbGV0aW9uIGNvbmZpZyAqLwo+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHN0X25l
dGxpbmtfYXR0cl9saXN0IG5ld2NoYWluX2NvbmZpZ1tdID0gewo+Pj4gKyAgICAge05GVEFfVEFC
TEVfTkFNRSwgVEFCTkFNRSwgc3RybGVuKFRBQk5BTUUpICsgMSwgTlVMTH0sCj4+PiArICAgICB7
TkZUQV9DSEFJTl9OQU1FLCBDSEFJTk5BTUUsIHN0cmxlbihDSEFJTk5BTUUpICsgMSwgTlVMTH0s
Cj4+PiArICAgICB7TkZUQV9DSEFJTl9JRCwgJmNoYWluX2lkLCBzaXplb2YoY2hhaW5faWQpLCBO
VUxMfSwKPj4KPj4gVW5mb3J0dW5hdGVseSB0aGUgY3VycmVudCBvbGRlc3QgZGlzdHJvcyAoTGVh
cCA0MiBhbmQgVWJ1bnR1IEJpb25pYykgYXJlIHRvbyBvbGQKPj4gZm9yIE5GVEFfQ0hBSU5fSUQs
IE5GVEFfUlVMRV9DSEFJTl9JRCwgY291bGQgeW91IHBsZWFzZSBhZGQgdGhlbSB0byBMQVBJPwo+
IAo+IEl0IHdhcyB0aGUgc2FtZSBvbiBSSEVMOCAoYW5kL29yIG90aGVyIGNsb25lIE9TKS4KPiAK
PiBBbmQsIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcyB0ZXN0IGFkZGVkIHRvIHJ1bnRlc3QvY3Zl
IGFuZCAuZ2l0aWdub3JlLgoKWWVzLCBzb3JyeSwgSSByZWFsaXplZCB0aGF0IHNob3J0bHkgYWZ0
ZXIgc3VibWlzc2lvbiBhbmQgd2lsbCBmaXggaXQgaW4gCnRoZSBuZXh0IHZlcnNpb24uCgo+IElu
IG15IHBhdGNoIHYxIGFib3V0IENWRS0yMDIzLTMxMjQ4IGNoZWNrIGVycm9yID09IEVOT0VOVC4g
SW4gdGhpcwo+IGNhc2UsIHRlc3QgcmVwb3J0cyBjb3JyZWN0IHJlc3VsdC4KPiBJdCBtYXkgYmUg
ZGlmZmljdWx0IHRvIGltcGxlbWVudCB0ZXN0IGxpa2UgcGF0Y2ggdjEgdXNpbmcgdGhlIGludGVy
bmFsCj4gdHN0X25ldGxpbmsgQVBJLCBidXQgd2Ugc2hvdWxkIGJlIGF3YXJlIG9mIHRoaXMgaXNz
dWUuCgpJJ3ZlIHJld3JpdHRlbiB0aGUgdGVzdCB0byB1c2UgRU5PRU5UIGNoZWNrIHdpdGggdGhl
IHRzdF9uZXRsaW5rIEFQSS4gCk1heSBJIGNyZWRpdCB5b3Ugd2l0aCBDby1EZXZlbG9wZWQtYnkg
b3IgU3VnZ2VzdGVkLWJ5IChjaG9vc2Ugb25lKT8KCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNo
YUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5lZXIKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJ
YQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
