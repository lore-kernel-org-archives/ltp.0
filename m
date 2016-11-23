From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 13:57:27 +0100
Subject: [LTP] [PATCH 1/3] ltp/numa: waiting for numastat refresh
In-Reply-To: <1479872202-29920-1-git-send-email-liwang@redhat.com>
References: <1479872202-29920-1-git-send-email-liwang@redhat.com>
Message-ID: <20161123125727.GF3346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +wait_for_update()
> +{
> +    NUMASTAT_PATH="/sys/devices/system/node/node$1/numastat"
> +    local loop=0
>  
> +    while [ $loop -lt 5 ]; do
> +        sum_value=0
> +
> +        for i in $(seq 200); do
> +            det_value=$(grep $2 ${NUMASTAT_PATH} | cut -d ' ' -f 2)
> +            sum_value=$((sum_value + det_value))

I do not understand this part, here you are summing the accumated value
over and over. That is not making any sense.

> +            sync && tst_sleep 10ms

Why the sync here?

> +        done
> +
> +        if [ $((sum_value/200)) -eq $det_value ]; then

Here as well. It's higly unlikely that the value would be exactly equal
since the number is increased by other things the system does as well.

> +            return
> +        fi
> +
> +        loop=$((loop+1))
> +    done
> +}

This seems like a good idea generally but what would I do is something
as:

* Read the statistic with some small sleep in between as you do
* Exit once the increase is at least the expected value
* Give up if there was no increase in some well defined time or
  if it generally took too much time, i.e. something as:

  if the last increase of the number was more than second ago -> fail
  (this could be done easily by counting time since the last increase
   and resetting it if there was some)

  if the number was increased steadily for more than ten seconds but
  hasn't reached at least the expected value -> fail

The timing constants may need to be tuned, but AFAIC this is the best we
can do in this tests.

-- 
Cyril Hrubis
chrubis@suse.cz
