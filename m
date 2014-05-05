Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Diwakar.Sharma@in.bosch.com>) id 1WhIcE-00004v-8F
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 13:07:30 +0000
Received: from smtp6-v.fe.bosch.de ([139.15.237.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WhIcC-0004Tz-Ik
	for ltp-list@lists.sourceforge.net; Mon, 05 May 2014 13:07:30 +0000
From: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>
Date: Mon, 5 May 2014 21:06:55 +0800
Message-ID: <46CD92664333704E8A06E512A60A9E9F2AD2C4C797@SGPMBX02.APAC.bosch.com>
References: <46CD92664333704E8A06E512A60A9E9F2AD2C0B12F@SGPMBX02.APAC.bosch.com>
	<53678BBD.80607@oracle.com>
In-Reply-To: <53678BBD.80607@oracle.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hello,

I am using 3.8.13.21

oracle-virtualbox:/usr/lib# uname -r
3.8.13.21

Thanks and Regards
Diwakar Sharma



-----Original Message-----
From: Stanislav Kholmanskikh [mailto:stanislav.kholmanskikh@oracle.com] 
Sent: Monday, May 05, 2014 6:32 PM
To: Diwakar Sharma (RBEI/ECF3); ltp-list@lists.sourceforge.net
Subject: Re: [LTP] - Kernel - tunable max_map_count test failure - 20140115-46-g2368cd4



On 05/05/2014 10:52 AM, Diwakar Sharma (RBEI/ECF3) wrote:
> Hi,

Hi!

>
> I was getting the max_map_count test failed. It looked to me failing at filter_map function. The platform I'm working on is an i686 architecture running on Virtualbox.
> I added below additional macro condition and it's passing now. I want to understand if not including i686/386 was intentional originally for some reason? Also vdso part I added additionaly.
>
> #elif defined(__i686__) || defined(__i386__)
> static int filter_map(char *line)
> {
>          char buf[BUFSIZ];
>          int ret;
>
>          ret = sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf);
>          if (ret != 1)
>                  return 0;
>
>          return ((strcmp(buf, "[vdso]") == 0) | (strcmp(buf, "[vsyscall]") == 0));
> }
>
>
> On another similar architecture (but the actual h/w board), the same code gives messages like "4096 map entries in total, but expected 4096 entries" and reported FAIL, implying map_count and max_maps is same ( Contrary to map_count==max_maps+1 ). How do we analyze this scenario? Does this mean it is not exceeding by one for sysctl setting? How to verify that.
>

Which kernel version do you use? I want to check this test case in my 
environment.

Thanks.

PS: Also look at this thread 
http://sourceforge.net/p/ltp/mailman/ltp-list/thread/52009D26.4030609%40oracle.com/

>
> Thanks and Regards
> Diwakar Sharma
>
>
>
> ------------------------------------------------------------------------------
> Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
> &#149; 3 signs your SCM is hindering your productivity
> &#149; Requirements for releasing software faster
> &#149; Expert tips and advice for migrating your SCM now
> http://p.sf.net/sfu/perforce
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

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
