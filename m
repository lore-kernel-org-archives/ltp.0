Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <carmelo.amoroso@st.com>) id 1P0DqY-0003xV-E1
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 13:34:22 +0000
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0DqW-0002Mk-4G
	for ltp-list@lists.sourceforge.net; Mon, 27 Sep 2010 13:34:22 +0000
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 27 Sep 2010 15:34:05 +0200
Message-ID: <4CA09D4D.6050708@st.com>
Content-Type: multipart/mixed; boundary="_002_4CA09D4D6050708stcom_"
MIME-Version: 1.0
Subject: [LTP] ltp_clone alignment issues.
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "jpalecek@web.de" <jpalecek@web.de>

--_002_4CA09D4D6050708stcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Folks,
I want to reopen an old discussion on ltp_clone and stack alignment
issue (see
http://sourceforge.net/mailarchive/message.php?msg_name=3D4B421480.1040400%=
40petalogix.com).
Indeed recently a commit has partially fixed a problem on ARM
(0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
extended to all archs that have stack that grows downwards.

Indeed, as Jiri replied in that old thread, the value passed to clone as
child stack should be never accessed,  because it is the topmost address
of the memory allocated for the child process (it's the previous stack
pointer).

So, in archs that do not like unaligned stack, using (stack - size - 1 )
will cause the process to be killed by a SIGBUS, on other archs, we are
just wasting one byte of the malloc-ed stack.

On my SH4 arch, the stack must be 4byte aligned (as in ARM).

Please, find attached a patch against master branch

Best regards,
Carmelo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkygnU0ACgkQoRq/3BrK1s+GugCgrrCDWRWknR36qdOFv6Qzg4Kl
tEAAn1lRyS/5RL2ymbrX4A3q+7L3w/Gs
=3DyBmF
-----END PGP SIGNATURE-----

--_002_4CA09D4D6050708stcom_
Content-Type: text/x-patch;
	name="0001-lib-Fix-ltp_clone-wrapper-stack-argument-for-all-arc.patch"
Content-Description: 0001-lib-Fix-ltp_clone-wrapper-stack-argument-for-all-arc.patch
Content-Disposition: attachment;
	filename="0001-lib-Fix-ltp_clone-wrapper-stack-argument-for-all-arc.patch";
	size=1797; creation-date="Mon, 27 Sep 2010 15:34:08 GMT";
	modification-date="Mon, 27 Sep 2010 15:34:08 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MzkzZGEwYTFhNjk1OWNjNWQyNWY3M2JlNjNiYWY4YzNmYWU4NzYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQ2FybWVsbyBBbW9yb3NvIDxjYXJtZWxvLmFtb3Jvc29Ac3Qu
Y29tPg0KRGF0ZTogTW9uLCAyNyBTZXAgMjAxMCAxMzowMDowNiArMDAwMA0KU3ViamVjdDogW1BB
VENIXSBsaWI6IEZpeCBsdHBfY2xvbmUgd3JhcHBlciBzdGFjayBhcmd1bWVudCBmb3IgYWxsIGFy
Y2hpdGVjdHVyZXMNCg0KRm9yIGFsbCB0aGUgYXJjaGl0ZWN0dXJlcyB0aGF0IGhhdmUgc3RhY2sg
dGhhdCBncm93cyBkb3dud2FyZHMsIHRoZQ0Kc3RhY2sgYXJndW1lbnQgcGFzc2VkIHRvIHRoZSBj
bG9uZSBmdW5jdGlvbiBwb2ludHMgdG8gdGhlIHRvcG1vc3QNCmFkZHJlc3Mgb2YgdGhlIG1lbW9y
eSBzcGFjZSBzZXQgdXAgZm9yIHRoZSBjaGlsZCBzdGFjay4gU28gaXQgaXMgbm90DQpjb3JyZWN0
IHRvIG1vdmUgdGhlIHN0YWNrIGRvd24uIFRoZSBBQkkgZ3VhcmFudGVlcyB0aGF0IHRoZSBmdW5j
dGlvbiBoYXMNCnRvIGNyZWF0ZSBpdCdzIG93biBzdGFjayBmcmFtZS4NCg0KTmV2ZXJ0aGVsZXNz
LCBvbiBzb21lIGFyY2hpdGVjdHVyZXMgdGhhdCBkbyBub3QgYWNjZXB0IHVuYWxpZ25lZCBzdGFj
aywNCml0IGNhdXNlcyB0aGUgcHJvY2VzcyB0byBiZSBraWxsZWQgYnkgdGhlIGtlcm5lbCB3aXRo
IGEgU0lHQlVTLg0KT24gYXJjaGl0ZWN0dXJlcyB0aGF0IHNhZmVseSBoYW5kbGUgdW5hbGlnbmVk
IHN0YWNrLCB3ZSBhcmUgYWN0dWFsbHkNCnJlc2VydmluZyBvbmUgYnl0ZSBsZXNzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDYXJtZWxvIEFtb3Jvc28gPGNhcm1lbG8uYW1vcm9zb0BzdC5jb20+DQotLS0N
CiBsaWIvY2xvbmVyLmMgfCAgICA5ICsrKy0tLS0tLQ0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL2Nsb25lci5jIGIv
bGliL2Nsb25lci5jDQppbmRleCA2YWQ0YTAwLi5lNTNjOWNmIDEwMDY0NA0KLS0tIGEvbGliL2Ns
b25lci5jDQorKysgYi9saWIvY2xvbmVyLmMNCkBAIC01OSwxNiArNTksMTMgQEAgbHRwX2Nsb25l
KHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIGludCAoKmZuKSh2b2lkICphcmcpLCB2b2lkICph
cmcsDQogCXJldCA9IGNsb25lKGZuLCBzdGFjaywgY2xvbmVfZmxhZ3MsIGFyZyk7DQogI2VsaWYg
ZGVmaW5lZChfX2lhNjRfXykNCiAJcmV0ID0gY2xvbmUyKGZuLCBzdGFjaywgc3RhY2tfc2l6ZSwg
Y2xvbmVfZmxhZ3MsIGFyZywgTlVMTCwgTlVMTCwgTlVMTCk7DQotI2VsaWYgZGVmaW5lZChfX2Fy
bV9fKQ0KKyNlbHNlDQogCS8qDQotCSAqIFN0YWNrIHNpemUgc2hvdWxkIGJlIGEgbXVsdGlwbGUg
b2YgMzIgYml0IHdvcmRzDQotCSAqICYgc3RhY2sgbGltaXQgbXVzdCBiZSBhbGlnbmVkIHRvIGEg
MzIgYml0IGJvdW5kYXJ5DQorCSAqIEZvciBhcmNocyB3aGVyZSBzdGFjayBncm93cyBkb3dud2Fy
ZHMsIHN0YWNrIHBvaW50cyB0byB0aGUgdG9wbW9zdCBhZGRyZXNzDQorCSAqIG9mIHRoZSBtZW1v
cnkgc3BhY2Ugc2V0IHVwIGZvciB0aGUgY2hpbGQgc3RhY2suDQogCSAqLw0KIAlyZXQgPSBjbG9u
ZShmbiwgKHN0YWNrID8gc3RhY2sgKyBzdGFja19zaXplIDogTlVMTCksDQogCQkJY2xvbmVfZmxh
Z3MsIGFyZyk7DQotI2Vsc2UNCi0JcmV0ID0gY2xvbmUoZm4sIChzdGFjayA/IHN0YWNrICsgc3Rh
Y2tfc2l6ZSAtIDEgOiBOVUxMKSwNCi0JCQljbG9uZV9mbGFncywgYXJnKTsNCiAjZW5kaWYNCiAN
CiAJcmV0dXJuIHJldDsNCi0tIA0KMS43LjENCg0K

--_002_4CA09D4D6050708stcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--_002_4CA09D4D6050708stcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_002_4CA09D4D6050708stcom_--

