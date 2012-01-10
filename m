Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RkSZL-0002YD-8b
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:40:15 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RkSZK-0000MM-CA
	for ltp-list@lists.sourceforge.net; Tue, 10 Jan 2012 03:40:15 +0000
Received: by ggno1 with SMTP id o1so41694ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jan 2012 19:40:08 -0800 (PST)
Message-ID: <4F0BB312.5070009@casparzhang.com>
Date: Tue, 10 Jan 2012 11:40:02 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
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
To: LTP List <ltp-list@lists.sourceforge.net>

T24gMjAxMuW5tDAx5pyIMTDml6UgMTE6MzgsIENhc3BhciBaaGFuZyB3cm90ZToKPiAKPiB3aGVu
IGV4ZWN1dGluZyB3aXRoIGAkQklOL3J1bmx0cGAgY29tbWFuZCwgZ2V0cnVzYWdlMDMgcHV0cyBv
dXQKPiBkdXBsaWNhdGVkIGluZm9ybWF0aW9uIGR1ZSB0byBidWZmZXJlZCBzdGRvdXQuIFVzaW5n
IGZmbHVzaChzdGRvdXQpIHRvCj4gc29sdmUgdGhpcyBpc3N1ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBDYXNwYXIgWmhhbmcgPGNhc3BhckBjYXNwYXJ6aGFuZy5jb20+Cj4gLS0tCj4gIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmMgIHwgICAgNyArKysrKysr
Cj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzX2NoaWxkLmMgIHwg
ICAgMSArCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQo+IAoKTm90IHN1cmUgaWYgd2UgaGF2ZSBhbnkgYmV0dGVyIHNvbHV0aW9uIHRvIGF2b2lkIHN1
Y2ggYnVmZmVyZWQgSS9PIGlzc3VlLgoKQ2FzcGFyCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KV3Jp
dGUgb25jZS4gUG9ydCB0byBtYW55LgpHZXQgdGhlIFNESyBhbmQgdG9vbHMgdG8gc2ltcGxpZnkg
Y3Jvc3MtcGxhdGZvcm0gYXBwIGRldmVsb3BtZW50LiBDcmVhdGUgCm5ldyBvciBwb3J0IGV4aXN0
aW5nIGFwcHMgdG8gc2VsbCB0byBjb25zdW1lcnMgd29ybGR3aWRlLiBFeHBsb3JlIHRoZSAKSW50
ZWwgQXBwVXBTTSBwcm9ncmFtIGRldmVsb3BlciBvcHBvcnR1bml0eS4gYXBwZGV2ZWxvcGVyLmlu
dGVsLmNvbS9qb2luCmh0dHA6Ly9wLnNmLm5ldC9zZnUvaW50ZWwtYXBwZGV2Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlz
dApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
