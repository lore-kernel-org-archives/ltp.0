Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFaqG-0001gE-Ei
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:46:24 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFaqF-0005ch-M4
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 00:46:24 +0000
Received: by pbcum15 with SMTP id um15so945556pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 17:46:17 -0700 (PDT)
Date: Wed, 4 Apr 2012 17:42:24 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204041738350.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="967339439-1242534820-1333586545=:25027"
Subject: [LTP] [PATCH 2/2] Replace struct event_t with struct inotify_event
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--967339439-1242534820-1333586545=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Replace struct event_t with struct inotify_event

Also do some minor whitespace cleanup while I'm
in the neighborhood.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

---
  testcases/kernel/syscalls/inotify/inotify02.c |   13 ++++---------
  1 files changed, 4 insertions(+), 9 deletions(-)


--------------1.7.2.5
Content-Type: text/x-patch; name="0002-Replace-struct-event_t-with-struct-inotify_event.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-Replace-struct-event_t-with-struct-inotify_event.patch"

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 59f83ba..c87797f 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -81,15 +81,10 @@ char buf[BUF_SIZE];
  int fd, fd_notify;
  int wd;

-struct event_t {
-	char name[BUF_SIZE];
-	int mask;
-	int len;
-};
  #define FILE_NAME1 "test_file1"
  #define FILE_NAME2 "test_file2"

-struct event_t event_set[EVENT_MAX];
+struct inotify_event event_set[EVENT_MAX];

  char event_buf[EVENT_BUF_LEN];

@@ -239,7 +234,7 @@ int main(int ac, char **av)
  						 "1c17d18e3775485bf1e0ce79575eb637a94494a2.");
  				tst_resm(TFAIL,
  					 "get unnecessary event: "
-					 "wd=%d mask=%x cookie=%u len=%u"
+					 "wd=%d mask=%x cookie=%u len=%u "
  					 "name=\"%s\"", event->wd, event->mask,
  					 event->cookie, event->len,
  					 event->name);
