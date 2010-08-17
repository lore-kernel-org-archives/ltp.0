Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <RenXiu.Liang@windriver.com>) id 1OlFBS-0005hF-IX
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 05:58:02 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OlFBN-0006NS-7H
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 05:58:02 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB3DD1.1EF4E3DB"
Date: Tue, 17 Aug 2010 07:57:00 +0200
Message-ID: <52CF90264091A14888078A031D780F4305936FA5@ism-mail03.corp.ad.wrs.com>
References: <52CF90264091A14888078A031D780F4305936FA4@ism-mail03.corp.ad.wrs.com>
From: "Liang, RenXiu" <RenXiu.Liang@windriver.com>
Subject: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal - 11
	--- exiting
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
To: ltp-list@lists.sf.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB3DD1.1EF4E3DB
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CB3DD1.1EF4E3DB"


------_=_NextPart_002_01CB3DD1.1EF4E3DB
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In mtest06/mmap1.c, when handling the signal 11 in sig_handler, it =
doesn't cover another two race conditions:
one is si_code equals "SEGV_MAPERR" but si_address does not equal to =
map_address;
and one is si_code equals to "SEGV_ACCERR"; see below error log:

<<<test_start>>>
tag=3Dmtest06 stime=3D1270902396
cmdline=3D"  mmap1 -x 0.05"
contacts=3D""
analysis=3Dexit
initiation_status=3D"ok"
<<<test_output>>>
mmap1       0  INFO  :  pid[5456]: map, change contents, unmap files
1000 times
mmap1       0  INFO  :  created thread[1216369840]
mmap1       0  INFO  :  pid[5456] - read contents of memory 0x48002000
1000 times
mmap1       0  INFO  :  page fault occurred at 0x48002000
mmap1       0  INFO  :  page fault occurred at 0x48002000
mmap1       0  INFO  :  page fault occurred at 0x48002000
mmap1       0  INFO  :  page fault occurred at 0x48002000
......
mmap1       0  INFO  :  page fault occurred at 0x48002000
mmap1       0  INFO  :  page fault occurred at 0x48002000
caught unexpected signal - 11 --- exiting
<<<execution_status>>>
duration=3D1 termination_type=3Dexited termination_id=3D255 =
corefile=3Dno
cutime=3D0 cstime=3D4
<<<test_end>>>

After cover all the three race conditions in one case in sig_handler(), =
run mtest06 repeatedly, test will not fail by catching signal 11.

See attached patch.

Thanks,
Renxiu


------_=_NextPart_002_01CB3DD1.1EF4E3DB
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>[Patch] Fix mtest06 failure: caught unexpected signal - 11 --- =
exiting</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>In mtest06/mmap1.c, when handling the signal 11 in =
sig_handler, it doesn't cover another two race conditions:<BR>
one is si_code equals &quot;SEGV_MAPERR&quot; but si_address does not =
equal to map_address;<BR>
and one is si_code equals to &quot;SEGV_ACCERR&quot;; see below error =
log:<BR>
<BR>
&lt;&lt;&lt;test_start&gt;&gt;&gt;<BR>
tag=3Dmtest06 stime=3D1270902396<BR>
cmdline=3D&quot;&nbsp; mmap1 -x 0.05&quot;<BR>
contacts=3D&quot;&quot;<BR>
analysis=3Dexit<BR>
initiation_status=3D&quot;ok&quot;<BR>
&lt;&lt;&lt;test_output&gt;&gt;&gt;<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
pid[5456]: map, change contents, unmap files<BR>
1000 times<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
created thread[1216369840]<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
pid[5456] - read contents of memory 0x48002000<BR>
1000 times<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
......<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
mmap1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; INFO&nbsp; :&nbsp; =
page fault occurred at 0x48002000<BR>
caught unexpected signal - 11 --- exiting<BR>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<BR>
duration=3D1 termination_type=3Dexited termination_id=3D255 =
corefile=3Dno<BR>
cutime=3D0 cstime=3D4<BR>
&lt;&lt;&lt;test_end&gt;&gt;&gt;<BR>
<BR>
After cover all the three race conditions in one case in sig_handler(), =
run mtest06 repeatedly, test will not fail by catching signal 11.<BR>
<BR>
See attached patch.<BR>
<BR>
Thanks,<BR>
Renxiu<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01CB3DD1.1EF4E3DB--

------_=_NextPart_001_01CB3DD1.1EF4E3DB
Content-Type: text/x-patch;
	name="0001-Fix-sig_handler-for-SIGSEGV-in-mmap1.c.patch"
Content-Transfer-Encoding: base64
Content-Description: 0001-Fix-sig_handler-for-SIGSEGV-in-mmap1.c.patch
Content-Disposition: attachment;
	filename="0001-Fix-sig_handler-for-SIGSEGV-in-mmap1.c.patch"

