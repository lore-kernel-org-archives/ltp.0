From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Apr 2016 04:05:56 -0400 (EDT)
Subject: [LTP] [PATCH] mmap2: change memory units and default size
In-Reply-To: <1458708300-14960-1-git-send-email-jcsistemas2001@gmail.com>
References: <1458708300-14960-1-git-send-email-jcsistemas2001@gmail.com>
Message-ID: <1558521674.17901489.1459757156206.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Julio Cruz" <jcsistemas2001@gmail.com>
> To: "julio cruz" <julio.cruz@smartmatic.com>, ltp@lists.linux.it, chrubis@suse.cz, jstancek@redhat.com
> Cc: "Julio Cruz" <jcsistemas2001@gmail.com>
> Sent: Wednesday, 23 March, 2016 5:45:00 AM
> Subject: [LTP][PATCH] mmap2: change memory units and default size
> 
> This patch made three changes: 1) check the available memory
> before to perform the test case, 2) change the memory units
> from GB to MB, and 3)  make default file size to 128M.
> 
> These changes are needed during testing on embedded devices
> with RAM memory limitation (i.e. 512MB).
> 
> This patch no changed the test case procedure.

I have pushed this with some small changes, plus I dropped paragraph
below, because patch now changes also default size to 128M.

Regards,
Jan

> 
> To use this test case in embedded devices, I suggest to change
> the testrun 'mm' as below from: "mtest06_2 mmap2 -x 0.002 -a -p"
> to "mtest06_2 mmap2 -x 0.002 -a -p -s 100" according with
> your system memory available
> 
> Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>
