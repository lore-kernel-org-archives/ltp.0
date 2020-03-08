From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 8 Mar 2020 16:07:23 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E5?=
 =?utf-8?q?=2E7-60528b7=2Ecki_=28stable-queue=29?=
In-Reply-To: <173385062.10432633.1583427362328.JavaMail.zimbra@redhat.com>
References: <cki.EED856DF66.LLEP90YP5M@redhat.com>
 <2065777364.10425170.1583425488638.JavaMail.zimbra@redhat.com>
 <173385062.10432633.1583427362328.JavaMail.zimbra@redhat.com>
Message-ID: <976629603.10711789.1583698043547.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 5.6.0-0.rc3 crashed as well. On s390x I'm using it's enough to
> "cat /sys/fs/cgroup/cpu.pressure" to trigger.

Fix has already been posted:
  https://lore.kernel.org/lkml/20200224030007.3990-1-cai@lca.pw/

With this patch applied, I no longer see crashes with 5.6.0-rc4+.

