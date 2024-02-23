Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058CFC54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:51:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63C723D0070
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:51:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5289C3CCD58
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:51:19 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BBADB601561
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:51:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ED741F79C;
 Fri, 23 Feb 2024 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708696277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u+4wVWrFdMRlSGIQB0+3IhC+BF6+Xhh6vCe1/Q8uec=;
 b=FADbAe9p30hccBtJ3O8YSWMPwqK42MOzaBpgf+bIbuTieTFzCoYbh9hWXo1MgVn9Qyo8DT
 i7j8GzAuv/0JALCnTggVdxwAHrnw/wqWUaT8Nl/CqnxCMBFJFadLUNSS7NTA2yG0Q7ou3e
 aEVFcwDLX6AuDmCg1YpSH0r7BZrBRkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708696277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u+4wVWrFdMRlSGIQB0+3IhC+BF6+Xhh6vCe1/Q8uec=;
 b=aUr5SeoznSxhcnrhXOXPP98jKmbVv1fdDkyGvgKKPckCnJfmhris3snNcmNQXNEMFJSEZG
 X7nqKdLVR/RUcGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708696277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u+4wVWrFdMRlSGIQB0+3IhC+BF6+Xhh6vCe1/Q8uec=;
 b=FADbAe9p30hccBtJ3O8YSWMPwqK42MOzaBpgf+bIbuTieTFzCoYbh9hWXo1MgVn9Qyo8DT
 i7j8GzAuv/0JALCnTggVdxwAHrnw/wqWUaT8Nl/CqnxCMBFJFadLUNSS7NTA2yG0Q7ou3e
 aEVFcwDLX6AuDmCg1YpSH0r7BZrBRkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708696277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u+4wVWrFdMRlSGIQB0+3IhC+BF6+Xhh6vCe1/Q8uec=;
 b=aUr5SeoznSxhcnrhXOXPP98jKmbVv1fdDkyGvgKKPckCnJfmhris3snNcmNQXNEMFJSEZG
 X7nqKdLVR/RUcGBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 634FD13776;
 Fri, 23 Feb 2024 13:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id IhrLFtWi2GXrfAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 13:51:17 +0000
Date: Fri, 23 Feb 2024 14:51:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240223135115.GB1463543@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-2-pvorel@suse.cz>
 <20240105120300.GA1482331@pevik> <ZdiLwe8BNRDQRYiB@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdiLwe8BNRDQRYiB@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.69 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[49.86%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] metaparse: Print parsing file on verbose
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

PiBIaSEKPiA+IFRoaXMgaW50cm9kdWNlcyB3YXJuaW5nOgoKPiA+ICQgbWFrZSBtZXRhcGFyc2UK
PiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBtZXRhcGFyc2UuYzoxNzoKPiA+IEluIGZ1bmN0aW9u
IOKAmGRhdGFfbm9kZV9zdHJpbmfigJksCj4gPiAgICAgaW5saW5lZCBmcm9tIOKAmG1haW7igJkg
YXQgbWV0YXBhcnNlLmM6ODk0OjY6Cj4gPiBkYXRhX3N0b3JhZ2UuaDo4NDoyMDogd2FybmluZzog
YXJyYXkgc3Vic2NyaXB0IOKAmHN0cnVjdCBkYXRhX25vZGVbMF3igJkgaXMgcGFydGx5IG91dHNp
ZGUgYXJyYXkgYm91bmRzIG9mIOKAmHVuc2lnbmVkIGNoYXJbNl3igJkgWy1XYXJyYXktYm91bmRz
PV0KPiA+ICAgIDg0IHwgICAgICAgICBub2RlLT50eXBlID0gREFUQV9TVFJJTkc7Cj4gPiAgICAg
ICB8ICAgICAgICAgfn5+fn5+fn5+fn5efn5+fn5+fn5+fn5+Cj4gPiBkYXRhX3N0b3JhZ2UuaDo3
OTozNDogbm90ZTogb2JqZWN0IG9mIHNpemUgNiBhbGxvY2F0ZWQgYnkg4oCYbWFsbG9j4oCZCj4g
PiAgICA3OSB8ICAgICAgICAgc3RydWN0IGRhdGFfbm9kZSAqbm9kZSA9IG1hbGxvYyhzaXplKTsK
PiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
Cj4gPiBIT1NUQ0MgbWV0YWRhdGEvbWV0YXBhcnNlCgo+ID4gV2hhdCBhbSBJIG1pc3Npbmc/Cgo+
IFRoaXMgbG9va3MgbGlrZSB0aGUgY29tcGlsZXIgaXMgY29uZnVzZWQgYnkgdGhlIHVuaW9uIGFu
ZCBmbGV4aWJsZSBhcnJheQo+IGFuZCBzdGF0aWMgYW5hbHlzaXMgcHJvZHVjZXMgZ2liYmVyaXNo
LiBUaGUgdmVyeSBmYWN0IHRoYXQgdGhpcyBpcwo+IHRyaWdnZXJlZCBieSBhZGRpdGlvbiBvZiB1
bnJlbGF0ZWQgcGllY2Ugb2YgY29kZSBzdXBwb3J0cyB0aGF0IGh5cG90ZXNpcwo+IGFzIHdlbGwu
CgpUaGFua3MgZm9yIGluZm8uIFNvIHJlYWxseSBmYWxzZSBwb3NpdGl2ZT8gVGhlcmVmb3JlIHdl
IGhhdmUgbm90aGluZyB0byBpbXByb3ZlCmFuZCB3ZSBzaG91bGQgcmVwb3J0IHRvIGdjYz8KCktp
bmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
