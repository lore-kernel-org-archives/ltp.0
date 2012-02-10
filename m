Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RvgDa-00042p-Uw
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 02:28:10 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RvgDZ-0005kN-VJ
	for ltp-list@lists.sourceforge.net; Fri, 10 Feb 2012 02:28:10 +0000
Received: by iaby12 with SMTP id y12so4181825iab.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Feb 2012 18:28:04 -0800 (PST)
Message-ID: <4F348098.8090202@casparzhang.com>
Date: Fri, 10 Feb 2012 10:27:36 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328828750-11079-1-git-send-email-vlee@twitter.com>
In-Reply-To: <1328828750-11079-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] safe_macros: Include errno.h.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

T24gMDIvMTAvMjAxMiAwNzowNSBBTSwgVmluc29uIExlZSB3cm90ZToKPiBGaXggYnVpbGQgcmVn
cmVzc2lvbiBpbnRyb2R1Y2VkIGJ5IGNvbW1pdAo+IGQ2YTFmMjUxMzdiMGFjODcwNGJkMDhjYzRi
YzhhZjAxY2NlYWNhMGUuCj4gCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGJ1aWxkIGVycm9yIG9u
IFVidW50dSAxMS4xMC4KPiBzYWZlX21hY3Jvcy5jOiBJbiBmdW5jdGlvbiDigJhzYWZlX3N0cnRv
bOKAmToKPiBzYWZlX21hY3Jvcy5jOjM0OToyOiBlcnJvcjog4oCYZXJybm/igJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMKPiBmdW5jdGlvbikKPiBzYWZlX21hY3Jvcy5jOjM0OToyOiBu
b3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5Cj4gb25jZSBm
b3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCj4gc2FmZV9tYWNyb3MuYzozNTE6MTY6IGVy
cm9yOiDigJhFUkFOR0XigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMKPiBmdW5jdGlv
bikKCkhpIENvbW1pdHRlZCwgdGhhbmtzLgoKQ2FzcGFyCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFZp
bnNvbiBMZWUgPHZsZWVAdHdpdHRlci5jb20+Cj4gLS0tCj4gIGxpYi9zYWZlX21hY3Jvcy5jIHwg
ICAgMSArCj4gIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9saWIvc2FmZV9tYWNyb3MuYyBiL2xpYi9zYWZlX21hY3Jvcy5j
Cj4gaW5kZXggNGM4Y2JiNy4uMzFkZjBmZCAxMDA2NDQKPiAtLS0gYS9saWIvc2FmZV9tYWNyb3Mu
Ywo+ICsrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4gQEAgLTIsNiArMiw3IEBACj4gICNpbmNsdWRl
IDxzeXMvbW1hbi5oPgo+ICAjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+Cj4gICNpbmNsdWRlIDxz
eXMvc3RhdC5oPgo+ICsjaW5jbHVkZSA8ZXJybm8uaD4KPiAgI2luY2x1ZGUgPGZjbnRsLmg+Cj4g
ICNpbmNsdWRlIDxsaWJnZW4uaD4KPiAgI2luY2x1ZGUgPGxpbWl0cy5oPgoKCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQpWaXJ0dWFsaXphdGlvbiAmIENsb3VkIE1hbmFnZW1lbnQgVXNpbmcgQ2FwYWNp
dHkgUGxhbm5pbmcKQ2xvdWQgY29tcHV0aW5nIG1ha2VzIHVzZSBvZiB2aXJ0dWFsaXphdGlvbiAt
IGJ1dCBjbG91ZCBjb21wdXRpbmcgCmFsc28gZm9jdXNlcyBvbiBhbGxvd2luZyBjb21wdXRpbmcg
dG8gYmUgZGVsaXZlcmVkIGFzIGEgc2VydmljZS4KaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9q
YXcvc2ZubC8xMTQvNTE1MjEyMjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRw
LWxpc3QK
