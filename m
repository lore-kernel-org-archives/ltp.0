From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Jul 2020 17:35:01 +0200
Subject: [LTP] [PATCH V7 17/19] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <f0df00dd69cf02791a99883db1fd6fd7a1462074.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <f0df00dd69cf02791a99883db1fd6fd7a1462074.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200727153501.GD7863@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This gets rid of the test script and updates the utimensat01.c file to
> handle most of the tests covered earlier (apart from testing the same
> for files owned by root, as the test is run as root right now).

We also lost a check if atime and mtime was modified or not.

The original script did set both to 0 and then depending on what have
been passed as the times and if the call succeeded checked if the value
stayed zero or was modified. Can we add this back as well?

Also the modification for the makefile and runtest file is part of the
patch that adds the time64 variant while it should have been part of
this patch.

Other than this there are a few minor things, for instance I do not see
the reason for double indirection in the struct mytime. And I would have
done some of the initialization in the test setup, e.g. why do we call
update_error(), re-create TEST_DIR, etc. on each run.

-- 
Cyril Hrubis
chrubis@suse.cz
