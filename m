Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1Tb6eL-0001RI-RU
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 09:31:17 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tb6eF-00070l-P6
	for ltp-list@lists.sourceforge.net; Wed, 21 Nov 2012 09:31:17 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qAL9V2jE020561
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Nov 2012 17:31:04 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Wed, 21 Nov 2012 17:30:17 +0800
Message-Id: <1353490217-30332-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ar01: fix a bug of attribute "selinux" in rhel6
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
To: ltp-list@lists.sourceforge.net

V2hlbiBTRUxpbnV4IGlzIGVuYWJsZWQsICJscyAtbG4iIHdpbGwgbGlzdCBwZXJtaXNzaW9ucyB3
aXRoICItcnctci0tci0tLiIsCmJ1dCAiYXIgLXR2IiB3aWxsIGxpc3QgcGVybWlzc2lvbnMgd2l0
aCAiLXJ3LXItLXItLSLvvIxzbyB0aGUgY2FzZSAyMiB3aWxsIGZhaWwuCgpTaWduZWQtb2ZmLWJ5
OiBQZW5nIEhhaXRhbyA8cGVuZ2h0QGNuLmZ1aml0c3UuY29tPgotLS0KIHRlc3RjYXNlcy9jb21t
YW5kcy9hZGUvYXIvYXIwMSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jb21tYW5kcy9hZGUvYXIvYXIw
MSBiL3Rlc3RjYXNlcy9jb21tYW5kcy9hZGUvYXIvYXIwMQppbmRleCA5NDhjMWZlLi4zMmZlZjEx
IDEwMDc1NQotLS0gYS90ZXN0Y2FzZXMvY29tbWFuZHMvYWRlL2FyL2FyMDEKKysrIGIvdGVzdGNh
c2VzL2NvbW1hbmRzL2FkZS9hci9hcjAxCkBAIC01MzYsNyArNTM2LDcgQEAgZG8KIAlscyAtbG4g
LS10aW1lLXN0eWxlPSslYiIgIiVlIiAiJUg6JU0gZmlsZTEuaW4gZmlsZTIuaW4gZmlsZTMuaW4g
fAogCXdoaWxlIHJlYWQgcGVybWlzc2lvbnMgbGluayB1aWQgZ2lkIHNpemUgbW9udGggZGF5IHRp
bWUgZmlsZV9uYW1lCiAJZG8KLQkJZWNobyAiJHBlcm1pc3Npb25zOyR1aWQvJGdpZDskc2l6ZTsk
bW9udGg7JGRheTskdGltZTskZmlsZV9uYW1lIgorCQllY2hvICIke3Blcm1pc3Npb25zJS59OyR1
aWQvJGdpZDskc2l6ZTskbW9udGg7JGRheTskdGltZTskZmlsZV9uYW1lIgogCWRvbmUgPj4gICRU
Q3RtcC9saWIuYS5leHAKIAogCWFyIC10diAkVEN0bXAvbGliLmEgfAotLSAKMS44LjAKCgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KTW9uaXRvciB5b3VyIHBoeXNpY2FsLCB2aXJ0dWFsIGFuZCBjbG91
ZCBpbmZyYXN0cnVjdHVyZSBmcm9tIGEgc2luZ2xlCndlYiBjb25zb2xlLiBHZXQgaW4tZGVwdGgg
aW5zaWdodCBpbnRvIGFwcHMsIHNlcnZlcnMsIGRhdGFiYXNlcywgdm13YXJlLApTQVAsIGNsb3Vk
IGluZnJhc3RydWN0dXJlLCBldGMuIERvd25sb2FkIDMwLWRheSBGcmVlIFRyaWFsLgpQcmljaW5n
IHN0YXJ0cyBmcm9tICQ3OTUgZm9yIDI1IHNlcnZlcnMgb3IgYXBwbGljYXRpb25zIQpodHRwOi8v
cC5zZi5uZXQvc2Z1L3pvaG9fZGV2MmRldl9ub3YKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9sdHAtbGlzdAo=
