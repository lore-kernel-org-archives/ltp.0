From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Dec 2017 00:17:29 +0530
Subject: [LTP] [RFC] Showing skipped tests in results?
In-Reply-To: <20171206105233.GD13979@rei>
References: <20171205221105.yobl5c4brhpu5tdo@xps> <20171206105233.GD13979@rei>
Message-ID: <CA+G9fYtUa69MaYSsRTpZHKYX1UJZ2p3ZqKWvwvur7-HdaHhviA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 6 December 2017 at 16:22, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> When we skip tests in LTP using "./runltp -S SKIPFILE", they get removed
>> from the test list completely, leaving no trace in the results.
>> Meanwhile, tests that are not able to run due to configuration show up
>> as a "CONF" in the results file.
>>
>> From our perspective, this is not ideal because we want to see tests
>> that are explicitly skipped as skipped in the results. Ideally, tests
>> that are skipped will still show up in the results as a SKIP.
>>
>> It looks like there's some precedent in runltp for prepending a string
>> to a test name that can then later be picked up and interpreted by
>> individual tests.
>>
>> Specifically, I noticed that if you use -I ITERATIONS to run tests
>> multiple times, it will prepend an iteration count and number in
>> alltests:
>>
>> $ cat alltests
>> 1_ITERATION_gzip01 gzip_tests.sh
>> 2_ITERATION_gzip01 gzip_tests.sh
>> 3_ITERATION_gzip01 gzip_tests.sh
>>
>> Which made me wonder if we could use a similar convention for SKIP,
>> rather than just removing the test from alltests (what currently
>> happens).
>>
>> So for example, if you skip gzip01, the alltests file would end up with
>> something like: SKIP_gzip01 gzip_tests.sh
>>
>> When I try that, it actually runs gzip01 still. I thought it would
>> fail. Which means that something is stripping the "SKIP_" (and
>> throwing it away).
>
> I think that you misunderstand how things works, the first string on
> each line in the alltests file that is parsed by ltp-pan is just test
> name that appears in the test result file, it does not affect anything
> but that.
>
> I guess that the easiest solution would be replacing the actuall command
> that is supposed to be executed with something that just reports
> skipped status.
>
> Quick hack would be replacing these with something that just returns the
> right exit value:
>
> gzip01 gzip_tests.hs -> gzip01 exit 32
Not working.
the second argument is expected to be a file.

gzip01 gzip_tests.hs -> gzip01 skip.sh
should work.
We have to create skip.sh inside ltp
skip.sh contains single line exit 32

Which is the right place holder to host skip.sh ?

>
> Something like this should mark the gzip01 as TCONF in test results,
> would that suffice for your purpose?
>
> This should be as easy as changing the sed command from delete to
> replace in the runltp script.


OTOH,
I have noticed one more problem with sed with updated script.


Issues:
1. Want to skip only "testcase" write inside skipfile and run ./ltp-skip.sh

 testcase is replaced by testcase skip.sh ( = TCONF ) which is expected.
 testcase_64 is replaced by testcase skip.sh which is incorrect testcase name
 testcase_16 is replaced by testcase skip.sh which is incorrect testcase name
 testcase_xxxx is replaced by testcase skip.sh which is incorrect testcase name

diff -Narub alltests.org  alltests
--- alltests.org 2017-12-07 22:41:46.373419820 +0530
+++ alltests 2017-12-07 23:54:53.188657734 +0530
@@ -272,8 +272,8 @@
 fcntl33_64 fcntl33_64
 fcntl34 fcntl34
 fcntl34_64 fcntl34_64
-fcntl35 fcntl35
-fcntl35_64 fcntl35_64
+fcntl35 skip.sh
+fcntl35 skip.sh
 fcntl36 fcntl36
 fcntl36_64 fcntl36_64


2. The skipfile have limitation of
testcase_name should be a single word in SKIPFILE

Feature is
We can added comments inside SKIPFILE starting with #
The script will  ignore line starting with #


From c3e77bbaf03e126de15524f817960740a8c94e1b Mon Sep 17 00:00:00 2001
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Dec 2017 23:14:44 +0530
Subject: [PATCH] runltp: SKIPFILE: skip test cases should be visible as TCONF
 in results

When we skip tests in LTP using "./runltp -S SKIPFILE", they get removed
from the test list completely, leaving no trace in the results.

This patch will add SKIPFILE listed test cases names to results as TCONF
testcase_name -> testcase_name skip.sh

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 runltp | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/runltp b/runltp
index 8e40d67..f206fe1 100755
--- a/runltp
+++ b/runltp
@@ -692,11 +692,13 @@ main()
     fi

     # Blacklist or skip tests if a SKIPFILE was specified with -S
-    if [ -n "$SKIPFILE" ]
-    then
-        for file in $( cat $SKIPFILE ); do
-            sed -i "/^$file[ \t]/d" ${TMP}/alltests
-        done
+    if [ -n "${SKIPFILE}" ]; then
+        while read -r test_name; do
+            case "${test_name}" in \#*) continue ;; esac
+            if [ ${test_name} ]; then
+                sed -i "/${test_name}/c\\${test_name} skip.sh" alltests
+            fi
+        done < ${SKIPFILE}
     fi

     # check for required users and groups
-- 
2.7.4

- Naresh

>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
