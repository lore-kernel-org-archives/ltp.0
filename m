From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Apr 2018 09:02:35 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <5AE27062.1060804@cn.fujitsu.com>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
 <b72b277b-e8e0-d69c-b918-bd48341c2a1d@oracle.com>
 <20180426172713.GB14157@x230> <5AE27062.1060804@cn.fujitsu.com>
Message-ID: <20180427070235.gsjwq7xq5eaf2af5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> > sysctl and keyctl are actually testing kernel bugs.
> > Other kernel related (at least lsmod, mkfs, mkswap, unshare, ldd, gdb) + TPM tools
> > (tpm-tools, ...) are probably valid.
> Hi,

> I want to leave unshare01 because it could test not only namespaces but also a RHEL specific bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=1463072
> I attach the fix patch for your reference.

Bug is not visible ("You are not authorized to access bug #1463072. To see this bug, you must first log in to an account with the appropriate permissions."), but the fix is self-describing, thanks for sending it.


> Thanks,
> Xiao Yang


Kind regards,
Petr
