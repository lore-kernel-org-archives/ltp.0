Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF09DC5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 09:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40DC23CFE0A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 10:08:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D445D3CBDCE
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 10:08:04 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6D38100205C
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 10:08:03 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A16044EE6E;
 Fri,  8 Mar 2024 08:56:29 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 89B461391D;
 Fri,  8 Mar 2024 08:56:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id z1pEIL3S6mXLMQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Mar 2024 08:56:29 +0000
Date: Fri, 8 Mar 2024 09:56:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240308085628.GB257921@pevik>
References: <20240308045230.3106549-1-liwang@redhat.com>
 <20240308045230.3106549-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308045230.3106549-3-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: A16044EE6E
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] stack_clash: make use of tst_kcmdline_parse
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

SGkgTGksCgo+ICB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAtCWNoYXIgYnVmWzQwOTZdLCAqcDsK
PiArCWNoYXIgKnA7CnN0YWNrX2NsYXNoLmM6Mjc2OjE1OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFi
bGUg4oCYcOKAmSBbLVd1bnVzZWQtdmFyaWFibGVdCiAgMjc2IHwgICAgICAgICBjaGFyICpwOwog
ICAgICB8ICAgICAgICAgICAgICAgXgoKPiAgCXBhZ2Vfc2l6ZSA9IHN5c2NvbmYoX1NDX1BBR0VT
SVpFKTsKPiAgCXBhZ2VfbWFzayA9IH4ocGFnZV9zaXplIC0gMSk7Cgo+IC0JYnVmWzQwOTVdID0g
J1wwJzsKPiAtCVNBRkVfRklMRV9TQ0FORigiL3Byb2MvY21kbGluZSIsICIlNDA5NVteXG5dIiwg
YnVmKTsKPiArCXN0cnVjdCB0c3Rfa2NtZGxpbmVfcGFyYW0gcGFyYW1zID0gVFNUX0tDTURMSU5F
X0lOSVQoInN0YWNrX2d1YXJkX2dhcCIpOwo+ICsJdHN0X2tjbWRsaW5lX3BhcnNlKCZwYXJhbXMs
IDEpOwoKPiAtCWlmICgocCA9IHN0cnN0cihidWYsICJzdGFja19ndWFyZF9nYXA9IikpICE9IE5V
TEwpIHsKPiAtCQlpZiAoc3NjYW5mKHAsICJzdGFja19ndWFyZF9nYXA9JWxkIiwgJkdBUF9QQUdF
UykgIT0gMSkgewo+IC0JCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAic3NjYW5mIik7Cj4gLQkJ
CXJldHVybjsKPiAtCQl9Cj4gKwlpZiAocGFyYW1zLnZhbHVlWzBdICE9ICdcMCcpIHsKPiArCQlH
QVBfUEFHRVM9IGF0b2wocGFyYW1zLnZhbHVlKTsKPiAgCQl0c3RfcmVzKFRJTkZPLCAic3RhY2tf
Z3VhcmRfZ2FwID0gJWxkIiwgR0FQX1BBR0VTKTsKPiAgCX0KCk90aGVyd2lzZSBMR1RNLgpSZXZp
ZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpLaW5kIHJlZ2FyZHMsClBldHIK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
