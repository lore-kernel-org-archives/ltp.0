Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2VKB-0003iW-IX
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 19:33:51 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2VK8-0006A6-2s
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 19:33:51 +0000
Received: by pzk26 with SMTP id 26so7610937pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 12:33:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1256576579.4929.59.camel@subratamodak.linux.ibm.com>
References: <364299f40910212314yc2f4f3fjc54b8d3897636be3@mail.gmail.com>
	<1256576579.4929.59.camel@subratamodak.linux.ibm.com>
Date: Mon, 26 Oct 2009 12:33:42 -0700
Message-ID: <364299f40910261233m30e06594j584387d6de403349@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001636ed69a6a50a9f0476dba3f8
Subject: Re: [LTP] [New test] ptrace05.c - ptrace(PTRACE_TRACEME, ...) test
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

--001636ed69a6a50a9f0476dba3f8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2009 at 10:02 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-10-21 at 23:14 -0700, Garrett Cooper wrote:
>> The following calls ptrace(PTRACE_TRACEME, 0) for all signals and
>> validates that all signals apart from SIGKILL are properly intercepted
>> and WIFSTOPPED remains true, and SIGKILL is properly treated as
>> WIFSIGNALED() && WTERMSIG() returns SIGKILL.
>>
>> =A0 =A0 1. This test app helped unroot another issue with our custom Lin=
ux
>> platform here at Cisco.
>> =A0 =A0 2. This test application does function properly on a Gentoo Linu=
x
>> based x86_64 / 2.6.30 kernel however, so it's an issue with our OS
>> platform.
>>
>> =A0 =A0 I will add this application to testcases/kernel/syscalls/ptrace,
>> if someone else sees the value in it. I agree that additional error
>> checking could be added for the calls to kill(2)... I just whipped
>> this up in 45 mins after finding this strange behavior on our
>> platform.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Just a quick build and test. It fails on my 32 bit and 64 bit X
> machines:

I looked at it again this weekend, and my criterion for kill (..., 0)
was incorrect. The newer version passes, and tests correct criterion,
as per the manpage:

ptrace05   23  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 23)
ptrace05   24  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 24)
ptrace05   25  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 25)
ptrace05   26  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 26)
ptrace05   27  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 27)
ptrace05   28  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 28)
ptrace05   29  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 29)
ptrace05   30  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 30)
ptrace05   31  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 31)
ptrace05   32  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 32)
ptrace05   33  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 33)
ptrace05   34  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 34)
ptrace05   35  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 35)
ptrace05   36  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 36)
ptrace05   37  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 37)
ptrace05   38  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 38)
ptrace05   39  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 39)
ptrace05   40  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 40)
ptrace05   41  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 41)
ptrace05   42  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 42)
ptrace05   43  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 43)
ptrace05   44  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 44)
ptrace05   45  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 45)
ptrace05   46  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 46)
ptrace05   47  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 47)
ptrace05   48  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 48)
ptrace05   49  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 49)
ptrace05   50  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 50)
ptrace05   51  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 51)
ptrace05   52  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 52)
ptrace05   53  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 53)
ptrace05   54  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 54)
ptrace05   55  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 55)
ptrace05   56  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 56)
ptrace05   57  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 57)
ptrace05   58  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 58)
ptrace05   59  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 59)
ptrace05   60  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 60)
ptrace05   61  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 61)
ptrace05   62  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 62)
ptrace05   63  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 63)
ptrace05   64  TPASS  :  Stopped as expected
ptrace05    0  TINFO  :  [child] Sending kill(.., 64)
ptrace05   65  TPASS  :  Stopped as expected
gcooper@orangebox /scratch/ltp-dev2/ltp $ echo $?
0

/*
 **************************************************************************=
****
 *
 *   ptrace05 - an app which ptraces itself as per arbitrarily
specified signals,
 *   over a user specified range.
 *
 *   Copyright (C) 2009, Garrett Cooper
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License alon=
g
 *   with this program; if not, write to the Free Software Foundation, Inc.=
,
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 **************************************************************************=
****
 */

#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>
#include <libgen.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "test.h"
#include "usctest.h"

