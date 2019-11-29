From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Nov 2019 07:16:48 -0500 (EST)
Subject: [LTP] [PATCH] mtest01: correct the ALLOC_THRESHOLD definition
 on s390x
In-Reply-To: <20191128045525.15454-1-liwang@redhat.com>
References: <20191128045525.15454-1-liwang@redhat.com>
Message-ID: <615998340.14360504.1575029808785.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> mtest01 hits a problem on s390x platform. The situation is that if children's
> memory allocating is ongoing and the test remaining time is in an emergency,
> the
> parent will break from the while loop and try to revoke children, obviously,
> it
> doesn't have enough time to wait for the children's status change to 'T'.
> Then it
> occurs timeout issue as below:
> 
>   mtest01.c:134: INFO: Filling up 80% of free ram which is 5868864 kbytes
>   mtest01.c:149: INFO: ... child 38289 starting
>   mtest01.c:149: INFO: ... child 38288 starting
>   mtest01.c:208: WARN: the remaininig time is not enough for testing
>   mtest01.c:218: FAIL: kbytes allocated (and written to) less than expected
>   5868864
>   Test timeouted, sending SIGKILL!

Acked-by: Jan Stancek <jstancek@redhat.com>

I/O on that system looks painfully slow, if it can't fill ~5G of swap in 5 minutes.

