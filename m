From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 May 2016 16:09:54 +0300
Subject: [LTP] [PATCH v2 1/3] network: merge
 networktests.sh/networkstress.sh into network.sh
In-Reply-To: <20160517122908.GC12051@rei.lan>
References: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
 <20160517122908.GC12051@rei.lan>
Message-ID: <573B1822.3030601@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 05/17/2016 03:29 PM, Cyril Hrubis wrote:
> Hi!
>> @@ -4,68 +4,6 @@ TST_TOTAL=1
>>   TCID="network_settings"
>>   . test_net.sh
> We are working around the checks in test.sh here by defining TST_TOTAL
> and TCID. Maybe it would be better to add the settings to separate
> script sourced by the test_net.sh and here as well so that we don't have
> to...

But if we don't source test.sh we will break some dependencies between 
test_net.sh and test.sh,
e.g. variables like this one:

export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}

It might call tst_brkm/tst_resm...

BTW, if we already using tst_* functions from test.sh, may be we could
replace network.sh's 'echo' commands there too?

Thanks,
Alexey

>
> Otherwise this version looks fine.
>

