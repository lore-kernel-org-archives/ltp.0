Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D793C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 20:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785356368; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=9RjtQHqgZX5XLQ4gQlN5WZJB/b8fP85biekVgxNVFdI=;
 b=Y4ZBtd1uOur9AT8xUfzMPNDD9pv3MOGSr2hOu3/H48XHfG/2E08bAcbUAqe53Z3CpWtmV
 wMcpVMJ7+dX+u5YRrXEcocwenxsubwR8ZsNREQ4KTzGvRlFa68oLTqP9gkgriNbJJnTB0p2
 hARlcEbAiuOU3P0+c2WS3X7SVGhMMC4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C9563E7293
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 22:19:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B54013E1664
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 22:19:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0DB042001C6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 22:19:06 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so8623715e9.3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785356346; x=1785961146; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yteK99NdPx8rdcyNP1Wze6NZu6eb29JHuOMitsqpjFY=;
 b=MWuchGZx3yHMRLDg8j2BRLNTfTa9i4P9GrKgV0ebYjUQOq5p49RtLu/+JqNjuK0g6G
 zj838CxKFLWO6yanA2OrsZtvosRv3VlYGv0/VSa6fyAMxeTFCkvyvyiJWzVAZgZ3Llz+
 IRTlzXdQ8y0Zku926zYpiBtb3ApeBzr56BhhYEYD7epz81uc582vop7FG5yb06ykUP/o
 uwIjmh5827a85d+sAQeno+V73QebCCHlgsMtO3fIrcRjiJLEnLZKn2vhYPSy7PCqVrZW
 0jsb8S5uxnLRuVwEbmWg4cPI8ZGDkyskuvHW3V1kj8d54SxHH89cHXMahXXtMnAZFU/3
 bakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785356346; x=1785961146;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yteK99NdPx8rdcyNP1Wze6NZu6eb29JHuOMitsqpjFY=;
 b=DWRm0BGG5ZrPzmiiD/w25XTMcxzXn0N/0qLRoL25wEXc/UFABiLRVzxT2LtV28fCbg
 VLH6Vrjplz10xajVQH2t0EdmbNkc9urUJLkJMoFENmSXuJHWt9gGWndsMlUIA3wOoxBn
 t+I/0txHZdeqLH7SXEZoVma74YED/2914rmGoZ8I2a7omSxmINm13SNw/K28Da19Xyv0
 nO/QHHHkgVhc3d7S6+7mWZyNbw3fxNZWJEzwOFr5qG6vaa9vH/4V9AvSefqsgMZC+35d
 6wPHpjZ4Hnbm0xyST4kqm8ZuXoCGiMv4T1I41KDxum11ZKjhE+z0FmRdjWj+RB9p4bg8
 k3+w==
X-Gm-Message-State: AOJu0Yzq6Hf2p8EevSDw4q4iNMKZQH++2iuIa4LXt8wux1cf2PLBmxIY
 xLoBHS0tHGVllHEIYshfvzxZ2EBwuJi7qn7QbHcWXvz7UyvJnGIGi1iV+XHLCXoD6ZD1IksyF3Z
 tQFfbqSA=
X-Gm-Gg: AR+sD13WHB9l7fKaMehohMxntSV+qsOlBzqwcZu5aSVmNOsPsi9Ugj4NfWK8pnm7u0F
 ePOj0Yop2wH/juG719gVfm+s9XFwbegKu15Fe91QNBNv7tpCS6jIpHqoC8xDi89CvRE+Y58AHC6
 y+JzjloZgRorFDSsvr0cyaDZNLyuGXdfOgfP2IIgFnBfjGFnrZ0BTSua03OVCfwtV4Y3aO3xUd/
 w1q2TA2DGFv5ZhbZY8XY5hvgh3zQRn3l8vv0lmCAhaasbkiuAPvTxZtvzZpS9l0t3j4HN62pglp
 PQJpRoBGXyS5x7Km2AEx6ZpBlYkpPCfWlRLK6JWY86oC4wS7tJKlNwuDK/cZYjmh9pzXG6ODkft
 xXlZzZESBHBgVNkiS3zZoHrUACik52Ue7D2jxNgIv/HD6V4dk3YNrxAbjHcl0bOhOT6t1feiXba
 0Hepk4oTvICAYlFkwiwUJrrMH92yMsaPbGgddwy1QqxYuoDmJWHs3HD/QsspxeF5hGGr/B201YY
 k4zhA==
