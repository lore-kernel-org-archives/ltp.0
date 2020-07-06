From: Harish <harish@linux.ibm.com>
Date: Mon, 6 Jul 2020 14:51:15 +0530
Subject: [LTP] [PATCH V4 5/6] syscalls: Don't pass struct timespec to
 tst_syscall()
In-Reply-To: <CAEemH2eSer9ewwSqfs5SA491veL1sy7Xhktkoi6gOT+r3uDQtg@mail.gmail.com>
References: <c47220ecab3c7570f5387cd71894c977009ad3d8.1590572545.git.viresh.kumar@linaro.org>
 <9562fdf4debd759439ee7f468008177003db9513.1592457867.git.viresh.kumar@linaro.org>
 <CAEemH2cu_o2eCHQB1_Bo0aQiR2WK6knbBtD83-5_77gZZbA-Ow@mail.gmail.com>
 <20200703125927.GA11556@yuki.lan>
 <CAEemH2cN735haDmyqbNa_LwDgumFqAspYfJaKRpsOg0Rij9tEA@mail.gmail.com>
 <1513894e-d23e-055e-df27-d8cf36b8c609@linux.ibm.com>
 <CAEemH2eSer9ewwSqfs5SA491veL1sy7Xhktkoi6gOT+r3uDQtg@mail.gmail.com>
Message-ID: <8a9a0eb5-0ef1-6140-0dd3-93fe6f5d8910@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/6/20 2:27 PM, Li Wang wrote:
>
> Harish <harish@linux.ibm.com <mailto:harish@linux.ibm.com>> wrote:
>
>     Hi,
>
>     I tried the suggested patch, but was unsuccessful in running the
>     test. Here is my diff.
>     ...
>     Is there anything I am missing here? Thanks in advance.
>
> Your diff version looks correct.
>
> I doubt have you rebuild your LTP or at least rebuild the ltp-lib?
My bad, I did rebuild the ltp with the diff. But it required a clean 
before I do so.
I can confirm tests are running now.

Thanks.
>
> -- 
> Regards,
> Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200706/cb163167/attachment.htm>
