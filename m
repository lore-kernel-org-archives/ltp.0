Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XX6gr-0005VX-Hg
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 10:54:25 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XX6gq-0005nD-LF
	for ltp-list@lists.sourceforge.net; Thu, 25 Sep 2014 10:54:25 +0000
Message-ID: <5423F4C8.10101@oracle.com>
Date: Thu, 25 Sep 2014 14:56:08 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1406634124.3928.1.camel@G08JYZSD130126>	
	<53DA2E9A.5030902@oracle.com>
	<1406862709.2835.1.camel@G08JYZSD130126>
	<53DB94E1.70404@oracle.com>
In-Reply-To: <53DB94E1.70404@oracle.com>
Subject: Re: [LTP] [PATCH v2 1/2] network ftp: some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
On 08/01/2014 05:23 PM, Alexey Kodanev wrote:
> Hi Zeng!
> On 08/01/2014 07:11 AM, Zeng Linggang wrote:
>> * Move do_setup and do_cleanup into ftp_setup.
>>
>> * Delete ftp02_s1 and add do_test function for it.
>>
>> * Delete ftp_set_passwd and ftp_setup_vsftp_conf, since they are not 
>> be used.
>>
>> * Use test.sh instead of net_cmdlib.sh
>>
>> * Abandon trap and use tst_exit.
>>
>> * Make the test like:
>>     (set TCID TST_TOTAL ...)
>>     setup
>>     do_test
>>     check_result
>>     tst_exit
>>
>> * Some cleanup.
>>
>> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
>> ---
>>   testcases/network/tcp_cmds/ftp/ftp02               |  99 +++++++-----
>>   testcases/network/tcp_cmds/ftp/ftp02_s1            |  71 ---------
>>   testcases/network/tcp_cmds/ftp/ftp03               | 175 
>> +++++++--------------
>>   testcases/network/tcp_cmds/ftp/ftp04               | 109 ++++++-------
>>   testcases/network/tcp_cmds/ftp/ftp05               | 146 
>> ++++++++---------
>>   testcases/network/tcp_cmds/ftp/ftp_set_passwd      |  28 ----
>>   testcases/network/tcp_cmds/ftp/ftp_setup           |  73 +++++++++
>>   .../network/tcp_cmds/ftp/ftp_setup_vsftp_conf      |   5 -
>>   8 files changed, 304 insertions(+), 402 deletions(-)
>>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp02_s1
>>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_set_passwd
>>   create mode 100644 testcases/network/tcp_cmds/ftp/ftp_setup
>>   delete mode 100755 testcases/network/tcp_cmds/ftp/ftp_setup_vsftp_conf
>>
...
>> -#-----------------------------------------------------------------------
>> -# FUNCTION:  do_cleanup
>> -#----------------------------------------------------------------------- 
>>
>> +TCID="$0"
>
> May be we should just change it to ftp02, otherwise test name will 
> depend on how you running it (e.g. running by full path, TCID becomes 
> "/opt/ltp/testcases/bin/test_name".
>

Pushed both patches, also changed TCID names.
Thanks.

> Are you running these tests from runEALtests.sh?
>
> Can we add them to networktests.sh, to "TCP/IP command tests" group as 
> it already has ftp01?
>
> Thanks,
> Alexey
>


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
