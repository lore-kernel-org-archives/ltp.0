Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nn4tk-0002u2-Kf
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 06:51:04 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nn4tj-0008ML-P7
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 06:51:04 +0000
Received: by pvf33 with SMTP id 33so636657pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 22:50:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100304064544.GA11885@linux.vnet.ibm.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
	<4B8E5DF3.7090502@calsoftinc.com>
	<9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
	<BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>
	<20100304064544.GA11885@linux.vnet.ibm.com>
Date: Wed, 3 Mar 2010 22:50:57 -0800
Message-ID: <364299f41003032250i78c201fesc5ce55d6d2c2794f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>, Maxin John <maxin.john@gmail.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Shwetabh <shwetabh.goel@calsoftinc.com>

On Wed, Mar 3, 2010 at 10:45 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Wed, Mar 03, 2010 at 03:16:47PM -0800, Garrett Cooper wrote:
>> On Mar 3, 2010, at 9:00 AM, Maxin John <maxin.john@gmail.com> wrote:
>>
>> > Hi Shwetabh,
>> >
>> >> 3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
>> >> [root@localhost ~]# cd /opt/ltp/
>> >> [root@localhost ltp]# ./runltp -f cpuhotplug
>> >>
>> >
>> > Please find attached the quick 'n' dirty patch
>> > (cpu_hotplugin_makefile.patch) to execute cpuhotplugin test.
>> > I have observed that the 'hotplug' directory is not included in
>> > "testcases/kernel/Makefile". I have also
>> > created a Makefile in 'hotplug/cpu_hotplug' directory.
>> >
>> > After applying this patch, I have followed the usual ./configure;
>> > make; sudo make install steps and executed
>> > the cpuhotplug test and observed the below given output . It seems
>> > like the test execution is "not so good" in
>> > my machine. Your mileage may vary.
>> >
>> > Garret,Rishi, please review the patch and let me know your comments.
>> >
>> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>>
>> It looks better but it's going to need a minor amount of fudging in
>> the scripts to source the appropriate scripts to execute cpuhotplug's
>> tests... I'll pick this up tomorrow if it's not done by then...
>
> Yes it looks better, i have tested it and true there are still some
> problem with testcase, can you look very closely and try to find the
> root cause for that ? Since this patch is important to run cpuhotplug
> testcases, i have included this to master branch.

    I'm not arguing that it's a good step towards getting the task
solved; I'm arguing that the change wasn't complete. I'm cleaning it
up right now...
Thanks,
-Garrett

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
