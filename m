From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 Dec 2019 09:43:04 -0500 (EST)
Subject: [LTP] [bug] userspace hitting sporadic SIGBUS on xfs (Power9,
 ppc64le), v4.19 and later
In-Reply-To: <20191203190925.GA5150@infradead.org>
References: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
 <1738119916.14437244.1575151003345.JavaMail.zimbra@redhat.com>
 <8736e3ffen.fsf@mpe.ellerman.id.au>
 <1420623640.14527843.1575289859701.JavaMail.zimbra@redhat.com>
 <1766807082.14812757.1575377439007.JavaMail.zimbra@redhat.com>
 <20191203190925.GA5150@infradead.org>
Message-ID: <385099805.15030947.1575470584839.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Please try the patch below:

I ran reproducer for 18 hours on 2 systems were it previously reproduced,
there were no crashes / SIGBUS.

