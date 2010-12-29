Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRW-0003Bd-4u
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:38 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRV-0004WR-Ab
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:38 +0000
Received: by mail-gw0-f47.google.com with SMTP id a12so1779190gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:37 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:37 +0800
Message-ID: <AANLkTi=pHhb0Stk5RpnobA0Sqo4G6C07meCKTQzBCY8B@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  [Bug Fix] fcntl14 cause msh relaunch in uClinux platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8959802433190768288=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============8959802433190768288==
Content-Type: multipart/alternative; boundary=0016e645ab96a5fd9c0498894a4b

--0016e645ab96a5fd9c0498894a4b
Content-Type: text/plain; charset=ISO-8859-1

fcntl14 cause msh relaunch in uClinux platform.

--
fcntl14     0  INFO  :  Enter block 1: without mandatory locking


BusyBox v1.13.4 (2009-06-04 17:49:13 CST) built-in shell (msh)
Enter 'help' for a list of built-in commands.
root:/> fcntl14     1  PASS  :  testcase:1 PASSED
fcntl14     2  PASS  :  testcase:2 PASSED
fcntl14     3  PASS  :  testcase:3 PASSED
fcntl14     4  PASS  :  testcase:4 PASSED
fcntl14     5  PASS  :  testcase:5 PASSED
fcntl14     6  PASS  :  testcase:6 PASSED
fcntl14     7  PASS  :  testcase:7 PASSED
--


Fix by delivering parent as one parameter of child process:
--
Index: testcases/kernel/syscalls/fcntl/fcntl14.c
===================================================================
--- testcases/kernel/syscalls/fcntl/fcntl14.c
+++ testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -763,7 +763,7 @@
                        break;
                case 0: /* child */
 #ifdef UCLINUX
-                       if (self_exec(argv0, "n", 1) < 0) {
+                       if (self_exec(argv0, "nd", 1, parent) < 0) {
                                tst_resm(TFAIL, "self_exec failed");
                                break;
                        }
@@ -980,7 +980,7 @@
 #ifdef UCLINUX
        argv0 = av[0];

-       maybe_run_child(&do_usleep_child, "n", 1);
+       maybe_run_child(&do_usleep_child, "nd", 1, &parent);
        thiscase = malloc(sizeof(testcase));

        maybe_run_child(&dochild, "nddddddddd", 2, &thiscase->c_type,
--



Best regards,
Vivi Li

--0016e645ab96a5fd9c0498894a4b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZmNudGwxNCBjYXVzZSBtc2ggcmVsYXVuY2ggaW4gdUNsaW51eCBwbGF0Zm9ybS48YnI+PGJyPi0t
PGJyPmZjbnRsMTSgoKCgIDCgIElORk+gIDqgIEVudGVyIGJsb2NrIDE6IHdpdGhvdXQgbWFuZGF0
b3J5IGxvY2tpbmc8YnI+PGJyPjxicj5CdXN5Qm94IHYxLjEzLjQgKDIwMDktMDYtMDQgMTc6NDk6
MTMgQ1NUKSBidWlsdC1pbiBzaGVsbCAobXNoKTxicj5FbnRlciAmIzM5O2hlbHAmIzM5OyBmb3Ig
YSBsaXN0IG9mIGJ1aWx0LWluIGNvbW1hbmRzLjxicj4KCgoKcm9vdDovJmd0OyBmY250bDE0oKCg
oCAxoCBQQVNToCA6oCB0ZXN0Y2FzZToxIFBBU1NFRDxicj5mY250bDE0oKCgoCAyoCBQQVNToCA6
oCB0ZXN0Y2FzZToyIFBBU1NFRDxicj5mY250bDE0oKCgoCAzoCBQQVNToCA6oCB0ZXN0Y2FzZToz
IFBBU1NFRDxicj5mY250bDE0oKCgoCA0oCBQQVNToCA6oCB0ZXN0Y2FzZTo0IFBBU1NFRDxicj5m
Y250bDE0oKCgoCA1oCBQQVNToCA6oCB0ZXN0Y2FzZTo1IFBBU1NFRDxicj4KCgoKZmNudGwxNKCg
oKAgNqAgUEFTU6AgOqAgdGVzdGNhc2U6NiBQQVNTRUQ8YnI+ZmNudGwxNKCgoKAgN6AgUEFTU6Ag
OqAgdGVzdGNhc2U6NyBQQVNTRUQ8YnI+LS08YnI+PGJyPjxicj5GaXggYnkgZGVsaXZlcmluZyBw
YXJlbnQgYXMgb25lIHBhcmFtZXRlciBvZiBjaGlsZCBwcm9jZXNzOjxicj4tLTxicj5JbmRleDog
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY250bC9mY250bDE0LmM8YnI+CgoKCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT08YnI+LS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNudGwvZmNudGwxNC5jPGJyPisr
KyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjbnRsL2ZjbnRsMTQuYzxicj4KQEAgLTc2Myw3
ICs3NjMsNyBAQDxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBicmVhazs8YnI+oKCgoKCgoKCg
oKCgoKCgIGNhc2UgMDogLyogY2hpbGQgKi88YnI+oCNpZmRlZiBVQ0xJTlVYPGJyPi2goKCgoKCg
oKCgoKCgoKCgoKCgoKCgIGlmIChzZWxmX2V4ZWMoYXJndjAsICZxdW90O24mcXVvdDssIDEpICZs
dDsgMCkgezxicj4roKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBpZiAoc2VsZl9leGVjKGFyZ3YwLCAm
cXVvdDtuZCZxdW90OywgMSwgcGFyZW50KSAmbHQ7IDApIHs8YnI+CgoKCgqgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIHRzdF9yZXNtKFRGQUlMLCAmcXVvdDtzZWxmX2V4ZWMgZmFpbGVk
JnF1b3Q7KTs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBicmVhazs8YnI+oKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgfTxicj5AQCAtOTgwLDcgKzk4MCw3IEBAPGJyPqAjaWZkZWYg
VUNMSU5VWDxicj6goKCgoKCgIGFyZ3YwID0gYXZbMF07PGJyPgoKCgoKPGJyPi2goKCgoKAgbWF5
YmVfcnVuX2NoaWxkKCZhbXA7ZG9fdXNsZWVwX2NoaWxkLCAmcXVvdDtuJnF1b3Q7LCAxKTs8YnI+
K6CgoKCgoCBtYXliZV9ydW5fY2hpbGQoJmFtcDtkb191c2xlZXBfY2hpbGQsICZxdW90O25kJnF1
b3Q7LCAxLCAmYW1wO3BhcmVudCk7PGJyPqCgoKCgoKAgdGhpc2Nhc2UgPSBtYWxsb2Moc2l6ZW9m
KHRlc3RjYXNlKSk7PGJyPjxicj6goKCgoKCgIG1heWJlX3J1bl9jaGlsZCgmYW1wO2RvY2hpbGQs
ICZxdW90O25kZGRkZGRkZGQmcXVvdDssIDIsICZhbXA7dGhpc2Nhc2UtJmd0O2NfdHlwZSw8YnI+
CgoKCgotLTxicj48YnI+PGJyPjxicj5CZXN0IHJlZ2FyZHMsPGJyPlZpdmkgTGk8YnI+Cg==
--0016e645ab96a5fd9c0498894a4b--


--===============8959802433190768288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============8959802433190768288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8959802433190768288==--

