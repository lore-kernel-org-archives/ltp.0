Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MNxfJ-0004q8-NK
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:32:05 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNxfF-0003zo-Eu
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:32:05 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9FE91.D404F646"
Date: Mon, 6 Jul 2009 16:31:03 -0700
Message-ID: <8368651DACC1964480F951191B94A078D0105B@svexch01.mvista.com>
In-Reply-To: <1246895427.4887.44.camel@subratamodak.linux.ibm.com>
References: <8368651DACC1964480F951191B94A078BC18DD@svexch01.mvista.com>
	<1246895427.4887.44.camel@subratamodak.linux.ibm.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][syscalls] change io_* testcases to run directly
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9FE91.D404F646
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here is the patch to remove the unneeded scripts for the io_* tests, =
which should be used in conjunction with the previous patch for the =
syscalls patch.=20

Thanks,

-----Original Message-----
From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]=20
Sent: Monday, July 06, 2009 8:50 AM
To: Henry Yei
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH][syscalls] change io_* testcases to run =
directly

On Wed, 2009-07-01 at 16:34 -0700, Henry Yei wrote:=20
> Again, I forgot the subject..
>=20
> It looks like the io_*.sh files are now not needed since the test =
source has been modified to check for an autoconf definition.
> This patch modifies the syscalls runtest file to call those test=20
> directly. (io_cancel, io_destroy01, io_getevents01, io_setup01,=20
> io_submit01)
>=20
> As the scripts are not needed any more, can we remove the following?
>=20
Edited, my paths and file names were way incorrect.
> ltp/testcases/kernel/syscalls/io_cancel/run-io_cancel.sh
> ltp/testcases/kernel/syscalls/io_destroy/run-io_destroy.sh
> ltp/testcases/kernel/syscalls/io_getevents/run-io_getevents.sh
> ltp/testcases/kernel/syscalls/io_setup/run-io_setup.sh
> ltp/testcases/kernel/syscalls/io_submit/run-io_submit.sh

Removing reference from runtest/syscalls is ok. But, how about removing =
the actual scritps ? Send me a patch for that :-)

Regards--
Subrata

>=20
> These scripts were not being copied into testcases/bin anyway and so =
AFAIK, were not being run correctly by pan anyway.
>=20
> Henry Yei
> MontaVista Software, Inc.
> hyei@mvista.com
>=20
>=20
> =20
> ----------------------------------------------------------------------
> -------- _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------_=_NextPart_001_01C9FE91.D404F646
Content-Type: application/octet-stream;
	name="io_testscripts-remove.patch"
Content-Transfer-Encoding: base64
Content-Description: io_testscripts-remove.patch
Content-Disposition: attachment;
	filename="io_testscripts-remove.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZGVzdHJv
