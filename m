From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Dec 2017 14:34:59 +0100
Subject: [LTP] [RFC] Showing skipped tests in results?
In-Reply-To: <CA+G9fYtUa69MaYSsRTpZHKYX1UJZ2p3ZqKWvwvur7-HdaHhviA@mail.gmail.com>
References: <20171205221105.yobl5c4brhpu5tdo@xps> <20171206105233.GD13979@rei>
 <CA+G9fYtUa69MaYSsRTpZHKYX1UJZ2p3ZqKWvwvur7-HdaHhviA@mail.gmail.com>
Message-ID: <20171208133459.GA2554@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think that you misunderstand how things works, the first string on
> > each line in the alltests file that is parsed by ltp-pan is just test
> > name that appears in the test result file, it does not affect anything
> > but that.
> >
> > I guess that the easiest solution would be replacing the actuall command
> > that is supposed to be executed with something that just reports
> > skipped status.
> >
> > Quick hack would be replacing these with something that just returns the
> > right exit value:
> >
> > gzip01 gzip_tests.hs -> gzip01 exit 32
> Not working.
> the second argument is expected to be a file.

Not a true, I've looked to the ltp-pan.c and it does crude heuristic
that decides if the second part of the line is supposed to be binary
name or a shell script, if it finds any shell redirection characters or
semicolon then it's executed as a script.

> gzip01 gzip_tests.hs -> gzip01 skip.sh
> should work.
> We have to create skip.sh inside ltp
> skip.sh contains single line exit 32

gzip01 foo -> gzip01 exit 32;

That one actually works.

> OTOH,
> I have noticed one more problem with sed with updated script.
> 
> 
> Issues:
> 1. Want to skip only "testcase" write inside skipfile and run ./ltp-skip.sh

Which script are you referring to? There is no ltp-skip.sh in LTP source
code tree.

>  testcase is replaced by testcase skip.sh ( = TCONF ) which is expected.
>  testcase_64 is replaced by testcase skip.sh which is incorrect testcase name
>  testcase_16 is replaced by testcase skip.sh which is incorrect testcase name
>  testcase_xxxx is replaced by testcase skip.sh which is incorrect testcase name
> 
> diff -Narub alltests.org  alltests
> --- alltests.org 2017-12-07 22:41:46.373419820 +0530
> +++ alltests 2017-12-07 23:54:53.188657734 +0530
> @@ -272,8 +272,8 @@
>  fcntl33_64 fcntl33_64
>  fcntl34 fcntl34
>  fcntl34_64 fcntl34_64
> -fcntl35 fcntl35
> -fcntl35_64 fcntl35_64
> +fcntl35 skip.sh
> +fcntl35 skip.sh
>  fcntl36 fcntl36
>  fcntl36_64 fcntl36_64

That is beacuse you have broken the mathing pattern in your patch, the
original one that just deleted the line matched whitespace after the
name.

> 2. The skipfile have limitation of
> testcase_name should be a single word in SKIPFILE
> 
> Feature is
> We can added comments inside SKIPFILE starting with #
> The script will  ignore line starting with #

I'm okay with adding comments to skipfile.

> From c3e77bbaf03e126de15524f817960740a8c94e1b Mon Sep 17 00:00:00 2001
> From: Naresh Kamboju <naresh.kamboju@linaro.org>
> Date: Thu, 7 Dec 2017 23:14:44 +0530
> Subject: [PATCH] runltp: SKIPFILE: skip test cases should be visible as TCONF
>  in results
> 
> When we skip tests in LTP using "./runltp -S SKIPFILE", they get removed
> from the test list completely, leaving no trace in the results.
> 
> This patch will add SKIPFILE listed test cases names to results as TCONF
> testcase_name -> testcase_name skip.sh
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> ---
>  runltp | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/runltp b/runltp
> index 8e40d67..f206fe1 100755
> --- a/runltp
> +++ b/runltp
> @@ -692,11 +692,13 @@ main()
>      fi
> 
>      # Blacklist or skip tests if a SKIPFILE was specified with -S
> -    if [ -n "$SKIPFILE" ]
> -    then
> -        for file in $( cat $SKIPFILE ); do
> -            sed -i "/^$file[ \t]/d" ${TMP}/alltests
> -        done
> +    if [ -n "${SKIPFILE}" ]; then
> +        while read -r test_name; do
> +            case "${test_name}" in \#*) continue ;; esac
> +            if [ ${test_name} ]; then
> +                sed -i "/${test_name}/c\\${test_name} skip.sh" alltests
> +            fi
> +        done < ${SKIPFILE}

Apart from the broken sed matching regular expression and the skip.sh
that can be replaced with 'exit 32;' this looks reasonably good.

-- 
Cyril Hrubis
chrubis@suse.cz
