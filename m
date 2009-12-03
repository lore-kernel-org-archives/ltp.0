Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDMX-0008L1-Vf
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:12:57 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDMR-00052H-VY
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:12:57 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F0R3v015915
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:00:27 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FCVKH059976
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:12:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB3FCUfP015294
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:12:30 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <op.u399hfgxu2flwt@debian>
References: <4b159f21.8713f30a.416d.423cSMTPIN_ADDED@mx.google.com>
	<200912011820.37533.vapier@gentoo.org>  <op.u399hfgxu2flwt@debian>
Date: Thu, 03 Dec 2009 20:41:51 +0530
Message-Id: <1259853116.5085.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Small fixes (some bashisms and probable typos)
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?UTF-8?Q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

T24gV2VkLCAyMDA5LTEyLTAyIGF0IDAwOjQyICswMTAwLCBKacWZw60gUGFsZcSNZWsgd3JvdGU6
IAo+IE9uIFdlZCwgMDIgRGVjIDIwMDkgMDA6MjA6MzYgKzAxMDAsIE1pa2UgRnJ5c2luZ2VyIDx2
YXBpZXJAZ2VudG9vLm9yZz4gIAo+IHdyb3RlOgo+IAo+ID4gb3RoZXIgdGhhbiB0aGUgbWlub3Ig
dGhpbmdzIGkgbWVudGlvbmVkIHNwZWNpZmljYWxseSwgdGhlIHJlc3Qgb2YgeW91ciAgCj4gPiBj
aGFuZ2VzCj4gPiBsb29rIGZpbmUgdG8gbWUuICB0aGFua3MhCj4gCj4gT0suIEknbGwgcmVzZW5k
IHRoZSB0d28uCgpUaGlzIHJlc2VuZCBpcyB5ZXQgdG8gYXJyaXZlIDstKQoKUmVnYXJkcy0tClN1
YnJhdGEKCj4gCj4gICAgSmlyaSBQYWxlY2VrCj4gCj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkpvaW4gdXMgRGVjZW1iZXIgOSwgMjAwOSBmb3IgdGhlIFJlZCBIYXQgVmlydHVhbCBFeHBlcmll
bmNlLAphIGZyZWUgZXZlbnQgZm9jdXNlZCBvbiB2aXJ0dWFsaXphdGlvbiBhbmQgY2xvdWQgY29t
cHV0aW5nLiAKQXR0ZW5kIGluLWRlcHRoIHNlc3Npb25zIGZyb20geW91ciBkZXNrLiBZb3VyIGNv
dWNoLiBBbnl3aGVyZS4KaHR0cDovL3Auc2YubmV0L3NmdS9yZWRoYXQtc2ZkZXYyZGV2Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxp
bmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
