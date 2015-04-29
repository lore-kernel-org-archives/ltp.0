Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YnQ0S-00017I-UC
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:20 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YnQ0P-00069w-JG
	for ltp-list@lists.sourceforge.net; Wed, 29 Apr 2015 11:18:20 +0000
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Apr 2015 13:17:57 +0200
Message-Id: <cover.1430305546.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 0/4 v2] (merged) cpuhotplug fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

This patchset is result of merge of following series:
  http://article.gmane.org/gmane.linux.ltp/22762
  http://article.gmane.org/gmane.linux.ltp/22678

It is based on patchset from Stanislav, with changes
noted below:
1. cpuhotplug: use cpu states in cleanup
   no changes to Stanislav's version
2. cpu_hotplug: added get_hotplug_cpus, get_hotplug_cpus_num
   This patch has been merged with my 'get_present_cpus' patch,
   get_hotplug_cpus has been modified to operate on present cpus
   only.
3. cpu_hotplug: use hotplug/present cpus functions
   This comes from my series, there is no counterpart or conflict
   with Stanislav's patchset.
4. cpuhotplug04.sh: operate only with hotpluggable CPUs
   minor change here to use number of present CPUs, rather than all

@Stanislav: Can you please review this series and check, whether
            it still fixes issue you met on sparc64 kernel?

Regards,
Jan


Jan Stancek (1):
  cpu_hotplug: use hotplug/present cpus functions

Stanislav Kholmanskikh (3):
  cpuhotplug: use cpu states in cleanup
  cpu_hotplug: add get_hotplug_cpus, get_present_cpus
  cpuhotplug04.sh: operate only with hotpluggable CPUs

 .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh | 17 ++---
 .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh | 16 ++--
 .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh | 74 +++++++++---------
 .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |  2 +-
 .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |  2 +-
 .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 89 +++++++++++++++++++---
 8 files changed, 135 insertions(+), 69 deletions(-)

-- 
1.8.3.1


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
