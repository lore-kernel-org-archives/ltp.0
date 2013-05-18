Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UdVDN-0006Kq-UK
	for ltp-list@lists.sourceforge.net; Sat, 18 May 2013 00:41:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdVDM-0003oY-NN
	for ltp-list@lists.sourceforge.net; Sat, 18 May 2013 00:41:37 +0000
Message-ID: <5196CE0E.8030303@cn.fujitsu.com>
Date: Sat, 18 May 2013 08:40:46 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1368817006-7581-1-git-send-email-vlee@freedesktop.org>
In-Reply-To: <1368817006-7581-1-git-send-email-vlee@freedesktop.org>
Subject: Re: [LTP] [PATCH] mount/mount03.c: Add mode argument to open call.
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Vinson Lee <vlee@freedesktop.org>
Cc: ltp-list@lists.sourceforge.net

T24gMDUvMTgvMjAxMyAwMjo1NiBBTSwgVmluc29uIExlZSB3cm90ZToKPiBGcm9tOiBWaW5zb24g
TGVlIDx2bGVlQHR3aXR0ZXIuY29tPgo+IAo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBidWlsZCBl
cnJvciBvbiBVYnVudHUgaW50cm9kdWNlZCB3aXRoIGNvbW1pdAo+IDI0MzI0YWQ1ZGFlNzExNzIx
MjUwNjBiODI1ODA0ODZiMGYzZDM3ZGEuCj4gCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3Iv
aW5jbHVkZS9mY250bC5oOjI1MjowLAo+ICAgICAgICAgICAgICAgICAgZnJvbSBtb3VudDAzLmM6
NzM6Cj4gSW4gZnVuY3Rpb24g4oCYb3BlbuKAmSwKPiAgICAgaW5saW5lZCBmcm9tIOKAmHNldHVw
4oCZIGF0IG1vdW50MDMuYzo0NDc6NToKPiAvdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9i
aXRzL2ZjbnRsMi5oOjUxOjI0OiBlcnJvcjogY2FsbCB0byDigJhfX29wZW5fbWlzc2luZ19tb2Rl
4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBvcGVuIHdpdGggT19DUkVBVCBpbiBz
ZWNvbmQgYXJndW1lbnQgbmVlZHMgMyBhcmd1bWVudHMKPiAKPiBTaWduZWQtb2ZmLWJ5OiBWaW5z
b24gTGVlIDx2bGVlQHR3aXR0ZXIuY29tPgoKQXBwbGllZCwgdGhhbmsgeW91LgoKV2FubG9uZyBH
YW8KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQWxpZW5WYXVsdCBVbmlmaWVkIFNlY3VyaXR5IE1h
bmFnZW1lbnQgKFVTTSkgcGxhdGZvcm0gZGVsaXZlcnMgY29tcGxldGUKc2VjdXJpdHkgdmlzaWJp
bGl0eSB3aXRoIHRoZSBlc3NlbnRpYWwgc2VjdXJpdHkgY2FwYWJpbGl0aWVzLiBFYXNpbHkgYW5k
CmVmZmljaWVudGx5IGNvbmZpZ3VyZSwgbWFuYWdlLCBhbmQgb3BlcmF0ZSBhbGwgb2YgeW91ciBz
ZWN1cml0eSBjb250cm9scwpmcm9tIGEgc2luZ2xlIGNvbnNvbGUgYW5kIG9uZSB1bmlmaWVkIGZy
YW1ld29yay4gRG93bmxvYWQgYSBmcmVlIHRyaWFsLgpodHRwOi8vcC5zZi5uZXQvc2Z1L2FsaWVu
dmF1bHRfZDJkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