RnJvbSBjYjNhMzAzMmFjZjgxOGE2OWU2ZDdiZDAyOGQ0YjBjOTI3YjBmYWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZW54aXUgTGlhbmcgPHJlbnhpdS5saWFuZ0B3aW5kcml2ZXIu
Y29tPgpEYXRlOiBNb24sIDE2IEF1ZyAyMDEwIDE5OjU3OjU0IC0wNzAwClN1YmplY3Q6IFtQQVRD
SCAxLzFdIEZpeCBzaWdfaGFuZGxlcigpIGZvciBTSUdTRUdWIGluIG1tYXAxLmMKCiJtdGVzdDA2
IiBpcyBhaW1lZCBhdCBzdHJlc3NpbmcgdGhlIG1lbW9yeSBtYW5hZ2VyIGJ5IHNpbXVsdGFuaW91
cwptYXAvdW5tYXAvcmVhZCBieSBsaWdodCB3ZWlnaHQgcHJvY2Vzc2VzOyBpdCB0cmllcyB0byBo
YW5kbGUKU0lHU0VHViBzaWduYWwgaW4gc2lnX2hhbmRsZXIgaW5zdGVhZCBvZiBkb2luZyBzeW5j
aHJvbml6YXRpb25zCmJldHdlZW4gcmVhZCBhbmQgd3JpdGUgdGhyZWFkczsgdHdvIG1vcmUgcmFj
ZSBjb25kaXRpb25zIGFyZQpub3QgY292ZXJlZDogb25lIGlzIHNpX2NvZGUgZXF1YWxzICJTRUdW
X01BUEVSUiIgYnV0IHNpX2FkZHJlc3MKZG9lcyBub3QgZXF1YWwgdG8gbWFwX2FkZHJlc3M7IHRo
ZSBvdGhlciBpcyBzaV9jb2RlIGVxdWFscyB0bwoiU0VHVl9BQ0NFUlIiOyB0cnkgdG8gY292ZXIg
dGhlIHRocmVlIGNvbmRpdGlvbnMgaW4gb25lIGNhc2UKdG8gcmVkdWNlIHRoZSBjb21wbGV4aXR5
LgoKU2lnbmVkLW9mZi1ieTogUmVueGl1IExpYW5nIDxyZW54aXUubGlhbmdAd2luZHJpdmVyLmNv
bT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9tdGVzdDA2L21tYXAxLmMgfCAgICA4ICsrLS0t
LS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9tdGVzdDA2L21tYXAxLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9tdGVzdDA2L21tYXAxLmMKaW5kZXggNDdhYjQ5YS4uN2ViMzU0NyAxMDA2
NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3QwNi9tbWFwMS5jCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL210ZXN0MDYvbW1hcDEuYwpAQCAtMTY4LDE0ICsxNjgsMTAgQEAgc2ln
X2hhbmRsZXIoaW50IHNpZ25hbCwJCS8qIHNpZ25hbCBudW1iZXIsIHNldCB0byBoYW5kbGUgU0lH
QUxSTSAgICAgICAqLwogICAgICAgICAgICAgIF9leGl0KDApOwogCiAgICAgICAgIGNhc2UgU0lH
U0VHVjoKLSAgICAgICAgICAgICBpZiAoaW5mby0+c2lfY29kZSA9PSBTRUdWX01BUEVSUiAmJgot
ICAgICAgICAgICAgICAgICAgICAgIGluZm8tPnNpX2FkZHIgPT0gbWFwX2FkZHJlc3MpCi0gICAg
ICAgICAgICAgewotICAgICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sCisgICAgICAgICAg
ICAgdHN0X3Jlc20oVElORk8sCiAgICAgICAgICAgICAgICAgICAgICJwYWdlIGZhdWx0IG9jY3Vy
cmVkIGF0ICVwIiwKICAgICAgICAgICAgICAgICAgICAgbWFwX2FkZHJlc3MpOwotICAgICAgICAg
ICAgICAgICAgbG9uZ2ptcChqbXBidWYsIDEpOwotICAgICAgICAgICAgIH0KKyAgICAgICAgICAg
ICBsb25nam1wKGptcGJ1ZiwgMSk7CiAgICAgICAgIGRlZmF1bHQ6CiAgICAgICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgImNhdWdodCB1bmV4cGVjdGVkIHNpZ25hbCAtICVkIC0tLSBleGl0aW5nXG4i
LAogICAgICAgICAgICAgICAgICAgICAgc2lnbmFsKTsKLS0gCjEuNi4xCgo=

------_=_NextPart_001_01CB3DD1.1EF4E3DB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
------_=_NextPart_001_01CB3DD1.1EF4E3DB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB3DD1.1EF4E3DB--

