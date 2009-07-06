Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNwwZ-0002Hq-27
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:45:51 +0000
Received: from an-out-0708.google.com ([209.85.132.246])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNwwU-0000ip-9B
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:45:51 +0000
Received: by an-out-0708.google.com with SMTP id c38so1775159ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 15:45:45 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 15:45:42 -0700
Message-ID: <364299f40907061545o4da1c12dj1c33dc6115f101@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e64615b0166352046e114425
Subject: [LTP] [PATCH] ballista should clean out all generated binaries
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

--0016e64615b0166352046e114425
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A few generated files weren't being pruned with clean (blexer,
bparser). This patch fixes that.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016e64615b0166352046e114425
Content-Type: application/octet-stream; 
	name="ballista-should-clean-all-binaries.diff"
Content-Disposition: attachment; 
	filename="ballista-should-clean-all-binaries.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwts59cg0

SW5kZXg6IHRlc3RjYXNlcy9iYWxsaXN0YS9iYWxsaXN0YS9NYWtlZmlsZQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJD
UyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3Rlc3RjYXNlcy9iYWxsaXN0YS9iYWxsaXN0YS9NYWtl
ZmlsZSx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS41CmRpZmYgLXUgLXIxLjUgTWFrZWZpbGUKLS0t
IHRlc3RjYXNlcy9iYWxsaXN0YS9iYWxsaXN0YS9NYWtlZmlsZQkyNiBGZWIgMjAwOSAwNjoyOTo0
MiAtMDAwMAkxLjUKKysrIHRlc3RjYXNlcy9iYWxsaXN0YS9iYWxsaXN0YS9NYWtlZmlsZQk2IEp1
bCAyMDA5IDIyOjQzOjQ2IC0wMDAwCkBAIC0xMTUsOSArMTE1LDggQEAKIHBhdXNlX2hhcm5lc3Mg
OiBwYXVzZV9oYXJuZXNzLmNwcCAke09CSlN9CiAJJHtDQ30gLUl0ZW1wbGF0ZXMgJHtDRkxBR1N9
IHBhdXNlX2hhcm5lc3MuY3BwICR7T0JKU30gLW8gcGF1c2VfaGFybmVzcyAKIAotCiAjIGNsZWFu
IHVwIGV2ZXJ5dGhpbmcgdGhhdCB3ZSBidWlsZAogY2xlYW4gOgogCSQoTUFLRSkgLUMgdGVtcGxh
dGVzIGNsZWFuCi0Jcm0gLWYgKi5vIGJhbGxpc3RhIGNhbGxHZW4gY2FsbEdlbl9zdGFuZEFsb25l
IGdlbkNvZGVDcmVhdG9yIHJlcGxhY2VyIHRlc3RtYXJzaGFsCi0KKwkkKFJNKSAtZiAqLm8gKi5v
dXQgYmFsbGlzdGEgYmxleGVyIGJwYXJzZXIgY2FsbEdlbiBjYWxsR2VuX3N0YW5kQWxvbmUgXAor
CSAgICAgICAgICAgIGdlbkNvZGVDcmVhdG9yIHJlcGxhY2VyIHRlc3RtYXJzaGFsCg==
--0016e64615b0166352046e114425
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016e64615b0166352046e114425
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e64615b0166352046e114425--

