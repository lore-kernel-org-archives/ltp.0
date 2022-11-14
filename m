Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D1BC4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 09:32:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 382F93CD239
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:32:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492803C28F3
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 10:32:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C2F2E1000644
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 10:32:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 629251FDAD;
 Mon, 14 Nov 2022 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668418338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+iiha7ZeW4gi+huQ3TgVXF5LOz9QOft1j8vSjg0X0c=;
 b=2gBCKRuKZZrFzqqSTSMMRn+tErg8ejhw/x/4pOpUtoBsGhr0v04EOvt3EASHYUV08gKT+O
 fWkl29dk1F9LEzOs4P1JLyKCFjUIguVstzZfDMY6nvG8qhXpYJzMDmkR/ldKiCpV+AjrJM
 QEK2y83bzAq9dmgNmkoTT6Sq2F5qJZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668418338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+iiha7ZeW4gi+huQ3TgVXF5LOz9QOft1j8vSjg0X0c=;
 b=yrpCULn4a4fzZHyLouea2cZai817i8ee3wzKPN0f4lr2j70hzwj/ALzF6Ej/I09WbsR90O
 cNEZPSYA8GbThtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FA3413A92;
 Mon, 14 Nov 2022 09:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3fi2DiILcmP0QAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 14 Nov 2022 09:32:18 +0000
Message-ID: <97929765-6f56-e83e-ad46-34d6143a6b24@suse.cz>
Date: Mon, 14 Nov 2022 10:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Li Wang <liwang@redhat.com>
References: <20221111160812.10437-1-mdoucha@suse.cz>
 <CAEemH2d1ONow28Db9gNT8BV_LtjjrQVGs1dLaYkVg8PpiPzR_Q@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2d1ONow28Db9gNT8BV_LtjjrQVGs1dLaYkVg8PpiPzR_Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] save_restore: Introduce new struct field
 for flags
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

T24gMTIuIDExLiAyMiA5OjI3LCBMaSBXYW5nIHdyb3RlOgo+ICAgICAgwqBbc291cmNlLGNdCj4g
ICAgICDCoC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgLXN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gICAgIC17Cj4gICAgIC3CoCDCoCDCoCDCoEZJTEVfUFJJTlRGKCIvcHJvYy9zeXMva2Vy
bmVsL2NvcmVfcGF0dGVybiIsICIvbXlwYXRoIik7Cj4gICAgIC3CoCDCoCDCoCDCoFNBRkVfVFJZ
X0ZJTEVfUFJJTlRGKCIvcHJvYy9zeXMvdXNlci9tYXhfdXNlcl9uYW1lc3BhY2VzIiwKPiAgICAg
IiVkIiwgMTApOwo+ICAgICAtfQo+ICAgICAtCj4gICAgICDCoHN0YXRpYyBzdHJ1Y3QgdHN0X3Rl
c3QgdGVzdCA9IHsKPiAgICAgIMKgIMKgIMKgIMKgIC4uLgo+ICAgICAgwqAgwqAgwqAgwqAgLnNl
dHVwID0gc2V0dXAsCj4gICAgICDCoCDCoCDCoCDCoCAuc2F2ZV9yZXN0b3JlID0gKGNvbnN0IHN0
cnVjdCB0c3RfcGF0aF92YWxbXSkgewo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7Ii9w
cm9jL3N5cy9rZXJuZWwvY29yZV9wYXR0ZXJuIiwgTlVMTH0sCj4gICAgIC3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHsiPy9wcm9jL3N5cy91c2VyL21heF91c2VyX25hbWVzcGFjZXMiLCBOVUxMfSwK
PiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgeyIhL3N5cy9rZXJuZWwvbW0va3NtL3J1biIs
ICIxIn0sCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHsiL3Byb2Mvc3lzL2tlcm5lbC9j
b3JlX3BhdHRlcm4iLCBOVUxMLCAwfSwKPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgeyIv
cHJvYy9zeXMvdXNlci9tYXhfdXNlcl9uYW1lc3BhY2VzIiwgTlVMTCwKPiAgICAgVFNUX1NSX0lG
X0FDQ0VTU30sCj4gCj4gCj4gVGhpcyBzaG91bGQgYmUgVFNUX1NSX0NPTkRfQUNDRVNTIF4KPiAK
PiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20gPG1haWx0bzpsaXdhbmdA
cmVkaGF0LmNvbT4+CgpHb29kIGNhdGNoLiBJIG5vdGljZWQgdGhpcyBtaXN0YWtlIHJpZ2h0IGJl
Zm9yZSBzZW5kaW5nIHRoZSBwYXRjaCwgZml4ZWQgCml0LCBleHBvcnRlZCBhIG5ldyBwYXRjaCwg
YW5kIHRoZW4gc29tZWhvdyBzZW50IHRoZSBvbGQgcGF0Y2ggYW55d2F5Li4uIAoqZmFjZXBhbG0q
CgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpRQSBFbmdpbmVlciBmb3IgU29m
dHdhcmUgTWFpbnRlbmFuY2UKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtvdmEg
MTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
