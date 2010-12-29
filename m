Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRK-0006CC-7X
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:26 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRJ-00013F-A3
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:26 +0000
Received: by gxk20 with SMTP id 20so4618986gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:20 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:19 +0800
Message-ID: <AANLkTinfPDnAj15kpPX+om+JEQ569hUBG53GTkHjPF=Q@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  port several ltp test cases for uClinux platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1098859232067997310=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============1098859232067997310==
Content-Type: multipart/alternative; boundary=0016e64651be9f65a004988949eb

--0016e64651be9f65a004988949eb
Content-Type: text/plain; charset=ISO-8859-1

Port following ltp test cases for uClinux platform:
--
fcntl17
rt_sigqueueinfo01
exit_group01
umount03
mount03
eventfd01
--

Bellow is the patch:
--
Index: testcases/kernel/syscalls/fcntl/fcntl17.c
===================================================================
--- testcases/kernel/syscalls/fcntl/fcntl17.c
+++ testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -477,7 +477,7 @@

                /* parent */

-               if ((child_pid2 = fork()) == 0) {       /* second child */
+               if ((child_pid2 = FORK_OR_VFORK()) == 0) {      /* second
child */
 #ifdef UCLINUX
                        if (self_exec(av[0], "nddddddddd", 2, file_fd,
                                      parent_pipe[0], parent_pipe[1],
@@ -501,7 +501,7 @@

                /* parent */

-               if ((child_pid3 = fork()) == 0) {       /* third child */
+               if ((child_pid3 = FORK_OR_VFORK()) == 0) {      /* third
child */
 #ifdef UCLINUX
                        if (self_exec(av[0], "nddddddddd", 3, file_fd,
                                      parent_pipe[0], parent_pipe[1],
Index: testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
===================================================================
--- testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
+++ testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c
@@ -128,7 +128,7 @@
        for (lc = 0; TEST_LOOPING(lc); ++lc) {
                Tst_count = 0;
                for (testno = 0; testno < TST_TOTAL; ++testno) {
-                       TEST(pid = fork());
+                       TEST(pid = FORK_OR_VFORK());
                        setup();
                        if (TEST_RETURN < 0) {
                                tst_resm(TFAIL, "fork() Failed, errno=%d :
%s", TEST_ERRNO,
@@ -146,6 +146,7 @@

strerror(TEST_ERRNO));
                                }
                                cleanup();
+                               _exit(0);
                        }
                        tst_exit();
                }
Index: testcases/kernel/syscalls/exit_group/exit_group01.c
===================================================================
--- testcases/kernel/syscalls/exit_group/exit_group01.c
+++ testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -128,7 +128,7 @@
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {

-                    TEST(cpid = fork());     //call exit_group()
+                    TEST(cpid = FORK_OR_VFORK());     //call exit_group()
                      if(TEST_RETURN == -1) {
                                tst_resm(TFAIL, "fork() error ...errno
%d",TEST_ERRNO);
                                cleanup();
Index: testcases/kernel/syscalls/umount/umount03.c
===================================================================
--- testcases/kernel/syscalls/umount/umount03.c
+++ testcases/kernel/syscalls/umount/umount03.c
@@ -170,7 +170,7 @@
                /* reset Tst_count in case we are looping. */
                Tst_count = 0;

-               switch (fork()) {
+               switch (FORK_OR_VFORK()) {

                case -1:
                        /* fork() failed */
Index: testcases/kernel/syscalls/mount/mount03.c
===================================================================
--- testcases/kernel/syscalls/mount/mount03.c
+++ testcases/kernel/syscalls/mount/mount03.c
@@ -391,7 +391,7 @@
                /* Validate MS_NOSUID flag of mount call */

                setup_uid();
-               if ((pid = fork()) == 0) {
+               if ((pid = FORK_OR_VFORK()) == 0) {
                        snprintf(file, PATH_MAX, "%ssetuid_test",
Path_name);
                        if (chmod(file, SUID_MODE) != 0) {
                                tst_resm(TWARN, "chmod() failed to "
@@ -429,7 +429,7 @@
        int pid, status;
        char command[PATH_MAX];

-       switch (pid = fork()) {
+       switch (pid = FORK_OR_VFORK()) {
        case -1:
                tst_resm(TWARN, "Unable to fork a child process"
                         " to exec over!  Errno:%d, :%s",
Index: testcases/kernel/syscalls/eventfd/eventfd01.c
===================================================================
--- testcases/kernel/syscalls/eventfd/eventfd01.c
+++ testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -438,7 +438,7 @@
        uint64_t to_parent = 0xdeadbeef;
        uint64_t dummy;

-       cpid = fork();
+       cpid = FORK_OR_VFORK();
        if (cpid == -1)
                tst_resm(TBROK|TERRNO, "fork() failed");
        if (cpid != 0) {
--


Best regards,
Vivi Li

--0016e64651be9f65a004988949eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

UG9ydCBmb2xsb3dpbmcgbHRwIHRlc3QgY2FzZXMgZm9yIHVDbGludXggcGxhdGZvcm06PGJyPi0t
PGJyPmZjbnRsMTc8YnI+cnRfc2lncXVldWVpbmZvMDE8YnI+ZXhpdF9ncm91cDAxPGJyPnVtb3Vu
dDAzPGJyPm1vdW50MDM8YnI+ZXZlbnRmZDAxPGJyPi0tPGJyPjxicj5CZWxsb3cgaXMgdGhlIHBh
dGNoOjxicj4tLTxicj5JbmRleDogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY250bC9mY250
bDE3LmM8YnI+CgoKCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT08YnI+LS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmNudGwvZmNudGwxNy5jPGJyPisrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjbnRsL2Zj
bnRsMTcuYzxicj5AQCAtNDc3LDcgKzQ3Nyw3IEBAPGJyPjxicj6goKCgoKCgoKCgoKCgoKAgLyog
cGFyZW50ICovPGJyPgoKCgo8YnI+LaCgoKCgoKCgoKCgoKCgIGlmICgoY2hpbGRfcGlkMiA9IGZv
cmsoKSkgPT0gMCkge6CgoKCgoCAvKiBzZWNvbmQgY2hpbGQgKi88YnI+K6CgoKCgoKCgoKCgoKCg
IGlmICgoY2hpbGRfcGlkMiA9IEZPUktfT1JfVkZPUksoKSkgPT0gMCkge6CgoKCgIC8qIHNlY29u
ZCBjaGlsZCAqLzxicj6gI2lmZGVmIFVDTElOVVg8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
aWYgKHNlbGZfZXhlYyhhdlswXSwgJnF1b3Q7bmRkZGRkZGRkZCZxdW90OywgMiwgZmlsZV9mZCw8
YnI+CgoKCqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgcGFyZW50X3BpcGVb
MF0sIHBhcmVudF9waXBlWzFdLDxicj5AQCAtNTAxLDcgKzUwMSw3IEBAPGJyPjxicj6goKCgoKCg
oKCgoKCgoKAgLyogcGFyZW50ICovPGJyPjxicj4toKCgoKCgoKCgoKCgoKAgaWYgKChjaGlsZF9w
aWQzID0gZm9yaygpKSA9PSAwKSB7oKCgoKCgIC8qIHRoaXJkIGNoaWxkICovPGJyPiugoKCgoKCg
oKCgoKCgoCBpZiAoKGNoaWxkX3BpZDMgPSBGT1JLX09SX1ZGT1JLKCkpID09IDApIHugoKCgoCAv
KiB0aGlyZCBjaGlsZCAqLzxicj4KCgoKoCNpZmRlZiBVQ0xJTlVYPGJyPqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIGlmIChzZWxmX2V4ZWMoYXZbMF0sICZxdW90O25kZGRkZGRkZGQmcXVvdDssIDMs
IGZpbGVfZmQsPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgcGFyZW50
X3BpcGVbMF0sIHBhcmVudF9waXBlWzFdLDxicj5JbmRleDogdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9ydF9zaWdxdWV1ZWluZm8vcnRfc2lncXVldWVpbmZvMDEuYzxicj4KCgoKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PTxicj4tLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdxdWV1ZWluZm8vcnRfc2ln
cXVldWVpbmZvMDEuYzxicj4rKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdxdWV1
ZWluZm8vcnRfc2lncXVldWVpbmZvMDEuYzxicj5AQCAtMTI4LDcgKzEyOCw3IEBAPGJyPgoKCgqg
oKCgoKCgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7PGJyPqCgoKCgoKCg
oKCgoKCgoCBUc3RfY291bnQgPSAwOzxicj6goKCgoKCgoKCgoKCgoKAgZm9yICh0ZXN0bm8gPSAw
OyB0ZXN0bm8gJmx0OyBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7PGJyPi2goKCgoKCgoKCgoKCgoKCg
oKCgoKCgIFRFU1QocGlkID0gZm9yaygpKTs8YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKAgVEVT
VChwaWQgPSBGT1JLX09SX1ZGT1JLKCkpOzxicj4KCgoKoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
c2V0dXAoKTs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgaWYgKFRFU1RfUkVUVVJOICZsdDsg
MCkgezxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHRzdF9yZXNtKFRGQUlMLCAm
cXVvdDtmb3JrKCkgRmFpbGVkLCBlcnJubz0lZCA6ICVzJnF1b3Q7LCBURVNUX0VSUk5PLDxicj5A
QCAtMTQ2LDYgKzE0Niw3IEBAPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgc3RyZXJyb3IoVEVTVF9FUlJOTykpOzxicj4KCgoKoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB9PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgY2xlYW51cCgpOzxicj4roKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIF9leGl0
KDApOzxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB9PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIHRzdF9leGl0KCk7PGJyPqCgoKCgoKCgoKCgoKCgoCB9PGJyPkluZGV4OiB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2V4aXRfZ3JvdXAvZXhpdF9ncm91cDAxLmM8YnI+CgoKCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT08YnI+LS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXhpdF9ncm91cC9leGl0X2dyb3Vw
MDEuYzxicj4rKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9leGl0X2dyb3VwL2V4aXRfZ3Jv
dXAwMS5jPGJyPkBAIC0xMjgsNyArMTI4LDcgQEA8YnI+oKCgoKCgoKCgoKCgoKCgoCBUc3RfY291
bnQgPSAwOzxicj4KCgoKoKCgoKCgoKCgoKCgoKCgoCBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyAm
bHQ7IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHs8YnI+PGJyPi2goKCgoKCgoKCgoKCgoKCgoKCgIFRF
U1QoY3BpZCA9IGZvcmsoKSk7oKCgoCAvL2NhbGwgZXhpdF9ncm91cCgpPGJyPiugoKCgoKCgoKCg
oKCgoKCgoKCgIFRFU1QoY3BpZCA9IEZPUktfT1JfVkZPUksoKSk7oKCgoCAvL2NhbGwgZXhpdF9n
cm91cCgpPGJyPgoKCgqgoKCgoKCgoKCgoKCgoKCgoKCgoKAgaWYoVEVTVF9SRVRVUk4gPT0gLTEp
IHs8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB0c3RfcmVzbShURkFJTCwgJnF1
b3Q7Zm9yaygpIGVycm9yIC4uLmVycm5vICVkJnF1b3Q7LFRFU1RfRVJSTk8pOzxicj6goKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGNsZWFudXAoKTs8YnI+SW5kZXg6IHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAzLmM8YnI+CgoKCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+LS0t
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAzLmM8YnI+KysrIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvdW1vdW50L3Vtb3VudDAzLmM8YnI+QEAgLTE3MCw3ICsxNzAs
NyBAQDxicj6goKCgoKCgoKCgoKCgoKAgLyogcmVzZXQgVHN0X2NvdW50IGluIGNhc2Ugd2UgYXJl
IGxvb3BpbmcuICovPGJyPgoKCgqgoKCgoKCgoKCgoKCgoKAgVHN0X2NvdW50ID0gMDs8YnI+PGJy
Pi2goKCgoKCgoKCgoKCgoCBzd2l0Y2ggKGZvcmsoKSkgezxicj4roKCgoKCgoKCgoKCgoKAgc3dp
dGNoIChGT1JLX09SX1ZGT1JLKCkpIHs8YnI+PGJyPqCgoKCgoKCgoKCgoKCgoCBjYXNlIC0xOjxi
cj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoCAvKiBmb3JrKCkgZmFpbGVkICovPGJyPkluZGV4OiB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYzxicj4KCgoKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PTxicj4tLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmM8YnI+Kysr
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jPGJyPkBAIC0zOTEsNyAr
MzkxLDcgQEA8YnI+oKCgoKCgoKCgoKCgoKCgIC8qIFZhbGlkYXRlIE1TX05PU1VJRCBmbGFnIG9m
IG1vdW50IGNhbGwgKi88YnI+CgoKCjxicj6goKCgoKCgoKCgoKCgoKAgc2V0dXBfdWlkKCk7PGJy
Pi2goKCgoKCgoKCgoKCgoCBpZiAoKHBpZCA9IGZvcmsoKSkgPT0gMCkgezxicj4roKCgoKCgoKCg
oKCgoKAgaWYgKChwaWQgPSBGT1JLX09SX1ZGT1JLKCkpID09IDApIHs8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgc25wcmludGYoZmlsZSwgUEFUSF9NQVgsICZxdW90OyVzc2V0dWlkX3Rlc3Qm
cXVvdDssIFBhdGhfbmFtZSk7PGJyPgoKCgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBpZiAoY2ht
b2QoZmlsZSwgU1VJRF9NT0RFKSAhPSAwKSB7PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgdHN0X3Jlc20oVFdBUk4sICZxdW90O2NobW9kKCkgZmFpbGVkIHRvICZxdW90Ozxicj5A
QCAtNDI5LDcgKzQyOSw3IEBAPGJyPqCgoKCgoKAgaW50IHBpZCwgc3RhdHVzOzxicj6goKCgoKCg
IGNoYXIgY29tbWFuZFtQQVRIX01BWF07PGJyPgoKCgo8YnI+LaCgoKCgoCBzd2l0Y2ggKHBpZCA9
IGZvcmsoKSkgezxicj4roKCgoKCgIHN3aXRjaCAocGlkID0gRk9SS19PUl9WRk9SSygpKSB7PGJy
PqCgoKCgoKAgY2FzZSAtMTo8YnI+oKCgoKCgoKCgoKCgoKCgIHRzdF9yZXNtKFRXQVJOLCAmcXVv
dDtVbmFibGUgdG8gZm9yayBhIGNoaWxkIHByb2Nlc3MmcXVvdDs8YnI+oKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgICZxdW90OyB0byBleGVjIG92ZXIhoCBFcnJubzolZCwgOiVzJnF1b3Q7LDxicj4K
CgoKSW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZC9ldmVudGZkMDEuYzxi
cj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PGJyPi0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50ZmQvZXZl
bnRmZDAxLmM8YnI+KysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZC9ldmVudGZk
MDEuYzxicj4KCgoKQEAgLTQzOCw3ICs0MzgsNyBAQDxicj6goKCgoKCgIHVpbnQ2NF90IHRvX3Bh
cmVudCA9IDB4ZGVhZGJlZWY7PGJyPqCgoKCgoKAgdWludDY0X3QgZHVtbXk7PGJyPjxicj4toKCg
oKCgIGNwaWQgPSBmb3JrKCk7PGJyPiugoKCgoKAgY3BpZCA9IEZPUktfT1JfVkZPUksoKTs8YnI+
oKCgoKCgoCBpZiAoY3BpZCA9PSAtMSk8YnI+oKCgoKCgoKCgoKCgoKCgIHRzdF9yZXNtKFRCUk9L
fFRFUlJOTywgJnF1b3Q7Zm9yaygpIGZhaWxlZCZxdW90Oyk7PGJyPgoKCgqgoKCgoKCgIGlmIChj
cGlkICE9IDApIHs8YnI+LS08YnI+PGJyPjxicj5CZXN0IHJlZ2FyZHMsPGJyPlZpdmkgTGk8YnI+
Cg==
--0016e64651be9f65a004988949eb--


--===============1098859232067997310==
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
--===============1098859232067997310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1098859232067997310==--

