From: Steve Muckle <smuckle@google.com>
Date: Wed, 20 Mar 2019 16:57:24 -0700
Subject: [LTP] [PATCH] syscalls/sendmmsg: add new test
In-Reply-To: <20190320230422.GA9453@dell5510>
References: <20190320021618.36043-1-smuckle@google.com>
 <20190320230422.GA9453@dell5510>
Message-ID: <61a8d1e9-b39d-91c8-81a1-e86a4d33848e@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/20/2019 04:04 PM, Petr Vorel wrote:
>> +	retval = sendmmsg(send_sockfd, msg, 2, 0);
> Unfortunately we need to have autotools check for sendmmsg() [1]
> to fix failure on old distros
> /usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c   -lltp -o sendmmsg01
> /usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c: In function 'sender_thread':
> /usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c:53: warning: implicit declaration of function 'sendmmsg'
> /tmp/ccqXXRS6.o: In function `sender_thread':
> /usr/src/ltp/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c:53: undefined reference to `sendmmsg'

Thanks Petr for your review and pointing me to the issue. I will add a 
config check for this.

thanks,
Steve
