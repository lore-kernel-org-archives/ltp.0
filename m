Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkEtv-00034k-Er
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 15:45:55 +0000
Date: Tue, 13 May 2014 17:44:53 +0200
From: chrubis@suse.cz
Message-ID: <20140513154453.GC21042@rei>
References: <1396615481-13156-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1396615481-13156-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3 1/2] network: vxlan: add new test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +ip_local=${IPV4_NETWORK}.${LHOST_IPV4_HOST}
> +ip_vxlan_local="192.168.124.1"
> +mac_vxlan_local="3A:1C:C0:A8:7C:01"
> +
> +ip_remote=${IPV4_NETWORK}.${RHOST_IPV4_HOST}
> +ip_vxlan_remote="192.168.124.2"
> +mac_vxlan_remote="3A:1C:C0:A8:7C:02"

Where are these mac addresses from? Are they random?
(3A:1C:C0 doesn't seem to be assigned to any vendor...)

The patches looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
