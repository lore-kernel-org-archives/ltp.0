Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F899CD3427
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:29:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E60273E620C
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 16:29:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387863CF054
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:28:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A2ED3200939
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:28:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 337865C712;
 Tue,  5 May 2026 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777991335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJSHG2h2WZJPqb3V4tTtQPVfz53I0Vn4RJsqhapwStA=;
 b=JrIu8WoxgbzVOYGA2vQlJ3EZ2F698OjYk8wV7/WnUlrRNeaUbRMClCmZmRMeeNqIO+s3o7
 J1nZ7bhFQmVhpytFx6D3EdhonTQ1FiMTcsP5KthZlfI9YQ80rprQF0ECft45gEGVrYjzbf
 HZgWWd4eC2a769uyIFOfG/2/xa2EShY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777991335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJSHG2h2WZJPqb3V4tTtQPVfz53I0Vn4RJsqhapwStA=;
 b=PaqZbc4QOxw2b7c4LbT3CZyWcOk65h2xY9XtIvBkKiyBGexmbyjSssqDVsPn1DOO4wKzQw
 O5a3A7sHzMAwmgCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777991335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJSHG2h2WZJPqb3V4tTtQPVfz53I0Vn4RJsqhapwStA=;
 b=JrIu8WoxgbzVOYGA2vQlJ3EZ2F698OjYk8wV7/WnUlrRNeaUbRMClCmZmRMeeNqIO+s3o7
 J1nZ7bhFQmVhpytFx6D3EdhonTQ1FiMTcsP5KthZlfI9YQ80rprQF0ECft45gEGVrYjzbf
 HZgWWd4eC2a769uyIFOfG/2/xa2EShY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777991335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJSHG2h2WZJPqb3V4tTtQPVfz53I0Vn4RJsqhapwStA=;
 b=PaqZbc4QOxw2b7c4LbT3CZyWcOk65h2xY9XtIvBkKiyBGexmbyjSssqDVsPn1DOO4wKzQw
 O5a3A7sHzMAwmgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3D94593A3;
 Tue,  5 May 2026 14:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eioEOKb++WmkDwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Tue, 05 May 2026 14:28:54 +0000
Message-ID: <b8fe44d0-31e1-4813-a279-c2021567f883@suse.de>
Date: Tue, 5 May 2026 16:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260331220354.297027-1-rbranco@suse.de>
 <20260411094742.219667-1-rbranco@suse.de>
 <20260411094742.219667-2-rbranco@suse.de> <afn62QQkJgwO28hE@yuki.lan>
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <afn62QQkJgwO28hE@yuki.lan>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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

