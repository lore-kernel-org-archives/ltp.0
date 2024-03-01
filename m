Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B539BC5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 10:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E9833D02DB
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 11:54:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE543D02D2
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:54:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 869E0140015F
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 11:54:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43B323376F;
 Fri,  1 Mar 2024 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709290483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MixNpOd/KZ+uaKaijqqSLmuFYU3+B/Cu+7YHAi+sN0=;
 b=sfG2uJrQjzZsyOQBApbEFDJlv4ZcwHuljpk1W3yXezwlVDb4S8t+HHFJGLa1I3XDxmqqBR
 36Rg8Q0Dji/wyz7Ji1PMbsUK6nuC97QO3YOdnSjxVraCAMXLdsdSBsyEqT0KB953Jb12R0
 N2r2IVJ08OyspuYXwY0ZXAdEtuUsWKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709290483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MixNpOd/KZ+uaKaijqqSLmuFYU3+B/Cu+7YHAi+sN0=;
 b=mUs33VoXQA58KldlYcIoDQyhK7zcTnz6TRlwfcLpwzd1FWljqahnO+OAjQi/4OhqhuOOoY
 Cbq4uBoSQjPET9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709290483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MixNpOd/KZ+uaKaijqqSLmuFYU3+B/Cu+7YHAi+sN0=;
 b=sfG2uJrQjzZsyOQBApbEFDJlv4ZcwHuljpk1W3yXezwlVDb4S8t+HHFJGLa1I3XDxmqqBR
 36Rg8Q0Dji/wyz7Ji1PMbsUK6nuC97QO3YOdnSjxVraCAMXLdsdSBsyEqT0KB953Jb12R0
 N2r2IVJ08OyspuYXwY0ZXAdEtuUsWKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709290483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MixNpOd/KZ+uaKaijqqSLmuFYU3+B/Cu+7YHAi+sN0=;
 b=mUs33VoXQA58KldlYcIoDQyhK7zcTnz6TRlwfcLpwzd1FWljqahnO+OAjQi/4OhqhuOOoY
 Cbq4uBoSQjPET9BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DE91713A39;
 Fri,  1 Mar 2024 10:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id xp5oNPKz4WUIKwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 10:54:42 +0000
Date: Fri, 1 Mar 2024 11:54:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240301105437.GB1661970@pevik>
References: <20240214170949.793338-1-pvorel@suse.cz>
 <20240214170949.793338-4-pvorel@suse.cz>
 <CAEemH2cuq7P_eK8fFR37ZgAF+w84Fkcat_BRM9nmXpmoODkuYg@mail.gmail.com>
 <20240301085916.GA1661970@pevik>
 <CAOQ4uxguhb-yRexA=aLCTxzA=mP3T_M7mR+WS4vZuHK8L_XmUw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxguhb-yRexA=aLCTxzA=mP3T_M7mR+WS4vZuHK8L_XmUw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.73 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.43)[78.39%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tree: Relicense GPL-2.0 (v2 only) =>
 GPL-2.0-or-later
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBGcmksIE1hciAxLCAyMDI0IGF0IDEwOjU54oCvQU0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gSGkgUGV0ciwKCj4gPiA+
IEFsbCBsb29rcyBnb29kIHRvIG1lLiBGZWVsIGZyZWUgdG8gbWVyZ2UgdGhpcyBwYXRjaHNldC4K
Cj4gPiBUaGFuayB5b3UhIEZZSSBJJ20gc3RpbGwgd2FpdGluZyBmb3IgQW1pcidzIGFjay4KCgo+
IEFja2VkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoKVGhhbmtzIGEg
bG90LCBBbWlyIQoKPiBUaGFua3MsCj4gQW1pci4KCj4gPiBJIGd1ZXNzIHdlIGNvdWxkIHJlbGlj
ZW5zZSBSaWNoaWUncyB3b3JrIHdpdGhvdXQgaGlzIGFjayAoU1VTRSB3b3JrIGFjdHVhbGx5KSwK
PiA+IGJ1dCBhdCBsZWFzdCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb3NlX3JhbmdlL2Ns
b3NlX3JhbmdlMDEuYyBpcyBmcm9tCj4gPiBrc2VsZnRlc3QgKHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2NvcmUvY2xvc2VfcmFuZ2VfdGVzdC5jKSwgd2hpY2ggaXMgR1BMIHYyCj4gPiBvbmx5LCBJ
IHN1cHBvc2UgSSBzaG91bGQgdXNlIEdQTC0yLjAtb25seSBmb3IgdGhpcyBvbmUuCj4gPiBJIGhh
dmVuJ3QgZm91bmQgYSByZWNvcmQgdGhhdCBvdGhlciB0d28gZnJvbSBSaWNoaWUgd291bGQgYmUg
ZnJvbSBrc2VsZnRlc3QsCj4gPiB0aHVzIEknbGwgdXNlIEdQTC0yLjAtb3ItbGF0ZXIgZm9yIHRo
ZW0uCgpQYXRjaHNldCBtZXJnZWQgd2l0aCB0aGVzZSBjaGFuZ2VzIGluIHRoZSBzZWNvbmQgY29t
bWl0LgoKVGhhbmtzIHRvIHlvdSBhbGwuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBLaW5kIHJl
Z2FyZHMsCj4gPiBQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