eS9ydW4taW9fZGVzdHJveS5zaAkyMDA4LTA3LTExIDEzOjIxOjQzLjAwMDAwMDAwMCAtMDcwMAor
KysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZGVzdHJveS9ydW4taW9fZGVzdHJv
eS5zaAkxOTY5LTEyLTMxIDE2OjAwOjAwLjAwMDAwMDAwMCAtMDgwMApAQCAtMSwxMSArMCwwIEBA
Ci0jIS9iaW4vc2gKLQotc3lzY2FsbD1pb19kZXN0cm95Ci0KLWlmIFsgLWYgJExUUFJPT1QvdGVz
dGNhc2VzL2Jpbi8ke3N5c2NhbGx9MDEgXTsgdGhlbgotICAgICAgICAgJExUUFJPT1QvdGVzdGNh
c2VzL2Jpbi8ke3N5c2NhbGx9MDEKLWVsc2UKLSAgICAgICAgIGVjaG8gIiR7c3lzY2FsbH0wMSAw
IENPTkYgOiBTeXN0ZW0gZG9lc24ndCBzdXBwb3J0IGV4ZWN1dGlvbiBvZiB0aGUgdGVzdCIKLQot
ZmkKLQotLS0gbHRwLWZ1bGwtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb19j
YW5jZWwvcnVuLWlvX2NhbmNlbC5zaAkyMDA4LTA2LTI3IDAzOjU0OjQ2LjAwMDAwMDAwMCAtMDcw
MAorKysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fY2FuY2VsL3J1bi1pb19jYW5j
ZWwuc2gJMTk2OS0xMi0zMSAxNjowMDowMC4wMDAwMDAwMDAgLTA4MDAKQEAgLTEsMTEgKzAsMCBA
QAotIyEvYmluL3NoCi0KLXN5c2NhbGw9aW9fY2FuY2VsCi0KLWlmIFsgLWYgJExUUFJPT1QvdGVz
dGNhc2VzL2Jpbi8ke3N5c2NhbGx9MDEgXTsgdGhlbgotICAgICAgICAgJExUUFJPT1QvdGVzdGNh
c2VzL2Jpbi8ke3N5c2NhbGx9MDEKLWVsc2UKLSAgICAgICAgIGVjaG8gIiR7c3lzY2FsbH0wMSAw
IENPTkYgOiBTeXN0ZW0gZG9lc24ndCBzdXBwb3J0IGV4ZWN1dGlvbiBvZiB0aGUgdGVzdCIKLQot
ZmkKLQotLS0gbHRwLWZ1bGwtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb19n
ZXRldmVudHMvcnVuLWlvX2dldGV2ZW50cy5zaAkyMDA4LTA3LTExIDEzOjIxOjQzLjAwMDAwMDAw
MCAtMDcwMAorKysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fZ2V0ZXZlbnRzL3J1
bi1pb19nZXRldmVudHMuc2gJMTk2OS0xMi0zMSAxNjowMDowMC4wMDAwMDAwMDAgLTA4MDAKQEAg
LTEsMTEgKzAsMCBAQAotIyEvYmluL3NoCi0KLXN5c2NhbGw9aW9fZ2V0ZXZlbnRzCi0KLWlmIFsg
LWYgJExUUFJPT1QvdGVzdGNhc2VzL2Jpbi8ke3N5c2NhbGx9MDEgXTsgdGhlbgotICAgICAgICAg
JExUUFJPT1QvdGVzdGNhc2VzL2Jpbi8ke3N5c2NhbGx9MDEKLWVsc2UKLSAgICAgICAgIGVjaG8g
IiR7c3lzY2FsbH0wMSAwIENPTkYgOiBTeXN0ZW0gZG9lc24ndCBzdXBwb3J0IGV4ZWN1dGlvbiBv
ZiB0aGUgdGVzdCIKLQotZmkKLQotLS0gbHRwLWZ1bGwtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9pb19zZXR1cC9ydW4taW9fc2V0dXAuc2gJMjAwOC0wNy0xMSAxMzoyMTo0My4w
MDAwMDAwMDAgLTA3MDAKKysrIGx0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3NldHVw
L3J1bi1pb19zZXR1cC5zaAkxOTY5LTEyLTMxIDE2OjAwOjAwLjAwMDAwMDAwMCAtMDgwMApAQCAt
MSwxMSArMCwwIEBACi0jIS9iaW4vc2gKLQotc3lzY2FsbD1pb19zZXR1cAotCi1pZiBbIC1mICRM
VFBST09UL3Rlc3RjYXNlcy9iaW4vJHtzeXNjYWxsfTAxIF07IHRoZW4KLSAgICAgICAgICRMVFBS
T09UL3Rlc3RjYXNlcy9iaW4vJHtzeXNjYWxsfTAxCi1lbHNlCi0gICAgICAgICBlY2hvICIke3N5
c2NhbGx9MDEgMCBDT05GIDogU3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBleGVjdXRpb24gb2YgdGhl
IHRlc3QiCi0KLWZpCi0KLS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaW9fc3VibWl0L3J1bi1pb19zdWJtaXQuc2gJMjAwOC0wNy0xMSAxMzoyMTo0My4wMDAw
MDAwMDAgLTA3MDAKKysrIGx0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3N1Ym1pdC9y
dW4taW9fc3VibWl0LnNoCTE5NjktMTItMzEgMTY6MDA6MDAuMDAwMDAwMDAwIC0wODAwCkBAIC0x
LDExICswLDAgQEAKLSMhL2Jpbi9zaAotCi1zeXNjYWxsPWlvX3N1Ym1pdAotCi1pZiBbIC1mICRM
VFBST09UL3Rlc3RjYXNlcy9iaW4vJHtzeXNjYWxsfTAxIF07IHRoZW4KLSAgICAgICAgICRMVFBS
T09UL3Rlc3RjYXNlcy9iaW4vJHtzeXNjYWxsfTAxCi1lbHNlCi0gICAgICAgICBlY2hvICIke3N5
c2NhbGx9MDEgMCBDT05GIDogU3lzdGVtIGRvZXNuJ3Qgc3VwcG9ydCBleGVjdXRpb24gb2YgdGhl
IHRlc3QiCi0KLWZpCi0K

------_=_NextPart_001_01C9FE91.D404F646
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
------_=_NextPart_001_01C9FE91.D404F646
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9FE91.D404F646--

