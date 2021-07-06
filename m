From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue, 6 Jul 2021 10:22:47 -0300
Subject: [LTP] [PATCH v3 3/3] syscalls/shmget*: Convert into new api
In-Reply-To: <98a17ec4-3697-d5ba-583b-ce539782f18c@canonical.com>
References: <YNM4rlDJLzb4xk6v@yuki>
 <1624512827-3256-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1624512827-3256-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YNnlIVB9M4/11JmT@yuki>
 <98a17ec4-3697-d5ba-583b-ce539782f18c@canonical.com>
Message-ID: <YORZJ5vIMabVG0yG@mussarela>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 05, 2021 at 12:03:33PM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2021 17:05, Cyril Hrubis wrote:
> > Hi!
> > Pushed with a minor changes, thanks.
> > 
> 
> It looks like this commit not only converted into new API but also
> changed the test. We started noticing shmget02 and shmget03 test
> failures on several systems.
> 
> https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1934432
> 
> Reverting the commit helps and tests pass.
> 
> Since it is one big patch doing multiple things at the same time, it is
> difficult to bisect it more and find the cause.  Any ideas what went
> different here comparing to previous version of these tests?
> 

New tests were added, like testing for EPERM when using SHM_HUGETLB.
However, it does not fail with EPERM with there is sufficient
RLIMIT_MEMLOCK. I have just sent a fix for that.

Cascardo.

> 
> Best regards,
> Krzysztof
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