X-Received: by 2002:a05:600c:3115:b0:495:71fc:3a64 with SMTP id
 5b1f17b1804b1-49800cc59f9mr218925e9.25.1785356346296; 
 Wed, 29 Jul 2026 13:19:06 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c46160dfsm165112875e9.10.2026.07.29.13.19.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:19:05 -0700 (PDT)
Message-ID: <5e27b4ff-af04-49ef-a830-934164486892@suse.com>
Date: Wed, 29 Jul 2026 22:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-3-pvorel@suse.cz>
 <56ad6458-25b4-4eee-ab1e-8d3c6d489aa8@suse.com>
 <20260729133640.GA36478@pevik>
Content-Language: en-US
In-Reply-To: <20260729133640.GA36478@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiA3LzI5LzI2IDM6MzYgUE0sIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgQXZpbmVzaCwKPiAK
Pj4gSGkgUGV0ciwKPiAKPj4gZmV3IGNvbW1lbnRzIGJlbG93Cj4gVGhhbmtzIQo+IAo+PiBPbiA3
LzI5LzI2IDExOjU3IEFNLCBQZXRyIFZvcmVsIHdyb3RlOgo+Pj4gU2lnbmVkLW9mZi1ieTogUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4+PiAtLS0KPj4+IFRoZSBzYW1lIGFzIHYxLgo+IAo+
Pj4gICAgaW5jbHVkZS90c3RfdGVzdC5oIHwgIDkgKysrKysrKystCj4+PiAgICBsaWIvdHN0X3Rl
c3QuYyAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+
ICAgIDIgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3Rlc3QuaCBiL2luY2x1ZGUvdHN0X3Rlc3QuaAo+
Pj4gaW5kZXggYzY5MzYyNDg1ZS4uMDkxMDY2MDgyNyAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUv
dHN0X3Rlc3QuaAo+Pj4gKysrIGIvaW5jbHVkZS90c3RfdGVzdC5oCj4+PiBAQCAtMjgwLDYgKzI4
MCw5IEBAIHN0cnVjdCB0c3RfdWxpbWl0X3ZhbCB7Cj4+PiAgICAgKgo+Pj4gICAgICogQG1pbl9r
dmVyOiBBIG1pbmltdW0ga2VybmVsIHZlcnNpb24gc3VwcG9ydGluZyB0aGUgZmlsZXN5c3RlbSB3
aGljaCBoYXMgYmVlbgo+Pj4gICAgICogICAgICAgICAgICBjcmVhdGVkIHdpdGggbWtmcy4KPj4+
ICsgKgo+Pj4gKyAqIEBtYXhfa3ZlcjogQSBtYXhpbXVtIGtlcm5lbCB2ZXJzaW9uIHN1cHBvcnRp
bmcgdGhlIGZpbGVzeXN0ZW0gd2hpY2ggaGFzIGJlZW4KPj4+ICsgKiAgICAgICAgICAgIGNyZWF0
ZWQgd2l0aCBta2ZzLgo+Pj4gICAgICovCj4+PiAgICBzdHJ1Y3QgdHN0X2ZzIHsKPj4+ICAgIAlj
b25zdCBjaGFyICp0eXBlOwo+Pj4gQEAgLTI5Miw2ICsyOTUsNyBAQCBzdHJ1Y3QgdHN0X2ZzIHsK
Pj4+ICAgIAljb25zdCB2b2lkICptbnRfZGF0YTsKPj4+ICAgIAljb25zdCBjaGFyICptaW5fa3Zl
cjsKPj4+ICsJY29uc3QgY2hhciAqbWF4X2t2ZXI7Cj4+PiAgICB9Owo+Pj4gICAgLyoqCj4+PiBA
QCAtMzAxLDcgKzMwNSw5IEBAIHN0cnVjdCB0c3RfZnMgewo+Pj4gICAgICogICAgICAgIGFuZCBl
YWNoIHRpbWUgcGFzc2VkIGFuIGluY3JlYXNpbmcgY291bnRlciB2YWx1ZS4KPj4+ICAgICAqIEBv
cHRpb25zOiBBbiBOVUxMIG9wdHN0ciB0ZXJtaW5hdGVkIGFycmF5IG9mIHN0cnVjdCB0c3Rfb3B0
aW9uLgo+Pj4gICAgICoKPj4+IC0gKiBAbWluX2t2ZXI6IEEgbWluaW1hbCBrZXJuZWwgdmVyc2lv
biB0aGUgdGVzdCBjYW4gcnVuIG9uLiBlLmcuICIzLjEwIi4KPj4+ICsgKiBAbWluX2t2ZXI6IEEg
bWluaW1hbCBrZXJuZWwgdmVyc2lvbiB0aGUgdGVzdCBjYW4gcnVuIG9uLiBlLmcuICI0LjQiLgo+
PiBzL21pbmltYWwvbWluaW11bQo+IAo+IFlvdSBzcG90dGVkIG1vcmUgZ3JhbW1hciBlcnJvcnMg
c28gSSB0cnVzdCB5b3UgOikuIEJ1dCBjYW4geW91IHBsZWFzZSBkb3VibGUKPiBjaGVjayB0aGF0
IGl0J8SRIHJlYWxseSBjb3JyZWN0PyBNaW5pbWFsIGlzIGFuIGFkamVjdGl2ZSwgbWluaW11bSBp
cyBhbiBhZGplY3RpdmUKPiBidXQgYWxzbyBhIG5vdW4gYW5kIGFuIGFkdmVyYi4KPiAKPiBXaGVu
IGdvb2dsaW5nIEkgZXZlbiBmb3VuZCB1c2Ugb2YgYm90aCBpbiB0aGUgc2FtZSBkb2N1bWVudCA6
KQo+IGh0dHBzOi8va3ViZXJuZXRlcy5pby9kb2NzL3JlZmVyZW5jZS9ub2RlL2tlcm5lbC12ZXJz
aW9uLXJlcXVpcmVtZW50cy8KPiAiaGF2ZSBtaW5pbXVtIGtlcm5lbCB2ZXJzaW9uIHJlcXVpcmVt
ZW50cyIKPiAibWluaW1hbCBrZXJuZWwgdmVyc2lvbiByZXF1aXJlbWVudCIKSSBzZWUgd2UgYXJl
IHVzaW5nIG1pbmltYWwgaW4gbWFueSBwbGFjZXMgYWxyZWFkeS4gSSB0aGluayBib3RoIHdvcmRp
bmdzCmFyZSBjb3JyZWN0LiBKdXN0IHRoYXQgJ21heGltYWwga2VybmVsIHZlcnNpb24nIHNvdW5k
ZWQgYSBiaXQgb2RkIHRvIG1lLgpTbyBwbGVhc2UgaWdub3JlIG15IGNvbW1lbnQgaGVyZS4KPiAK
Pj4+ICsgKgo+Pj4gKyAqIEBtYXhfa3ZlcjogQSBtYXhpbWFsIGtlcm5lbCB2ZXJzaW9uIHRoZSB0
ZXN0IGNhbiBydW4gb24uIGUuZy4gIjcuMiIuCj4+IHMvbWF4aW1hbC9tYXhpbXVtCj4gZHR0bwo+
IAo+PiBBbHNvLCBJIGFzc3VtZSB0ZXN0IHdpbGwgKm5vdCBiZSBza2lwcGVkKiBvbiBrZXJuZWwg
dmVyc2lvbnMKPj4gNy4xLjEsIDcuMS4yIGV0YyBqdXN0IHdpdGgKPj4gLm1heF9rdmVyPSI3LjEi
Cj4gCj4gR29vZCBwb2ludCwgdGhhbmtzID0+IHYzIChzaWdoKS4KPiAKPiBjaGVja19tYXhfa3Zl
cigpIG5lZWRzIHRvIGhhdmUgdGhpcyBjb25kaXRpb24gdG8gdGFrZSBhbiBhY2NvdW50IHRoZSBz
dWJsZXZlbC4KPiAKPiAtaWYgKHRzdF9rdmVyY21wKHYxLCB2MiwgdjMpID4gMCkgewo+ICtpZiAo
dHN0X2t2ZXJjbXAodjEsIHYyLCB2MykgPj0gMTAyNCkgewo+IAkJbXNnID0gIlRoZSB0ZXN0IHJl
cXVpcmVzIGtlcm5lbCAlcyBvciBvbGRlciI7CkFuZCB3aWxsIHRoaXMgYmUgZmluZSB3aXRoIC0K
Lm1heF9rdmVyPSI3LjEuNSIKb24gU1VUIHdpdGggdjcuMi4wID8KCnNvcnJ5LCBoYXZlbid0IHRl
c3RlZCB5ZXQuCgo+IC4uLgo+IAo+IFN1YmxldmVsIGNhbiBiZSBhYm92ZSAyNTUgc2luY2UgNC40
LjI1Ngo+IGh0dHBzOi8vbHduLm5ldC9tbC9saW51eC1rZXJuZWwvMjAyMTAyMDgxNDU4MDUuODk4
NjU4MDU1QGxpbnV4Zm91bmRhdGlvbi5vcmcvCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9OWI4MmYx
M2U3ZWYzCj4gCj4gQnV0IGl0IHNob3VsZCBiZSBiZWxvdyAxMDI0IChwcmFjdGljYWxseSB0aGUg
aGlnaGVzdCBzdWJsZXZlbCBoYXMgYmVlbiAzMzcpLgo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRy
Cj4gCj4+IG1heWJlIHdlIHNob3VsZCBjbGFyaWZ5Lgo+IAo+Pj4gICAgICoKPj4+ICAgICAqIEBz
dXBwb3J0ZWRfYXJjaHM6IEEgTlVMTCB0ZXJtaW5hdGVkIGFycmF5IG9mIGFyY2hpdGVjdHVyZXMg
dGhlIHRlc3QgcnVucyBvbgo+Pj4gICAgICogICAgICAgICAgICAgICAgICAgZS5nLiB7Ing4Nl82
NCwgIng4NiIsIE5VTEx9LiBDYWxscyB0c3RfaXNfb25fYXJjaCgpIHRvCj4+PiBAQCAtNTUxLDYg
KzU1Nyw3IEBAIHN0cnVjdCB0c3RfZnMgewo+Pj4gICAgCXN0cnVjdCB0c3Rfb3B0aW9uICpvcHRp
b25zOwo+Pj4gICAgCWNvbnN0IGNoYXIgKm1pbl9rdmVyOwo+Pj4gKwljb25zdCBjaGFyICptYXhf
a3ZlcjsKPj4+ICAgIAljb25zdCBjaGFyICpjb25zdCAqc3VwcG9ydGVkX2FyY2hzOwo+Pj4gZGlm
ZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKPj4+IGluZGV4IDc3OGEx
ZmVkNDAuLmZhMzhiM2E3YTMgMTAwNjQ0Cj4+PiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+Pj4gKysr
IGIvbGliL3RzdF90ZXN0LmMKPj4+IEBAIC0xMDg3LDYgKzEwODcsMzYgQEAgc3RhdGljIGJvb2wg
Y2hlY2tfbWluX2t2ZXIoY29uc3QgY2hhciAqbWluX2t2ZXIsIGNvbnN0IGludCBicmtfbm9zdXBw
KQo+Pj4gICAgCXJldHVybiB0cnVlOwo+Pj4gICAgfQo+Pj4gKy8qCj4+PiArICogQ2hlY2sgZm9y
IHRoZSBtYXhpbWFsIHJlcXVpcmVkIGtlcm5lbCB2ZXJzaW9uLgo+Pj4gKyAqCj4+PiArICogcmV0
dXJuOiB0cnVlIGlmIHRoZSBrZXJuZWwgdmVyc2lvbiBpcyBsb3cgZW5vdWdoLCBmYWxzZSBvdGhl
cndpc2UuCj4gCj4+IFRoaXMgc291bmRzIGEgYml0IGNvbmZ1c2luZy4gSG93IGFib3V0LQo+IAo+
PiBDaGVjayB0aGUgcnVubmluZyBrZXJuZWwgYWdhaW5zdCB0aGUgbGFzdCB2ZXJzaW9uIHRoZSB0
ZXN0IGFwcGxpZXMgdG8uCj4gCj4gTWFrZXMgc2Vuc2UuIEJhc2VkIG9uIGNoZWNrX21pbl9rdmVy
KCksIHdoaWNoIHdhcyByZW5hbWVkIGZyb20gY2hlY2tfa3ZlcigpIGluCj4gdGhlIHByZXZpb3Vz
IGNvbW1pdC4gQ291bGQgeW91IGhhdmUgbG9vayBvbiB0aGVzZSBhcyB3ZWxsLiBBbnl3YXksIGlm
IHlvdSBoYXZlCj4gdGltZSwgaGF2aW5nIGEgbG9vayBvbiBkb2NzIHdvcmRpbmcgYXMgYSBzZXBh
cmF0ZSBlZmZvcnQgd291bGQgaGVscC4Kc3VyZSwgSSB3aWxsIHNlZSBpZiBJIGZpbmQgc29tZXRo
aW5nIHdvcnRoIHJlcG9ydGluZy4KCj4gCj4+IHJldHVybjogdHJ1ZSBpZiB0aGUga2VybmVsIGlz
IG9sZCBlbm91Z2gsIGZhbHNlIG90aGVyd2lzZS4KPiAKPiArMQo+IAo+Pj4gKyAqLwo+Pj4gK3N0
YXRpYyBib29sIGNoZWNrX21heF9rdmVyKGNvbnN0IGNoYXIgKm1heF9rdmVyLCBjb25zdCBpbnQg
YnJrX25vc3VwcCkKPj4+ICt7Cj4+PiArCWNoYXIgKm1zZzsKPj4+ICsJaW50IHYxLCB2MiwgdjM7
Cj4+PiArCj4+PiArCWlmICh0c3RfcGFyc2Vfa3ZlcihtYXhfa3ZlciwgJnYxLCAmdjIsICZ2Mykp
IHsKPj4+ICsJCXRzdF9yZXMoVFdBUk4sCj4+PiArCQkJIkludmFsaWQga2VybmVsIHZlcnNpb24g
JXMsIGV4cGVjdGVkICUlZC4lJWQuJSVkIiwKPj4gSSB3b3VsZG4ndCBzYXkgJ2tlcm5lbCB2ZXJz
aW9uIGlzIGludmFsaWQnLiBtYXliZSB0ZXN0IGlzbid0Cj4+IHN1cHBvcnRlZC9hcHBsaWNhYmxl
IG9uLi4KPiAKPiB0c3RfcGFyc2Vfa3ZlcigpIHJldHVybnMgMSBvbiBlcnJvciA9PiB0aGlzIGlz
IHJlYWxseSBhbiBlcnJvciBjaGVjay4KPiBPdGhlciB0aGluZyBpcyB0aGF0IHRoZSBzYW1lIGVy
cm9yIGhhbmRsaW5nIGlzIG9uIGJvdGggcGxhY2VzLCBidXQgdGhhdCdzIHZlcnkKPiBtaW5vci4K
c29ycnksIG15IGJhZC4gSSBtaXN1bmRlcnN0b29kIHRoaXMuIFBsZWFzZSBpZ25vcmUuCj4gCj4g
S2luZCByZWdhcmRzLAo+IFBldHIKPiAuLi4KPiAKPj4gVGhhbmtzLAo+PiBBdmluZXNoCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
