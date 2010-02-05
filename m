Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1NdXww-0001AZ-IX
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 23:50:58 +0000
Received: from mail-iw0-f179.google.com ([209.85.223.179])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NdXwv-0006WW-Lv
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 23:50:58 +0000
Received: by iwn9 with SMTP id 9so736083iwn.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Feb 2010 15:50:52 -0800 (PST)
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Fri, 5 Feb 2010 15:26:35 -0800
Message-ID: <42aa607e1002051526o463518eaka70bc787760db1e6@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0016e64980fe8367db047ee2c9fa
Subject: [LTP] [PATCH][utimensat.sh] cd to tmp directory before copying to
	prevent deleting original utimensat binary
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

--0016e64980fe8367db047ee2c9fa
Content-Type: multipart/alternative; boundary=0016e64980fe8367d2047ee2c9f8

--0016e64980fe8367d2047ee2c9f8
Content-Type: text/plain; charset=ISO-8859-1

This patch makes the test script cd into the tmp directory before running
the tests. This makes sure the script does not delete the original utimensat
binary, causing the test to fail on a second run.

Signed-off-by: Henry Yei<hyei@mvista.com>

--0016e64980fe8367d2047ee2c9f8
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">This patch makes the test script cd into the tmp directory before running the tests. This makes sure the script does not delete the original utimensat binary, causing the test to fail on a second run.<br><br>

Signed-off-by: Henry Yei&lt;<a href="mailto:hyei@mvista.com">hyei@mvista.com</a>&gt;<br><br><br>
</div>

--0016e64980fe8367d2047ee2c9f8--

--0016e64980fe8367db047ee2c9fa
Content-Type: text/x-patch; charset=US-ASCII; name="utimensat_tests.patch"
Content-Disposition: attachment; filename="utimensat_tests.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5blp9380

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lbnNhdC91dGltZW5zYXRfdGVz
dHMuc2gJMjAwOS0wOS0xNiAwODowMjoxMC4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC13ZGlyL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVuc2F0L3V0aW1lbnNhdF90ZXN0cy5zaAkyMDEw
LTAyLTA1IDE0OjM2OjUwLjA0ODUwNzk0NCAtMDgwMApAQCAtNjEsNyArNjEsNyBAQCBzZXR1cF9m
aWxlKCkKIAogICAgIEZJTEU9JDEKIAotICAgICMgTWFrZSBzdXJlIGFueSBvbGQgdmVyaW9uIG9m
IGZpbGUgaXMgZGVsZXRlZAorICAgICMgTWFrZSBzdXJlIGFueSBvbGQgdmVyc2lvbiBvZiBmaWxl
IGlzIGRlbGV0ZWQKIAogICAgIGlmIHRlc3QgLWUgJEZJTEU7IHRoZW4KICAgICAgICAgc3VkbyBj
aGF0dHIgLWFpICRGSUxFCkBAIC0xMjYsNyArMTI2LDcgQEAgY2hlY2tfcmVzdWx0KCkKICAgICBm
aQogCiAgICAgcmVhZCByZXMgYXRpbWUgbXRpbWUgPCAkUkVTVUxUX0ZJTEUKLSAgIAorCiAgICAg
ZWNobyAiRVhQRUNURUQ6ICRFWFBFQ1RFRF9SRVNVTFQgJEVYUEVDVF9BVElNRV9DSEFOR0VEICJc
CiAgICAgICAgICAiJEVYUEVDVF9NVElNRV9DSEFOR0VEIgogICAgIGVjaG8gIlJFU1VMVDogICAk
cmVzICRhdGltZSAkbXRpbWUiCkBAIC0yNDUsNyArMjQ1LDcgQEAgcnVuX3Rlc3QoKQogCiB1c2Vy
X3Rlc3Rlcj1ub2JvZHkKIHN1ZG8gLXUgJHVzZXJfdGVzdGVyIG1rZGlyIC1wICRURVNUX0RJUgot
CitjZCAkVEVTVF9ESVIKIGNob3duIHJvb3QgJExUUFJPT1QvdGVzdGNhc2VzL2Jpbi8kVEVTVF9Q
Uk9HCiBjaG1vZCB1Z28reCx1K3MgJExUUFJPT1QvdGVzdGNhc2VzL2Jpbi8kVEVTVF9QUk9HCiAK
--0016e64980fe8367db047ee2c9fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
--0016e64980fe8367db047ee2c9fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e64980fe8367db047ee2c9fa--

