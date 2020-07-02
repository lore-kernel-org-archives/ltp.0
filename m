From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jul 2020 11:12:29 +0800
Subject: [LTP] [PATCH 1/1] numa01.sh: Handle computation error
In-Reply-To: <20200701233133.122801-1-petr.vorel@gmail.com>
References: <20200701233133.122801-1-petr.vorel@gmail.com>
Message-ID: <CAEemH2d7RxH+33nMGsPYTpKUUy-T+Nfw_uAO2OJFTYLUiWkE-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 2, 2020 at 7:31 AM Petr Vorel <petr.vorel@gmail.com> wrote:

> when numastat -p did not give a value, the resulting bc calculation was
> empty string instead of 0, thus shell -eq comparison lacked the first
> operator:
>
> Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
> if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
>
> (standard_in) 1: syntax error
> (standard_in) 1: syntax error
> /root/ltp-install/testcases/bin/numa01.sh: line 93: [: -eq: unary operator
> expected
>
> Also fix style (use local and lowercase local function variables).
>
> Fixes: 702
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
> Hi,
>
> Simple fix for https://github.com/linux-test-project/ltp/issues/702,
> I guess there should be more checks. Not tested.
> BTW I thought numa01.sh was intended to be replaced with C (@Cyril: am I
> correct?), thus I didn't bother to split syntax fix into 2 commits.
>

I think yes, I remember the syscalls/set_mempolicy* is going to replace
numa.sh tests.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200702/a3a7c2cb/attachment-0001.htm>
