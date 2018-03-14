From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Mar 2018 13:09:24 +0100
Subject: [LTP] [PATCH v2 2/3] lib: TCONF on "not supported" errnos in
 SAFE_SOCKET()
In-Reply-To: <50741a4d-d12e-f0b7-adf7-92fe0a8e0c1d@cn.fujitsu.com>
References: <20180313150111.16501-1-pvorel@suse.cz>
 <20180313150111.16501-2-pvorel@suse.cz>
 <50741a4d-d12e-f0b7-adf7-92fe0a8e0c1d@cn.fujitsu.com>
Message-ID: <20180314120924.evwoxl5yn4pvd6jz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Lianwen,

> Hi
>    I am sorry I forget to report my debug info on RHEL7.5Beta about this
> question.
> I write a testcase on RHEL7.5Beta. the test case is below.

> #include <netinet/in.h>
> #include <sys/socket.h>
> #include <stdio.h>

> int main (int argc, const char * argv[])
> {
>     //create a dccp socket
>     int server_socket = socket(AF_INET6, SOCK_DCCP, IPPROTO_DCCP);
>     if (server_socket == -1) {
>         perror("socket error");
>         return 1;
>     }
>    printf("test is ok \n");
> }

> And the  RHEL7.5Beta will report "Socket type not supported"  when run my
> testcase  on RHEL7.5Beta .
This is ESOCKTNOSUPPORT.

> and the RHEL7.4GA will report "Permission denied " when run my testcase on
> RHEL7.4GA
Not sure why it does not report ESOCKTNOSUPPORT, but I've seen some of these.

> it's ok when run my testcase on RHEL7.3GA.

> That's all.

> Thanks
> Lianwen Sun

Thanks for testing!


Kind regards,
Petr
