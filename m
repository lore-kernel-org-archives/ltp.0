From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 7 Apr 2017 14:04:43 +0300
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <20170406155005.smxqad2aqkcwecmz@dell5510>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
 <20170406155005.smxqad2aqkcwecmz@dell5510>
Message-ID: <7ec9883c-7b9a-42ff-b49f-a5732d59a9fb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06.04.2017 18:50, Petr Vorel wrote:
> ...
>> Given that the number of such tests are really small (stress/route,
>> stress/multicast) and they don't source test_net.sh (only through
>> network.sh), may be it is time to get rid of these variables inside
>> test_net.sh and use just one, for reverse addresses as well?
> testcases/network/stress/dns/dns-stress sources test_net.sh. I suppose we can
> "fix it" by removing test_net.sh and setting necessary variables directly in
> the script like other scripts do (e.g.
> testcases/network/stress/route/route6-change-dst).
> I agree that this would simplify things greatly (tst_net_vars.c would be much
> smaller and use mainly glibc network related functions), but on the other hand I
> wanted all network tests using test_net.sh. I don't like the idea that part of
> the tests which are using the same variables, but their values are hardwired
> into the script.

And if we convert them to use test_net.sh and add missing interfaces
like the ones
needed for dns-stress tests, i.e. tst_ip_reverse(), etc., there would be
no need to
use them directly in the tests.

Actually, we can still update tst_ipaddr() to use IP_HOSTs variables
without adding
together two variables :)

I guess subnet mask should be set as a separate variable, similar to
stress/multicast
tests (to support these tests), and if not provided, we can get it with
getifaddr(), or at
least set to predefined default value, for IPv6 it is almost always /64.

Thanks,
Alexey

