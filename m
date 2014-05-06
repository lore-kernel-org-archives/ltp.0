Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WhbBw-0007DA-Te
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:57:36 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WhbBv-0005iH-UG
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 08:57:36 +0000
Message-ID: <5368A3EB.2060100@oracle.com>
Date: Tue, 06 May 2014 12:57:15 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <46CD92664333704E8A06E512A60A9E9F2AD2C0B12F@SGPMBX02.APAC.bosch.com>
	<53678BBD.80607@oracle.com>
	<46CD92664333704E8A06E512A60A9E9F2AD2C4C797@SGPMBX02.APAC.bosch.com>
In-Reply-To: <46CD92664333704E8A06E512A60A9E9F2AD2C4C797@SGPMBX02.APAC.bosch.com>
Subject: Re: [LTP] - Kernel - tunable max_map_count test failure -
	20140115-46-g2368cd4
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
To: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>



On 05/05/2014 05:06 PM, Diwakar Sharma (RBEI/ECF3) wrote:
> Hello,
>
> I am using 3.8.13.21
>
> oracle-virtualbox:/usr/lib# uname -r
> 3.8.13.21

Hmm, max_map_count passes with vanilla kernel 3.8.13 and the current LTP 
git version:

[root@ol6-i386 tunable]# uname -a
Linux ol6-i386 3.8.13 #1 SMP Tue May 6 02:47:45 EDT 2014 i686 i686 i386 
GNU/Linux

[root@ol6-i386 tunable]# cat /proc/self/maps
08048000-08053000 r-xp 00000000 fd:00 135174     /bin/cat
08053000-08054000 rw-p 0000a000 fd:00 135174     /bin/cat
0962e000-0964f000 rw-p 00000000 00:00 0          [heap]
b737d000-b757d000 r--p 00000000 fd:00 134061 
/usr/lib/locale/locale-archive
b757d000-b757e000 rw-p 00000000 00:00 0
b757e000-b770f000 r-xp 00000000 fd:00 2069       /lib/libc-2.12.so
b770f000-b7711000 r--p 00191000 fd:00 2069       /lib/libc-2.12.so
b7711000-b7712000 rw-p 00193000 fd:00 2069       /lib/libc-2.12.so
b7712000-b7715000 rw-p 00000000 00:00 0
b771a000-b771b000 rw-p 00000000 00:00 0
b771b000-b771c000 r-xp 00000000 00:00 0          [vdso]
b771c000-b773a000 r-xp 00000000 fd:00 2062       /lib/ld-2.12.so
b773a000-b773b000 r--p 0001d000 fd:00 2062       /lib/ld-2.12.so
b773b000-b773c000 rw-p 0001e000 fd:00 2062       /lib/ld-2.12.so
bf8b7000-bf8d8000 rw-p 00000000 00:00 0          [stack]

[root@ol6-i386 tunable]# ./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
max_map_count    1  TPASS  :  64 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 256
max_map_count    2  TPASS  :  256 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 1024
max_map_count    3  TPASS  :  1024 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 4096
max_map_count    4  TPASS  :  4096 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 16384
max_map_count    5  TPASS  :  16384 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 65536
max_map_count    6  TPASS  :  65536 map entries in total as expected.
max_map_count    0  TINFO  :  set overcommit_memory to 0
max_map_count    0  TINFO  :  set max_map_count to 65530

It's a virtual machine in VirtualBox-4.3-4.3.10_93012_el6-1.x86_64


>
> Thanks and Regards
> Diwakar Sharma
>
>
>
> -----Original Message-----
> From: Stanislav Kholmanskikh [mailto:stanislav.kholmanskikh@oracle.com]
> Sent: Monday, May 05, 2014 6:32 PM
> To: Diwakar Sharma (RBEI/ECF3); ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] - Kernel - tunable max_map_count test failure - 20140115-46-g2368cd4
>
>
>
> On 05/05/2014 10:52 AM, Diwakar Sharma (RBEI/ECF3) wrote:
>> Hi,
>
> Hi!
>
>>
>> I was getting the max_map_count test failed. It looked to me failing at filter_map function. The platform I'm working on is an i686 architecture running on Virtualbox.
>> I added below additional macro condition and it's passing now. I want to understand if not including i686/386 was intentional originally for some reason? Also vdso part I added additionaly.
>>
>> #elif defined(__i686__) || defined(__i386__)
>> static int filter_map(char *line)
>> {
>>           char buf[BUFSIZ];
>>           int ret;
>>
>>           ret = sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf);
>>           if (ret != 1)
>>                   return 0;
>>
>>           return ((strcmp(buf, "[vdso]") == 0) | (strcmp(buf, "[vsyscall]") == 0));
>> }
>>
>>
>> On another similar architecture (but the actual h/w board), the same code gives messages like "4096 map entries in total, but expected 4096 entries" and reported FAIL, implying map_count and max_maps is same ( Contrary to map_count==max_maps+1 ). How do we analyze this scenario? Does this mean it is not exceeding by one for sysctl setting? How to verify that.
>>
>
> Which kernel version do you use? I want to check this test case in my
> environment.
>
> Thanks.
>
> PS: Also look at this thread
> http://sourceforge.net/p/ltp/mailman/ltp-list/thread/52009D26.4030609%40oracle.com/
>
>>
>> Thanks and Regards
>> Diwakar Sharma
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
>> &#149; 3 signs your SCM is hindering your productivity
>> &#149; Requirements for releasing software faster
>> &#149; Expert tips and advice for migrating your SCM now
>> http://p.sf.net/sfu/perforce
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
