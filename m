Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Ux5rO-0000tF-RB
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 01:39:54 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ux5rN-0001Ap-Ek
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 01:39:54 +0000
Message-ID: <51DE0CE7.2080403@cn.fujitsu.com>
Date: Thu, 11 Jul 2013 09:39:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1373424973-32151-1-git-send-email-penght@cn.fujitsu.com>
	<267085751.2020967.1373482084934.JavaMail.root@redhat.com>
In-Reply-To: <267085751.2020967.1373482084934.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] syslog-lib.sh: Use lib to restart syslog
	service
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 07/11/2013 02:48 AM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> > From: "Peng Haitao" <penght@cn.fujitsu.com>
>> > To: ltp-list@lists.sourceforge.net
>> > Sent: Wednesday, 10 July, 2013 4:56:13 AM
>> > Subject: [LTP] [PATCH v2] syslog-lib.sh: Use lib to restart syslog service
>> > 
>> > Use restart_daemon() to restart syslog service.
>> > 
>> > Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> Hi,
> 
> looks good to me. I also ran all syslog testcases with this patch
> on systemd/rsyslog based distro (RHEL7alpha) - all PASSed.

Thank you for your test and review. Pushed.

Wanlong Gao

> 
> Regards,
> Jan
> 


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
