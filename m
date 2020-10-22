From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Oct 2020 14:43:48 +0800
Subject: [LTP] [PATCH] Remove ftime and sys/timeb.h
In-Reply-To: <1603339033-8451-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1603339033-8451-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2ec2s0wJmCoNOYuMmnn6E1YJVQFid6EkVDoB8KpeC29kg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> The two case use ftime to get the current milliseconds and it was
> used to generate random value. Use gettimeofday() to get the microseconds
> can reach the same aim.
>
> This also fixes the travis build error[1] on Fedora:Rawhide because the <sys/timeb.h>
> has been deprecated[2].
>
> [1] https://travis-ci.org/github/linux-test-project/ltp/jobs/737698948
> [2] https://www.spinics.net/lists/fedora-devel/msg279545.html
>
> Reported-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Reviewed-by: Li Wang <liwang@redhat.com>

Travis CI Passed: https://travis-ci.org/github/wangli5665/ltp/builds/737927003

-- 
Regards,
Li Wang

