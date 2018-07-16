From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 16 Jul 2018 17:20:01 +0100
Subject: [LTP] [PATCH 0/4] Add dependency checking
In-Reply-To: <769723769.33318962.1531756364899.JavaMail.zimbra@redhat.com>
 (Jan Stancek's message of "Mon, 16 Jul 2018 11:52:44 -0400")
References: <20180711122925.24278-1-punit.agrawal@arm.com>
 <769723769.33318962.1531756364899.JavaMail.zimbra@redhat.com>
Message-ID: <87lgabm9u6.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> writes:

> ----- Original Message -----
>> Hi,
>> 
>> While investigating failures from nightly runs, I came across some
>> tests that don't explicitly check for dependencies.
>> 
>> Add appropriate check for dependencies so the tests are reported as an
>> issue with the configuration rather than a test failure. These set of
>> patches transitions ~50-60 tests from reporting failures to a
>> configuration issue.
>> 
>> Thanks,
>> Punit
>> 
>
> Hi,
>
> Pushed with the exception of patch 2.

Thanks for merging the patches.

> Switching quota_remount_test01.sh away from apicmds will
> likely need more changes, e.g. it should use at least 
> tst_exit().
>
> If we take the effort to port this test to shell library,
> it should be "tst_test.h" one.
>
> If you're up to rewriting test for tst_test.h, that would
> be preffered. Otherwise, I rather use some shell check
> and avoid including "test.h" for the sole purpose of having
> tst_check_cmds.

Ok, makes sense to use a shell check. I'll send an updated patch.

I won't be able to get to rewriting the test anytime soon but I'd really
like to eliminate the false positives on the nightly runs so we can
start paying attention to the real failures on new development.

Regards,
Punit
