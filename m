From: Qais Yousef <qais.yousef@arm.com>
Date: Thu, 16 Jul 2020 10:33:17 +0100
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
In-Reply-To: <20200716060710.GA3812@dell5510>
References: <20200714152510.13470-1-qais.yousef@arm.com>
 <20200716060710.GA3812@dell5510>
Message-ID: <20200716093316.re67arcm3tbxtwas@e107158-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


On 07/16/20 08:07, Petr Vorel wrote:
> Hi Qais,
> 
> thanks for your patch.

Thanks for having a look.

> BTW this has already been reviewed and tested by Huacai Chen [1].
> LGTM, although I'd prefer to detect with with polling, isn't it possible? [1].

FWIW I did try to avoid the sleep [1].

Were you thinking of something like that (pseudo code)?

	for i in $(seq 3)
	do
		sleep 1
		verify()
		if [ sucess ]; then
			break;
		fi
	done

Or you had something more sophisticated in mind?

Thanks

--
Qais Yousef

[1] https://lore.kernel.org/lkml/20200407133520.GI162390@mtj.duckdns.org/
