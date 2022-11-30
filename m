Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52A6C433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 02:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E99933CDE6F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 03:45:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1F63C85AE
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 03:45:19 +0100 (CET)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CE37600914
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 03:45:12 +0100 (CET)
X-UUID: 9d46f0f9ff7349a5a6fd4c7df87c6aa1-20221130
X-UUID: 9d46f0f9ff7349a5a6fd4c7df87c6aa1-20221130
Received: from node2.com.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghongling@kylinos.cn>) (Generic MTA)
 with ESMTP id 1799691187; Wed, 30 Nov 2022 10:45:07 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
 by node2.com.cn (NSMail) with SMTP id AD7A1B80E29F;
 Wed, 30 Nov 2022 10:45:06 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
 id A2227B80E29F; Wed, 30 Nov 2022 10:45:06 +0800 (CST)
From: =?UTF-8?B?5pu+57qi546y?= <zenghongling@kylinos.cn>
To: =?UTF-8?B?UGV0ciBWb3JlbA==?= <pvorel@suse.cz>,
Date: Wed, 30 Nov 2022 10:45:06 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <2oc1dehrobv-2oc577y0tt8@nsmail7.0.0--kylin--1>
References: Y4Xd4jd/X5zsmoqH@pevik
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 30 Nov 2022 10:45:06 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-z5w2avrjzs-z5ym6ilnnd
X-ns-mid: webmail-6386c3b2-yz31xzht
X-ope-from: <zenghongling@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?utf-8?b?5Zue5aSNOiBSZTogIFtQQVRDSF0gbWtmczogcmVsYXggc2l6?=
 =?utf-8?q?e_check?=
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
Cc: =?UTF-8?B?bHRw?= <ltp@lists.linux.it>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This message is in MIME format.

