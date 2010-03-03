Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Nmhdd-0006CI-0n
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 06:00:53 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nmhdb-0002Ef-Nk
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 06:00:52 +0000
Received: by pvf33 with SMTP id 33so293024pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 22:00:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100303045624.GB10185@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
	<f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
	<20100303045624.GB10185@linux.vnet.ibm.com>
Date: Wed, 3 Mar 2010 11:30:42 +0530
Message-ID: <f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd1a868d198710480df337a
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

--000e0cd1a868d198710480df337a
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 3, 2010 at 10:26 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Tue, Mar 02, 2010 at 08:38:20PM +0530, naresh kamboju wrote:
>> On Tue, Mar 2, 2010 at 2:20 PM, Rishikesh K Rajak
>> <risrajak@linux.vnet.ibm.com> wrote:
>> > I feel before getting semaphore value, we need to sync first so here
>> > sleep is require,though your point is valid that there is no use of
>> > using sleep inside while loop.
>> I agree with you.
>> AFAIU, we should call sleep() before calling getting semaphore
>> value.when we don't have while loop here. Because while loop condition
>> is depends on val so when ever we call sem_getvalue() it will get
>> latest value of val.
>> In addition to this, we are ensuring val is decremented before we do
>> unlock the sem by while loop condition.
>>
>> Having sleep() in while loop will not effect the final output. IIUC
>>
>
> Hi Naresh,
>
> I am not able to apply your patch against ltp next branch. can you
> please send me patch against next branch of ltp ?
Here I have posted and attached to this e-mail.

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

---
 testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
|   15 	8 +	7 -	0 !
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
===================================================================
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
@@ -161,7 +161,6 @@ int main()
 	}
 	fprintf(stderr, "P: child_1:%d forked\n", c_1);
 	
-	sleep(1);
 	c_2 = fork();
 	if (c_2 == 0)
 	{
@@ -176,13 +175,13 @@ int main()
 	}
 	fprintf(stderr, "P: child_2: %d forked\n", c_2);

+        /* Step 3 Implementation */
 	/* Make sure the two children has been waiting */	
-	/*do {
-		sleep(1);
+	do {
 		sem_getvalue(sem_1, &val);
 		//printf("val = %d\n", val);
 	} while (val != 1);
-	*/
+
 	c_3 = fork();
 	if (c_3 == 0)
 	{
@@ -191,13 +190,15 @@ int main()
 	}
 	fprintf(stderr, "P: child_3: %d forked\n", c_3);
 	
+        /* Step 3 Implementation */
 	/* Make sure child 3 has been waiting for the lock */	
-	/*do {
-		sleep(1);
+	do {
 		sem_getvalue(sem_1, &val);
 		//printf("val = %d\n", val);
 	} while (val != 0);
-	*/
+
+	/* Synchronization required before release the lock */
+	sleep(1);
 	/* Ok, let's release the lock */
 	fprintf(stderr, "P: release lock\n");
 	sem_post(sem);

Best regards
Naresh Kamboju
>
> #git clone -b next
> git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
>
> And then create your patch and send it to ltp-list@
>
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
>

--000e0cd1a868d198710480df337a
Content-Type: application/octet-stream; 
	name="posix-sem-post-unstable-fix.patch"
Content-Disposition: attachment; filename="posix-sem-post-unstable-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6bpxm9m0

LS0tCiB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9zZW1fcG9zdC84LTEuYyB8ICAgMTUgCTggKwk3IC0JMCAhCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKSW5kZXg6IGIvdGVzdGNhc2VzL29wZW5fcG9z
aXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3Bvc3QvOC0xLmMKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQotLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50
ZXJmYWNlcy9zZW1fcG9zdC84LTEuYworKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fcG9zdC84LTEuYwpAQCAtMTYxLDcgKzE2MSw2
IEBAIGludCBtYWluKCkgCiAJfQogCWZwcmludGYoc3RkZXJyLCAiUDogY2hpbGRfMTolZCBmb3Jr
ZWRcbiIsIGNfMSk7CiAJCi0Jc2xlZXAoMSk7CiAJY18yID0gZm9yaygpOwogCWlmIChjXzIgPT0g
MCkKIAl7CkBAIC0xNzYsMTMgKzE3NSwxMyBAQCBpbnQgbWFpbigpIAogCX0KIAlmcHJpbnRmKHN0
ZGVyciwgIlA6IGNoaWxkXzI6ICVkIGZvcmtlZFxuIiwgY18yKTsKIAorICAgICAgICAvKiBTdGVw
IDMgSW1wbGVtZW50YXRpb24gKi8KIAkvKiBNYWtlIHN1cmUgdGhlIHR3byBjaGlsZHJlbiBoYXMg
YmVlbiB3YWl0aW5nICovCQotCS8qZG8geyAKLQkJc2xlZXAoMSk7CisJZG8gewogCQlzZW1fZ2V0
dmFsdWUoc2VtXzEsICZ2YWwpOwogCQkvL3ByaW50ZigidmFsID0gJWRcbiIsIHZhbCk7CiAJfSB3
aGlsZSAodmFsICE9IDEpOwotCSovCisKIAljXzMgPSBmb3JrKCk7CiAJaWYgKGNfMyA9PSAwKQog
CXsKQEAgLTE5MSwxMyArMTkwLDE1IEBAIGludCBtYWluKCkgCiAJfQogCWZwcmludGYoc3RkZXJy
LCAiUDogY2hpbGRfMzogJWQgZm9ya2VkXG4iLCBjXzMpOwogCQorICAgICAgICAvKiBTdGVwIDMg
SW1wbGVtZW50YXRpb24gKi8KIAkvKiBNYWtlIHN1cmUgY2hpbGQgMyBoYXMgYmVlbiB3YWl0aW5n
IGZvciB0aGUgbG9jayAqLwkKLQkvKmRvIHsgCi0JCXNsZWVwKDEpOworCWRvIHsKIAkJc2VtX2dl
dHZhbHVlKHNlbV8xLCAmdmFsKTsKIAkJLy9wcmludGYoInZhbCA9ICVkXG4iLCB2YWwpOwogCX0g
d2hpbGUgKHZhbCAhPSAwKTsKLQkqLworCisJLyogU3luY2hyb25pemF0aW9uIHJlcXVpcmVkIGJl
Zm9yZSByZWxlYXNlIHRoZSBsb2NrICovCisJc2xlZXAoMSk7CiAJLyogT2ssIGxldCdzIHJlbGVh
c2UgdGhlIGxvY2sgKi8KIAlmcHJpbnRmKHN0ZGVyciwgIlA6IHJlbGVhc2UgbG9ja1xuIik7CiAJ
c2VtX3Bvc3Qoc2VtKTsK
--000e0cd1a868d198710480df337a
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
--000e0cd1a868d198710480df337a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd1a868d198710480df337a--

