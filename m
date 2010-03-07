Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NoJqI-0000tv-Km
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 17:00:38 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NoJqG-0001vP-CZ
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 17:00:38 +0000
Received: by pvf33 with SMTP id 33so1442758pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Mar 2010 09:00:30 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 7 Mar 2010 22:30:30 +0530
Message-ID: <9debc4411003070900o5362e9ddq5ec4ea06d297d2fc@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd15316cefc98048138e245
Subject: [LTP] [PATCH] runtest/io file modification to run aio02 test
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

--000e0cd15316cefc98048138e245
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I have observed that, while executing the io tests in LTP, the 'aio02'
test failed to get executed:

--------------------------------------------------------------------------------------------------
$./runtests -f  io

Running tests.......
<<<test_start>>>
tag=aio01 stime=1267980185
cmdline="aio01"
contacts=""
analysis=exit
<<<test_output>>>
aio01       1  TPASS  :  Test 1: 10 writes in   0.000102 sec
aio01       2  TPASS  :  Test 2: 10 reads in   0.000056 sec
aio01       3  TPASS  :  Test 3: 10 prep,writes in   0.000070 sec
aio01       4  TPASS  :  Test 4: 10 prep,reads in   0.000051 sec
aio01       5  TPASS  :  Test 5: 10 reads and writes in   0.000108 sec
aio01       6  TPASS  :  Test 6: 10 read,write,verify in 0.000108 sec
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=aio02 stime=1267980185
cmdline="runfstests.sh aio_tio"
contacts=""
analysis=exit
<<<test_output>>>
Starting the Tests
incrementing stop
Test run starting at  Sun Mar 7 22:13:05 IST 2010
Missing the test program. You must pass a test path/name for testing
usage: runfstests.sh [ -a test name ]

example: runfstests.sh -a cases/aio_tio

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100228

-------------------------------------------------------------------------------------------------------

The "aio02_io_runtest.patch" makes the necessary changes in  "io" file
in "runtest" directory.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>

Warm Regards,
Maxin B. John

--000e0cd15316cefc98048138e245
Content-Type: text/x-patch; charset=US-ASCII; name="aio02_io_runtest.patch"
Content-Disposition: attachment; filename="aio02_io_runtest.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6i31id90

ZGlmZiAtLWdpdCBhL3J1bnRlc3QvaW8gYi9ydW50ZXN0L2lvCmluZGV4IDc1Mjc0YzQuLmE1MmQw
NTMgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvaW8KKysrIGIvcnVudGVzdC9pbwpAQCAtMSwzICsxLDMg
QEAKICNBSU8wMSAmIEFJTzAyIHRlc3RzIHRvIGJlIHJ1bgogYWlvMDEgYWlvMDEKLWFpbzAyIHJ1
bmZzdGVzdHMuc2ggYWlvX3RpbworYWlvMDIgcnVuZnN0ZXN0cy5zaCAtYSBhaW9fdGlvCmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2lvL2Fpby9haW8wMi9ydW5mc3Rlc3RzLnNoIGIvdGVz
dGNhc2VzL2tlcm5lbC9pby9haW8vYWlvMDIvcnVuZnN0ZXN0cy5zaAppbmRleCBlZWVkMzg5Li44
YTI5ZGJkIDEwMDc1NQotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2Fpby9haW8wMi9ydW5mc3Rl
c3RzLnNoCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vYWlvL2FpbzAyL3J1bmZzdGVzdHMuc2gK
QEAgLTQ1LDEwICs0NSwxMCBAQCBmaQogICAgcmVzPSQ/CiAgICBpZiBbICRyZXMgLWVxIDAgXSA7
IAogICAgdGhlbiBzdHI9IiI7Ci0gICBwYXNzZXM9JFtwYXNzZXMgKzFdOworICAgcGFzc2VzPWBl
eHByICAkcGFzc2VzICsgMWA7CiAgICBlbHNlCiAgICBzdHI9IiAtLSBGQUlMRUQiOwotICAgZmFp
bHM9JFtmYWlscyArMV07CisgICBmYWlscz1gZXhwciAkZmFpbHMgKyAxYDsKICAgIGZpCiAjZG9u
ZQogCg==
--000e0cd15316cefc98048138e245
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
--000e0cd15316cefc98048138e245
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd15316cefc98048138e245--