--nsmail-z5w2avrjzs-z5ym6ilnnd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+SGkgUGV0ZXI6PC9wPgo8cD4mbmJzcDsmbmJzcDsgPGJyPiZndDsgV2l0
aCByZWNlbnQgY2hhbmdlIHRvIGUyZnNwcm9ncywgb3ZlcmhlYWQgY2FsY3Vs
YXRlZCBpbiB1c2VyLXNwYWNlIGluY3JlYXNlZDxicj5EbyB5b3Uga25vdyBp
biB3aGljaCB2ZXJzaW9uIGl0IGdvdCBjaGFuZ2VkPzxicj4mbmJzcDsgWW91
IGNhbiByZWZlcmVuY2UgPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL3R5
dHNvL2UyZnNwcm9ncy9jb21taXQvNTkwMzdjNTM1N2QzOWM2ZDBmMTRhMGFm
ZjcwZTY3ZGMxM2VhZmM4NCI+aHR0cHM6Ly9naXRodWIuY29tL3R5dHNvL2Uy
ZnNwcm9ncy9jb21taXQvNTkwMzdjNTM1N2QzOWM2ZDBmMTRhMGFmZjcwZTY3
ZGMxM2VhZmM4NDwvYT48L3A+CjxwPkkgdGVzdGVkIG9uIG15IHBsYXRmb3Jt
KGFybS94ODYpLCBmb3VuZCB0aGUgPC9wPgo8cD5kZiAtUCAtQiAxayBtbnRw
b2ludCB8IHRhaWwgLW4xIHwgYXdrICd7cHJpbnQgJDJ9JzwvcD4KPHA+dGhl
IHZhbHVlIGlzIGxlc3MgdGhhbiBzaXplIDgqMTA8L3A+CjxwPmNoYW5nZSB0
byAiNyIgY2FuIHBhc3MuPC9wPgo8cD4mbmJzcDs8L3A+CjxwPlRoZXJlJ3Mg
bm8gc3RyaWN0IHJ1bGUgaG93IG11Y2ggdGhlIG92ZXJoZWFkIHdpbGwgYmUg
YW5kIG5vIGFibm9ybWFsIGZvciBlMmZzcHJvZ3MgdGVzdCxTbyByZWxheCB0
aGUgY29uZGl0aW9uIHRvIDcwJTwvcD4KPHA+dG8gcGFzcyB0aGUgbWtmcyBp
bnRlcmZhY2UgdGVzdC48L3A+CjxwPiZuYnNwOzwvcD4KPHA+VGhhbmtzITxi
cj4tLS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxfc2lnYXR1cmUiPjwvZGl2
Pgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9InJlIiBzdHlsZT0ibWFyZ2luLWxl
ZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBib3JkZXItbGVmdDog
MXB4IHNvbGlkIGdyZWVuOyI+PGJyPjxicj48YnI+CjxkaXYgc3R5bGU9ImJh
Y2tncm91bmQtY29sb3I6ICNmNWY3ZmE7Ij48c3Ryb25nPuS4u+OAgOmimO+8
mjwvc3Ryb25nPjxzcGFuIGlkPSJzdWJqZWN0Ij5SZTogW0xUUF0gW1BBVENI
XSBta2ZzOiByZWxheCBzaXplIGNoZWNrPC9zcGFuPiA8YnI+PHN0cm9uZz7m
l6XjgIDmnJ/vvJo8L3N0cm9uZz48c3BhbiBpZD0iZGF0ZSI+MjAyMi0xMS0y
OSAxODoyNDwvc3Bhbj4gPGJyPjxzdHJvbmc+5Y+R5Lu25Lq677yaPC9zdHJv
bmc+PHNwYW4gaWQ9ImZyb20iPlBldHIgVm9yZWw8L3NwYW4+IDxicj48c3Ry
b25nPuaUtuS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJ0byIgc3R5bGU9
IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPuabvue6oueOsjs8L3NwYW4+PC9k
aXY+Cjxicj4KPGRpdiBpZD0iY29udGVudCI+CjxkaXYgY2xhc3M9InZpZXdl
cl9wYXJ0IiBzdHlsZT0icG9zaXRpb246IHJlbGF0aXZlOyBvdmVyZmxvdzog
aGlkZGVuOyI+CjxkaXY+SGkgemVuZ2hvbmdsaW5nLDxicj48YnI+Jmd0OyBO
dW1iZXIgb2YgdG90YWwgZGF0YSBibG9ja3MgaW4gZmlsZXN5c3RlbSByZXBv
cnRlZCBieSBzdGF0ZnM8YnI+Jmd0OyBtYXkgYmUgbGVzcyB0aGFuIGN1cnJl
bnQgZm9ybXVsYSBvZiA5MCUuIEZvciBleGFtcGxlIGV4dDQgd2lsbDxicj4m
Z3Q7IHN1YnRyYWN0ICJzX2ZpcnN0X2RhdGFfYmxvY2sgcGx1cyBpbnRlcm5h
bCBqb3VybmFsIGJsb2NrcyIuPGJyPjxicj4mZ3Q7IFdpdGggcmVjZW50IGNo
YW5nZSB0byBlMmZzcHJvZ3MsIG92ZXJoZWFkIGNhbGN1bGF0ZWQgaW4gdXNl
ci1zcGFjZSBpbmNyZWFzZWQ8YnI+RG8geW91IGtub3cgaW4gd2hpY2ggdmVy
c2lvbiBpdCBnb3QgY2hhbmdlZD88YnI+TWF5YmUgaXQnZCBiZSB3b3J0aCB0
byBtZW50aW9uIHRoYXQgdG8gZXh0NCBtYWludGFpbmVycyw8YnI+anVzdCB0
byBiZSBzdXJlIGl0J3Mgbm90IGEgcmVncmVzc2lvbi48YnI+PGJyPiZndDsg
c2xpZ2h0bHkgYW5kIExUUCB0ZXN0IHN0YXJ0ZWQgZmFpbGluZzogdHl0c28v
ZTJmc3Byb2dzPGJyPkEgYml0IGNyeXB0aWMgZGVzY3JpcHRpb24gOiguIFlv
dSBtZWFuIHByb2JhYmx5IGh0dHBzOi8vZ2l0aHViLmNvbS90eXRzby9lMmZz
cHJvZ3M8YnI+d2hpY2ggaXMgYWxzbyBvbjxicj5odHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vZnMvZXh0Mi9lMmZzcHJvZ3MuZ2l0Lzxicj48YnI+
S2luZCByZWdhcmRzLDxicj5QZXRyPGJyPjxicj4mZ3Q7IG1rZnMwMSAxIFRQ
QVNTOiAnbWtmcyAtdCBleHQ0IC9kZXYvbG9vcDAgJyBwYXNzZWQuPGJyPiZn
dDsgbWtmczAxIDIgVEZBSUw6ICdta2ZzIC10IGV4dDQgL2Rldi9sb29wMCAx
NjAwMCcgZmFpbGVkLCBub3QgZXhwZWN0ZWQuPGJyPjxicj4mZ3Q7IFNpbmNl
IHRoZXJlJ3Mgbm8gc3RyaWN0IHJ1bGUgaG93IG11Y2ggdGhlIG92ZXJoZWFk
IHdpbGwgYmUsPGJyPiZndDsgYXMgcnVsZSBvZiB0aHVtYiByZWxheCB0aGUg
Y29uZGl0aW9uIHRvIDcwJS48YnI+PGJyPiZndDsgU2lnbmVkLW9mZi1ieTog
emVuZ2hvbmdsaW5nIDxicj4mZ3Q7IC0tLTxicj4mZ3Q7IHRlc3RjYXNlcy9j
b21tYW5kcy9ta2ZzL21rZnMwMS5zaCB8IDQgKystLTxicj4mZ3Q7IDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pPGJy
Pjxicj4mZ3Q7IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvY29tbWFuZHMvbWtm
cy9ta2ZzMDEuc2ggYi90ZXN0Y2FzZXMvY29tbWFuZHMvbWtmcy9ta2ZzMDEu
c2g8YnI+Jmd0OyBpbmRleCAyNjNhYTQ3Li5hOTY0Nzc0IDEwMDc1NTxicj4m
Z3Q7IC0tLSBhL3Rlc3RjYXNlcy9jb21tYW5kcy9ta2ZzL21rZnMwMS5zaDxi
cj4mZ3Q7ICsrKyBiL3Rlc3RjYXNlcy9jb21tYW5kcy9ta2ZzL21rZnMwMS5z
aDxicj4mZ3Q7IEBAIC02NiwxMSArNjYsMTEgQEAgbWtmc192ZXJpZnlfc2l6
ZSgpPGJyPiZndDsgIyAxay1ibG9jayBzaXplIHNob3VsZCBiZSBkZXZpZGVk
IGJ5IHRoaXMgYXJndW1lbnQgZm9yIG50ZnMgdmVyaWZpY2F0aW9uLjxicj4m
Z3Q7IGlmIFsgIiQxIiA9ICJudGZzIiBdOyB0aGVuPGJyPiZndDsgbG9jYWwg
cmF0ZT0xMDI0LzUxMjxicj4mZ3Q7IC0gaWYgWyAkYmxvY2tudW0gLWx0ICIk
KCgkMi8kcmF0ZSo4LzEwKSkiIF07IHRoZW48YnI+Jmd0OyArIGlmIFsgJGJs
b2NrbnVtIC1sdCAiJCgoJDIvJHJhdGUqNy8xMCkpIiBdOyB0aGVuPGJyPiZn
dDsgcmV0dXJuIDE8YnI+Jmd0OyBmaTxicj4mZ3Q7IGVsc2U8YnI+Jmd0OyAt
IGlmIFsgJGJsb2NrbnVtIC1sdCAiJCgoJDIqOC8xMCkpIiBdOyB0aGVuPGJy
PiZndDsgKyBpZiBbICRibG9ja251bSAtbHQgIiQoKCQyKjcvMTApKSIgXTsg
dGhlbjxicj4mZ3Q7IHJldHVybiAxPGJyPiZndDsgZmk8YnI+Jmd0OyBmaTwv
ZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pg==

--nsmail-z5w2avrjzs-z5ym6ilnnd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--nsmail-z5w2avrjzs-z5ym6ilnnd--
