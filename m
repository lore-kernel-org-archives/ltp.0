From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 21:15:25 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <20210518091422.41857-1-aleksei.kodanev@bell-sw.com>
References: <20210518091422.41857-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YKQSTR1wkB/U81Em@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> +static void setup(void)
> +{
> +	unsigned int i;
> +	int fd;
...
> +	SAFE_CP(host_file, "hosts");
One more thing, could we check for /etc/hosts before?
Because we want to TCONF on systems without it not TBROK.
And I guess there are embedded systems without it out there.

Kind regards,
Petr