CgpPbiA1LzUvMjYgNDoxMiBQTSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+PiArc3RhdGljIHZvaWQg
cnVuKHZvaWQpCj4+ICt7Cj4+ICsJcHRocmVhZF90IHRocjsKPj4gKwlzdHJ1Y3QgdWZmZGlvX2Fw
aSB1ZmZkaW9fYXBpID0ge307Cj4+ICsJc3RydWN0IHVmZmRpb19yZWdpc3RlciB1ZmZkaW9fcmVn
aXN0ZXI7Cj4+ICsKPj4gKwlzZXRfcGFnZXMoKTsKPj4gKwo+PiArCXVmZmQgPSBTQUZFX1VTRVJG
QVVMVEZEKE9fQ0xPRVhFQyB8IE9fTk9OQkxPQ0ssIHRydWUpOwo+PiArCXVmZmRpb19hcGkuYXBp
ID0gVUZGRF9BUEk7Cj4+ICsJdWZmZGlvX2FwaS5mZWF0dXJlcyA9IDA7Cj4+ICsJU0FGRV9JT0NU
TCh1ZmZkLCBVRkZESU9fQVBJLCAmdWZmZGlvX2FwaSk7Cj4+ICsJaWYgKCEodWZmZGlvX2FwaS5m
ZWF0dXJlcyAmIFVGRkRfRkVBVFVSRV9NSU5PUl9TSE1FTSkpCj4+ICsJCXRzdF9icmsoVENPTkYs
ICJVRkZEX0ZFQVRVUkVfTUlOT1JfU0hNRU0gbm90IHN1cHBvcnRlZCIpOwo+PiArCVNBRkVfQ0xP
U0UodWZmZCk7Cj4+ICsKPj4gKwl1ZmZkID0gU0FGRV9VU0VSRkFVTFRGRChPX0NMT0VYRUMgfCBP
X05PTkJMT0NLLCBmYWxzZSk7Cj4+ICsKPj4gKwl1ZmZkaW9fYXBpLmFwaSA9IFVGRkRfQVBJOwo+
PiArCXVmZmRpb19hcGkuZmVhdHVyZXMgPSBVRkZEX0ZFQVRVUkVfTUlOT1JfU0hNRU07Cj4+ICsK
Pj4gKwlTQUZFX0lPQ1RMKHVmZmQsIFVGRkRJT19BUEksICZ1ZmZkaW9fYXBpKTsKPj4gKwo+PiAr
CXVmZmRpb19yZWdpc3Rlci5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKSBwYWdlOwo+PiAr
CXVmZmRpb19yZWdpc3Rlci5yYW5nZS5sZW4gPSBwYWdlX3NpemU7Cj4+ICsJdWZmZGlvX3JlZ2lz
dGVyLm1vZGUgPSBVRkZESU9fUkVHSVNURVJfTU9ERV9NSU5PUjsKPj4gKwo+PiArCVNBRkVfSU9D
VEwodWZmZCwgVUZGRElPX1JFR0lTVEVSLCAmdWZmZGlvX3JlZ2lzdGVyKTsKPj4gKwo+PiArCS8q
Cj4+ICsJICogRHJvcCBQVEVzIHdoaWxlIHJldGFpbmluZyB0aGUgY2FjaGVkIHNobWVtIHBhZ2Ug
c28gdGhlIG5leHQgYWNjZXNzCj4+ICsJICogZmF1bHRzIGluIE1JTk9SIG1vZGUuCj4+ICsJICov
Cj4+ICsJaWYgKG1hZHZpc2UocGFnZSwgcGFnZV9zaXplLCBNQURWX0RPTlRORUVEKSA8IDApCj4+
ICsJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJtYWR2aXNlIE1BRFZfRE9OVE5FRUQgZmFpbGVk
Iik7Cj4+ICsKPj4gKwlTQUZFX1BUSFJFQURfQ1JFQVRFKCZ0aHIsIE5VTEwsICh2b2lkICopIGhh
bmRsZV90aHJlYWQsIE5VTEwpOwo+PiArCj4+ICsJY2hhciBjID0gcGFnZVswXTsKPj4gKwo+PiAr
CWlmIChjID09ICdaJykKPj4gKwkJdHN0X3JlcyhUUEFTUywgIlBhZ2VmYXVsdCBoYW5kbGVkIHZp
YSBVRkZESU9fQ09OVElOVUUiKTsKPj4gKwllbHNlCj4+ICsJCXRzdF9yZXMoVEZBSUwsICJwYWdl
ZmF1bHQgbm90IGhhbmRsZWQgdmlhIFVGRkRJT19DT05USU5VRSwgZ290ICclYyciLCBjKTsKPj4g
Kwo+PiArCVNBRkVfUFRIUkVBRF9KT0lOKHRociwgTlVMTCk7Cj4+ICsJcmVzZXRfcGFnZXMoKTsK
Pj4gK30KPj4gKwo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiArCS50ZXN0
X2FsbCA9IHJ1biwKPj4gKwkvKgo+PiArCSAqIFVGRkRJT19DT05USU5VRSBpcyBhdmFpbGFibGUg
c2luY2UgNS4xMyBidXQKPj4gKwkgKiBVRkZEX0ZFQVRVUkVfTUlOT1JfU0hNRU0gYXBwZWFyZWQg
aW4gNS4xNAo+PiArCSAqLwo+PiArCS5taW5fa3ZlciA9ICI1LjE0IiwKPiBTaG91bGQgd2UgZG8g
YSBydW50aW1lIGNoZWNrIGluIHRoZSB0ZXN0IHNldHVwIGhlcmUgYXMgd2VsbD8KCldlJ3JlIGNo
ZWNraW5nIGZvciBVRkZEX0ZFQVRVUkVfTUlOT1JfU0hNRU3CoCBpdCB0aGUgMiBzdGVwIGhhbmRz
aGFrZS4KCkNoZWVycywKUgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
