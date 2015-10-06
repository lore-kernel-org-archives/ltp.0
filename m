From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Oct 2015 15:21:38 +0200
Subject: [LTP] [PATCH 02/10] network/nfs: rename nfs dir to nfs_stress
In-Reply-To: <1443618568-29200-2-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
 <1443618568-29200-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20151006132138.GB28743@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/network/nfs/nfs_stress/open_files.c |  126 +++++++++++++++++++++++++

I would like to to see the open_files.c to be renamed to
nfs01_open_files.c.

Otherwise the patchset looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
