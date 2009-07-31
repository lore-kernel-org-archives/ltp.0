Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rpaulsen@us.ibm.com>) id 1MWhkM-0007Rr-RZ
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 02:21:26 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWhkE-0006Tj-4h
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 02:21:26 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6V2FpoE011177
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 22:15:51 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V2LBjt245996
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 22:21:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V2LBl5003404
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 22:21:11 -0400
Message-ID: <OF14E618F8.D2F48B92-ON85257604.000CCB2C-86257604.000CE18C@us.ibm.com>
From: Robert Paulsen <rpaulsen@us.ibm.com>
Date: Thu, 30 Jul 2009 22:21:08 -0400
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC"
Content-Disposition: inline
Subject: [LTP] Fw: sync_file_range01 testcase BUG and PATCH
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

--0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC
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

Signed-off-by: Robert Paulsen <rpaulsen@us.ibm.com>

Robert Paulsen
IBM Linux Technology Center, Austin
rpaulsen@us.ibm.com
512-468-0565
--0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC
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

--0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0__=0ABBFC97DF9F4DBC8f9e8a93df938690918c0ABBFC97DF9F4DBC--


