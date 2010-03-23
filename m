Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1NtzLj-0005xQ-Qn
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 08:20:31 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NtzLi-0008N7-VZ
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 08:20:31 +0000
Received: by pvc21 with SMTP id 21so2888108pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 01:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323043940.GA4384@linux.vnet.ibm.com>
References: <364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
	<f5a7b3811003030333n4b0b4045sff5795d99cd7da00@mail.gmail.com>
	<364299f41003030342m7bf4a44ey897b7d2ca365a318@mail.gmail.com>
	<f5a7b3811003030349s2d279fcdx8b74cff2e3a875ab@mail.gmail.com>
	<364299f41003030355y5a921691vdde6baafbe8439cd@mail.gmail.com>
	<f5a7b3811003030545l30efa927tb377f113da30a0bd@mail.gmail.com>
	<f5a7b3811003080257n43d1af67o2942f4d8de2dc5b1@mail.gmail.com>
	<20100322082528.GF20606@linux.vnet.ibm.com>
	<f5a7b3811003221150w11edbf02xade0f97ecb98a6ff@mail.gmail.com>
	<20100323043940.GA4384@linux.vnet.ibm.com>
Date: Tue, 23 Mar 2010 13:34:39 +0530
Message-ID: <f5a7b3811003230104k2dfd7de2rf74857d2299b9504@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd13806f09344048273431a
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
	sem_post/8-1.c
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--000e0cd13806f09344048273431a
Content-Type: text/plain; charset=ISO-8859-1

Hi  Rishi,

This patch is prepared by using latest git.
I have placed patch below and attached to this e-mail.

Rishi, please use attached file as patch to apply to master, because
dos2unix file issue may come.

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

---
 testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
|    4    3 +     1 -     0 !
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
===================================================================
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
@@ -161,7 +161,6 @@ int main()
        }
        fprintf(stderr, "P: child_1:%d forked\n", c_1);

-       sleep(1);
        c_2 = fork();
        if (c_2 == 0)
        {
@@ -198,6 +197,9 @@ int main()
                //printf("val = %d\n", val);
        } while (val != 0);
        */
+
+       /* Synchronization required before release the lock */
+       sleep(1);
        /* Ok, let's release the lock */
        fprintf(stderr, "P: release lock\n");
        sem_post(sem);

Best regards,
Naresh Kamboju

--000e0cd13806f09344048273431a
Content-Type: application/octet-stream; 
	name="posix-sem-post-unstable-fix-8-1.patch"
Content-Disposition: attachment; 
	filename="posix-sem-post-unstable-fix-8-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g74ez4dw0

LS0tCiB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9zZW1fcG9zdC84LTEuYyB8ICAgIDQgCTMgKwkxIC0JMCAhCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDogYi90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fcG9zdC84LTEuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRl
cmZhY2VzL3NlbV9wb3N0LzgtMS5jCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0
ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV9wb3N0LzgtMS5jCkBAIC0xNjEsNyArMTYxLDYg
QEAgaW50IG1haW4oKSAKIAl9CiAJZnByaW50ZihzdGRlcnIsICJQOiBjaGlsZF8xOiVkIGZvcmtl
ZFxuIiwgY18xKTsKIAkKLQlzbGVlcCgxKTsKIAljXzIgPSBmb3JrKCk7CiAJaWYgKGNfMiA9PSAw
KQogCXsKQEAgLTE5OCw2ICsxOTcsOSBAQCBpbnQgbWFpbigpIAogCQkvL3ByaW50ZigidmFsID0g
JWRcbiIsIHZhbCk7CiAJfSB3aGlsZSAodmFsICE9IDApOwogCSovCisKKwkvKiBTeW5jaHJvbml6
YXRpb24gcmVxdWlyZWQgYmVmb3JlIHJlbGVhc2UgdGhlIGxvY2sgKi8KKwlzbGVlcCgxKTsKIAkv
KiBPaywgbGV0J3MgcmVsZWFzZSB0aGUgbG9jayAqLwogCWZwcmludGYoc3RkZXJyLCAiUDogcmVs
ZWFzZSBsb2NrXG4iKTsKIAlzZW1fcG9zdChzZW0pOwo=
--000e0cd13806f09344048273431a
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
--000e0cd13806f09344048273431a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd13806f09344048273431a--

