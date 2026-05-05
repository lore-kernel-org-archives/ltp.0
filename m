Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373FEFF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 13:30:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9CF83E6AD7
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 15:30:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67BC23E24B4
 for <ltp@lists.linux.it>; Tue,  5 May 2026 15:26:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C96BF200985
 for <ltp@lists.linux.it>; Tue,  5 May 2026 15:26:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 819CB6AB3E;
 Tue,  5 May 2026 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777987604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKdsX2aWsPNwZ4YuS9mh5KCymmj6etqi7Z9yhV5ukHY=;
 b=SmcoL2OsjoO+QT+fvX3vOBGZHMHZAvXFd76tW1NSTzoLiM1jKEAxFl2u72JHBSKXYln6hp
 SemPX95BzNfDqNzcYmCB/EcU7y8VKnLcaXzbMI29QXVZ4nt8AFjZPCC6YmEEkGlogrNwxi
 95qAooSOnvbmRfzM0aFOcHcRT95a5uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777987604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKdsX2aWsPNwZ4YuS9mh5KCymmj6etqi7Z9yhV5ukHY=;
 b=FNBDb8eGp5VThhGNSBARnvHhRibYFIljHWL/yLnOlll+aoAYk3KF/tYWVTjFKAl/nsP1WJ
 AP0y3Wx2DBS1KWCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777987604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKdsX2aWsPNwZ4YuS9mh5KCymmj6etqi7Z9yhV5ukHY=;
 b=SmcoL2OsjoO+QT+fvX3vOBGZHMHZAvXFd76tW1NSTzoLiM1jKEAxFl2u72JHBSKXYln6hp
 SemPX95BzNfDqNzcYmCB/EcU7y8VKnLcaXzbMI29QXVZ4nt8AFjZPCC6YmEEkGlogrNwxi
 95qAooSOnvbmRfzM0aFOcHcRT95a5uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777987604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKdsX2aWsPNwZ4YuS9mh5KCymmj6etqi7Z9yhV5ukHY=;
 b=FNBDb8eGp5VThhGNSBARnvHhRibYFIljHWL/yLnOlll+aoAYk3KF/tYWVTjFKAl/nsP1WJ
 AP0y3Wx2DBS1KWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EEBC593A3;
 Tue,  5 May 2026 13:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IS8KFhTw+WkzTQAAD6G6ig
 (envelope-from <dwagner@suse.de>); Tue, 05 May 2026 13:26:44 +0000
Message-ID: <630b316a-1222-4227-90c9-8a3f5b4a3885@suse.de>
Date: Tue, 5 May 2026 15:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Chlad <sebastianchlad@gmail.com>, priyama2@linux.ibm.com
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
 <20260501151420.1042995-1-priyama2@linux.ibm.com>
 <CAJCsO8epT++TaOs7=NAy+jC4pQDN9tA-1n_tFy233sHKkJ697w@mail.gmail.com>
 <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
From: Daniel Wagner <dwagner@suse.de>
In-Reply-To: <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 05 May 2026 15:29:55 +0200
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, daniel.wagner@suse.com,
 ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiA1LzUvMjYgMTA6NDUgQU0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4+IEJlZm9yZSBn
b2luZyBmdXJ0aGVyLCBjb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gdGhlIGludGVuZGVkIExUUC0g
Cj4+IHNwZWNpZmljIHZhbHVlIG9mCj4+IHRoaXMgdGVzdD8gYmxrdGVzdHMgYWxyZWFkeSBoYXMg
YSBkZWRpY2F0ZWQgTlZNZSB0ZXN0IGdyb3VwIHdpdGggbXVjaCAKPj4gYnJvYWRlcgo+PiBjb3Zl
cmFnZSwgaW5jbHVkaW5nIGNvbnRyb2xsZXIvbmFtZXNwYWNlIGRpc2NvdmVyeSwgTlZNZSBjb21t
YW5kcywgCj4+IGZhYnJpY3MsIGV0Yy46CknigJl2ZSBoYWQgYSBxdWljayBsb29rIGF0IHRoZSB0
ZXN0IGF0dGFjaGVkIHRvIHRoaXMgZW1haWwgYW5kIEkgCmNvbXBsZXRlbHkgYWdyZWUgd2l0aCBT
ZWJhc3RpYW4uIFRoaXMgc2hvdWxkIGdvIGludG8gYmxrdGVzdHMuCgpXZSBhbHJlYWR5IGhhdmUg
YSBnb29kIGNvbGxlY3Rpb24gb2YgTlZNZS1zcGVjaWZpYyB0ZXN0cyB0aGVyZSwgc28gaXQgCndv
dWxkIGJlIGEgcGVyZmVjdCBmaXQuIFBsdXMsIHRoZSB1cHN0cmVhbSBkZXZlbG9wZXJzIHJ1biB0
aGUgYmxrdGVzdHMgCnN1aXRlIHJlZ3VsYXJseSBhZ2FpbnN0IGJvdGggdGhlIG1haW5saW5lIGFu
ZCAnbnZtZS1uZXh0JyBicmFuY2hlcy4gCk1vdmluZyBpdCB0aGVyZSB3b3VsZCBoZWxwIHVzIGNh
dGNoIGFueSBOVk1lIGlzc3VlcyB2ZXJ5IGVhcmx5IG9uLiAKSG9uZXN0bHksIEnigJltIG5vdCBx
dWl0ZSBzdXJlIGhvdyBvZnRlbiBMVFAgaXMgZXhlY3V0ZWQgZm9yIE5WTWUsIHNvIHRoaXMgCmZl
ZWxzIGxpa2UgdGhlIHNhZmVyIGJldCEKClRoYW5rcywKRGFuaWVsCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
