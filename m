From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 May 2021 19:36:28 +0200
Subject: [LTP] [PATCH v2 1/1] netns_helper.sh: Replace ip version check
 with feature testing
In-Reply-To: <20210512150750.12152-1-pvorel@suse.cz>
References: <20210512150750.12152-1-pvorel@suse.cz>
Message-ID: <YJ1jnIa/mVOGVtQ4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>  netns_ip_setup()
>  {
> -	tst_check_iproute 111010
> +	ip netns || tst_brk TCONF "ip without netns support (required iproute2 >= ss111010 - v3.0.0)"
FYI merged as:
	ip netns > /dev/null || \
		tst_brk TCONF "ip without netns support (required iproute2 >= ss111010 - v3.0.0)"

(deliberately kept stderr redirection)

Kind regards,
Petr

