Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shwetabh.goel@calsoftinc.com>) id 1NmoDt-0005LP-Nj
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 13:02:45 +0000
Received: from inbox235.nyi.net ([66.111.15.35])
	by sfi-mx-4.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NmoDs-0002qS-TV
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 13:02:45 +0000
Received: from imss.calsofthq.com (imss.calsofthq.com [172.16.0.44])
	by mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id o23D2YtN017383
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 18:32:34 +0530
Received: from imss.calsofthq.com (localhost.localdomain [127.0.0.1])
	by localhost.calsofthq.com (Postfix) with ESMTP id 7B37D5E6861
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Mar 2010 18:37:28 +0530 (IST)
Received: from mail.calsofthq.com (mail.calsofthq.com [172.16.0.7])
	by imss.calsofthq.com (Postfix) with ESMTP id 5B9331BE1072
	for <ltp-list@lists.sourceforge.net>;
	Wed,  3 Mar 2010 18:37:28 +0530 (IST)
Received: from [172.17.6.83] (shwetabhg.calsofthq.com [172.17.6.83])
	(authenticated bits=0)
	by mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id o23D2XL6017380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 18:32:33 +0530
Message-ID: <4B8E5DF3.7090502@calsoftinc.com>
Date: Wed, 03 Mar 2010 18:32:43 +0530
From: Shwetabh <shwetabh.goel@calsoftinc.com>
MIME-Version: 1.0
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
In-Reply-To: <20100303124352.GD23601@linux.vnet.ibm.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: ltp-list@lists.sourceforge.net

Hi Rishi,

Here is the information you needed:

- Installation Steps:
1. Downloaded LTP's Feb 2010 Stable build from ltp.sourceforge.net
2. Extracted/compiled using following commands:
tar -xzf ltp-full-20100228.tgz
cd ltp-full-20100228
./configure
make
make install
3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
[root@localhost ~]# cd /opt/ltp/
[root@localhost ltp]# ./runltp -f cpuhotplug

- OS Version: RHEL 5.4

- Automake version:
[root@localhost ~]# automake --version
automake (GNU automake) 1.9.6
Written by Tom Tromey <tromey@redhat.com>.

Autoconf version:
[root@localhost ~]# autoconf --version
autoconf (GNU Autoconf) 2.59
Written by David J. MacKenzie and Akim Demaille.

- Arch: x86_64

I was able to run the same test w/o any issues with 
ltp-full-20090731.tgz, which I "think" was the
last drop which would compile and install in the same location. Even in 
the current case, I was able
to run the test only after I copied all folders from 
/root/ltp-full-20100228/testcases to /opt/ltp/testcases.

Regards,
Shwetabh
On 3/3/2010 6:13 PM, Rishikesh K Rajak wrote:
> On Wed, Mar 03, 2010 at 04:05:43PM +0530, Shwetabh wrote:
>    
>> Hi,
>>
>>      
> Hi Shwetabh,
>
> Few queries:
>      - Tell us the complete steps of execution/compiling
>      - OS version ?
>      - automake&  autoconf version ?
>      - Arch ?
>
> Thanks
> -Rishi
>
>    
>> In recent ltp releases, I see quite a few test cases breaking since
>> their required tools
>> are not being copied over to /opt/ltp/testcases/. I believe this
>> behaviour started since
>> ltp started compiling and copying the files to /opt/ltp. Here is an example:
>>
>> ----<<snip>>-----------
>> remove test cases which require the block device.
>> You can specify it with option -b
>> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 27204     -n 27204  -p  -f
>> /tmp/ltp-gcfmm27210/alltests -l
>> /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log  -C
>> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
>> LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log
>> FAILED COMMAND File:
>> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
>> Running tests.......
>> <<<test_start>>>
>> tag=CPUHOTPLUG stime=1267586681
>> cmdline="(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./runtests.sh)"
>> contacts=""
>> analysis=exit
>> <<<test_output>>>
>> incrementing stop
>> sh: line 0: cd: /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/: No such
>> file or directory
>> sh: ./runtests.sh: No such file or directory
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=0 termination_type=exited termination_id=127 corefile=no
>> cutime=0 cstime=0
>> <<<test_end>>>
>> INFO: ltp-pan reported some tests FAIL
>> LTP Version: LTP-20100228
>>
>>          ###############################################################"
>>
>>               Done executing testcases."
>>               LTP Version:  LTP-20100228
>>          ###############################################################"
>>
>> [root@localhost runtest]# cd /opt/ltp/testcases/
>> [root@localhost testcases]# ls
>> bin  data
>> [root@localhost testcases]# pwd
>> /opt/ltp/testcases
>> [root@localhost testcases]# ls -l
>> total 76
>> drwxr-xr-x 7 root root 69632 Mar  2 22:24 bin
>> drwxr-xr-x 2 root root  4096 Mar  2 22:19 data
>>
>> --------------------
>>
>> Please advice if I am doing something wrong here. Do I manually have to
>> copy the tools from tarballs' testcases/kernel directory?
>> If so, shouldn't this be done by make install?
>>
>> -- 
>> Regards,
>> Shwetabh
>>
>>
>> ------------------------------------------------------------------------------
>> Download Intel&#174; Parallel Studio Eval
>> Try the new software tools for yourself. Speed compiling, find bugs
>> proactively, and fine-tune applications for parallel performance.
>> See why Intel Parallel Studio got high marks during beta.
>> http://p.sf.net/sfu/intel-sw-dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>      
>    

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
