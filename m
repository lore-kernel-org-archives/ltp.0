From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 13:27:41 +0100
Subject: [LTP] [PATCH 3/3] netstress: randomize payload length
In-Reply-To: <1507813427-3737-3-git-send-email-alexey.kodanev@oracle.com>
References: <1507813427-3737-1-git-send-email-alexey.kodanev@oracle.com>
 <1507813427-3737-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20171031122741.spiobpt5ttmtmsii@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Not default, needs '-A x' option, where x is the upper limit
> of the random payload.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
<snip>

> +	if (tst_parse_int(Aarg, &max_rand_msg_len, 10, max_msg_len))
> +		tst_brk(TBROK, "Invalid max randome payload size '%s'", Aarg);
                                          ^ typo?

Otherwise looks good to me.


Kind regards,
Petr
