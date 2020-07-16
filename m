From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 16 Jul 2020 08:07:10 +0200
Subject: [LTP] [PATCH] cpuset_hotplug_test.sh: Fix a race condition
In-Reply-To: <20200714152510.13470-1-qais.yousef@arm.com>
References: <20200714152510.13470-1-qais.yousef@arm.com>
Message-ID: <20200716060710.GA3812@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Qais,

thanks for your patch.
BTW this has already been reviewed and tested by Huacai Chen [1].
LGTM, although I'd prefer to detect with with polling, isn't it possible? [1].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/pull/706#issuecomment-658492329
[2] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
