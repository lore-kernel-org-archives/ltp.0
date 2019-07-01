From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 1 Jul 2019 03:00:04 -0400 (EDT)
Subject: [LTP] [PATCH] cve/meltdown.c: abort the test if kallsyms was
 not enabled
In-Reply-To: <20190628093709.6625-1-po-hsu.lin@canonical.com>
References: <20190628093709.6625-1-po-hsu.lin@canonical.com>
Message-ID: <17466941.30834903.1561964404173.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The cve-2017-5754 meltdown test does not work with a kernel that does
> not have CONFIG_KALLSYMS enabled (e.g. Ubuntu KVM kernel).
> 
> Add and extra check for /proc/kallsyms to determine if we can run it.
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

Pushed.

Thanks,
Jan
