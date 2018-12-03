From: Li Wang <liwan@redhat.com>
Date: Mon, 3 Dec 2018 16:58:45 +0800
Subject: [LTP] [PATCH v2] fzsync: limit sampling time
In-Reply-To: <3557fc1c46246a58e69ed0c5bbd39458410472a4.1543655165.git.jstancek@redhat.com>
References: <c49a5628139703513cb66d84d03953ddb5cc1560.1543489660.git.jstancek@redhat.com>
 <3557fc1c46246a58e69ed0c5bbd39458410472a4.1543655165.git.jstancek@redhat.com>
Message-ID: <CAEemH2ey40AZ8gsCm6vt09SQEJduBW0XrhdQnu0M=CLWrREh1A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Dec 1, 2018 at 5:12 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> Fixes: #429
>
> Sampling can take considerably longer time on single CPU
> and very slow systems. This patch limits sampling time to
> 1/2 of fuzzing runtime (0.25 of test time). If we don't
> have enough samples by that time, stop sampling and use
> stats we gathered so far.

Patch v2 looks good to me, and I'd suggest to reserve more time before
pushing, in case Richard has some extra comments.

>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Li Wang <liwang@redhat.com>

--
Regards,
Li Wang
