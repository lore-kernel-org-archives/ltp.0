Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA33C4332F
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 01:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D89793CC2A0
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 02:50:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 424683CC286
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 02:50:02 +0100 (CET)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 03BA01C68004
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 02:49:55 +0100 (CET)
X-UUID: 1fbde5c6f325455cba2eb568dbabbea2-20221205
X-UUID: 1fbde5c6f325455cba2eb568dbabbea2-20221205
Received: from node2.com.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghongling@kylinos.cn>) (Generic MTA)
 with ESMTP id 975797968; Mon, 05 Dec 2022 09:49:46 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
 by node2.com.cn (NSMail) with SMTP id B503FB80E2A3;
 Mon,  5 Dec 2022 09:49:44 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
 id A95F7B80E2A3; Mon,  5 Dec 2022 09:49:44 +0800 (CST)
From: =?UTF-8?B?5pu+57qi546y?= <zenghongling@kylinos.cn>
To: =?UTF-8?B?cHZvcmVs?= <pvorel@suse.cz>,
	 <ltp@lists.linux.it>,
Date: Mon, 05 Dec 2022 09:49:44 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <2jtq51qy5gn-2jttyv77ay0@nsmail7.0.0--kylin--1>
References: Y4cPD+1DJhMwGPpj@pevik
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 05 Dec 2022 09:49:44 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-15t0l9kntpw-15t3557hxdh
X-ns-mid: webmail-638d4e38-15neyugl
X-ope-from: <zenghongling@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: =?UTF-8?B?UmljaGFyZCBQYWxldGhvcnBl?= <rpalethorpe@suse.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This message is in MIME format.

