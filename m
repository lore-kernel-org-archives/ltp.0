Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPE2c-0002e8-9p
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:12:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPE2Y-0007Z8-IJ
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:12:50 +0000
Date: Tue, 11 Aug 2015 20:12:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811181219.GB24227@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-10-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436424468-11756-10-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 09/23] network/virt/vlan03: add new test-case
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
> +tst_resm TINFO "networks with the same VLAN ID must work"
> +
> +res="TPASS"
> +
> +virt_setup "id 4094" "id 4094"
> +virt_compare_netperf || res="TFAIL"
> +
> +tst_resm $res "done"
> +
> +tst_resm TINFO "different VLAN ID shall not work together"
> +res="TPASS"
> +virt_setup "id 4093" "id 4094"
> +virt_compare_netperf && res="TFAIL"
> +
> +tst_resm $res "done"

I would rather see the test issuing one PASS/FAIL for each of the
asserting here. Why cannot we use tst_resm TPASS/TFAIL in the
virt_compare_netperf function?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
