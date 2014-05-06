Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccnandi@yahoo.com>) id 1WhofY-00035K-Ca
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 23:21:04 +0000
Received: from nm41.bullet.mail.ne1.yahoo.com ([98.138.120.48])
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WhofV-0003uo-T3
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 23:21:04 +0000
Message-ID: <1399418275.53978.YahooMailNeo@web141606.mail.bf1.yahoo.com>
Date: Tue, 6 May 2014 16:17:55 -0700 (PDT)
From: C Nandi <ccnandi@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="-225646846-1447681308-1399418275=:53978"
Subject: [LTP] Reg: sendfile01_server
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

---225646846-1447681308-1399418275=:53978
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

From "testcases/network/tcp_cmds/sendfile/sendfile01"=0A=A0=A0=A0 53=A0=A0=
=A0=A0=A0 CLIENT=3D"testsf_c${EXEC_SUFFIX}"=0A=A0=A0=A0 54=A0=A0=A0=A0=A0 S=
ERVER=3D"testsf_s${EXEC_SUFFIX}"=0A=0ASERVER can be "testsf_s" or "testfs_s=
6"=0A=0ABut, in testcases/network/tcp_cmds/sendfile/sendfile01_server, =0A=
=0A=A0=A0=A0=A0 1=A0 #!/bin/sh=0A=A0=A0=A0=A0 2=A0 #set -x=0A=A0=A0=A0=A0 3=
=A0 cd $3=0A=A0=A0=A0=A0 4=A0 exec 1< /dev/null=A0=A0=A0=A0=A0=A0 # open de=
scriptor 1=0A=A0=A0=A0=A0 5=A0 exec 2< /dev/null=A0=A0=A0=A0=A0=A0 # open d=
escriptor 1=0A=A0=A0=A0=A0 6=A0 nohup ./testsf_s $1 $2 &=0A=0A=0ASERVER wil=
l always execute as "testfs_s"=0A=0AI guess, below changes would be good.=
=0A=0Adiff --git a/testcases/network/tcp_cmds/sendfile/sendfile01_server b/=
testcases/network/tcp_cmds/sendfile/sendfile01_server=0Aindex 2383ce4..9933=
db4 100755=0A--- a/testcases/network/tcp_cmds/sendfile/sendfile01_server=0A=
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01_server=0A@@ -3,4 +3,4 =
@@=0A=A0cd $3=0A=A0exec 1< /dev/null=A0=A0=A0=A0=A0=A0 # open descriptor 1=
=0A=A0exec 2< /dev/null=A0=A0=A0=A0=A0=A0 # open descriptor 1=0A-nohup ./te=
stsf_s $1 $2 &=0A+nohup ./$4 $1 $2 &=0A=0A=0A=0A=0AIf you feel this is corr=
ect, please find the patch attached with this e-mail.=0A=0A=0A=A0=0AThanks =
and Regards, =0ACHANDRASHEKHAR NANDI
---225646846-1447681308-1399418275=:53978
Content-Type: application/octet-stream;
	name="0001-sendfile01_server-Correction-to-run-both-testsf_s-an.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-sendfile01_server-Correction-to-run-both-testsf_s-an.patch"

RnJvbSA0NzBhM2I2ODBhOTc2NGI4MmE5YmE1MzQ1YjYwNGYwMmQxZWFhMjc3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZHJhc2hla2hh
ciBOYW5kaSA8Q2hhbmRyYXNoZWtoYXIuTmFuZGlAbXBoYXNpcy5jb20+CkRh
dGU6IFR1ZSwgNiBNYXkgMjAxNCAxNzoxMTowNyAtMDYwMApTdWJqZWN0OiBb
UEFUQ0hdIHNlbmRmaWxlMDFfc2VydmVyOiBDb3JyZWN0aW9uIHRvIHJ1biBi
b3RoICd0ZXN0c2ZfcycgYW5kCiAndGVzdHNmX3M2JyBUaGFua3MgdG8gIlJv
YmVydHMsIExlZSIgZm9yIHBvaW50aW5nIHRoaXMgb3V0CgpTaWduZWQtb2Zm
LWJ5OiBDaGFuZHJhc2hla2hhciBOYW5kaSA8Q2hhbmRyYXNoZWtoYXIuTmFu
ZGlAbXBoYXNpcy5jb20+Ci0tLQogdGVzdGNhc2VzL25ldHdvcmsvdGNwX2Nt
ZHMvc2VuZGZpbGUvc2VuZGZpbGUwMV9zZXJ2ZXIgfCAgICAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy9zZW5kZmls
ZS9zZW5kZmlsZTAxX3NlcnZlciBiL3Rlc3RjYXNlcy9uZXR3b3JrL3RjcF9j
bWRzL3NlbmRmaWxlL3NlbmRmaWxlMDFfc2VydmVyCmluZGV4IDIzODNjZTQu
Ljk5MzNkYjQgMTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9uZXR3b3JrL3RjcF9j
bWRzL3NlbmRmaWxlL3NlbmRmaWxlMDFfc2VydmVyCisrKyBiL3Rlc3RjYXNl
cy9uZXR3b3JrL3RjcF9jbWRzL3NlbmRmaWxlL3NlbmRmaWxlMDFfc2VydmVy
CkBAIC0zLDQgKzMsNCBAQAogY2QgJDMKIGV4ZWMgMTwgL2Rldi9udWxsICAg
ICAgICMgb3BlbiBkZXNjcmlwdG9yIDEKIGV4ZWMgMjwgL2Rldi9udWxsICAg
ICAgICMgb3BlbiBkZXNjcmlwdG9yIDEKLW5vaHVwIC4vdGVzdHNmX3MgJDEg
JDIgJgorbm9odXAgLi8kNCAkMSAkMiAmCi0tIAoxLjcuMTAuNAoK

---225646846-1447681308-1399418275=:53978
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
---225646846-1447681308-1399418275=:53978
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

---225646846-1447681308-1399418275=:53978--

