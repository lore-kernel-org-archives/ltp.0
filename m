From: Li Wang <liwang@redhat.com>
Date: Tue, 25 Feb 2020 18:00:00 +0800
Subject: [LTP] [PATCH V3 00/10] Add new LTP tests related to fsmount
 family of syscalls
In-Reply-To: <cover.1582612624.git.viresh.kumar@linaro.org>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2dogCkDHtZzwWCx-ahg-CebGYLNyew6F2AkJVPC_yivBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

These new tests look good, only a few comments/questions below:

Patch 1/10:
1. The git summary should be updated too (someone who push patch can help
do that:).
2. Maybe better to replace the TWARN by TINFO? Since tst_is_mounted() as a
general function to check if mount success, sometimes we just need the
return status then do next work(I tend to leave the waring or break operate
to LTP users:).

Patch 5/10, 9/10:
May I ask why we use "sync" as the key value in fsconfig()? I ask this
because it can get rid of the errors we found in XFS test before.

Patch 9/10, 10/10:
I guess that'd be better if we put the 'ismounted = 1' at the behind of
tst_is_mounted(), do you feel the code sequence looks strange which we set
'ismounted' to 1 then do mount checking?

Ack for the whole patchset v3 (+ follow some modification for above
comments):
    Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200225/515a0f53/attachment.htm>
