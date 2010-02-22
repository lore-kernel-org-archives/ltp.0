Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NjbpF-0001DJ-VV
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 17:12:05 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjbpE-0006cn-VM
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 17:12:05 +0000
Message-Id: <4B82586C020000E80005EC9E@sinclair.provo.novell.com>
Date: Mon, 22 Feb 2010 10:11:56 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartD7FD13CC.0__="
Subject: [LTP] January interim build test failures
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
To: ltp-list@lists.sourceforge.net

--=__PartD7FD13CC.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've lost track of which test cases currently have issues.  These are the =
failures from running ltplite on January interim build.  Could someone =
give me a quick idea which cases are known issues and which ones I need to =
investigate further.  These were from system with 2.6.32-7 kernel.

Thanks
Murlin


--=__PartD7FD13CC.0__=
Content-Type: application/octet-stream; name="LTP_RUN_ON-20100222-out.failed"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="LTP_RUN_ON-20100222-out.failed"

Y2hkaXIwMUEgc3ltbGluazAxIC1UIGNoZGlyMDEKbXNnY3RsMTAgbXNnY3RsMTAKbXNnY3RsMTEg
bXNnY3RsMTEKcnRfc2lnYWN0aW9uMDEgcnRfc2lnYWN0aW9uMDEKcnRfc2lncHJvY21hc2swMSBy
dF9zaWdwcm9jbWFzazAxCnJ0X3NpZ3N1c3BlbmQwMSBydF9zaWdzdXNwZW5kMDEKc3dhcG9mZjAx
IHN3YXBvZmYwMQpzd2Fwb2ZmMDIgc3dhcG9mZjAyCnN3YXBvbjAxIHN3YXBvbjAxCnN3YXBvbjAy
IHN3YXBvbjAyCnN3YXBvbjAzIHN3YXBvbjAzCnByb2MwMSBwcm9jMDEKY2dyb3VwIAljZ3JvdXBf
cmVncmVzc2lvbl90ZXN0LnNoCmNvbnRyb2xsZXJzIHRlc3RfY29udHJvbGxlcnMuc2gKc3UwMSBl
eHBvcnQgVENiaW49JExUUFJPT1QvdGVzdGNhc2VzL2JpbjtzdTAxCmNyb25fZGVueTAxIGNyb25f
ZGVueTAxCmNyb25fYWxsb3cwMSBjcm9uX2FsbG93MDEKY2xvY2tfZ2V0dGltZTAzIGNsb2NrX2dl
dHRpbWUwMwp0aW1lcl9jcmVhdGUwNCB0aW1lcl9jcmVhdGUwNApQT1dFUl9NQU5BR0VNRU5UIHJ1
bnB3dGVzdHMuc2gKTnVtYS10ZXN0Y2FzZXMgbnVtYTAxLnNoCmh1Z2VtbWFwMDQgaHVnZW1tYXAw
NCAtSC90bXAKaHVnZXNobWF0MDEgaHVnZXNobWF0MDEgLWkgNQpodWdlc2htYXQwMiBodWdlc2ht
YXQwMiAtaSA1Cmh1Z2VzaG1hdDAzIGh1Z2VzaG1hdDAzIC1pIDUKaHVnZXNobWN0bDAxIGh1Z2Vz
aG1jdGwwMSAtaSA1IC1jIDMKaHVnZXNobWN0bDAyIGh1Z2VzaG1jdGwwMiAtaSA1IC1jIDMKaHVn
ZXNobWN0bDAzIGh1Z2VzaG1jdGwwMyAtaSA1IC1jIDMKaHVnZXNobWR0MDEgaHVnZXNobWR0MDEg
LUkgNSAtYzEwCmh1Z2VzaG1nZXQwMSBodWdlc2htZ2V0MDEgLWMgMTAgLWkgMTAKaHVnZXNobWdl
dDAyIGh1Z2VzaG1nZXQwMiAtYyAxMCAtaSAxMApodWdlc2htZ2V0MDMgaHVnZXNobWdldDAzIC1j
IDEwIC1pIDEwCmh1Z2VzaG1nZXQwNSBodWdlc2htZ2V0MDUgLWMgMTAgLWkgMTAK

--=__PartD7FD13CC.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--=__PartD7FD13CC.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=__PartD7FD13CC.0__=--