@@ -250,8 +245,8 @@ int main(int ac, char **av)
  				    (event_set[test_num].name, event->name,
  				     event->len))) {
  				tst_resm(TPASS,
-					 "get event: wd=%d mask=%x"
-					 " cookie=%u len=%u name=\"%s\"",
+					 "get event: wd=%d mask=%x "
+					 "cookie=%u len=%u name=\"%s\"",
  					 event->wd, event->mask, event->cookie,
  					 event->len, event->name);

--967339439-1242534820-1333586545=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0002-Replace-struct-event_t-with-struct-inotify_event.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204041742240.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0002-Replace-struct-event_t-with-struct-inotify_event.patch

RnJvbSAzODUyY2EyZWYyNDBmMmU1ZWIwZmRjMGQ3MjdjMTRmOTNmYzAwY2Y4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFdlZCwgNCBBcHIgMjAx
MiAxNzoxOTowOCAtMDcwMA0KU3ViamVjdDogW1BBVENIIDIvMl0gUmVwbGFj
ZSBzdHJ1Y3QgZXZlbnRfdCB3aXRoIHN0cnVjdCBpbm90aWZ5X2V2ZW50DQpN
SU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4
ZWQ7IGJvdW5kYXJ5PSItLS0tLS0tLS0tLS0xLjcuMi41Ig0KDQpUaGlzIGlz
IGEgbXVsdGktcGFydCBtZXNzYWdlIGluIE1JTUUgZm9ybWF0Lg0KLS0tLS0t
LS0tLS0tLS0xLjcuMi41DQpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNo
YXJzZXQ9VVRGLTg7IGZvcm1hdD1maXhlZA0KQ29udGVudC1UcmFuc2Zlci1F
bmNvZGluZzogOGJpdA0KDQoNClNpZ25lZC1vZmYtYnk6IEdhcnJldHQgQ29v
cGVyIDx5YW5lZ29taUBnbWFpbC5jb20+DQotLS0NCiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lub3RpZnkvaW5vdGlmeTAyLmMgfCAgIDEzICsrKyst
LS0tLS0tLS0NCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCg0KDQotLS0tLS0tLS0tLS0tLTEuNy4yLjUNCkNv
bnRlbnQtVHlwZTogdGV4dC94LXBhdGNoOyBuYW1lPSIwMDAyLVJlcGxhY2Ut
c3RydWN0LWV2ZW50X3Qtd2l0aC1zdHJ1Y3QtaW5vdGlmeV9ldmVudC5wYXRj
aCINCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCkNvbnRlbnQt
RGlzcG9zaXRpb246IGF0dGFjaG1lbnQ7IGZpbGVuYW1lPSIwMDAyLVJlcGxh
Y2Utc3RydWN0LWV2ZW50X3Qtd2l0aC1zdHJ1Y3QtaW5vdGlmeV9ldmVudC5w
YXRjaCINCg0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW5vdGlmeS9pbm90aWZ5MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaW5vdGlmeS9pbm90aWZ5MDIuYw0KaW5kZXggNTlmODNiYS4uYzg3
Nzk3ZiAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW5vdGlmeS9pbm90aWZ5MDIuYw0KKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9pbm90aWZ5L2lub3RpZnkwMi5jDQpAQCAtODEsMTUgKzgxLDEw
IEBAIGNoYXIgYnVmW0JVRl9TSVpFXTsNCiBpbnQgZmQsIGZkX25vdGlmeTsN
CiBpbnQgd2Q7DQogDQotc3RydWN0IGV2ZW50X3Qgew0KLQljaGFyIG5hbWVb
QlVGX1NJWkVdOw0KLQlpbnQgbWFzazsNCi0JaW50IGxlbjsNCi19Ow0KICNk
ZWZpbmUgRklMRV9OQU1FMSAidGVzdF9maWxlMSINCiAjZGVmaW5lIEZJTEVf
TkFNRTIgInRlc3RfZmlsZTIiDQogDQotc3RydWN0IGV2ZW50X3QgZXZlbnRf
c2V0W0VWRU5UX01BWF07DQorc3RydWN0IGlub3RpZnlfZXZlbnQgZXZlbnRf
c2V0W0VWRU5UX01BWF07DQogDQogY2hhciBldmVudF9idWZbRVZFTlRfQlVG
X0xFTl07DQogDQpAQCAtMjM5LDcgKzIzNCw3IEBAIGludCBtYWluKGludCBh
YywgY2hhciAqKmF2KQ0KIAkJCQkJCSAiMWMxN2QxOGUzNzc1NDg1YmYxZTBj
ZTc5NTc1ZWI2MzdhOTQ0OTRhMi4iKTsNCiAJCQkJdHN0X3Jlc20oVEZBSUws
DQogCQkJCQkgImdldCB1bm5lY2Vzc2FyeSBldmVudDogIg0KLQkJCQkJICJ3
ZD0lZCBtYXNrPSV4IGNvb2tpZT0ldSBsZW49JXUiDQorCQkJCQkgIndkPSVk
IG1hc2s9JXggY29va2llPSV1IGxlbj0ldSAiDQogCQkJCQkgIm5hbWU9XCIl
c1wiIiwgZXZlbnQtPndkLCBldmVudC0+bWFzaywNCiAJCQkJCSBldmVudC0+
Y29va2llLCBldmVudC0+bGVuLA0KIAkJCQkJIGV2ZW50LT5uYW1lKTsNCkBA
IC0yNTAsOCArMjQ1LDggQEAgaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYp
DQogCQkJCSAgICAoZXZlbnRfc2V0W3Rlc3RfbnVtXS5uYW1lLCBldmVudC0+
bmFtZSwNCiAJCQkJICAgICBldmVudC0+bGVuKSkpIHsNCiAJCQkJdHN0X3Jl
c20oVFBBU1MsDQotCQkJCQkgImdldCBldmVudDogd2Q9JWQgbWFzaz0leCIN
Ci0JCQkJCSAiIGNvb2tpZT0ldSBsZW49JXUgbmFtZT1cIiVzXCIiLA0KKwkJ
CQkJICJnZXQgZXZlbnQ6IHdkPSVkIG1hc2s9JXggIg0KKwkJCQkJICJjb29r
aWU9JXUgbGVuPSV1IG5hbWU9XCIlc1wiIiwNCiAJCQkJCSBldmVudC0+d2Qs
IGV2ZW50LT5tYXNrLCBldmVudC0+Y29va2llLA0KIAkJCQkJIGV2ZW50LT5s
ZW4sIGV2ZW50LT5uYW1lKTsNCiANCg0KLS0tLS0tLS0tLS0tLS0xLjcuMi41
LS0NCg0KDQo=

--967339439-1242534820-1333586545=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-1242534820-1333586545=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-1242534820-1333586545=:25027--

