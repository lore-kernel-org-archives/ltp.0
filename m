Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E641C54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 08:52:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E9C33CC7B8
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 10:52:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 359953CC6FC
 for <ltp@lists.linux.it>; Wed, 21 May 2025 10:52:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77CBC6008F9
 for <ltp@lists.linux.it>; Wed, 21 May 2025 10:51:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83570208AC;
 Wed, 21 May 2025 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747817517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OIjakX4uV8kfjpptEVe3x/MTgD92Xvii5HAhZ1Wt4XQ=;
 b=hJ8z9qT40ZvVxKRHamkA1xzj7UcoZD66Xa41J2cuUcpHRlVmZtThv3ihC/WCACOmTAlE04
 ukY5aqC4GYvWVnYsww9KxbJkmPWqM3FZ1HcL5U7/sSvvZWbm4w7zAAWG8Sdzi09Z4MrRiu
 XdpXMx2sik+77cTETwKI+odzA/Wgp4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747817517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OIjakX4uV8kfjpptEVe3x/MTgD92Xvii5HAhZ1Wt4XQ=;
 b=LqFH9zsg9u6jnk5zlmVpQerRT2+j6H5lHBo97i1kiFFnrJz9Y4ilUL+ZcA+xRsAwWbHZ+d
 YcEQbvriSlf4ZADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747817517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OIjakX4uV8kfjpptEVe3x/MTgD92Xvii5HAhZ1Wt4XQ=;
 b=hJ8z9qT40ZvVxKRHamkA1xzj7UcoZD66Xa41J2cuUcpHRlVmZtThv3ihC/WCACOmTAlE04
 ukY5aqC4GYvWVnYsww9KxbJkmPWqM3FZ1HcL5U7/sSvvZWbm4w7zAAWG8Sdzi09Z4MrRiu
 XdpXMx2sik+77cTETwKI+odzA/Wgp4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747817517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OIjakX4uV8kfjpptEVe3x/MTgD92Xvii5HAhZ1Wt4XQ=;
 b=LqFH9zsg9u6jnk5zlmVpQerRT2+j6H5lHBo97i1kiFFnrJz9Y4ilUL+ZcA+xRsAwWbHZ+d
 YcEQbvriSlf4ZADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 749A513AA0;
 Wed, 21 May 2025 08:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +8nvGy2ULWhtNQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 21 May 2025 08:51:57 +0000
Message-ID: <3f698fa7-a76d-453f-a2d8-2e3cd4fe6ba3@suse.cz>
Date: Wed, 21 May 2025 10:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250521-fixes-msgstress01-v3-1-5d82167cb3e5@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250521-fixes-msgstress01-v3-1-5d82167cb3e5@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/msgstress01: Set upper bound for
 num_messages
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksClJldmlld2VkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+CgpPbiAyMS4g
MDUuIDI1IDEwOjMxLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBGcm9tOiBSaWNhcmRv
IEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IAo+IFRoZSBtc2dzdHJlc3MwMSB0ZXN0IGhh
cyBhIHdvcmthcm91bmQgdG8gbGltaXQgdGhlIGFtb3VudCBvZiBwcm9jZXNzZXMgaXQKPiB3aWxs
IHNwYXduLCBidXQgaXQgaXMgb25seSB1c2VkIGlmIHRoZSBvcHRpb24gc3RyX251bV9tZXNzYWdl
cyAoLW4pIGlzCj4gcGFzc2VkLiBUaGlzIGlzIGtub3duIHRvIGJlIHByb2JsZW1hdGljIGluIGxv
dyBtZW1vcnkgU1VUcywgc28gbWFrZSBzdXJlCj4gaXQncyB1c2VkLgo+IAo+IFN1Z2dlc3RlZC1i
eTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAt
IFNpbXBsaWZ5IFRXQVJOfFRJTkZPIGNoZWNrCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjUwNTEyLWZpeGVzLW1zZ3N0cmVzczAxLXYyLTEtNDlkZjczOWQ5M2Nh
QHN1c2UuY29tCj4gCj4gQ2hhbmdlcyBpbiB2MjoKPiAtIFByaW50IGEgbWVzc2FnZSBpZiBudW1f
bWVzc2FnZXMgdmFsdWUgaXMgcmVkdWNlZAo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDUxMi1maXhlcy1tc2dzdHJlc3MwMS12MS0xLWQzMzVmN2MxMzFjMEBz
dXNlLmNvbQo+IC0tLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvbXNnc3RyZXNz
L21zZ3N0cmVzczAxLmMgfCA2ICsrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dz
dHJlc3MvbXNnc3RyZXNzMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0
cmVzcy9tc2dzdHJlc3MwMS5jCj4gaW5kZXggYWU2MzdlNWQ3YWQ4OWMxMjU3YzljY2UwMTQ1MTIy
NDk3YzE5ZWU2NC4uMjJhMmMwZTdhYTUyYTM5NTZmNjIyMWZhMmQwOTk5MWI5ODcxZDQwZCAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dzdHJlc3MvbXNnc3Ry
ZXNzMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL21zZ3N0cmVzcy9t
c2dzdHJlc3MwMS5jCj4gQEAgLTI3MSw2ICsyNzEsMTIgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9p
ZCkKPiAgIAlpZiAodHN0X3BhcnNlX2ludChzdHJfbnVtX21lc3NhZ2VzLCAmbnVtX21lc3NhZ2Vz
LCAxLCBhdmFpbF9tc2cpKQo+ICAgCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBudW1iZXIgb2Yg
bWVzc2FnZXMgJyVzJyIsIHN0cl9udW1fbWVzc2FnZXMpOwo+ICAgCj4gKwlpZiAobnVtX21lc3Nh
Z2VzID4gYXZhaWxfbXNnKSB7Cj4gKwkJdHN0X3JlcyhhdmFpbF9tc2cgPCBudW1fbWVzc2FnZXMg
LyAyID8gVFdBUk4gOiBUSU5GTywKPiArCQkJIk51bWJlciBvZiBtZXNzYWdlcyByZWR1Y2VkIHRv
ICVkIiwgYXZhaWxfbXNnKTsKPiArCQludW1fbWVzc2FnZXMgPSBhdmFpbF9tc2c7Cj4gKwl9Cj4g
Kwo+ICAgCWlmICh0c3RfcGFyc2VfaW50KHN0cl9udW1faXRlcmF0aW9ucywgJm51bV9pdGVyYXRp
b25zLCAxLCBNQVhOUkVQUykpCj4gICAJCXRzdF9icmsoVEJST0ssICJJbnZhbGlkIG51bWJlciBv
ZiBtZXNzYWdlcyBpdGVyYXRpb25zICclcyciLCBzdHJfbnVtX2l0ZXJhdGlvbnMpOwo+ICAgCj4g
Cj4gLS0tCj4gYmFzZS1jb21taXQ6IDVkOGNiNWEzZWYzNzQ5ZWIyNmVlMjJkOTZjOTY1NGJmZGU0
MzAzMGYKPiBjaGFuZ2UtaWQ6IDIwMjUwNTEyLWZpeGVzLW1zZ3N0cmVzczAxLTQxNTdjZWI1NGIz
OAo+IAo+IEJlc3QgcmVnYXJkcywKCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5j
egpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElOVVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlr
b3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3plY2ggUmVwdWJsaWMKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
