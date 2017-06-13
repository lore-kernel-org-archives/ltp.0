From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Jun 2017 06:38:03 -0400 (EDT)
Subject: [LTP] [PATCH] dirtyc0w: Include stdint.h
In-Reply-To: <20170609163530.29056-1-raj.khem@gmail.com>
References: <20170609163530.29056-1-raj.khem@gmail.com>
Message-ID: <1043463577.33903685.1497350282998.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it







----- Original Message -----
> uintptr_t is defined in stdint.h
> 
> Fixes
> | dirtyc0w_child.c:76:15: error: 'uintptr_t' undeclared (first use in this
> | function); did you mean 'intptr_t'?
> |    lseek(mfd, (uintptr_t) map, SEEK_SET);
> |                ^~~~~~~~~

Pushed.

Thanks,
Jan
