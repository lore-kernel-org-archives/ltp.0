From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jul 2018 11:52:44 -0400 (EDT)
Subject: [LTP] [PATCH 0/4] Add dependency checking
In-Reply-To: <20180711122925.24278-1-punit.agrawal@arm.com>
References: <20180711122925.24278-1-punit.agrawal@arm.com>
Message-ID: <769723769.33318962.1531756364899.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi,
> 
> While investigating failures from nightly runs, I came across some
> tests that don't explicitly check for dependencies.
> 
> Add appropriate check for dependencies so the tests are reported as an
> issue with the configuration rather than a test failure. These set of
> patches transitions ~50-60 tests from reporting failures to a
> configuration issue.
> 
> Thanks,
> Punit
> 

Hi,

Pushed with the exception of patch 2.

Switching quota_remount_test01.sh away from apicmds will
likely need more changes, e.g. it should use at least 
tst_exit().

If we take the effort to port this test to shell library,
it should be "tst_test.h" one.

If you're up to rewriting test for tst_test.h, that would
be preffered. Otherwise, I rather use some shell check
and avoid including "test.h" for the sole purpose of having
tst_check_cmds.

Regards,
Jan
