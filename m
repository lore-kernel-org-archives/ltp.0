From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Nov 2018 08:00:37 +0100
Subject: [LTP] [PATCH] commands/logrotate_tests.sh: Fix two issues
In-Reply-To: <1542886783-30763-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1542886783-30763-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181128070037.GA30353@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> 1) Pass correct arguments when calling tst_res command in logrotate_tests.sh
> 2) If syslog group doesn't exist on system, su option with it triggers a
>    an 'unknow group' error in config file and then skips the config file.
>    e.g.  Running logrotate_sh gets either of the following errors, because
>    logrotate command with above error returns non-zero exit status since
>    commit e547b94 in logrotate:
>    ---------------------------------------------------------
>    logrotate01    1  TFAIL  :  ltpapicmd.c:154: Test #1: logrotate command failed. Reason:
>    ...
>    logrotate01    1  TFAIL  :  ltpapicmd.c:154: Test #1: logrotate command exited with 1 return code. Output:
>    ---------------------------------------------------------
>    We just use syslog group if it actually exists.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  testcases/commands/logrotate/logrotate_tests.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

thanks for your commit, pushed with some changes (I split commit into 2,
adjusted commit message, simplify variable name and reverse check logic to not
repeat group name).

Kind regards,
Petr
