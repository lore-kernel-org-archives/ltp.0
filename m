Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MOCXE-0000sU-Fd
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:24:44 +0000
Received: from qw-out-1920.google.com ([74.125.92.145])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOCX9-0006KW-4O
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:24:44 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1718783qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 08:24:38 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jul 2009 18:16:38 +0530
Message-ID: <f5a7b3810907070546v727fafc0o71fde4613e590254@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=0016364edc327d4f7e046e1d03e8
Subject: Re: [LTP] Compile failure with rt_sigaction on amd64
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

--0016364edc327d4f7e046e1d03e8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Garrett Cooper,

Thanks for your info.

>Oops... looks like someone forgot __amd64__ / >__ia64__:

yes.
i forgot to add these ARCH.
Because I am not having this Architecture at my end :-(

>gcc -g -O2 -I../../include -g -Wall -I../../../../include >-Wall -O2 -W
>rt_sigaction01.c -L../../../../lib -lltp -o rt_sigaction01
>rt_sigaction01.c: In function 'set_handler':
>rt_sigaction01.c:147: error: 'SIGSETSIZE' >undeclared .(first use in
>this function)
>rt_sigaction01.c:147: error: (Each undeclared >identifier is reported only=
 once
>rt_sigaction01.c:147: error: for each function it >appears in.)
>make[4]: *** [rt_sigaction01] Error 1

>I tried using sizeof(sigaction_t), but unfortunately the >results for
>the testcase(s) on my system were always EINVAL. >This issue wasn't
>present a few days ago...

>Any ideas?


I have made a patch to fix this issue please review the this temporary fix.

In my previous mail I have stated that sigset size (size_t sigsetsize)
will be different for Different ARCH. It is depending on
_COMPAT_NSIG_WORDS Macro.

We have to conform how its different with respect to ARCH and need to
have a generic solution to fix this issue.

I think its going to be an issue othere than __arm__ || __i386__ ||
__powerpc__ || __amd64__ || __ia64__ and __mips__

There are different ARCH are being used by our LTP developers.

I=92ll investigate this issue and come back with generic Solution to
support most of the ARCH.


please refer this linux-2.6.30/include/linux/compat.h

http://lxr.linux.no/linux+v2.6.30/include/linux/compat.h#L75

#define _COMPAT_NSIG_WORDS (_COMPAT_NSIG / _COMPAT_NSIG_BPW)

typedef struct {
compat_sigset_word sig[_COMPAT_NSIG_WORDS];
} compat_sigset_t;

Your suggestions are welcome ... :)


Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gm... >

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-07-07
16:58:11.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-07-07
16:59:38.000000000 +0530
@@ -59,7 +59,7 @@
#define SIGSETSIZE 16
#endif

-#if defined __arm__ || __i386__ || __powerpc__
+#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
#define SIGSETSIZE 8
#endif

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 2009-07-07
16:58:11.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 2009-07-07
16:59:48.000000000 +0530
@@ -55,7 +55,7 @@
#define SIGSETSIZE 16
#endif

-#if defined __arm__ || __i386__ || __powerpc__
+#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
#define SIGSETSIZE 8
#endif

--0016364edc327d4f7e046e1d03e8
Content-Type: application/octet-stream; name="ltp-fix-rt_sigaction.patch"
Content-Disposition: attachment; filename="ltp-fix-rt_sigaction.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwum5sub0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlvbi9ydF9z
aWdhY3Rpb24wMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdhY3Rpb24vcnRf
c2lnYWN0aW9uMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlv
bi9ydF9zaWdhY3Rpb24wMS5jCTIwMDktMDctMDcgMTY6NTg6MTEuMDAwMDAwMDAwICswNTMwCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnYWN0aW9uL3J0X3NpZ2FjdGlvbjAx
LmMJMjAwOS0wNy0wNyAxNjo1OTozOC4wMDAwMDAwMDAgKzA1MzAKQEAgLTU5LDcgKzU5LDcgQEAK
ICNkZWZpbmUgU0lHU0VUU0laRSAxNgogI2VuZGlmCiAKLSNpZiBkZWZpbmVkIF9fYXJtX18gfHwg
X19pMzg2X18gfHwgX19wb3dlcnBjX18KKyNpZiBkZWZpbmVkIF9fYXJtX18gfHwgX19pMzg2X18g
fHwgX19wb3dlcnBjX18gfHwgX19hbWQ2NF9fIHx8IF9faWE2NF9fCiAjZGVmaW5lIFNJR1NFVFNJ
WkUgOAogI2VuZGlmCiAKZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0
X3NpZ2FjdGlvbi9ydF9zaWdhY3Rpb24wMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
dF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDIuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3J0X3NpZ2FjdGlvbi9ydF9zaWdhY3Rpb24wMi5jCTIwMDktMDctMDcgMTY6NTg6MTEuMDAw
MDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnYWN0aW9u
L3J0X3NpZ2FjdGlvbjAyLmMJMjAwOS0wNy0wNyAxNjo1OTo0OC4wMDAwMDAwMDAgKzA1MzAKQEAg
LTU1LDcgKzU1LDcgQEAKICNkZWZpbmUgU0lHU0VUU0laRSAxNgogI2VuZGlmCiAKLSNpZiBkZWZp
bmVkIF9fYXJtX18gfHwgX19pMzg2X18gfHwgX19wb3dlcnBjX18KKyNpZiBkZWZpbmVkIF9fYXJt
X18gfHwgX19pMzg2X18gfHwgX19wb3dlcnBjX18gfHwgX19hbWQ2NF9fIHx8IF9faWE2NF9fCiAj
ZGVmaW5lIFNJR1NFVFNJWkUgOAogI2VuZGlmCiAK
--0016364edc327d4f7e046e1d03e8
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
--0016364edc327d4f7e046e1d03e8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016364edc327d4f7e046e1d03e8--

