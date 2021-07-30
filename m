From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 30 Jul 2021 10:50:18 +0300
Subject: [LTP] [PATCH v2] ipsec_lib.sh: check ip_vti/ip6_vti are enabled
 or skip tests
In-Reply-To: <YQOlbyslKEiw9rCx@pevik>
References: <YQFWT/0MBcZsLNVV@pevik>
 <20210728140453.23356-1-radoslav.kolev@suse.com> <YQOlbyslKEiw9rCx@pevik>
Message-ID: <acd8f1e4-bdce-6cc1-b232-95f2a8a6e10b@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.07.2021 10:08, Petr Vorel wrote:
> Hi Radoslav,
> 
> ...
>> +	if [ "$TST_IPV6" ]; then
>> +                tst_net_run -q "tst_check_drivers ip6_vti" || \
>> +                        tst_brk TCONF "ip6_vti driver not available on lhost or rhost"
>> +        else
>> +                tst_net_run -q "tst_check_drivers ip_vti" || \
>> +                        tst_brk TCONF "ip_vti driver not available on lhost or rhost"
>> +        fi
> nit: broken indentation, but that'll be fix during merge.
> 
> LGTM, but I'm going to merge shorter version (we have $TST_IPV6 for this
> purpose).
> 
> tst_net_run -q "tst_check_drivers ip${TST_IPV6}_vti" || \
> 	tst_brk TCONF "ip${TST_IPV6}_vti driver not available on lhost or rhost"
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks Radoslav, Petr!

Reviewed-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
