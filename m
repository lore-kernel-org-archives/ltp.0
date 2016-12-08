From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 8 Dec 2016 14:26:08 +0300
Subject: [LTP] Invoking networking tests
In-Reply-To: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
References: <20161207141855.lvyrqs4cxhy4wr2c@dell5510>
Message-ID: <58494350.80404@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 12/07/2016 05:18 PM, Petr Vorel wrote:
> Hi Alexey,
>
> we're going to run LTP networking tests to against openSUSE and SUSE. Is there anything
> you'd like to change on invoking these tests? Anything deprecated?

You can invoke network test as other LTP tests, just make sure you 
provided all
the necessary environment variables, all of them have default values, so 
youneed to
make sure they were set appropriately according to your environment.

Please also see the recent patch:
5f8ca6c ("network: test_net.sh: allow to run network tests on a single 
machine")

And any improvements are always welcome.

> I see that scripts are run by ltp-pan (via. testscripts/network.sh wrapper), which is I
> suppose standard way how to run any test in LTP (as it is in runltp and half of
> testscripts/*.sh scripts).
> How about testcases/lib/test_net.sh and testcases/lib/test.sh scripts? Not deprecated?

Not deprecated, i.e. if you encounter that a shell test not using either 
of these two,
it's quite outdated and needs to be converted to the newer library.

> BTW: what is the purpose of testscripts/*.sh scripts, why it isn't everything integrated
> into runltp?

Just a wrapper script for ltp-pan, provides convenient options to run 
network tests.
Some time ago network.sh used to have more functionality, like default 
values for
network environment variables, but now they all have moved to 
test_net.sh so we
don't depend on this script anymore.

Best regards,
Alexey

