From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 Dec 2015 14:31:32 +0300
Subject: [LTP] [Query] Regarding broken_ip4_version testcase
In-Reply-To: <1678861559.117761450688097753.JavaMail.weblogic@ep2mlwas06d>
References: <1678861559.117761450688097753.JavaMail.weblogic@ep2mlwas06d>
Message-ID: <5677E314.30806@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 12/21/2015 11:54 AM, Manjeet Pawar wrote:
> HI,
>>> Testcase:- "broken_ip4_version"
>>> Logs: here (xxx.xxx.xxx.xxx is rhost address)
>>> ++ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\'''
>>>
>> requesting a pswd?
> No it does not ask for a password. if I execute command on my target shell :- ssh -n -q root@xxx.xxx.xxx.xxx 'sh -c    '\' ip link set eth0 down  || echo RTERR'\''' , It runs successfully and doesn't stuck and not asking for password, i have made password authentication "no" . But when same command execute within testcase it stuck there.
>
> Another thing is test_net.sh does not use LTP_RSH as you told. It is using below command :
>   if [ -n "$TST_USE_SSH" ]; then
>          output=`ssh -n -q $user@$RHOST "sh -c \
>              '$BIN_PATH$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> So the env variable LTP_RSH exported by me does not have any role here. test_net.sh simply use ssh to connect  remote machine which it is able to connect but command doesn't return  anything and stuck at this moment.
>
> If you see it is actually doing "ip link set eth0 down  " for the remote host. And I can see the eth0 becomes down on remote machine. But command  stuck after making eth0 down.

Probably, your test interface is the same interface the management link 
is working on, i.e. eth0 is used to connect two machines over ssh. Try 
to set RHOST to the name or IP address that is not routed through eth0 
or use another test interface to perform the test. This is a requirement 
for network/stress group.

You can also remove "tst_restore_ipaddr()" from broken_*lib.sh scripts, 
if eth0 has already been configured with IPs.

I'm going to send a patch to remove this code from them, because most 
network tests expect IP addresses have already been set, and some of  
network/stress tests, broken_ip in particular, don't really need to 
restore the addresses.

Best regards,
Alexey

