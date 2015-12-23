From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Dec 2015 11:32:54 +0800
Subject: [LTP] [PATCH] ftrace_stress_test.sh: remove the tracing_enabled
	file tests
In-Reply-To: <1392836130.1371816.1450839868721.JavaMail.zimbra@redhat.com>
References: <1450784730-43354-1-git-send-email-chuhu@redhat.com>
 <1450795306.3105.102.camel@fedora>
 <1392836130.1371816.1450839868721.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2dTCFSOuW4suJohxzUogckJMUDpuMrQruD_qciH4zDBjw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


> > -
> > > -   for ((i = 0; i < $MAX_LOOP; i++))
> > > -   {
> > > -           echo 0 > "$TRACING_PATH"/tracing_enabled
> > > -           echo 1 > "$TRACING_PATH"/tracing_enabled
> >
> > Maybe we should keep this file but switch it to "tracing_on"?
> >
> > -- Steve
>
> Thanks for kind review the patch. As the case was created in 2010 when the
> two files exit together.There is another case for testing tracing_on :
> ftrace_tracing_on.sh.
>
> I think we need some checker to check whether tracing_on, tracing_enabled
> or other trace files are there, And then decide which sub stress scripts to
> run. And for some new trace file without test code,I'm also considering add
> some new stress script for them.
>

Sounds good, feel free to format patch adding them.

To make the progress extendable, we could also take consider that
reorganize the stress test to ftrace general test, then adding some
function or regression testcases.

something like:
---------
tracing
- ftrace_test
   - ftrace_lib.sh
   - ftrace_function_test.sh
   - ftrace_stress_test.sh
   - ftrace_regression_test.sh
   - frace testcase directory...
   - Makefile


Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151223/a54187dc/attachment.html>
