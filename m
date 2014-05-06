Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccnandi@yahoo.com>) id 1WhoDJ-000234-JC
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 22:51:53 +0000
Received: from nm45.bullet.mail.ne1.yahoo.com ([98.138.120.52])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WhoDF-00005V-Ut
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 22:51:53 +0000
References: 
Message-ID: <1399416524.48574.YahooMailNeo@web141601.mail.bf1.yahoo.com>
Date: Tue, 6 May 2014 15:48:44 -0700 (PDT)
From: C Nandi <ccnandi@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1633104601-1979827478-1399416524=:48574"
Subject: [LTP] Sendfile01 : mc_gethost argument
Reply-To: C Nandi <ccnandi@yahoo.com>
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

--1633104601-1979827478-1399416524=:48574
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AReferring, http://www.gnu.org/software/bash/manual/bash.html=A0 =
=0A=0A=A0=A0=A0 ${parameter:+word}=0A=A0=A0=A0 If parameter is null or unse=
t, nothing is substituted, otherwise the expansion of word is substituted.=
=0A=0A=0AAs per the syntax of "mc_gethost" it accepts -d, -6 or -f.=0A=A0=
=A0=A0 usage:=A0 mc_gethost [-d] [-6] [-f] (hostname|ipaddr)=0A=0AHence, I =
guess, the following correction is required.=0A=0Adiff --git a/testcases/ne=
twork/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/se=
ndfile01=0Aindex 1598106..ad16290 100755=0A--- a/testcases/network/tcp_cmds=
/sendfile/sendfile01=0A+++ b/testcases/network/tcp_cmds/sendfile/sendfile01=
=0A@@ -61,7 +61,7 @@ do_setup()=0A=0A=A0=A0=A0=A0 exists awk diff mc_gethos=
t grep rsh stat=0A=0A-=A0=A0=A0 if ! IPADDR=3D$(mc_gethost ${EXEC_SUFFIX:+6=
} $RHOST | awk 'BEGIN { ec=3D1 } /addresses:/ {print $2; ec=3D0 } E=0A+=A0=
=A0=A0 if ! IPADDR=3D$(mc_gethost ${EXEC_SUFFIX:+-6} $RHOST | awk 'BEGIN { =
ec=3D1 } /addresses:/ {print $2; ec=3D0 }=0A=A0=A0=A0=A0=A0=A0=A0=A0 # XXX =
(garrcoop): || exit 1 is there to prevent the test from hanging in the even=
t of an install err=0A=A0=A0=A0=A0=A0=A0=A0=A0 end_testcase "Failed to dete=
rmine the appropriate IP address for the machine." || exit 1=0A=A0=A0=A0=A0=
 fi=0A=0A=0A=0A=0A=0AIf you feel this is correct, please find the patch att=
ached with this e-mail.=0A=0AThanks and Regards, =0ACHANDRASHEKHAR NANDI=A0=
=A0=A0 
--1633104601-1979827478-1399416524=:48574
Content-Type: application/octet-stream;
	name="0001-sendfile01-Corrected-mc_gethost-argument.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-sendfile01-Corrected-mc_gethost-argument.patch"

RnJvbSAwYTUzNTQ0YjYxOGNmMDMwM2UzOTQ1MGEyNWQzNTMyYWFjZGYxMTM1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZHJhc2hla2hh
ciBOYW5kaSA8Q2hhbmRyYXNoZWtoYXIuTmFuZGlAbXBoYXNpcy5jb20+CkRh
dGU6IFR1ZSwgNiBNYXkgMjAxNCAxNjozNjo1MSAtMDYwMApTdWJqZWN0OiBb
UEFUQ0hdIHNlbmRmaWxlMDE6IENvcnJlY3RlZCBtY19nZXRob3N0IGFyZ3Vt
ZW50CgpTaWduZWQtb2ZmLWJ5OiBDaGFuZHJhc2hla2hhciBOYW5kaSA8Q2hh
bmRyYXNoZWtoYXIuTmFuZGlAbXBoYXNpcy5jb20+CgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL25ldHdvcmsvdGNwX2NtZHMvc2VuZGZpbGUvc2VuZGZpbGUw
MSBiL3Rlc3RjYXNlcy9uZXR3b3JrL3RjcF9jbWRzL3NlbmRmaWxlL3NlbmRm
aWxlMDEKaW5kZXggMTU5ODEwNi4uYWQxNjI5MCAxMDA3NTUKLS0tIGEvdGVz
dGNhc2VzL25ldHdvcmsvdGNwX2NtZHMvc2VuZGZpbGUvc2VuZGZpbGUwMQor
KysgYi90ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9zZW5kZmlsZS9zZW5k
ZmlsZTAxCkBAIC02MSw3ICs2MSw3IEBAIGRvX3NldHVwKCkKIAogICAgIGV4
aXN0cyBhd2sgZGlmZiBtY19nZXRob3N0IGdyZXAgcnNoIHN0YXQKIAotICAg
IGlmICEgSVBBRERSPSQobWNfZ2V0aG9zdCAke0VYRUNfU1VGRklYOis2fSAk
UkhPU1QgfCBhd2sgJ0JFR0lOIHsgZWM9MSB9IC9hZGRyZXNzZXM6LyB7cHJp
bnQgJDI7IGVjPTAgfSBFTkQgeyBleGl0IGVjIH0nKTsgdGhlbgorICAgIGlm
ICEgSVBBRERSPSQobWNfZ2V0aG9zdCAke0VYRUNfU1VGRklYOistNn0gJFJI
T1NUIHwgYXdrICdCRUdJTiB7IGVjPTEgfSAvYWRkcmVzc2VzOi8ge3ByaW50
ICQyOyBlYz0wIH0gRU5EIHsgZXhpdCBlYyB9Jyk7IHRoZW4KICAgICAgICAg
IyBYWFggKGdhcnJjb29wKTogfHwgZXhpdCAxIGlzIHRoZXJlIHRvIHByZXZl
bnQgdGhlIHRlc3QgZnJvbSBoYW5naW5nIGluIHRoZSBldmVudCBvZiBhbiBp
bnN0YWxsIGVycm9yLgogICAgICAgICBlbmRfdGVzdGNhc2UgIkZhaWxlZCB0
byBkZXRlcm1pbmUgdGhlIGFwcHJvcHJpYXRlIElQIGFkZHJlc3MgZm9yIHRo
ZSBtYWNoaW5lLiIgfHwgZXhpdCAxCiAgICAgZmkKLS0gCjEuNy4xMC40Cgo=


--1633104601-1979827478-1399416524=:48574
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--1633104601-1979827478-1399416524=:48574
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--1633104601-1979827478-1399416524=:48574--

