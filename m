From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 17 Apr 2020 17:56:38 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/pipe2_03: Add new test for pipe2
 O_DIRECT flag
In-Reply-To: <CAEemH2fUpkmU86d3M8LAL13x-vsC96ce8QdyjGacqy9m4_bD4g@mail.gmail.com>
References: <1586927503-10827-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1587022142-32122-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2fUpkmU86d3M8LAL13x-vsC96ce8QdyjGacqy9m4_bD4g@mail.gmail.com>
Message-ID: <e6dc08b9-bcce-51af-e64d-00b02fc459a3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li

> Hi Xu,
> 
> I feel confused that is this test duplicated with the one Lanie's 
> patch2/2? why using the same test name?
My pipe2_03.c is to test O_DIRECT flag, Lanie's patch is to test 
O_NONBLOCK flag as my perivous email said, see[1].

I don't think it is a problem(I need to generate patch-set, so named 
pipe2_03.c is better).

[1]http://lists.linux.it/pipermail/ltp/2020-April/016611.html

Best Regards
Yang Xu
> 
> -- 
> Regards,
> Li Wang