char	*TCID		=3D "ptrace05";
int	TST_TOTAL	=3D 0;

int usage(const char*);

int
usage(const char *argv0)
{
	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
	return 1;
}

int
main(int argc, char **argv)
{

	int end_signum =3D -1;
       	int signum;
	int start_signum =3D -1;
	int status;

	pid_t child;

	/* Parse the CLI args appropriately. */
	switch (argc) {
	case 3:
		end_signum =3D (int) strtol((const char*) *(argv+2), NULL, 10);
		/* Parse the signal value. */
		if (end_signum =3D=3D 0 && errno !=3D 0) {
			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
					*(argv+2));
			tst_exit();
		}
		/* FALLTHROUGH */
	case 2:
		start_signum =3D (int) strtol((const char*) *(argv+1), NULL, 10);
		/* Parse the signal value. */
		if (end_signum =3D=3D 0 && errno !=3D 0) {
			tst_resm(TBROK, "argument (%s) isn't a valid number.\n",
					*(argv+1) );
			tst_exit();
		}
		break;
	case 1:
		/* Do nothing. */
		break;
	default:
		return usage(basename(*argv));
	}

	if (start_signum =3D=3D -1) {
		start_signum =3D 0;
	}
	if (end_signum =3D=3D -1) {
		end_signum =3D SIGRTMAX;
	}

	for (signum =3D start_signum; signum <=3D end_signum; signum++) {

		switch (child =3D fork()) {
		case -1:
			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
			break;
		case 0:

			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) !=3D -1) {
				tst_resm(TINFO, "[child] Sending kill(.., %d)",
						signum);
				if (kill(getpid(), signum) < 0) {
					tst_resm(TINFO | TERRNO,
						"[child] kill(.., %d) failed.",
						signum);
				}
			} else {

				/*
				 * This won't increment the TST_COUNT var.
				 * properly, but it'll show up as a failure
				 * nonetheless.
				 */
				tst_resm(TFAIL | TERRNO,
					"Failed to ptrace(PTRACE_TRACEME, ...) "
					"properly");

			}
			/* Shouldn't get here if signum =3D=3D 0. */
			exit((signum =3D=3D 0 ? 0 : 2));
			break;

		default:

			waitpid(child, &status, 0);

			switch(signum) {
			case 0:
				if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0) {
					tst_resm(TPASS, "kill(.., 0) exited "
							"with 0, as expected.");
				} else {
					tst_resm(TFAIL, "kill(.., 0) didn't exit "
							"with 0.");
				}
				break;
			case SIGKILL:
				if (WIFSIGNALED(status)) {
					/* SIGKILL must be uncatchable. */
					if (WTERMSIG(status) =3D=3D SIGKILL) {
						tst_resm(TPASS,
							"Killed with SIGKILL, "
							"as expected.");
					} else {
						tst_resm(TPASS,
							"Didn't die with "
							"SIGKILL (?!) ");
					}
				} else if (WIFEXITED(status)) {
					tst_resm(TFAIL,
						"Exited unexpectedly instead "
						"of dying with SIGKILL.");
				} else if (WIFSTOPPED(status)) {
					tst_resm(TFAIL,
						"Stopped instead of dying "
						"with SIGKILL.");
				}
				break;
			/* All other processes should be stopped. */
			default:
				if (WIFSTOPPED(status)) {
					tst_resm(TPASS, "Stopped as expected");
				} else {
					tst_resm(TFAIL, "Didn't stop as "
							"expected.");
					if (kill (child, 0)) {
						tst_resm(TINFO,
							"Is still alive!?");
					} else if (WIFEXITED(status)) {
						tst_resm(TINFO,
							"Exited normally");
					} else if (WIFSIGNALED(status)) {
						tst_resm(TINFO,
							"Was signaled with "
							"signum=3D%d",
							WTERMSIG(status));
					}

				}

				break;

			}
			=09
		}
		/* Make sure the child dies a quick and painless death ... */
		kill(child, 9);

	}
	=09
	tst_exit();

}

--001636ed69a6a50a9f0476dba3f8
Content-Type: application/octet-stream; name="ptrace05.c"
Content-Disposition: attachment; filename="ptrace05.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g19mfyzp0

LyoKICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKgogKgogKiAgIHB0cmFjZTA1IC0gYW4gYXBwIHdoaWNo
IHB0cmFjZXMgaXRzZWxmIGFzIHBlciBhcmJpdHJhcmlseSBzcGVjaWZpZWQgc2lnbmFscywKICog
ICBvdmVyIGEgdXNlciBzcGVjaWZpZWQgcmFuZ2UuCiAqCiAqICAgQ29weXJpZ2h0IChDKSAyMDA5
LCBHYXJyZXR0IENvb3BlcgogKgogKiAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiAqICAgaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICog
ICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBM
aWNlbnNlLCBvcgogKiAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCiAqCiAq
ICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBi
ZSB1c2VmdWwsCiAqICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhl
IGltcGxpZWQgd2FycmFudHkgb2YKICogICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1Ig
QSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCiAqICAgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICoKICogICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZwogKiAgIHdpdGgg
dGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24sIEluYy4sCiAqICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QSAwMjExMC0xMzAxIFVTQS4KICoKICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgogKi8KCiNpbmNsdWRl
IDxzeXMvcHRyYWNlLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxsaWJn
ZW4uaD4KI2luY2x1ZGUgPG1hdGguaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Rk
aW8uaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlICJ0
ZXN0LmgiCiNpbmNsdWRlICJ1c2N0ZXN0LmgiCgpjaGFyCSpUQ0lECQk9ICJwdHJhY2UwNSI7Cmlu
dAlUU1RfVE9UQUwJPSAwOwoKaW50IHVzYWdlKGNvbnN0IGNoYXIqKTsKCmludAp1c2FnZShjb25z
dCBjaGFyICphcmd2MCkKewoJZnByaW50ZihzdGRlcnIsICJ1c2FnZTogJXMgW3N0YXJ0LXNpZ251
bV0gW2VuZC1zaWdudW1dXG4iLCBhcmd2MCk7CglyZXR1cm4gMTsKfQoKaW50Cm1haW4oaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQp7CgoJaW50IGVuZF9zaWdudW0gPSAtMTsKICAgICAgIAlpbnQgc2ln
bnVtOwoJaW50IHN0YXJ0X3NpZ251bSA9IC0xOwoJaW50IHN0YXR1czsKCglwaWRfdCBjaGlsZDsK
CgkvKiBQYXJzZSB0aGUgQ0xJIGFyZ3MgYXBwcm9wcmlhdGVseS4gKi8KCXN3aXRjaCAoYXJnYykg
ewoJY2FzZSAzOgoJCWVuZF9zaWdudW0gPSAoaW50KSBzdHJ0b2woKGNvbnN0IGNoYXIqKSAqKGFy
Z3YrMiksIE5VTEwsIDEwKTsKCQkvKiBQYXJzZSB0aGUgc2lnbmFsIHZhbHVlLiAqLwoJCWlmIChl
bmRfc2lnbnVtID09IDAgJiYgZXJybm8gIT0gMCkgewoJCQl0c3RfcmVzbShUQlJPSywgImFyZ3Vt
ZW50ICglcykgaXNuJ3QgYSB2YWxpZCBudW1iZXIuXG4iLAoJCQkJCSooYXJndisyKSk7CgkJCXRz
dF9leGl0KCk7CgkJfQoJCS8qIEZBTExUSFJPVUdIICovCgljYXNlIDI6CgkJc3RhcnRfc2lnbnVt
ID0gKGludCkgc3RydG9sKChjb25zdCBjaGFyKikgKihhcmd2KzEpLCBOVUxMLCAxMCk7CgkJLyog
UGFyc2UgdGhlIHNpZ25hbCB2YWx1ZS4gKi8KCQlpZiAoZW5kX3NpZ251bSA9PSAwICYmIGVycm5v
ICE9IDApIHsKCQkJdHN0X3Jlc20oVEJST0ssICJhcmd1bWVudCAoJXMpIGlzbid0IGEgdmFsaWQg
bnVtYmVyLlxuIiwKCQkJCQkqKGFyZ3YrMSkgKTsKCQkJdHN0X2V4aXQoKTsKCQl9CgkJYnJlYWs7
CgljYXNlIDE6CgkJLyogRG8gbm90aGluZy4gKi8KCQlicmVhazsKCWRlZmF1bHQ6CgkJcmV0dXJu
IHVzYWdlKGJhc2VuYW1lKCphcmd2KSk7Cgl9CgoJaWYgKHN0YXJ0X3NpZ251bSA9PSAtMSkgewoJ
CXN0YXJ0X3NpZ251bSA9IDA7Cgl9CglpZiAoZW5kX3NpZ251bSA9PSAtMSkgewoJCWVuZF9zaWdu
dW0gPSBTSUdSVE1BWDsKCX0KCglmb3IgKHNpZ251bSA9IHN0YXJ0X3NpZ251bTsgc2lnbnVtIDw9
IGVuZF9zaWdudW07IHNpZ251bSsrKSB7CgoJCXN3aXRjaCAoY2hpbGQgPSBmb3JrKCkpIHsgCgkJ
Y2FzZSAtMToKCQkJdHN0X3Jlc20oVEJST0sgfCBURVJSTk8sICJGYWlsZWQgdG8gZm9yayBwcm9w
ZXJseS4iKTsKCQkJYnJlYWs7CgkJY2FzZSAwOgoKCQkJaWYgKHB0cmFjZShQVFJBQ0VfVFJBQ0VN
RSwgMCwgTlVMTCwgTlVMTCkgIT0gLTEpIHsKCQkJCXRzdF9yZXNtKFRJTkZPLCAiW2NoaWxkXSBT
ZW5kaW5nIGtpbGwoLi4sICVkKSIsCgkJCQkJCXNpZ251bSk7CgkJCQlpZiAoa2lsbChnZXRwaWQo
KSwgc2lnbnVtKSA8IDApIHsKCQkJCQl0c3RfcmVzbShUSU5GTyB8IFRFUlJOTywKCQkJCQkJIltj
aGlsZF0ga2lsbCguLiwgJWQpIGZhaWxlZC4iLAoJCQkJCQlzaWdudW0pOwoJCQkJfQoJCQl9IGVs
c2UgewoKCQkJCS8qCgkJCQkgKiBUaGlzIHdvbid0IGluY3JlbWVudCB0aGUgVFNUX0NPVU5UIHZh
ci4KCQkJCSAqIHByb3Blcmx5LCBidXQgaXQnbGwgc2hvdyB1cCBhcyBhIGZhaWx1cmUKCQkJCSAq
IG5vbmV0aGVsZXNzLgoJCQkJICovCgkJCQl0c3RfcmVzbShURkFJTCB8IFRFUlJOTywKCQkJCQki
RmFpbGVkIHRvIHB0cmFjZShQVFJBQ0VfVFJBQ0VNRSwgLi4uKSAiCgkJCQkJInByb3Blcmx5Iik7
CgoJCQl9CgkJCS8qIFNob3VsZG4ndCBnZXQgaGVyZSBpZiBzaWdudW0gPT0gMC4gKi8KCQkJZXhp
dCgoc2lnbnVtID09IDAgPyAwIDogMikpOwoJCQlicmVhazsKCgkJZGVmYXVsdDoKCgkJCXdhaXRw
aWQoY2hpbGQsICZzdGF0dXMsIDApOwoKCQkJc3dpdGNoKHNpZ251bSkgewoJCQljYXNlIDA6CgkJ
CQlpZiAoV0lGRVhJVEVEKHN0YXR1cykgJiYgV0VYSVRTVEFUVVMoc3RhdHVzKSA9PSAwKSB7CgkJ
CQkJdHN0X3Jlc20oVFBBU1MsICJraWxsKC4uLCAwKSBleGl0ZWQgIgoJCQkJCQkJIndpdGggMCwg
YXMgZXhwZWN0ZWQuIik7CgkJCQl9IGVsc2UgewoJCQkJCXRzdF9yZXNtKFRGQUlMLCAia2lsbCgu
LiwgMCkgZGlkbid0IGV4aXQgIgoJCQkJCQkJIndpdGggMC4iKTsKCQkJCX0KCQkJCWJyZWFrOwoJ
CQljYXNlIFNJR0tJTEw6CgkJCQlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSkgewoJCQkJCS8qIFNJ
R0tJTEwgbXVzdCBiZSB1bmNhdGNoYWJsZS4gKi8KCQkJCQlpZiAoV1RFUk1TSUcoc3RhdHVzKSA9
PSBTSUdLSUxMKSB7CgkJCQkJCXRzdF9yZXNtKFRQQVNTLAoJCQkJCQkJIktpbGxlZCB3aXRoIFNJ
R0tJTEwsICIKCQkJCQkJCSJhcyBleHBlY3RlZC4iKTsKCQkJCQl9IGVsc2UgewoJCQkJCQl0c3Rf
cmVzbShUUEFTUywKCQkJCQkJCSJEaWRuJ3QgZGllIHdpdGggIgoJCQkJCQkJIlNJR0tJTEwgKD8h
KSAiKTsKCQkJCQl9CgkJCQl9IGVsc2UgaWYgKFdJRkVYSVRFRChzdGF0dXMpKSB7CgkJCQkJdHN0
X3Jlc20oVEZBSUwsCgkJCQkJCSJFeGl0ZWQgdW5leHBlY3RlZGx5IGluc3RlYWQgIgoJCQkJCQki
b2YgZHlpbmcgd2l0aCBTSUdLSUxMLiIpOwoJCQkJfSBlbHNlIGlmIChXSUZTVE9QUEVEKHN0YXR1
cykpIHsKCQkJCQl0c3RfcmVzbShURkFJTCwKCQkJCQkJIlN0b3BwZWQgaW5zdGVhZCBvZiBkeWlu
ZyAiCgkJCQkJCSJ3aXRoIFNJR0tJTEwuIik7CgkJCQl9CgkJCQlicmVhazsKCQkJLyogQWxsIG90
aGVyIHByb2Nlc3NlcyBzaG91bGQgYmUgc3RvcHBlZC4gKi8KCQkJZGVmYXVsdDoKCQkJCWlmIChX
SUZTVE9QUEVEKHN0YXR1cykpIHsKCQkJCQl0c3RfcmVzbShUUEFTUywgIlN0b3BwZWQgYXMgZXhw
ZWN0ZWQiKTsKCQkJCX0gZWxzZSB7CgkJCQkJdHN0X3Jlc20oVEZBSUwsICJEaWRuJ3Qgc3RvcCBh
cyAiCgkJCQkJCQkiZXhwZWN0ZWQuIik7CgkJCQkJaWYgKGtpbGwgKGNoaWxkLCAwKSkgewoJCQkJ
CQl0c3RfcmVzbShUSU5GTywKCQkJCQkJCSJJcyBzdGlsbCBhbGl2ZSE/Iik7CgkJCQkJfSBlbHNl
IGlmIChXSUZFWElURUQoc3RhdHVzKSkgewoJCQkJCQl0c3RfcmVzbShUSU5GTywKCQkJCQkJCSJF
eGl0ZWQgbm9ybWFsbHkiKTsKCQkJCQl9IGVsc2UgaWYgKFdJRlNJR05BTEVEKHN0YXR1cykpIHsK
CQkJCQkJdHN0X3Jlc20oVElORk8sCgkJCQkJCQkiV2FzIHNpZ25hbGVkIHdpdGggIgoJCQkJCQkJ
InNpZ251bT0lZCIsCgkJCQkJCQlXVEVSTVNJRyhzdGF0dXMpKTsKCQkJCQl9CgoJCQkJfQoKCQkJ
CWJyZWFrOwoKCQkJfQoJCQkJCgkJfQoJCS8qIE1ha2Ugc3VyZSB0aGUgY2hpbGQgZGllcyBhIHF1
aWNrIGFuZCBwYWlubGVzcyBkZWF0aCAuLi4gKi8KCQlraWxsKGNoaWxkLCA5KTsKCgl9CgkJCgl0
c3RfZXhpdCgpOwoKfQo=
--001636ed69a6a50a9f0476dba3f8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--001636ed69a6a50a9f0476dba3f8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636ed69a6a50a9f0476dba3f8--

