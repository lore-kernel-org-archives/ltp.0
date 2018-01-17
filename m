From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Jan 2018 10:03:19 -0500 (EST)
Subject: [LTP] [PATCH] tst_test: Fix exit value on tst_brk(TCONF, ...)
In-Reply-To: <20180117145846.21303-1-chrubis@suse.cz>
References: <20180117145846.21303-1-chrubis@suse.cz>
Message-ID: <83504737.1024347.1516201399150.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> We decided not to propagate TCONF into the test exit value in a case
> that the test had at least one TPASS in:
> 
> commit 5390d6ea36578c1fac8adc416b6f91aa4a330a08
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Thu Sep 7 15:47:22 2017 +0200
> 
>     lib/tst_test: Report 0 if test has both TPASS and TCONF
> 
> However this commit missed a case when TCONF is passed directly to the
> do_exit() function. This may happen in two cases actually, one of the is
> tst_brk(TCONF, ...) called from a test and second one is more subtle and
> happens when the last result in the run_tcases_per_fs() produces TCONF
> which is then propagated to the do_exit() function.
> 
> This commit simply mask the TCONF from the exit value in this cases if
> we happen to have non-zero success counter.

Makes sense to me, ACK.

Regards,
Jan
