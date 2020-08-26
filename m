From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 26 Aug 2020 12:20:43 +0200
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <20200826100828.21690-1-mdoucha@suse.cz>
References: <1390277350.9966000.1598362700248.JavaMail.zimbra@redhat.com>
 <20200826100828.21690-1-mdoucha@suse.cz>
Message-ID: <1efb7ffc-e08f-1eca-ccfd-16ef338252d3@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sorry, ignore this patch, I meant to add a bind() there to change the
source port...

On 26. 08. 20 12:08, Martin Doucha wrote:
> Let's see if it's really a delayed ICMP message. Can you reproduce the error
> after applying this patch?
> 
> In the meantime, I'll write a test for send(MSG_MORE).
> 
> ---
>  testcases/kernel/syscalls/setsockopt/setsockopt05.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> index e78ef236e..594178744 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> @@ -63,6 +63,7 @@ static void run(void)
>  	memset(buf, 0x42, BUFSIZE);
>  
>  	for (i = 0; i < 1000; i++) {
> +		addr.sin_port = 12345 + i;
>  		sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
>  		SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
>  		SAFE_SEND(1, sock, buf, BUFSIZE, MSG_MORE);
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
