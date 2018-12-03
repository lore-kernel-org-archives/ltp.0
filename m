From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Dec 2018 13:47:09 +0100
Subject: [LTP] [PATCH v2] fzsync: limit sampling time
In-Reply-To: <3557fc1c46246a58e69ed0c5bbd39458410472a4.1543655165.git.jstancek@redhat.com>
References: <c49a5628139703513cb66d84d03953ddb5cc1560.1543489660.git.jstancek@redhat.com>
 <3557fc1c46246a58e69ed0c5bbd39458410472a4.1543655165.git.jstancek@redhat.com>
Message-ID: <20181203124709.GB29929@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sampling can take considerably longer time on single CPU
> and very slow systems. This patch limits sampling time to
> 1/2 of fuzzing runtime (0.25 of test time). If we don't
> have enough samples by that time, stop sampling and use
> stats we gathered so far.

I do wonder if it would be better to really base the proportional
sampling time based on the actual test runtime (i.e. hardcoding it to be
exec_time_p/2) because that would mean we would have to tune only one
paramter when adjusting the test runtime. But I guess only a few tests
will adjust the test runtime anyway.

-- 
Cyril Hrubis
chrubis@suse.cz
