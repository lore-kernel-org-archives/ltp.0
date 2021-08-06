From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Aug 2021 09:48:44 +0200
Subject: [LTP] [PATCH v1] connectors/cn_pec: improve reliability
In-Reply-To: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
References: <20210805140806.3884-1-bogdan.lezhepekov@suse.com>
Message-ID: <YQzpXHDvFmoaSFhi@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Bogdan, Joerg,
> Sometimes pec_listener has not enough time to handle all
> the generated events.

> This patch only returns back the delay that was removed
> in a recent patch.

> Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
> ---
>  testcases/kernel/connectors/pec/cn_pec.sh | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
> index 9b85a5c81..24b1db761 100755
> --- a/testcases/kernel/connectors/pec/cn_pec.sh
> +++ b/testcases/kernel/connectors/pec/cn_pec.sh
> @@ -77,6 +77,8 @@ test()
>  	tst_sleep 100ms

>  	ROD event_generator -n $num_events -e $event \>gen_$event.log 2\>gen_$event.err
> +    # sleep until pec_listener has seen and handled all of the generated events
> +    tst_sleep 100ms
nit: mixing tabs and spaces (script uses tabs), can be fixed during merge.

If I understand the code correctly, pec_listener keeps receiving msg from PEC
until got signaled by kill. We generally try to avoid sleep in tests [1].

@Joerg: I'm not sure if it's reasonable to add another signal handler in which
pec_listener would print number of already handled requests (with write() as
printf() is not reentrant). Then we could loop for certain time before sending INT.

Kind regards,
Petr

[1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

>  	kill -s INT $pid 2> /dev/null
>  	wait $pid
