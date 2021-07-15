From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 13:58:05 +0200
Subject: [LTP] [PATCH 0/2] Add TST_NET_IPV{4,
 6}_ONLY and use on broken_ip
In-Reply-To: <77583f09-e378-c39e-8ca2-6bf77adbda52@bell-sw.com>
References: <20210714140716.1568-1-pvorel@suse.cz>
 <77583f09-e378-c39e-8ca2-6bf77adbda52@bell-sw.com>
Message-ID: <YPAizWCKXQHQOSBv@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 14.07.2021 17:07, Petr Vorel wrote:
> > Hi Alexey,

> > https://github.com/linux-test-project/ltp/issues/843

> > does it make sense to run it on IPv4 and broken_ip-totlen on IPv6?
> > Both don't break but not in runtest file.

> Hi Petr,

> Yes it should work with the -L option, but these tests are the same
> (differs the descriptions for IPv4/IPv6):

> diff -u broken_ip-plen broken_ip-totlen
> --- broken_ip-plen	2020-10-08 22:23:52.000000000 +0300
> +++ broken_ip-totlen	2020-10-08 22:23:52.000000000 +0300
> @@ -10,7 +10,7 @@

>  do_test()
>  {
> -	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong payload len for $NS_DURATION sec"
> +	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong total len field for $NS_DURATION sec"
>  	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $NS_ICMP_SENDER_DATA_MAXSIZE" -L
>  	tst_ping
>  }

Good catch, thanks!

> So broken_ip-totlen should be just removed.
I merged commit which implements this.

Kind regards,
Petr
