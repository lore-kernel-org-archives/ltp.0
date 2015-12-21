From: Manjeet Pawar <manjeet.p@samsung.com>
Date: Mon, 21 Dec 2015 08:54:58 +0000 (GMT)
Subject: [LTP] [Query] Regarding broken_ip4_version testcase
Message-ID: <1678861559.117761450688097753.JavaMail.weblogic@ep2mlwas06d>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI,
>> Testcase:- "broken_ip4_version"
>> Logs: here (xxx.xxx.xxx.xxx is rhost address)
>> ++ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\'''
>> 

>requesting a pswd?
No it does not ask for a password. if I execute command on my target shell :- ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\''' , It runs successfully and doesn't stuck and not asking for password, i have made password authentication "no" . But when same command execute within testcase it stuck there.

Another thing is test_net.sh does not use LTP_RSH as you told. It is using below command :
 if [ -n "$TST_USE_SSH" ]; then
        output=`ssh -n -q $user@$RHOST "sh -c \
            '$BIN_PATH$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
So the env variable LTP_RSH exported by me does not have any role here. test_net.sh simply use ssh to connect  remote machine which it is able to connect but command doesn't return  anything and stuck at this moment.

If you see it is actually doing "ip link set eth0 down  " for the remote host. And I can see the eth0 becomes down on remote machine. But command  stuck after making eth0 down.

Thanks
------- Original Message -------
Sender : Alexey Kodanev<alexey.kodanev@oracle.com>
Date : Dec 21, 2015 15:45 (GMT+09:00)
Title : Re: [LTP] [Query] Regarding broken_ip4_version testcase

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
> 

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
