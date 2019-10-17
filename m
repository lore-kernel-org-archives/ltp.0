From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Oct 2019 06:02:28 -0400 (EDT)
Subject: [LTP] [PATCH 1/1] setxattr03: define _GNU_SOURCE to fix build
 on musl
In-Reply-To: <20191016213001.23047-1-petr.vorel@gmail.com>
References: <20191016213001.23047-1-petr.vorel@gmail.com>
Message-ID: <184868574.6595050.1571306548992.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: Petr Vorel <pvorel@suse.cz>
> 
> musl defines loff_t in <fcntl.h> (already included) and guard it under
> _GNU_SOURCE.
> NOTE: glibc and others define it in <sys/types.h>
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

ACK
