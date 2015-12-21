From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Dec 2015 09:45:01 +0300
Subject: [LTP] [Query] Regarding broken_ip4_version testcase
In-Reply-To: <1046379286.777961450256035403.JavaMail.weblogic@epmlwas06c>
References: <1046379286.777961450256035403.JavaMail.weblogic@epmlwas06c>
Message-ID: <56779FED.9010100@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 12/16/2015 11:53 AM, Manjeet Pawar wrote:
> HI,
>
> I am running broken_ip testcases. I am using below env setting
>
> export NETWORK_DELAY=30
> export LTP_RSH="ssh -q  -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa -l root"

LTP_RSH is not used in test_net.sh/tst_rhost_run(), which is sourced by 
broken_ip test group.
So it will be as you wrote below without your private key.

You could try to create alias ssh='ssh -o StrictHostKeyChecking=no -i 
/root/.ssh/id_rsa'
and then run the test.


>
> Testcase:- "broken_ip4_version"
> Logs: here (xxx.xxx.xxx.xxx is rhost address)
> ++ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\'''
> <testcase stuck here>

requesting a pswd?

Best regards,
Alexey

Also please send any further emails to the following ML:

ltp@lists.linux.it

> I am not able to proceed after this command. I checked my remote machine, its network is already down when this command executed, but the testcase stuck at this moment and not returning anything.
> Am I missing anything?
> I checked with all my env settings, they are working for rest of the other testcases but not for this category "broken_ip_*).
> Thanks
> Manjeet
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

