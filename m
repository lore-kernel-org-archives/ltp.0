Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD3CFD313
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 13:17:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13A253C86BD
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 14:17:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5DA53C83EC
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:17:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CC401A002D9
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 14:17:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A03685BEF8;
 Mon, 24 Nov 2025 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763990245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjO2taTzG4zb+i3scyGLQiwdNDa6462J3sKy3WOKzMU=;
 b=EBbnJ1TJsKHxYfcMjr01RaVWy3PwNcE5ZxLF36mE/U0G+wDjwJOWRAElvxJME4+UKYssEM
 EMsbTVTGEVyJ8GbFGbNebgW+G3gNm9zFfeg5ryQ5iUgv9CxgGT9frE1iNS6APmWLZcBLm3
 HS02zxDPmNL+/kei1QTh2Y/5VcbC4Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763990245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjO2taTzG4zb+i3scyGLQiwdNDa6462J3sKy3WOKzMU=;
 b=xrAGqPdXT+Yhjbb/1oxnCwHHFWJhfMsgm9af97KeYtT41upMrlKpJjrVuyzn86lGsINOq9
 9zk4LqFkvieTwSDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763990245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjO2taTzG4zb+i3scyGLQiwdNDa6462J3sKy3WOKzMU=;
 b=EBbnJ1TJsKHxYfcMjr01RaVWy3PwNcE5ZxLF36mE/U0G+wDjwJOWRAElvxJME4+UKYssEM
 EMsbTVTGEVyJ8GbFGbNebgW+G3gNm9zFfeg5ryQ5iUgv9CxgGT9frE1iNS6APmWLZcBLm3
 HS02zxDPmNL+/kei1QTh2Y/5VcbC4Bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763990245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjO2taTzG4zb+i3scyGLQiwdNDa6462J3sKy3WOKzMU=;
 b=xrAGqPdXT+Yhjbb/1oxnCwHHFWJhfMsgm9af97KeYtT41upMrlKpJjrVuyzn86lGsINOq9
 9zk4LqFkvieTwSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F5F13EA61;
 Mon, 24 Nov 2025 13:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J5S/IeVaJGlcSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Nov 2025 13:17:25 +0000
Date: Mon, 24 Nov 2025 14:18:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aSRbG5o-lTPtG7wB@yuki.lan>
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan> <20251121104506.GA25561@pevik>
 <aSBQDg8PRXFK8GxB@yuki.lan>
 <CAEemH2fN=byf4dKvCk82KKuA9fRk0M6uh1GmMfiY2EPOk=X_Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fN=byf4dKvCk82KKuA9fRk0M6uh1GmMfiY2EPOk=X_Zg@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gVGhpcyBpcyBhIG5pY2UgaW1wcm92ZW1lbnQsIGJ1dCBvbmUgdGhpbmcgY29tZXMgdG8g
bXkgbWluZCB0aGF0Cj4gZ2V0X2NhY2hlZF9zaXplKCkgcmVhZHMgdGhlIHN5c3RlbSB3aWRlIOKA
nENhY2hlZOKAnSBzaXplIGZyb20KPiAnL3Byb2MvbWVtaW5mbycgbWlnaHQgbm90IGJlIHJlbGlh
YmxlIGluIHRoZSB0ZXN0IChwcm9iYmFseSBpbXBhY3QKPiBmcm9tIG90aGVyIHByb2dyZXNzKS4K
PiAKPiBTbywgaG93IGFib3V0IHVzaW5nIG1pbmNvcmUoKSB3b3JrcyBvbiB0aGUgY3VycmVudGx5
IG1hcHBlZCBwYWdlcwo+IHRvIGNvdW50IHRoZSByZXNpZGVudCBieXRlcyBpbiBtZW1vcnk/CgpJ
IGd1ZXNzIHRoYXQgd2UgY2FuIGRvIHRoYXQgaW4gYSBzdWJzZXF1ZW50IHBhdGNoLiBJJ3ZlIGp1
c3Qgc2VudApzbGlnaHRseSBtb2RpZmllZCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guCgotLSAKQ3ly
aWwgSHJ1YmlzCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
