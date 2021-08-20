From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Aug 2021 14:29:23 +0200
Subject: [LTP] [PATCH 3/3] network/tst_net.sh: extend the pattern in
 tst_ping_opt_unsupported()
In-Reply-To: <682fbc24-5b58-aacf-a3cc-8648ea52be33@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
 <20210804120446.32835-3-aleksei.kodanev@bell-sw.com>
 <YR+H7ar8cYin8mHe@pevik>
 <682fbc24-5b58-aacf-a3cc-8648ea52be33@bell-sw.com>
Message-ID: <YR+gIw3PNm7osPsJ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,
> On 20.08.2021 13:46, Petr Vorel wrote:
> > Hi Alexey,

> >> -	ping $@ 2>&1 | grep -q "invalid option"
> >> +	ping $@ 2>&1 | grep -qE "(invalid|unrecognized) option"

> > Which implementation needs it? Both ping from iputils and busybox report
> > "invalid option".


> It's busybox/ping that is using musl libc getopt():
> misc/getopt.c:			__getopt_msg(argv[0], ": unrecognized option: ", optchar, k);

Ah, thx for info.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
