From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Jan 2019 15:51:52 +0100
Subject: [LTP] [PATCH] lib/tst_net.sh: fix tst_set_sysctl() for
	non-netns setup
In-Reply-To: <1547038660-14008-1-git-send-email-alexey.kodanev@oracle.com>
References: <1547038660-14008-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20190110145152.GA10602@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

..
thanks for your fix. I pushed it with minor change (was not needed, but made
code more readable, I should have done it in original commit).

>  	local rparam=
> -	[ "$TST_USE_NETNS" = "yes" ] && rparam="-e"
> +	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r -e"
    [ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"


Kind regards,
Petr
