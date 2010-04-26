Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@in.ibm.com>) id 1O6J79-0002vJ-Tf
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 07:52:23 +0000
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O6J78-000156-Hu
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 07:52:23 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o3Q7qBUV019826
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 13:22:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3Q7qBv83567714
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 13:22:11 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3Q7q9in032369
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 13:22:10 +0530
In-Reply-To: <4BD53483.9080603@in.ibm.com>
References: <4BD53483.9080603@in.ibm.com>
Message-ID: <OFE356C1C8.3AAFB16D-ON65257711.002ACCFE-65257711.002B39D1@in.ibm.com>
From: Rishikesh K Rajak <risrajak@in.ibm.com>
Date: Mon, 26 Apr 2010 13:18:31 +0530
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E"
Content-Disposition: inline
Subject: Re: [LTP] PATCH : test_fs_bind testscript for busybox machines
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
To: suzuki@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

--0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E
Content-type: text/plain; charset=US-ASCII

Looks fine.

Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

committed as d9f3d25b9db35073c7104b759d526869d9867692

Thanks
-Rishi



                                                                           
             suzuki@linux.vnet                                             
             .ibm.com                                                      
                                                                        To 
             04/26/2010 12:06          Rishikesh K Rajak/India/IBM@IBMIN,  
             PM                        ltp-list@lists.sourceforge.net      
                                                                        cc 
                                       Robert Paulsen                      
                                       <rpaulsen@us.ibm.com>               
                                                                   Subject 
                                       PATCH : test_fs_bind testscript for 
                                       busybox machines                    
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




Hi,

The test_fs_bind testscript hangs indefinitely when run on a machine
where busybox applets are used.

The test hangs while trying to restore the mounts after a test run.


This happens because the "xargs" applet from busybox doesn't understand
the --max-args=1 option. Thus, the mounts from the test are not removed
and this goes on in a loop, indefinitely.

This could be avoided by using "-n" option which is supported by both
the implementations of xargs.


Attached the patch here.

Thanks

Suzuki
(See attached file: fix_fs_bind_tests_for_busybox_machines.diff)
--0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E
Content-type: application/octet-stream; 
	name="fix_fs_bind_tests_for_busybox_machines.diff"
Content-Disposition: attachment;
	filename="fix_fs_bind_tests_for_busybox_machines.diff"
Content-transfer-encoding: base64

DQpTaWduZWQtb2ZmLWJ5OiBTdXp1a2kgSyBQIDxzdXp1a2lAaW4uaWJtLmNvbT4NCg0KSW5kZXg6
IGx0cC90ZXN0c2NyaXB0cy90ZXN0X2ZzX2JpbmQuc2gNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsdHAub3Jp
Zy90ZXN0c2NyaXB0cy90ZXN0X2ZzX2JpbmQuc2gJMjAwOS0xMi0yMiAwMzoyODoyNS4wMDAwMDAw
MDAgKzAwMDANCisrKyBsdHAvdGVzdHNjcmlwdHMvdGVzdF9mc19iaW5kLnNoCTIwMTAtMDQtMjYg
MDU6NTA6NDEuMDAwMDAwMDAwICswMDAwDQpAQCAtMjM4LDcgKzIzOCw3IEBADQogCSMgbmV3IG1v
dW50cyBhcm91bmQgYW5kIHdpbGwgbmV2ZXIgcmVtb3ZlIG1vdW50cyBvdXRzaWRlIHRoZSB0ZXN0
DQogCSMgZGlyZWN0b3J5DQogCSggd2hpbGUgZ3JlcF9wcm9jX21vdW50cyA7IGRvDQotCQlncmVw
X3Byb2NfbW91bnRzIHwgYXdrICd7cHJpbnQgJDJ9JyB8IHhhcmdzIC1yIC0tbWF4LWFyZ3M9MSB1
bW91bnQgLWwNCisJCWdyZXBfcHJvY19tb3VudHMgfCBhd2sgJ3twcmludCAkMn0nIHwgeGFyZ3Mg
LXIgLW4gMSB1bW91bnQgLWwNCiAJZG9uZSApID4mIC9kZXYvbnVsbA0KIAkNCiAJIyBtb3VudCBs
aXN0IGFuZCBleGl0IHdpdGggMA0K

--0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0__=EABBFD82DFB94A6E8f9e8a93df938690918cEABBFD82DFB94A6E--


