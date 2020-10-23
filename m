From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Oct 2020 10:09:58 +0800
Subject: [LTP] [PATCH v2] Remove ftime and sys/timeb.h
In-Reply-To: <1603352029-11446-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5F913024.7050303@cn.fujitsu.com>
 <1603352029-11446-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2enndeLbZ8Kr8EgVEc1OF7znrtB4vJwpacpBxyTY7YdGA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> The two case uses ftime to get the current milliseconds and it was
> used to generate random value. Using gettimeofday() to get the microseconds
> can reach the same aim.
>
> This also fixes the travis build error[1] on Fedora:Rawhide because the <sys/timeb.h>
> has been deprecated[2].
>
> [1] https://travis-ci.org/github/linux-test-project/ltp/jobs/737698948
> [2] https://www.spinics.net/lists/fedora-devel/msg279545.html
>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Acked-by: Jan Stancek <jstancek@redhat.com>
> Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

Pushed, thanks!

-- 
Regards,
Li Wang

