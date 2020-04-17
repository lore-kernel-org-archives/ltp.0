From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Apr 2020 18:50:58 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <CAEemH2eMVJE0=LwgRVihjTXCm_LYqTHSb4ehPKWzXV_Siou0uA@mail.gmail.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2fUpkmU86d3M8LAL13x-vsC96ce8QdyjGacqy9m4_bD4g@mail.gmail.com>
 <e6dc08b9-bcce-51af-e64d-00b02fc459a3@cn.fujitsu.com>
 <CAEemH2eMVJE0=LwgRVihjTXCm_LYqTHSb4ehPKWzXV_Siou0uA@mail.gmail.com>
Message-ID: <CAEemH2eVn8BHXaR5bJMjRZy1xOnbNAEMxX2QR2DK=wOAts800w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 17, 2020 at 6:13 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Fri, Apr 17, 2020 at 5:56 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> wrote:
>
>> Hi Li
>>
>> > Hi Xu,
>> >
>> > I feel confused that is this test duplicated with the one Lanie's
>> > patch2/2? why using the same test name?
>> My pipe2_03.c is to test O_DIRECT flag, Lanie's patch is to test
>> O_NONBLOCK flag as my perivous email said, see[1].
>>
>> I don't think it is a problem(I need to generate patch-set, so named
>> pipe2_03.c is better).
>>
>
> But that will cause git patch confiliction becasue same file name, isn't
> it?
> I'm going to apply Lanie's two patches(modified on the git.v3), and once
> it done, your patch will broken on git confiliction.
>
>
One feasible way is that I help to rename  Lanie's pipe2_03.c to pipe2_04.c
and apply the patches first, then you do rebase your codes on the
latest commit. Is that OK for you?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200417/919bae77/attachment.htm>
