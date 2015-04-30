Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YnpX7-0001kB-BB
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 14:33:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnpX5-00032x-9b
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 14:33:45 +0000
Message-ID: <55423D3E.9000108@oracle.com>
Date: Thu, 30 Apr 2015 17:33:34 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <cover.1430380932.git.jstancek@redhat.com>
In-Reply-To: <cover.1430380932.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 0/4 v3] (merged) cpuhotplug fixes
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
To: Jan Stancek <jstancek@redhat.com>, ltp-list@lists.sourceforge.net



On 04/30/2015 11:13 AM, Jan Stancek wrote:
> Hi,
>
> This patchset is result of merge of following series:
>    http://article.gmane.org/gmane.linux.ltp/22762
>    http://article.gmane.org/gmane.linux.ltp/22678
>
> It is based on patchset from Stanislav, with changes
> noted below:
> 1. cpuhotplug: use cpu states in cleanup
>     no changes to Stanislav's version
> 2. cpu_hotplug: added get_hotplug_cpus, get_hotplug_cpus_num
>     This patch has been merged with my 'get_present_cpus' patch,
>     get_hotplug_cpus has been modified to operate on present cpus
>     only.
> 3. cpu_hotplug: use hotplug/present cpus functions
>     This comes from my series, there is no counterpart or conflict
>     with Stanislav's patchset.
> 4. cpuhotplug04.sh: operate only with hotpluggable CPUs
>     minor change here to use number of present CPUs, rather than all
>
> Changes in v3:
> + use present_mask variable in get_present_cpus
> + no special treatment for cpu0 in cpuhotplug03
> + fix cpuhotplug03 to spawn (number of present cpus)*2 processes
> + this time whole series has correct version in subject

Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Plus tested the series in a 4 vCPU VirtualBox VM both with and without 
the 'cpu0_hotplug' kernel cmdline.

Thanks.


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
