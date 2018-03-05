From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Mar 2018 09:09:42 +0100
Subject: [LTP] Errored: linux-test-project/ltp#681 (master - 6f407c7)
In-Reply-To: <5a997738f383c_43fd27ec5bf1c1744084@aecc662a-23f7-4696-957c-b2387f5c3876.mail>
References: <linux-test-project/ltp+348283888+errored@travis-ci.org>
 <5a997738f383c_43fd27ec5bf1c1744084@aecc662a-23f7-4696-957c-b2387f5c3876.mail>
Message-ID: <20180305080942.lsel4ezjsi2gndxg@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> Build Update for linux-test-project/ltp
> -------------------------------------

> Build: #681
> Status: Errored

> Duration: 14 minutes and 53 seconds
> Commit: 6f407c7 (master)
> Author: Cyril Hrubis
> Message: syscalls/inotify04: Fix & Cleanups.

> * Move file/directory creation from setup to
>   the test fuction, we remove these in the test
>   fucntion hence we have to create them on each
>   iteration as well for the -i option

> * Get rid of TST_TOTAL, use test_cnt instead
>   as a side effect this fixes the -i option

> * Make use of SAFE_MACROS() in cleanup

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

> View the changeset: https://github.com/linux-test-project/ltp/compare/22d43a959bb7...6f407c76286c

> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/348283888?utm_source=email&utm_medium=notification

False positive, again.
I'll try to use workaround from [1]
apt-get update --option Acquire::Retries=100 --option Acquire::http::Timeout="60"


Kind regards,
Petr

[1] https://github.com/travis-ci/travis-ci/issues/9112