--nsmail-15t0l9kntpw-15t3557hxdh
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+SGk6PC9wPgo8cD4mbmJzcDsgVGhhbmsgeW91IHZlcnkgbXVjaCBmb3Ig
eW91ciByZXBseSxJIHdpbGwgdGVzdCBpdCBieSB2MS40Ni41IG9mIGUyZnNw
cm9ncy48YnI+PGJyPjxicj4tLS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxf
c2lnYXR1cmUiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9InJlIiBz
dHlsZT0ibWFyZ2luLWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVt
OyBib3JkZXItbGVmdDogMXB4IHNvbGlkIGdyZWVuOyI+PGJyPjxicj48YnI+
CjxkaXYgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6ICNmNWY3ZmE7Ij48c3Ry
b25nPuS4u+OAgOmimO+8mjwvc3Ryb25nPjxzcGFuIGlkPSJzdWJqZWN0Ij5S
ZTogW0xUUF0gW1BBVENIXSBta2ZzOiByZWxheCBzaXplIGNoZWNrPC9zcGFu
PiA8YnI+PHN0cm9uZz7ml6XjgIDmnJ/vvJo8L3N0cm9uZz48c3BhbiBpZD0i
ZGF0ZSI+MjAyMi0xMS0zMCAxNjowNjwvc3Bhbj4gPGJyPjxzdHJvbmc+5Y+R
5Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9ImZyb20iPnB2b3JlbDwvc3Bh
bj4gPGJyPjxzdHJvbmc+5pS25Lu25Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9
InRvIiBzdHlsZT0id29yZC1icmVhazogYnJlYWstYWxsOyI+5pu+57qi546y
O2x0cDs8L3NwYW4+PC9kaXY+Cjxicj4KPGRpdiBpZD0iY29udGVudCI+Cjxk
aXYgY2xhc3M9InZpZXdlcl9wYXJ0IiBzdHlsZT0icG9zaXRpb246IHJlbGF0
aXZlOyBvdmVyZmxvdzogaGlkZGVuOyI+CjxkaXY+SGkgYWxsLDxicj48YnI+
Jmd0OyBIaSB6ZW5naG9uZ2xpbmcsPGJyPjxicj4mZ3Q7ICZndDsgTnVtYmVy
IG9mIHRvdGFsIGRhdGEgYmxvY2tzIGluIGZpbGVzeXN0ZW0gcmVwb3J0ZWQg
Ynkgc3RhdGZzPGJyPiZndDsgJmd0OyBtYXkgYmUgbGVzcyB0aGFuIGN1cnJl
bnQgZm9ybXVsYSBvZiA5MCUuIEZvciBleGFtcGxlIGV4dDQgd2lsbDxicj4m
Z3Q7ICZndDsgc3VidHJhY3QgInNfZmlyc3RfZGF0YV9ibG9jayBwbHVzIGlu
dGVybmFsIGpvdXJuYWwgYmxvY2tzIi48YnI+PGJyPiZndDsgJmd0OyBXaXRo
IHJlY2VudCBjaGFuZ2UgdG8gZTJmc3Byb2dzLCBvdmVyaGVhZCBjYWxjdWxh
dGVkIGluIHVzZXItc3BhY2UgaW5jcmVhc2VkPGJyPiZndDsgRG8geW91IGtu
b3cgaW4gd2hpY2ggdmVyc2lvbiBpdCBnb3QgY2hhbmdlZD88YnI+PGJyPkZv
ciBhIHJlY29yZCwgemVuZ2hvbmdsaW5nIHNlbmQgaHRtbCBtYWlsPGJyPmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yb2MxZGVocm9idi0yb2M1Nzd5
MHR0OEBuc21haWw3LjAuMC0ta3lsaW4tLTEvVC8jdTxicj48YnI+dGh1cyBy
ZXBlYXQgaXQgaGVyZTogdGhlIGFmZmVjdGVkIGNvbW1pdCBpcyBoZXJlOjxi
cj5odHRwczovL2dpdGh1Yi5jb20vdHl0c28vZTJmc3Byb2dzL2NvbW1pdC81
OTAzN2M1MzU3ZDM5YzZkMGYxNGEwYWZmNzBlNjdkYzEzZWFmYzg0PGJyPndo
aWNoIGlzIGZyb20gdjEuNDYuMC48YnI+PGJyPkknbSB0ZXN0aW5nIGl0IG9u
IG9wZW5TVVNFIHdpdGggMS40Ni41IGFuZCBpdCBkb2VzIG5vdCBoYXZlIHBy
b2JsZW0uPGJyPk1heWJlIHRoZXJlIGlzIHNvbWUgcHJvYmxlbSBvbiB0aGUg
c3lzdGVtIHlvdSB0ZXN0IGFuZCBsb3dlciB0aGUgYmFycmllciB5b3U8YnI+
anVzdCBoaWRlIGl0LiBNYXliZSBvdGhlcnMgc2VlIGl0IGRpZmZlcmVudGx5
Ljxicj48YnI+Jmd0OyBNYXliZSBpdCdkIGJlIHdvcnRoIHRvIG1lbnRpb24g
dGhhdCB0byBleHQ0IG1haW50YWluZXJzLDxicj4mZ3Q7IGp1c3QgdG8gYmUg
c3VyZSBpdCdzIG5vdCBhIHJlZ3Jlc3Npb24uPGJyPjxicj4mZ3Q7ICZndDsg
c2xpZ2h0bHkgYW5kIExUUCB0ZXN0IHN0YXJ0ZWQgZmFpbGluZzogdHl0c28v
ZTJmc3Byb2dzPGJyPiZndDsgQSBiaXQgY3J5cHRpYyBkZXNjcmlwdGlvbiA6
KC4gWW91IG1lYW4gcHJvYmFibHkgaHR0cHM6Ly9naXRodWIuY29tL3R5dHNv
L2UyZnNwcm9nczxicj4mZ3Q7IHdoaWNoIGlzIGFsc28gb248YnI+Jmd0OyBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZnMvZXh0Mi9lMmZzcHJv
Z3MuZ2l0Lzxicj48YnI+QHplbmdob25nbGluZyBiYXNpYyBtYWlsaW5nIGxp
c3QgcnVsZXM8YnI+MSkgc2VudCB0ZXh0L3BsYWluIChub3QgdGV4dC9odG1s
KSwgb3RoZXJ3aXNlIG1haWwgaXMgbm90IHJlYWRhYmxlPGJyPmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2x0cC8yb2MxZGVocm9idi0yb2M1Nzd5MHR0OEBu
c21haWw3LjAuMC0ta3lsaW4tLTEvVC8jdTxicj5hbmQgbm90IGV2ZW4gaW4g
cGF0Y2h3b3JrOjxicj5odHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3By
b2plY3QvbHRwL3BhdGNoLzE2Njk2OTE4MzEtMjM0NTYtMS1naXQtc2VuZC1l
bWFpbC16ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbi88YnI+PGJyPkNvbXBhcmUg
d2l0aCBteSBtYWlsOjxicj5odHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
WTRYZDRqZCUyRlg1enNtb3FIQHBldmlrL1QvI203NmQ0YWUzZjM5NmE2YWU2
MzM4MmNiNTY5YzMzZDhjNzQ2Y2UwOTc0PGJyPjxicj5Nb3JlIGluc3RydWN0
aW9ucyBhcmU6PGJyPmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
bGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjbm8tbWlt
ZS1uby1saW5rcy1uby1jb21wcmVzc2lvbi1uby1hdHRhY2htZW50cy1qdXN0
LXBsYWluLXRleHQ8YnI+PGJyPjIpIHJlcGx5IHRvIG1haWwgdGhyZWFkIHNv
IHRoYXQgbWFpbCBpcyBjb25uZWN0ZWQgdG8gdGhlIHRocmVhZDxicj5odHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1
Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2V4cGxpY2l0LWluLXJlcGx5LXRvLWhl
YWRlcnM8YnI+PGJyPkFjdHVhbGx5IG1vc3Qgb2YgdGhlIHJlYWRpbmcgZm9y
IGtlcm5lbCBhcHBsaWVzIHRvIExUUCBhcyB3ZWxsPGJyPmh0dHBzOi8vd3d3
Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGlu
Zy1wYXRjaGVzLmh0bWw8YnI+PGJyPktpbmQgcmVnYXJkcyw8YnI+UGV0cjwv
ZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pg==

--nsmail-15t0l9kntpw-15t3557hxdh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--nsmail-15t0l9kntpw-15t3557hxdh--
