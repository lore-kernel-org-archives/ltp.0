Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C717606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qoek/+Ex;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om99IkZR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qoek/+Ex;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Om99IkZR
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08DC83E9FCA
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:11:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 918C73EA95E
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:10:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C38B60004C
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:10:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85B8D223D6;
 Wed, 25 Nov 2026 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795641023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrH/scbMVefqWNkgWU3rB3t7Ri4e8wMWVqAtRlfI1ZA=;
 b=qoek/+ExV3YYh48qwcTzRFwCUgN3WYperqfhxqO3+mznpWAtLV6Zgfd2yhcUZC2op3uNAn
 EHGklek2yppDj6+X3wJU1zLCJXaLa3HVNFfvpZFNvmEnCYkum+PIh9isRdvlN2S/vw/z0n
 Xpenwh5ChNwi+07S7Jtv9qDzWy0IFZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795641023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrH/scbMVefqWNkgWU3rB3t7Ri4e8wMWVqAtRlfI1ZA=;
 b=Om99IkZRx/M/YzLX/MqSAz8YwR6KEV4QNb0XHBJhm++G9g1id0l6wPe1Ulpx5qLicozK6k
 nPH4h344di4Ct9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795641023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrH/scbMVefqWNkgWU3rB3t7Ri4e8wMWVqAtRlfI1ZA=;
 b=qoek/+ExV3YYh48qwcTzRFwCUgN3WYperqfhxqO3+mznpWAtLV6Zgfd2yhcUZC2op3uNAn
 EHGklek2yppDj6+X3wJU1zLCJXaLa3HVNFfvpZFNvmEnCYkum+PIh9isRdvlN2S/vw/z0n
 Xpenwh5ChNwi+07S7Jtv9qDzWy0IFZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795641023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrH/scbMVefqWNkgWU3rB3t7Ri4e8wMWVqAtRlfI1ZA=;
 b=Om99IkZRx/M/YzLX/MqSAz8YwR6KEV4QNb0XHBJhm++G9g1id0l6wPe1Ulpx5qLicozK6k
 nPH4h344di4Ct9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C5ED134CA;
 Wed, 25 Nov 2026 21:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lDN+O75OB2vVfwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Wed, 25 Nov 2026 21:10:23 +0000
Message-ID: <9cfaf9b9-a55a-49f5-817b-0635a76cf174@suse.de>
Date: Wed, 25 Nov 2026 22:10:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20261124180149.614825-1-rbranco@suse.de>
 <awbS7qkrPNhm7Kfq@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <awbS7qkrPNhm7Kfq@yuki.lan>
X-Spamd-Result: default: False [-17.27 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-0.98)[-0.983];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]
X-Spam-Score: -17.27
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add tests for UFFDIO_RWPROTECT
 and UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAxMS8yNS8yNiAxOjIyIFBNLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gU2hvdWxkbid0IHRo
aXMgcGFydCBiZSBpbiBlbHNlIGJyYW5jaD8gT3RoZXJ3aXNlIHdlIHJ1biBib3RoIHRlc3RzIGZv
ciBuCj4gPSAxLgoKIMKgIFRoYXQncyBpbnRlbnRpb25hbC4gRm9yIG4gPSAxIHRoZSB0aGluZyB1
bmRlciB0ZXN0IGlzIFVGRkRJT19TRVRfTU9ERToKIMKgIGFmdGVyIGRpc2FibGluZyBSV1BfQVNZ
TkMsIHRoZSBvbmx5IHdheSB0byB2ZXJpZnkgdGhlIHN3aXRjaCB0b29rIGVmZmVjdAogwqAgaXMg
dG8gc2hvdyB0aGF0IHRoZSBuZXh0IGFjY2VzcyBvbiBhIHJlLXByb3RlY3RlZCBwYWdlIGJsb2Nr
cyBhbmQgaXMKIMKgIGRlbGl2ZXJlZCBhcyBhIGZhdWx0LiBXaXRob3V0IHRoYXQgc2Vjb25kIGhh
bGYgd2UnZCBvbmx5IGJlIGNoZWNraW5nCiDCoCB0aGF0IHRoZSBpb2N0bCByZXR1cm5zIDAuCgo+
IEkgc3VwcG9zZSB0aGF0IHdlIHdvdWxkIGhhdmUgdG8gcnVuIHRoZSBoYW5kbGVfdGhyZWFkIGlu
IHRoZSBmaXJzdCBpZgo+IGJyYW5jaCBhcyB3ZWxsLCBidXQgbm90IGFzIGEgdGhyZWFkLCBzaW5j
ZSBpdCdzIGFzeW5jaHJvbm91cyB3ZSBjYW4gcnVuCj4gaXQgYXMgYSBub3JtYWwgZnVuY3Rpb24u
CgoKIMKgIFdpdGggVUZGRF9GRUFUVVJFX1JXUF9BU1lOQyB0aGUga2VybmVsIHJlc29sdmVzIHRo
ZSBhY2Nlc3MgaXRzZWxmIGFuZAogwqAgbm8gZmF1bHQgbWVzc2FnZSBpcyBxdWV1ZWQgYXQgYWxs
LCBzbyBoYW5kbGVfdGhyZWFkKCkgd291bGQgYmxvY2sgaW4KIMKgIHBvbGwoKSBmb3JldmVyLiBU
aGUgYXN5bmMgYnJhbmNoIGFjdHVhbGx5IGFzc2VydHMgdGhhdDogYWZ0ZXIgdGhlCiDCoCBhY2Nl
c3MgaXQgY2hlY2tzIHRoYXQgcG9sbCgpIG9uIHRoZSB1ZmZkIHdpdGggYSB6ZXJvIHRpbWVvdXQg
cmV0dXJucyAwLgoKIMKgIEluIHY1IEknbGwgc3BsaXQgdGhlIHR3byBwaGFzZXMgaW50byBjaGVj
a19hc3luY19hY2Nlc3MoKSBhbmQKIMKgIGNoZWNrX3N5bmNfZmF1bHQoKSBoZWxwZXJzIHdpdGgg
YSBjb21tZW50IGluIHJ1bigpLCBzbyB0aGUgZmxvdyBpcwogwqAgZXhwbGljaXQ6IG4gPSAwIHJ1
bnMgb25seSB0aGUgc3luYyBjaGVjaywgbiA9IDEgcnVucyB0aGUgYXN5bmMgY2hlY2ssCiDCoCB0
aGVuIFVGRkRJT19TRVRfTU9ERSwgdGhlbiB0aGUgc3luYyBjaGVjay4KCkJlc3QsClJpY2FyZG8K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
