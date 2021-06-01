From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jun 2021 12:09:09 +0200
Subject: [LTP] [PATCH v3] network/lib6/getaddrinfo01: rewrite with the
 new API + use static hostnames
In-Reply-To: <20210601094807.77790-1-aleksei.kodanev@bell-sw.com>
References: <20210601094807.77790-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YLYHRQYBwKz+JTlU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The test is now independent of various machine settings
> regarding the test host name as it adds predefined names
> and aliases to /etc/hosts file and restores it to its
> original state after completing the test.

> This should fix the following failures:
> * when gethostname() returns an alias name that doesn't
>   match canonical name;
> * No AAAA record for the returned name from gethostname().

> Addresses and names added to /etc/hosts are more or less
> unique, so that there are no conflicts with the existing
> configuration.

> Also most of the duplicate code is now gone.
...
> -	tst_resm(TPASS, "getaddrinfo IPv6 SOCK_STREAM/IPPROTO_UDP hints");
> +	if (access(host_file, W_OK))
I guess we don't have to bother with R_OK|W_OK (required R_OK for SAFE_CP()),
as no sane system would have disabled read permission on hosts file.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Kind regards,
Petr
