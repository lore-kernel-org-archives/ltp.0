Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83B9C43458
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 09:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E70D03E4B41
	for <ltp@archiver.kernel.org>; Mon, 29 Jun 2026 11:36:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3CAD3C5AD0
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 11:36:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7B811A00703
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 11:36:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1913975D0B;
 Mon, 29 Jun 2026 09:36:34 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F075779A8;
 Mon, 29 Jun 2026 09:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5TykA6I8QmoyYwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 29 Jun 2026 09:36:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A3D7AA10B5; Mon, 29 Jun 2026 11:36:25 +0200 (CEST)
Date: Mon, 29 Jun 2026 11:36:25 +0200
From: Jan Kara <jack@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
References: <202606291514.594c4370-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202606291514.594c4370-lkp@intel.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1913975D0B
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [fanotify] 82c6dd2047: ltp.fanotify21.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 AnonymeMeow <anonymemeow@gmail.com>, linux-fsdevel@vger.kernel.org,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIDI5LTA2LTI2IDE2OjQ1OjU4LCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToKPiBrZXJu
ZWwgdGVzdCByb2JvdCBub3RpY2VkICJsdHAuZmFub3RpZnkyMS5mYWlsIiBvbjoKPiAKPiBjb21t
aXQ6IDgyYzZkZDIwNDc5YmI2YTk2MjVlMWQ2M2E2NTBjM2JlODg2NWUyZGIgKCJmYW5vdGlmeTog
YWxsb3cgcmVwb3J0aW5nIHBpZGZkcyBmb3IgcmVhcGVkIHRhc2tzIikKPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQgbWFzdGVy
CgpGV0lXIHRoaXMgaXMgZXhwZWN0ZWQgZmFpbHVyZS4gUGF0Y2ggdG8gZml4IGZhbm90aWZ5MjEg
dG8gYWNjZXB0IHN1Y2Nlc3MKaW4gdGhpcyB0ZXN0IHdhcyBzdWJtaXR0ZWQgdG8gTFRQLgoKCQkJ
CQkJCQlIb256YQoKPiAKPiBbdGVzdCBmYWlsZWQgb24gbGludXMvbWFzdGVyICAgICAgNWE2Njkw
MGFmYmQ2YjJhMDYzZWViYWQzNTI5NDAzOGE2NTRkZTJiMF0KPiBbdGVzdCBmYWlsZWQgb24gbGlu
dXgtbmV4dC9tYXN0ZXIgM2Q1NjcwZDY3MmFlMDhiOGM1MzRiN2JlZWQ2ZjU3YzhiNDRlN2I0M10K
PiAKPiBpbiB0ZXN0Y2FzZTogbHRwCj4gdmVyc2lvbjogCj4gd2l0aCBmb2xsb3dpbmcgcGFyYW1l
dGVyczoKPiAKPiAJZGlzazogMUhERAo+IAlmczogeGZzCj4gCXRlc3Q6IHN5c2NhbGxzLTAwCj4g
Cj4gCj4gCj4gY29uZmlnOiB4ODZfNjQtcmhlbC05LjQtbHRwCj4gY29tcGlsZXI6IGdjYy0xNAo+
IHRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEgc29ja2V0cyBJbnRlbChSKSBDb3JlKFRNKSBpMy0z
MjIwIENQVSBAIDMuMzBHSHogKEl2eSBCcmlkZ2UpIHdpdGggOEcgbWVtb3J5Cj4gCj4gKHBsZWFz
ZSByZWZlciB0byBhdHRhY2hlZCBkbWVzZy9rbXNnIGZvciBlbnRpcmUgbG9nL2JhY2t0cmFjZSkK
PiAKPiAKPiAKPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1p
dCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9uIG9mCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0
KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncwo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL29lLWxrcC8yMDI2MDYyOTE1MTQuNTk0YzQzNzAtbGtwQGludGVsLmNvbQo+IAo+
IAo+IBtbMTszN21mYW5vdGlmeTE1OiAbWzBtG1sxOzM2bXNraXAbWzBtIHwgG1sxOzMzbXRhaW50
ZWQbWzBtICAoMTIuNTg1cykKPiAbWzE7MzdtZmFub3RpZnkyMTogG1swbRtbMTszMW1mYWlsG1sw
bSB8IBtbMTszM210YWludGVkG1swbSAgKDI1LjQzOHMpICAgIDwtLS0tLS0KPiAbWzE7MzdtaW9w
cmlvX3NldDAyOiAbWzBtG1sxOzMybXBhc3MbWzBtIHwgG1sxOzMzbXRhaW50ZWQbWzBtICAoMC4w
MzdzKQo+IAo+IAo+IC4uLgo+IAo+IAo+IEV4ZWN1dGlvbiB0aW1lOiA5bSAyOXMKPiAKPiBEaXNj
b25uZWN0aW5nIGZyb20gU1VUOiBkZWZhdWx0Cj4gCj4gVGFyZ2V0IGluZm9ybWF0aW9uCj4g4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gS2Vy
bmVsOiAgIExpbnV4IDcuMS4wLXJjMysgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBGcmkgSnVuIDI2
IDIwOjA1OjM0IENTVCAyMDI2Cj4gQ21kbGluZTogIGlwPTo6Ojpsa3AtaXZiLWQwNDo6ZGhjcAo+
ICAgICAgICAgICByb290PS9kZXYvcmFtMAo+ICAgICAgICAgICBSRVNVTFRfUk9PVD0vcmVzdWx0
L2x0cC8xSERELXhmcy1zeXNjYWxscy0wMC9sa3AtaXZiLWQwNC9kZWJpYW4tMTMteDg2XzY0LTIw
MjUwOTAyLmNnei94ODZfNjQtcmhlbC05LjQtbHRwL2djYy0xNC84MmM2ZGQyMDQ3OWJiNmE5NjI1
ZTFkNjNhNjUwYzNiZTg4NjVlMmRiLzAKPiAgICAgICAgICAgQk9PVF9JTUFHRT0vcGtnL2xpbnV4
L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0LzgyYzZkZDIwNDc5YmI2YTk2MjVlMWQ2M2E2NTBj
M2JlODg2NWUyZGIvdm1saW51ei03LjEuMC1yYzMrCj4gICAgICAgICAgIGJyYW5jaD1saW51eC1u
ZXh0L21hc3Rlcgo+ICAgICAgICAgICBqb2I9L2xrcC9qb2JzL3NjaGVkdWxlZC9sa3AtaXZiLWQw
NC9sdHAtMUhERC14ZnMtc3lzY2FsbHMtMDAtZGViaWFuLTEzLXg4Nl82NC0yMDI1MDkwMi5jZ3ot
ODJjNmRkMjA0NzliLTIwMjYwNjI2LTExMzIwLXA1ZzgwNC0wLnlhbWwKPiAgICAgICAgICAgdXNl
cj1sa3AKPiAgICAgICAgICAgQVJDSD14ODZfNjQKPiAgICAgICAgICAga2NvbmZpZz14ODZfNjQt
cmhlbC05LjQtbHRwCj4gICAgICAgICAgIGNvbW1pdD04MmM2ZGQyMDQ3OWJiNmE5NjI1ZTFkNjNh
NjUwYzNiZTg4NjVlMmRiCj4gICAgICAgICAgIGludHJlbWFwPXBvc3RlZF9tc2kKPiAgICAgICAg
ICAgbWF4X3VwdGltZT03MjAwCj4gICAgICAgICAgIExLUF9TRVJWRVI9aW50ZXJuYWwtbGtwLXNl
cnZlcgo+ICAgICAgICAgICBub2thc2xyCj4gICAgICAgICAgIHNlbGludXg9MAo+ICAgICAgICAg
ICBkZWJ1Zwo+ICAgICAgICAgICBhcGljPWRlYnVnCj4gICAgICAgICAgIHN5c3JxX2Fsd2F5c19l
bmFibGVkCj4gICAgICAgICAgIHJjdXBkYXRlLnJjdV9jcHVfc3RhbGxfdGltZW91dD0xMDAKPiAg
ICAgICAgICAgbmV0LmlmbmFtZXM9MAo+ICAgICAgICAgICBwcmludGsuZGV2a21zZz1vbgo+ICAg
ICAgICAgICBwYW5pYz0tMQo+ICAgICAgICAgICBzb2Z0bG9ja3VwX3BhbmljPTEKPiAgICAgICAg
ICAgbm1pX3dhdGNoZG9nPXBhbmljCj4gICAgICAgICAgIG9vcHM9cGFuaWMKPiAgICAgICAgICAg
bG9hZF9yYW1kaXNrPTIKPiAgICAgICAgICAgcHJvbXB0X3JhbWRpc2s9MAo+ICAgICAgICAgICBk
cmJkLm1pbm9yX2NvdW50PTgKPiAgICAgICAgICAgc3lzdGVtZC5sb2dfbGV2ZWw9ZXJyCj4gICAg
ICAgICAgIGlnbm9yZV9sb2dsZXZlbAo+ICAgICAgICAgICBjb25zb2xlPXR0eTAKPiAgICAgICAg
ICAgZWFybHlwcmludGs9dHR5UzAsMTE1MjAwCj4gICAgICAgICAgIGNvbnNvbGU9dHR5UzAsMTE1
MjAwCj4gICAgICAgICAgIHZnYT1ub3JtYWwKPiAgICAgICAgICAgcncKPiAgICAgICAgICAga2Vl
cF9pbml0cmRzPS9vc2ltYWdlL3BrZy9kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNnei9sdHAt
eDg2XzY0LTVjY2Y4MTZmNS0xXzIwMjYwNTMxLmNnego+IE1hY2hpbmU6ICB1bmtub3duCj4gQXJj
aDogICAgIHg4Nl82NAo+IFJBTTogICAgICA2ODk4MzY0IGtCCj4gU3dhcDogICAgIDAga0IKPiBE
aXN0cm86ICAgZGViaWFuIDEzCj4gCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gICAgICAgVEVTVCBTVU1N
QVJZCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gU3VpdGU6ICAgc3lzY2FsbHMtMDAKPiBSdW50aW1lOiA5
bSAxNXMKPiBSdW5zOiAgICAxODgKPiAKPiBSZXN1bHRzOgo+ICAgICBQYXNzZWQ6ICAgMjMzOQo+
ICAgICBGYWlsZWQ6ICAgMTgKPiAgICAgQnJva2VuOiAgIDAKPiAgICAgU2tpcHBlZDogIDQ1Cj4g
ICAgIFdhcm5pbmdzOiAwCj4gCj4gG1sxOzMxbUZhaWx1cmVzOhtbMG0KPiAgICAg4oCiIGZhbm90
aWZ5MjEKPiAKPiBTZXNzaW9uIHN0b3BwZWQKPiAvdG1wL2tpcmsucm9vdC9sYXRlc3QgaXMgbm90
IGZvdW5kCj4gCj4gCj4gCj4gVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFscyB0byByZXBy
b2R1Y2UgYXJlIGF2YWlsYWJsZSBhdDoKPiBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNp
L2FyY2hpdmUvMjAyNjA2MjkvMjAyNjA2MjkxNTE0LjU5NGM0MzcwLWxrcEBpbnRlbC5jb20KPiAK
PiAKPiAKPiAtLSAKPiAwLURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlCj4gaHR0cHM6Ly9naXRo
dWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpCj4gCi0tIApKYW4gS2FyYSA8amFja0BzdXNlLmNv
bT4KU1VTRSBMYWJzLCBDUgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
