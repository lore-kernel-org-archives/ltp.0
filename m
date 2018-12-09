From: Enji Cooper <yaneurabeya@gmail.com>
Date: Sun, 9 Dec 2018 12:27:24 -0800
Subject: [LTP] [PATCH] openposix: Remove _XOPEN_SOURCE in
 strchr/strcpy/strncpy
In-Reply-To: <20181207100013.GA14165@dell5510>
References: <1544089211-8138-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20181207100013.GA14165@dell5510>
Message-ID: <E3AC0FBF-9E7E-4127-BCC2-67490FB84BCA@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

All,
	I think we should try moving forward to 700. Staying at 600 doesn’t really buy us much in the longterm (it’s testing the 2001 POSIX spec), and the underlying implementation likely supports both—unless the implementers were pedantic, and anecdotally this hasn’t been the general case in GNU/Linux, compared to *BSD.
	Thank you Xiao for pointing this out. I misunderstood what you meant in the PR.
	I’ll push for removing the _XOPEN_SOURCE #defines and bumping the version to 700.
Thank you!
-Enji

> On Dec 7, 2018, at 2:00 AM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Hi Xiao,
> 
>> We have defined _XOPEN_SOURCE to 600 by gcc -D in open_posix_testsuite/CFLAGS，
>> So defining _XOPEN_SOURCE to different value in test results in a "_XOPEN_SOURCE
>> redefined" warning.
> 
>> It seems that all of tests get pass even if _XOPEN_SOURCE is defined to 600
>> by default, so remove the duplicate _XOPEN_SOURCE in test.
> 
> FYI I also mentioned it in https://github.com/linux-test-project/ltp/pull/423
> but it was ignored.
> This is a side effect, that we use mailing list and github pull requests.
> 
> I guess _XOPEN_SOURCE 600 is ok.
> If _XOPEN_SOURCE 700 is really needed, we can use:
> #ifdef _XOPEN_SOURCE
> #undef _XOPEN_SOURCE
> #endif
> #define _XOPEN_SOURCE 700
> 
> Kind regards,
> Petr
> 
>> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> ---
> 
> 
>> testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c  | 1 -
>> testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c  | 1 -
>> testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c | 1 -
>> testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c | 1 -
>> 4 files changed, 4 deletions(-)
> 
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
>> index 95eda79..611a64d 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strchr/1-1.c
>> @@ -25,7 +25,6 @@
>>  *	-Repeat the above all steps for given number of iterations.
>> */
> 
>> -#define _XOPEN_SOURCE 700
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdlib.h>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
>> index 2fdc002..adfbfc3 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strcpy/1-1.c
>> @@ -17,7 +17,6 @@
>>  *  -Also compare returned pointer with s2.
>> */
> 
>> -#define _XOPEN_SOURCE 700
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdlib.h>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> index 3458015..396bd60 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/1-1.c
>> @@ -20,7 +20,6 @@
>>  *  -Repeat the above steps for given number of iterations.
>> */
> 
>> -#define _XOPEN_SOURCE 700
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdlib.h>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
>> index a7761c5..2a20872 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/strncpy/2-1.c
>> @@ -20,7 +20,6 @@
>>  *  -Repeat the above steps for given number of iterations.
>> */
> 
>> -#define _XOPEN_SOURCE 700
>> #include <stdio.h>
>> #include <string.h>
>> #include <stdlib.h>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181209/8ef721c8/attachment.sig>
