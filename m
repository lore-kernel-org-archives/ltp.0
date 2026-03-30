Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C577FB3CE8
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 900DD3E4F04
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 11:24:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 010DE3CB570
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:24:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E4BA10000C8
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 11:24:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 725205BE97;
 Mon, 30 Mar 2026 09:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774862648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLRUPM4mKFV1UsIXASEx49gpcGa2/xzP+3y98JmyREo=;
 b=HzGTvKD3P1M22byukw6qipE42JlhflND7mwhGqBRTLzp4l8kbc1zOp4GVcpOjl9UMdPsu6
 VNDQCdGUC+zyRqbLciKdeHQMnlpBGUuSZYTbxxw2ntipPXYaH0+JqL31nMdqQP8jvPK6wq
 y4qFkQaGJtXnsZAJvlBHTOpZT1qZmh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774862648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLRUPM4mKFV1UsIXASEx49gpcGa2/xzP+3y98JmyREo=;
 b=W2ari99Xf0ViJqolncmt58//bbPJzy2AIEVUtF43QHk0/EmOriIU5sSnlwk/IACn6eIGdA
 GLBjuyilr/im9sBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774862648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLRUPM4mKFV1UsIXASEx49gpcGa2/xzP+3y98JmyREo=;
 b=HzGTvKD3P1M22byukw6qipE42JlhflND7mwhGqBRTLzp4l8kbc1zOp4GVcpOjl9UMdPsu6
 VNDQCdGUC+zyRqbLciKdeHQMnlpBGUuSZYTbxxw2ntipPXYaH0+JqL31nMdqQP8jvPK6wq
 y4qFkQaGJtXnsZAJvlBHTOpZT1qZmh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774862648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLRUPM4mKFV1UsIXASEx49gpcGa2/xzP+3y98JmyREo=;
 b=W2ari99Xf0ViJqolncmt58//bbPJzy2AIEVUtF43QHk0/EmOriIU5sSnlwk/IACn6eIGdA
 GLBjuyilr/im9sBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 573994A0A2;
 Mon, 30 Mar 2026 09:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bWyMEzhBymlFHAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Mon, 30 Mar 2026 09:24:08 +0000
Message-ID: <91b22331-8fef-49c2-8976-0389c6064505@suse.de>
Date: Mon, 30 Mar 2026 11:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <69ca34fd.050a0220.3c7430.fd79@mx.google.com>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <69ca34fd.050a0220.3c7430.fd79@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd: Add test using UFFDIO_CONTINUE
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

CgpPbiAzLzMwLzI2IDEwOjMxIEFNLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+PiArc3RhdGlj
IGludCBwYWdlX3NpemU7Cj4+ICtzdGF0aWMgY2hhciAqcGFnZTsKPj4gK3N0YXRpYyBpbnQgdWZm
ZDsKPj4gK3N0YXRpYyBpbnQgbWVtZmQgPSAtMTsKPiB1ZmZkIG11c3QgYmUgaW5pdGlhbGl6ZWQg
dG8gLTEuIFplcm8gaXMgYSB2YWxpZCBmZCAoc3RkaW4pLgoKV2lsbCBhbHNvIGZpeCB0aGUgb3Ro
ZXIgdGVzdHMgaW4gdGhlICJNaW5vciBmaXhlcyIgcGF0Y2guCgo+IEFsc28sIHJlc2V0X3BhZ2Vz
KCkgaXMgdGhlIC5jbGVhbnVwIGNhbGxiYWNrIGJ1dCBuZXZlciBjbG9zZXMgdWZmZC4gSWYKPiBy
dW4oKSBhYm9ydHMgYWZ0ZXIgU0FGRV9VU0VSRkFVTFRGRCgpIGJ1dCBiZWZvcmUgc3Bhd25pbmcg
dGhlIHRocmVhZAo+IChlLmcuIFRDT05GIGF0IHRoZSBmZWF0dXJlIGNoZWNrKSwgdWZmZCBsZWFr
cy4gQWRkOgo+Cj4gCWlmICh1ZmZkICE9IC0xKQo+IAkJU0FGRV9DTE9TRSh1ZmZkKTsKCkRpdHRv
LgoKPj4gKwlTQUZFX0lPQ1RMKHVmZmQsIFVGRkRJT19DT05USU5VRSwgJnVmZmRpb19jb250aW51
ZSk7Cj4+ICsKPj4gKwljbG9zZSh1ZmZkKTsKPj4gKwlyZXR1cm4gTlVMTDsKPiBVc2UgU0FGRV9D
TE9TRSh1ZmZkKSBpbnN0ZWFkIG9mIGNsb3NlKHVmZmQpLgoKRGl0dG8gaGVyZS4KCj4+ICsJdWZm
ZGlvX2NvbnRpbnVlLnJhbmdlLnN0YXJ0ID0KPj4gKwkJbXNnLmFyZy5wYWdlZmF1bHQuYWRkcmVz
cyAmIH4ocGFnZV9zaXplIC0gMSk7Cj4gcGFnZV9zaXplIGlzIGludCwgc28gfihwYWdlX3NpemUg
LSAxKSBwcm9kdWNlcyBhIHNpZ25lZCBpbnQgbWFzayB0aGF0Cj4gZ2V0cyBzaWduLWV4dGVuZGVk
IHdoZW4gYXBwbGllZCB0byB0aGUgX191NjQgYWRkcmVzcy4gQ2FzdCB0byBhdm9pZAo+IHJlbHlp
bmcgb24gaW1wbGVtZW50YXRpb24tZGVmaW5lZCBiZWhhdmlvcjoKPgo+IAltc2cuYXJnLnBhZ2Vm
YXVsdC5hZGRyZXNzICYgfigodW5zaWduZWQgbG9uZylwYWdlX3NpemUgLSAxKTsKClNoYWxsIHdl
IGRlY2xhcmUgcGFnZV9zaXplIGFzIGxvbmcgYmVjYXVzZSBzeXNjb25mKCkgcmV0dXJucyBsb25n
PwoKQWxzbyBuZWVkcyBmaXhpbmcgdGhlIG90aGVyIHRlc3RzLsKgIEkgdXNlZCB1c2VyZmF1bHRm
ZDAxLmMgYXMgdGVtcGxhdGUuCgpCZXN0LApSaWNhcmRvLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
