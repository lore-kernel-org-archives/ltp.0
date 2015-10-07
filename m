From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 07 Oct 2015 13:22:25 +0300
Subject: [LTP] [PATCH 02/10] network/nfs: rename nfs dir to nfs_stress
In-Reply-To: <5613D038.7000803@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
 <1443618568-29200-2-git-send-email-alexey.kodanev@oracle.com>
 <20151006132138.GB28743@rei.suse.cz> <5613D038.7000803@oracle.com>
Message-ID: <5614F261.2000803@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Patchset applied with the following changes:
* open_files.c ->nfs01_open_files,
* added cd $TST_TMPDIR in setup after 'mount' command. This is need 
because mount is called on test current working directory, so the test 
could still write to the local dir instead of nfs mount.

Best regards,
Alexey

