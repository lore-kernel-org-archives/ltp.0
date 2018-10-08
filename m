From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Oct 2018 12:07:22 +0200
Subject: [LTP] [PATCH] netns_helper.sh: use 'ping -6' when ping6 is not
 avaliable
In-Reply-To: <1535514684-26111-1-git-send-email-Lei.Yang@windriver.com>
References: <1535514684-26111-1-git-send-email-Lei.Yang@windriver.com>
Message-ID: <20181008100722.GA15472@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lei,

> ping6 has been merged into ping since 2015 by using "ping -6"
> in some distrubiton like open embeded, they droped ping6 completely
> this patch will let both "ping -6" and ping6 work

> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  testcases/kernel/containers/netns/netns_helper.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
...
> -		tping="ping6"; NETMASK=64
> +		if which ping6 >/dev/null 2>&1; then
> +		    tping="ping6" 
> +		else
> +		    tping="ping -6"
> +		fi
> +		NETMASK=64

I decided to push this patch. I plan to create alias in tst_net.sh, but
netns_helper.sh doesn't use it (and use still legacy shell API),
so your patch uses the best approach.

Thanks for your patch!

Kind regards,
Petr
