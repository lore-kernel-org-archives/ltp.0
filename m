From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Feb 2020 06:56:54 -0500 (EST)
Subject: [LTP] min_free_kbytes.c:134: FAIL: child unexpectedly failed:
 139
In-Reply-To: <MAXPR0101MB14687E3C724A815D2857EA14EE1A0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14687E3C724A815D2857EA14EE1A0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <333767604.7805569.1581940614115.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> i am running min_free_kbytes test,6 test cases are failing with error message
> min_free_kbytes.c:134: FAIL: child unexpectedly failed: 139.
> i am attaching the test result

Hi,

for future, can you just paste the test output to email, instead of sending screenshots of text?

You're not providing much information, such as LTP version, kernel, architecture or distro.
Or if it worked previously and started failing only now. So it's difficult for anyone to
try reproduce your steps.

Output is unusual, status codes suggest child running into SIGSEGV and SIGILL at some
point after eatup_mem(). Did you try to run this with gdb, strace or look at core files?

