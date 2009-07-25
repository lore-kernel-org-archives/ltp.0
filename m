Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rpaulsen@us.ibm.com>) id 1MUflp-0005ca-Gj
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 11:50:33 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUflk-0007am-1I
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 11:50:33 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6P7oDGq014034
	for <ltp-list@lists.sourceforge.net>; Sat, 25 Jul 2009 03:50:13 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6PBoLm1223730
	for <ltp-list@lists.sourceforge.net>; Sat, 25 Jul 2009 07:50:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6PBoLO1003545
	for <ltp-list@lists.sourceforge.net>; Sat, 25 Jul 2009 07:50:21 -0400
Received: from d01ml072.pok.ibm.com (d01ml072.pok.ibm.com [9.63.10.37])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n6PBoLJ6003542
	for <ltp-list@lists.sourceforge.net>; Sat, 25 Jul 2009 07:50:21 -0400
Message-ID: <OFAF51CC3A.0B2793FB-ON852575FE.00403BE8-862575FE.004135EB@us.ibm.com>
From: Robert Paulsen <rpaulsen@us.ibm.com>
Date: Sat, 25 Jul 2009 07:50:20 -0400
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78"
Content-Disposition: inline
Subject: [LTP] sync_file_range01 testcase BUG and PATCH
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

--0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78
Content-type: text/plain; charset=US-ASCII


The testcase sync_file_range01 uses a file descriptor (variable sfd) in its
second test, expcting to see an ESPIPE error.

Unfortunately, the code's open of that file descriptor somehow ended up
within a set of curly braces encompasing an error path, not the mainline
code where it should be. Thus, sfd is never set, In practice this leaves
sfd set to zero. That is actually stdin and stdin can work for the testcase
but it is not guaranteed. In fact it mostly works, but it hapens to fail
sometimes. The attached patch causes the open for sfd (to /dev/null) to
actually get invoked.

(See attached file: sync_file_range01.diff)

Robert Paulsen
IBM Linux Technology Center, Austin
rpaulsen@us.ibm.com
512-468-0565
--0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78
Content-type: application/octet-stream; 
	name="sync_file_range01.diff"
Content-Disposition: attachment; filename="sync_file_range01.diff"
Content-transfer-encoding: base64

LS0tIGx0cC1mdWxsLTIwMDkwNjMwLW9yaWcvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zeW5j
X2ZpbGVfcmFuZ2Uvc3luY19maWxlX3JhbmdlMDEuYwkyMDA5LTAzLTIzIDA4OjM2OjA3LjAwMDAw
MDAwMCAtMDUwMAorKysgbHRwLWZ1bGwtMjAwOTA2MzAvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zeW5jX2ZpbGVfcmFuZ2Uvc3luY19maWxlX3JhbmdlMDEuYwkyMDA5LTA3LTI0IDA3OjI2OjIy
LjAwMDAwMDAwMCAtMDUwMApAQCAtMjI0LDEwICsyMjQsMTAgQEAgdm9pZCBzZXR1cCgpCiAJCQkg
Im9wZW4oJXMsIE9fUkRXUnxPX0NSRUFULDA3MDApIEZhaWxlZCwgZXJybm89JWQgOiAlcyIsCiAJ
CQkgZmlsZW5hbWUsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwogCi0JCXNmZCA9IG9wZW4oc3Bs
X2ZpbGUsIE9fUkRXUiB8IE9fQ1JFQVQsIDA3MDApOwotCiAJfQogCisJc2ZkID0gb3BlbihzcGxf
ZmlsZSwgT19SRFdSIHwgT19DUkVBVCwgMDcwMCk7CisKIAlyZXR1cm47CiB9CiAK

--0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0__=0ABBFF6DDFD3BD788f9e8a93df938690918c0ABBFF6DDFD3BD78--


