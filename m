From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Aug 2021 12:46:05 +0200
Subject: [LTP] [PATCH 3/3] network/tst_net.sh: extend the pattern in
 tst_ping_opt_unsupported()
In-Reply-To: <20210804120446.32835-3-aleksei.kodanev@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
 <20210804120446.32835-3-aleksei.kodanev@bell-sw.com>
Message-ID: <YR+H7ar8cYin8mHe@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> -	ping $@ 2>&1 | grep -q "invalid option"
> +	ping $@ 2>&1 | grep -qE "(invalid|unrecognized) option"

Which implementation needs it? Both ping from iputils and busybox report
"invalid option".

Kind regards,
Petr
